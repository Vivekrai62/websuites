import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import '../../Utils/Routes/routes_name.dart';
import '../saveToken/save_token.dart';
import '../../data/models/responseModels/login/login_response_model.dart';
import '../../data/repositories/repositories.dart';

class LoginViewModel extends GetxController {
  final _userPreference = SaveUserData();
  final _apiRepository = Repositories();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final RxBool loading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool remember = false.obs;

  Future<void> login(BuildContext context) async {
    loading.value = true;
    try {
      Map<String, dynamic> loginData = {
        'email': emailController.value.text.trim(),
        'password': passwordController.value.text.trim(),
      };

      final LoginResponseModel loginResponse = await _apiRepository.loginApi(loginData);

      if (loginResponse.accessToken != null && loginResponse.accessToken!.isNotEmpty) {
        if (kDebugMode) {
          print('Attempting to save user data with rememberMe: ${remember.value}');
        }
        bool saved = await _userPreference.saveCompleteUserData(
          loginResponse,
          rememberMe: remember.value, // Pass remember value
        );

        if (saved) {
          if (kDebugMode) {
            print('User data saved successfully, rememberMe: ${remember.value}');
          }
          Get.offAllNamed(
            RoutesName.home_manager,
            arguments: {
              'accessToken': loginResponse.accessToken,
              'email': loginResponse.user?.email ?? '',
              'first_name': loginResponse.user?.firstName ?? '',
              'last_name': loginResponse.user?.lastName ?? '',
              'user_id': loginResponse.user?.id ?? '',
              'is_admin': loginResponse.user?.isAdmin ?? false,
              'crm_category': loginResponse.user?.crmCategory ?? '',
            },
          );
        } else {
          Get.snackbar(
            'Error',
            'Failed to save user data',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Invalid login credentials',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      String errorMessage = 'Login failed. Please try again.';
      if (e is PlatformException && e.code == 'channel-error') {
        errorMessage = 'Failed to access local storage. Please try again.';
      } else if (e.toString().contains('timeout')) {
        errorMessage = 'Request timeout. Please try again.';
      } else if (e.toString().contains('401') || e.toString().contains('unauthorized')) {
        errorMessage = 'Invalid email or password.';
      } else if (e is SocketException || e.toString().contains('network')) {
        errorMessage = 'Network error. Please check your internet connection.';
      }
      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      loading.value = false;
    }
  }

  Future<void> loginWithBasicSave(BuildContext context) async {
    loading.value = true;
    try {
      Map<String, dynamic> loginData = {
        'email': emailController.value.text.trim(),
        'password': passwordController.value.text.trim(),
      };

      final LoginResponseModel loginResponse = await _apiRepository.loginApi(loginData);

      if (loginResponse.accessToken != null && loginResponse.accessToken!.isNotEmpty) {
        bool saved = await _userPreference.saveUser(
          loginResponse.accessToken!,
          loginResponse.user?.firstName ?? '',
          loginResponse.user?.email ?? '',
          remember.value,
        );
        if (saved) {
          Get.offAllNamed(RoutesName.home_manager);
        } else {
          Get.snackbar(
            'Error',
            'Failed to save user data',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      Get.snackbar(
        'Error',
        'Login failed. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      loading.value = false;
    }
  }

  Future<void> checkLoginStatus() async {
    try {
      await _userPreference.initializePreferences();
      bool isLoggedIn = await _userPreference.isLoggedIn();
      if (isLoggedIn) {
        LoginResponseModel userData = await _userPreference.getUser();
        if (userData.accessToken != null && userData.accessToken!.isNotEmpty) {
          if (kDebugMode) {
            print('User is logged in, navigating to home_manager');
          }
          Get.offAllNamed(RoutesName.home_manager, arguments: {
            'accessToken': userData.accessToken,
            'email': userData.user?.email ?? '',
            'first_name': userData.user?.firstName ?? '',
            'last_name': userData.user?.lastName ?? '',
            'user_id': userData.user?.id ?? '',
            'is_admin': userData.user?.isAdmin ?? false,
            'crm_category': userData.user?.crmCategory ?? '',
          });
        } else {
          if (kDebugMode) {
            print('Invalid or expired session, navigating to login');
          }
          Get.offAllNamed(RoutesName.login_screen);
        }
      } else {
        if (kDebugMode) {
          print('No user logged in, navigating to login');
        }
        Get.offAllNamed(RoutesName.login_screen);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking login status: $e');
      }
      Get.offAllNamed(RoutesName.login_screen);
    }
  }

  Future<void> logout() async {
    try {
      bool cleared = await _userPreference.removeUser();
      if (cleared) {
        Get.offAllNamed(RoutesName.login_screen);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Logout error: $e');
      }
    }
  }

  void clearForm() {
    emailController.value.clear();
    passwordController.value.clear();
    remember.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    // Future.delayed(Duration(seconds: 10), () {
    //   checkLoginStatus();
    // });
  }

  @override
  void onClose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    emailFocusNode.value.dispose();
    passwordFocusNode.value.dispose();
    super.onClose();
  }
}