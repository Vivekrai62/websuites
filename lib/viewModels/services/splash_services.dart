import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../Utils/Routes/routes_name.dart';
import '../../data/models/responseModels/login/login_response_model.dart';
import '../../viewModels/saveToken/save_token.dart';

class SplashServices {
  final SaveUserData _userPreference = SaveUserData();

  void isLogin() async {
    try {
      await _userPreference.initializePreferences();
      await Future.delayed(const Duration(milliseconds: 1500)); // Splash screen delay

      if (kDebugMode) {
        print('Checking login status...');
      }

      final bool loggedIn = await _userPreference.isLoggedIn();
      if (loggedIn) {
        final loginResponse = await _userPreference.getUser();
        if (loginResponse.accessToken != null && loginResponse.accessToken!.isNotEmpty) {
          if (kDebugMode) {
            print('User is logged in with token: ${loginResponse.accessToken}');
          }
          _navigateToHome(loginResponse);
        } else {
          if (kDebugMode) {
            print('Invalid or expired session, navigating to login');
          }
          _navigateToLogin();
        }
      } else {
        if (kDebugMode) {
          print('User is not logged in, navigating to login screen');
        }
        _navigateToLogin();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in splash service: $e');
      }
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Timer(const Duration(milliseconds: 500), () {
      if (Get.context != null) {
        Get.offAllNamed(RoutesName.login_screen);
      }
    });
  }

  void _navigateToHome(LoginResponseModel loginResponse) {
    Timer(const Duration(milliseconds: 500), () {
      if (Get.context != null) {
        Get.offAllNamed(
          RoutesName.home_manager,
          arguments: {
            'accessToken': loginResponse.accessToken ?? '',
            'email': loginResponse.user?.email ?? '',
            'first_name': loginResponse.user?.firstName ?? '',
            'last_name': loginResponse.user?.lastName ?? '',
            'user_id': loginResponse.user?.id ?? '',
            'is_admin': loginResponse.user?.isAdmin ?? false,
            'crm_category': loginResponse.user?.crmCategory ?? '',
          },
        );
      }
    });
  }
}