import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:websuites/resources/getxLocalization/languages.dart';
import 'package:websuites/views/bottomNavBarScreen/profile_Screen/bottom__nav_profile_screen.dart';
import 'Utils/Routes/routes.dart';
import 'Utils/Routes/routes_name.dart';
import 'data/repositories/repositories.dart';
import 'viewModels/saveToken/save_token.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
  runApp(const MyApp());
}

Future<void> _initializeApp() async {
  try {
    SaveUserData saveUserData = SaveUserData();
    await saveUserData.initializePreferences();
    if (!kIsWeb) {
      HttpOverrides.global = MyHttpOverrides();
    }
    if (kDebugMode) {
      print('App initialization completed successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error during app initialization: $e');
    }
    // Fallback: Proceed to run app even if initialization fails
    if (!kIsWeb) {
      try {
        HttpOverrides.global = MyHttpOverrides();
      } catch (httpError) {
        if (kDebugMode) {
          print('Error setting up HTTP overrides: $httpError');
        }
      }
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ThemeController
    Get.put(ThemeController());

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: 'WHCrm',
          translations: Languages(),
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          theme: ThemeData(
            fontFamily: 'Nunito',
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: Colors.grey[50],
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.black),
              titleLarge: TextStyle(color: Colors.black),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
              ),
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            fontFamily: 'Nunito',
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: Colors.grey[900],
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.white),
              titleLarge: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey[800],
              ),
            ),
            useMaterial3: true,
          ),
          themeMode: Get.find<ThemeController>().themeMode.value, // Bind to ThemeController
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesName.splash_screen,
          getPages: AllRoutes.appRoutes(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            );
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) =>
      host == 'api.unlayer.com';
  }
}