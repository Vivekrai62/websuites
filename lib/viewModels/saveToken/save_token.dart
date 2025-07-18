import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/responseModels/login/login_response_model.dart';

class SaveUserData {
  static SharedPreferences? _prefs;
  static bool _isInitialized = false;
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(milliseconds: 500);

  Future<bool> saveString(String key, String value) async {
    try {
      final SharedPreferences sp = await _getPrefs();
      await sp.setString(key, value);
      if (kDebugMode) {
        print("Updated $key with value: $value");
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error updating user field $key: $e");
      }
      return false;
    }
  }

  Future<String?> getString(String key) async {
    try {
      final SharedPreferences sp = await _getPrefs();
      String? value = sp.getString(key);
      if (kDebugMode) {
        print("Retrieved $key: $value");
      }
      return value;
    } catch (e) {
      if (kDebugMode) {
        print("Error getting $key: $e");
      }
      return null;
    }
  }


  Future<void> initializePreferences() async {
    if (_isInitialized && _prefs != null) {
      if (kDebugMode) {
        print("SharedPreferences already initialized");
      }
      return;
    }

    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        await Future.delayed(_retryDelay);
        _prefs = await SharedPreferences.getInstance();
        _isInitialized = true;
        if (kDebugMode) {
          print("SharedPreferences initialized successfully on attempt $attempt");
        }
        return;
      } catch (e) {
        if (kDebugMode) {
          print("Attempt $attempt failed to initialize SharedPreferences: $e");
        }
        if (attempt == _maxRetries) {
          _isInitialized = false;
          _prefs = null;
          if (kDebugMode) {
            print("Max retries reached. SharedPreferences initialization failed.");
          }
          throw PlatformException(
            code: 'channel-error',
            message: 'Failed to initialize SharedPreferences after $_maxRetries attempts: $e',
            details: null,
          );
        }
      }
    }
  }

  // Get SharedPreferences instance
  Future<SharedPreferences> _getPrefs() async {
    if (_prefs == null || !_isInitialized) {
      await initializePreferences();
    }
    if (_prefs == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'SharedPreferences could not be initialized',
        details: null,
      );
    }
    return _prefs!;
  }

  // Save user data
  Future<bool> saveUser(String token, String firstName, String email, bool rememberValue) async {
    try {
      final SharedPreferences sp = await _getPrefs();
      await sp.setString('accessToken', token);
      await sp.setString('first_name', firstName);
      await sp.setString('email', email);
      await sp.setBool('remember_me', rememberValue);
      await sp.setInt('login_timestamp', DateTime.now().millisecondsSinceEpoch);

      if (kDebugMode) {
        print("User data saved: token=$token, firstName=$firstName, email=$email, remember=$rememberValue");
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error saving user data: $e");
      }
      return false;
    }
  }

  // Get user data with enhanced session check
  Future<LoginResponseModel> getUser() async {
    try {
      final SharedPreferences sp = await _getPrefs();
      String? token = sp.getString('accessToken');
      String? firstName = sp.getString('first_name');
      String? email = sp.getString('email');
      bool? isAdmin = sp.getBool('is_admin');
      bool? rememberMe = sp.getBool('remember_me') ?? true; // Default to true
      int? loginTimestamp = sp.getInt('login_timestamp');

      if (kDebugMode) {
        print("Retrieved: token=$token, firstName=$firstName, email=$email, rememberMe=$rememberMe, loginTimestamp=$loginTimestamp");
      }

      if (token == null || token.isEmpty || token == 'null') {
        if (kDebugMode) {
          print("No valid token found");
        }
        return LoginResponseModel(accessToken: '', user: null);
      }

      // Skip expiration check for fresh logins (e.g., within 10 seconds)
      if (rememberMe == false && loginTimestamp != null) {
        final now = DateTime.now().millisecondsSinceEpoch;
        final sessionAge = now - loginTimestamp;
        const maxSessionAge = 24 * 60 * 60 * 1000; // 24 hours
        const freshLoginThreshold = 10 * 1000; // 10 seconds

        if (sessionAge > maxSessionAge && sessionAge > freshLoginThreshold) {
          if (kDebugMode) {
            print("Session expired (age: $sessionAge ms), clearing data");
          }
          await removeUser();
          return LoginResponseModel(accessToken: '', user: null);
        }
      }

      return LoginResponseModel(
        accessToken: token,
        user: User(
          id: sp.getString('user_id') ?? '',
          firstName: firstName ?? '',
          lastName: sp.getString('last_name') ?? '',
          email: email ?? '',
          isAdmin: isAdmin ?? false,
          crmCategory: sp.getString('crm_category') ?? '',
          mobileApp: null,
          superSettings: null,
          isWhatsappEnabled: sp.getBool('whatsapp_enabled'),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error getting user data: $e");
      }
      return LoginResponseModel(accessToken: '', user: null);
    }
  }

  // Save complete user data
  Future<bool> saveCompleteUserData(LoginResponseModel loginResponse, {bool rememberMe = true}) async {
    try {
      final SharedPreferences sp = await _getPrefs();
      await sp.setString('accessToken', loginResponse.accessToken ?? '');
      await sp.setBool('remember_me', rememberMe); // Explicitly save rememberMe
      if (loginResponse.user != null) {
        final user = loginResponse.user!;
        await sp.setString('user_id', user.id ?? '');
        await sp.setString('first_name', user.firstName ?? '');
        await sp.setString('last_name', user.lastName ?? '');
        await sp.setString('email', user.email ?? '');
        await sp.setBool('is_admin', user.isAdmin ?? false);
        await sp.setString('crm_category', user.crmCategory ?? '');
        if (user.isWhatsappEnabled != null) {
          await sp.setBool('whatsapp_enabled', user.isWhatsappEnabled!);
        }
      }
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      await sp.setInt('login_timestamp', timestamp);

      if (kDebugMode) {
        print("Complete user data saved: token=${loginResponse.accessToken}, rememberMe=$rememberMe, login_timestamp=$timestamp");
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error saving complete user data: $e");
      }
      return false;
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final SharedPreferences sp = await _getPrefs();
      String? token = sp.getString('accessToken');
      bool loggedIn = token != null && token.isNotEmpty && token != 'null';
      if (kDebugMode) {
        print("User logged in status: $loggedIn");
      }
      return loggedIn;
    } catch (e) {
      if (kDebugMode) {
        print("Error checking login status: $e");
      }
      return false;
    }
  }

  // Get access token
  Future<String?> getAccessToken() async {
    try {
      final SharedPreferences sp = await _getPrefs();
      String? token = sp.getString('accessToken');
      return token != null && token.isNotEmpty && token != 'null' ? token : null;
    } catch (e) {
      if (kDebugMode) {
        print("Error getting access token: $e");
      }
      return null;
    }
  }

  // Remove user data
  Future<bool> removeUser() async {
    try {
      final SharedPreferences sp = await _getPrefs();
      List<String> keysToRemove = [
        'accessToken',
        'first_name',
        'last_name',
        'email',
        'user_id',
        'is_admin',
        'crm_category',
        'whatsapp_enabled',
        'remember_me',
        'login_timestamp',
      ];
      for (String key in keysToRemove) {
        await sp.remove(key);
      }
      if (kDebugMode) {
        print("User data removed successfully");
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error removing user data: $e");
      }
      return false;
    }
  }

  // Clear all preferences
  Future<bool> clearAllPreferences() async {
    try {
      final SharedPreferences sp = await _getPrefs();
      await sp.clear();
      if (kDebugMode) {
        print("All preferences cleared successfully");
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error clearing all preferences: $e");
      }
      return false;
    }
  }

  // Update specific user field
  Future<bool> updateUserField(String key, dynamic value) async {
    try {
      final SharedPreferences sp = await _getPrefs();
      if (value is String) {
        await sp.setString(key, value);
      } else if (value is bool) {
        await sp.setBool(key, value);
      } else if (value is int) {
        await sp.setInt(key, value);
      } else if (value is double) {
        await sp.setDouble(key, value);
      } else {
        await sp.setString(key, value.toString());
      }
      if (kDebugMode) {
        print("Updated $key with value: $value");
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error updating user field $key: $e");
      }
      return false;
    }
  }

  // Get remember me preference
  Future<bool> getRememberMe() async {
    try {
      final SharedPreferences sp = await _getPrefs();
      bool? rememberMe = sp.getBool('remember_me');
      if (kDebugMode) {
        print("Retrieved remember_me: $rememberMe");
      }
      return rememberMe ?? true; // Default to true to avoid premature expiration
    } catch (e) {
      if (kDebugMode) {
        print("Error getting remember me preference: $e");
      }
      return true; // Default to true to avoid premature expiration
    }
  }

  // Set remember me preference
  Future<bool> setRememberMe(bool value) async {
    try {
      final SharedPreferences sp = await _getPrefs();
      await sp.setBool('remember_me', value);
      if (kDebugMode) {
        print("Set remember_me to: $value");
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error setting remember me preference: $e");
      }
      return false;
    }
  }
}