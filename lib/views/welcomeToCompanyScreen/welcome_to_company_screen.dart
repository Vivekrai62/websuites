import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import '../../resources/imageStrings/image_strings.dart';
import '../../resources/strings/strings.dart';
import '../../resources/textStyles/text_styles.dart';
import '../../utils/appColors/app_colors.dart';

class WelcomeToCompany extends StatefulWidget {
  const WelcomeToCompany({super.key});

  @override
  State<WelcomeToCompany> createState() => _WelcomeToCompanyState();
}

class _WelcomeToCompanyState extends State<WelcomeToCompany> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.whiteColor,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ImageStrings.welcomeCompanyLogo,
                scale: 5.5,
              ),

              const SizedBox(
                height: 10,
              ),

              TextStyles.w600_universal(
                  fontSize: 20,
                  color: AllColors.welcomeColor,
                  context,
                  Strings.welcomeTitle),

              const SizedBox(
                height: 7,
              ),

              TextStyles.w400_13(
                  color: AllColors.grey, context, Strings.verifyYourIdentity),

              const SizedBox(
                height: 35,
              ),

              TextStyles.w500_16(
                  color: AllColors.blackColor, context, Strings.welcomeEmail),

              const SizedBox(
                height: 20,
              ),

              // WelcomeScreenButton(
              //       title: Strings.Welcome_Button1,
              //   onPress: (){},),

              CommonButton(
                height: Get.height / 20,
                width: Get.width / 1,
                title: Strings.mobileNumberCode,
                onPress: () {},
              ),

              const SizedBox(height: 15),

              // WelcomeScreenButton(
              //   title: Strings.Welcome_Button2,
              //   onPress: (){},),

              CommonButton(
                height: Get.height / 20,
                width: Get.width / 1,
                title: Strings.emailAddressCode,
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
