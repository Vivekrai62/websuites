import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../Utils/Routes/routes_name.dart';
import '../../resources/imageStrings/image_strings.dart';
import '../../resources/strings/strings.dart';
import '../../resources/textStyles/text_styles.dart';
import '../../utils/appColors/app_colors.dart';
import '../../utils/components/buttons/common_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AllColors.whiteColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: Get.height * 1,
            margin: const EdgeInsets.only(
              right: 40,
              left: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageStrings.welcomeCompanyLogo,
                  scale: 5.5,
                ),
                const SizedBox(height: 30),
                TextStyles.w600_universal(
                    fontSize: 20,
                    color: AllColors.welcomeColor,
                    context,
                    Strings.welcomeTo),
                const SizedBox(height: 10),
                TextStyles.w400_12(
                    color: AllColors.grey, context, Strings.weTextedYou),
                Center(
                  child: TextStyles.w400_12(
                      color: AllColors.grey, context, Strings.theCodeToSignIn),
                ),
                const SizedBox(height: 10),
                TextStyles.w600_universal(
                    color: AllColors.blackColor,
                    fontSize: 14,
                    context,
                    Strings.enterCode),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: Get.height / 15,
                  child: const Pinput(
                    keyboardType: TextInputType.number,
                    length: 6,
                    hapticFeedbackType: HapticFeedbackType.mediumImpact,
                    showCursor: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 380,
                  child: CommonButton(
                    title: Strings.button,
                    onPress: () {
                      Get.offNamed(RoutesName.home_screen);
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RoutesName.forgot_password_screen);
                  },
                  child: SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextStyles.w300_10(context, Strings.resendOtp)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
