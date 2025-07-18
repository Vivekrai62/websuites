import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:websuites/utils/dark_mode/dark_mode.dart';
import '../../Utils/Routes/routes_name.dart';
import '../../Utils/utils.dart';
import '../../resources/imageStrings/image_strings.dart';
import '../../resources/strings/strings.dart';
import '../../resources/textStyles/text_styles.dart';
import '../../utils/appColors/app_colors.dart';
import '../../utils/components/buttons/common_button.dart';
import '../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../utils/responsive/responsive_layout.dart';
import '../../utils/responsive/responsive_utils.dart';
import '../../viewModels/loginScreen/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel loginController = Get.put(LoginViewModel(), permanent: true);
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool isLoggedIn = false.obs;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      scaffoldKey: scaffoldKey,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible( // Changed from Expanded to Flexible
                          flex: 8,
                          child: Container(
                            width: ResponsiveUtilsScreenSize.isDesktop(context)
                                ? 0.3 * MediaQuery.of(context).size.width
                                : ResponsiveUtilsScreenSize.isTablet(context)
                                ? 0.6 * MediaQuery.of(context).size.width
                                : 0.9 * MediaQuery.of(context).size.width,
                            // Remove fixed height constraint
                            // height: ResponsiveUtilsScreenSize.isDesktop(context)
                            //     ? 400
                            //     : MediaQuery.of(context).size.height * 0.8,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min, // Add this
                              children: [
                                // Make logo smaller in landscape
                                AspectRatio(
                                  aspectRatio: ResponsiveUtilsScreenSize.isMobile(context) ||
                                      ResponsiveUtilsScreenSize.isTablet(context)
                                      ? (MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                      ? 6 / 1
                                      : 8 / 1) // Wider ratio for landscape
                                      : 6 / 1,
                                  child: Image.asset(ImageStrings.splashWHLogo),
                                ),
                                SizedBox(height: MediaQuery.of(context).orientation == Orientation.landscape
                                    ? Get.height / 50 // Smaller spacing in landscape
                                    : Get.height / 30),
                                Column(
                                  children: [
                                    TextStyles.w500_universal(
                                      fontSize: ResponsiveUtilsScreenSize.isMobile(context)
                                          ? 20
                                          : (ResponsiveUtilsScreenSize.isTablet(context)
                                          ? 22
                                          : 24),
                                      context,
                                      Strings.login,
                                      color: DarkMode.welcome(context),
                                    ),
                                    SizedBox(height: Get.height / 80),
                                    TextStyles.w400_13(
                                      color: AllColors.lightGrey,
                                      context,
                                      Strings.pleaseSignIn,
                                    ),
                                    TextStyles.w400_13(
                                      color: AllColors.lightGrey,
                                      context,
                                      Strings.theAdventure,
                                    ),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).orientation == Orientation.landscape
                                    ? Get.height / 50 // Smaller spacing in landscape
                                    : Get.height / 30),
                                Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextStyles.w400_15(context, Strings.email,color: DarkMode.backgroundColor2(context)),
                                      SizedBox(height: 8,),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          color: AllColors.textField2,
                                        ),
                                        child: Obx(() => TextFormField(
                                          style: TextStyle(color: DarkMode.backgroundColorTextField(context)),
                                          cursorColor: Colors.black45,
                                          controller: loginController.emailController.value,
                                          focusNode: loginController.emailFocusNode.value,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return Strings.flushEmail;
                                            }
                                            final emailRegex = RegExp(
                                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                            if (!emailRegex.hasMatch(value)) {
                                              return Strings.validEmailPassword;
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: Strings.hintEmail,
                                            hintStyle:
                                            TextStyles.textFormHintStyle(context),
                                          ),
                                          onFieldSubmitted: (_) => Utils.fieldFocusChange(
                                              context,
                                              loginController.emailFocusNode.value,
                                              loginController.passwordFocusNode.value),
                                        )),
                                      ),
                                      const SizedBox(height: 16),
                                      TextStyles.w400_15(context, Strings.password),
                                      SizedBox(height: 8,),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          color: AllColors.textField2,
                                        ),
                                        child: Obx(() => TextFormField(
                                          style: TextStyle(color: DarkMode.backgroundColorTextField(context)),
                                          obscureText: loginController.obscurePassword.value,
                                          cursorColor: Colors.black45,
                                          controller: loginController.passwordController.value,
                                          focusNode: loginController.passwordFocusNode.value,
                                          validator: (value) =>
                                          value!.isEmpty ? Strings.flushPass : null,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: Strings.hintPassword,
                                            hintStyle:
                                            TextStyles.textFormHintStyle(context),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                loginController.obscurePassword.value
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () => loginController
                                                  .obscurePassword
                                                  .value = !loginController.obscurePassword.value,
                                            ),
                                          ),
                                          onFieldSubmitted: (_) => Utils.fieldFocusChange(
                                              context,
                                              loginController.passwordFocusNode.value,
                                              loginController.emailFocusNode.value),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).orientation == Orientation.landscape
                                    ? Get.height / 60 // Smaller spacing in landscape
                                    : Get.height / 40),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 20.0,
                                          width: 20.0,
                                          child: Obx(() => Checkbox(
                                            checkColor: Colors.black45,
                                            activeColor: Colors.blue,
                                            value: loginController.remember.value,
                                            onChanged: (value) =>
                                            loginController.remember.value = value!,
                                          )),
                                        ),
                                        const SizedBox(width: 8),
                                        TextStyles.w400_12(
                                          context,
                                          Strings.rememberMe,
                                          color: AllColors.grey,
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () => Get.offNamed(RoutesName.forgot_password_screen),
                                      child: TextStyles.w400_12(
                                        context,
                                        Strings.forgotPassword,
                                        color: AllColors.buttonColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Obx(() => CommonButton(
                                  width: double.infinity,
                                  title: Strings.button,
                                  loading: loginController.loading.value,
                                  onPress: () {
                                    if (formKey.currentState!.validate()) {
                                      loginController.login(context);
                                    }
                                  },
                                )),
                                const SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextStyles.w400_13(
                                      color: AllColors.lightGrey,
                                      context,
                                      Strings.newOn,
                                    ),
                                    const SizedBox(width: 4),
                                    InkWell(
                                      onTap: () async {
                                        final Uri url = Uri.parse('https://www.whsuites.com');
                                        try {
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url,
                                                mode: LaunchMode.externalApplication);
                                          } else {
                                            Utils.flushBarErrorMessage(Strings.sales, context);
                                          }
                                        } catch (e) {
                                          Utils.flushBarErrorMessage(Strings.sales, context);
                                        }
                                      },
                                      child: TextStyles.w400_13(
                                        color: AllColors.buttonColor,
                                        context,
                                        Strings.purchaseNow,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Bottom logo with flexible spacing
                        if (MediaQuery.of(context).orientation == Orientation.portrait)
                          const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).orientation == Orientation.landscape ? 10 : 20,
                              top: MediaQuery.of(context).orientation == Orientation.landscape ? 10 : 0
                          ),
                          child: Image.asset(
                            ImageStrings.splashBottomLogo,
                            height: MediaQuery.of(context).orientation == Orientation.landscape ? 30 : 50,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: AllColors.mediumPurple,
    );
  }
}