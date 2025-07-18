import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import '../../resources/imageStrings/image_strings.dart';
import '../../utils/appColors/app_colors.dart';
import '../../viewModels/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices _splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() {
    // Add a small delay to ensure the splash screen is visible
    Future.delayed(const Duration(milliseconds: 500), () {
      _splashServices.isLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.whiteColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Image.asset(
                    ImageStrings.splashWHLogo,
                    scale: 4.7,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 50,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: Get.height / 8,
              padding: const EdgeInsets.only(bottom: 20),
              child: Image.asset(
                ImageStrings.splashBottomLogo,
                scale: 3.9,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}