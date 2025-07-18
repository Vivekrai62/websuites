// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Utils/Routes/routes_name.dart';
// import '../../Utils/utils.dart';
// import '../../resources/imageStrings/image_strings.dart';
// import '../../resources/strings/strings.dart';
// import '../../resources/textStyles/text_styles.dart';
// import '../../utils/appColors/app_colors.dart';
// import '../../utils/components/buttons/common_button.dart';
// import '../../utils/responsive/responsive_layout.dart';
// import '../../viewModels/loginScreen/login_view_model.dart';
//
// class NewLoginScreen extends StatefulWidget {
//   const NewLoginScreen({super.key});
//
//   @override
//   State<NewLoginScreen> createState() => _NewLoginScreenState();
// }
//
// class _NewLoginScreenState extends State<NewLoginScreen> {
//   final LoginViewModel loginController = Get.put(LoginViewModel());
//   final RxBool obscurePassword = true.obs;
//   final formkey = GlobalKey<FormState>();
//
//   void toggleObscurePassword() {
//     obscurePassword.value = !obscurePassword.value;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return OrientationBuilder(
//       builder: (context, orientation) {
//         // Responsive design based on screen size
//         final double screenHeight = MediaQuery.of(context).size.height;
//         final double screenWidth = MediaQuery.of(context).size.width;
//         return ResponsiveScaffold(
//           scaffoldKey: GlobalKey<ScaffoldState>(),
//           body: SingleChildScrollView(
//             // Add SingleChildScrollView for scrollability
//             child: Center(
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
//                 width: screenWidth * 0.8, // Adjust width for responsiveness
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: screenHeight * 0.1),
//                     Image.asset(ImageStrings.splashWHLogo, scale: 7),
//                     SizedBox(height: screenHeight * 0.04),
//                     TextStyles.w500_universal(
//                       fontSize: 25,
//                       context,
//                       Strings.login,
//                       color: AllColors.welcomeColor,
//                     ),
//                     SizedBox(height: screenHeight * 0.02),
//                     TextStyles.w400_13(
//                       color: AllColors.lightGrey,
//                       context,
//                       Strings.pleaseSignIn,
//                     ),
//                     TextStyles.w400_13(
//                       color: AllColors.lightGrey,
//                       context,
//                       Strings.theAdventure,
//                     ),
//                     const SizedBox(height: 20),
//                     Form(
//                       key: formkey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextStyles.w400_15(context, Strings.email),
//                           Container(
//                             padding: const EdgeInsets.only(left: 5),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5.0),
//                               color: AllColors.textField2,
//                             ),
//                             child: Obx(() => TextFormField(
//                               cursorColor: Colors.black45,
//                               controller:
//                               loginController.emailController.value,
//                               focusNode:
//                               loginController.emailFocusNode.value,
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   Utils.flushBarErrorMessage(
//                                       Strings.flushEmail, context);
//                                 }
//                                 return null;
//                               },
//                               decoration: const InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: Strings.hintEmail,
//                                 hintStyle: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 13,
//                                 ),
//                               ),
//                               onFieldSubmitted: (value) {
//                                 Utils.fieldFocusChange(
//                                   context,
//                                   loginController.emailFocusNode.value,
//                                   loginController.passwordFocusNode.value,
//                                 );
//                               },
//                             )),
//                           ),
//                           const SizedBox(height: 20),
//                           TextStyles.w400_15(context, Strings.password),
//                           Container(
//                             padding: const EdgeInsets.only(left: 5),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5.0),
//                               color: AllColors.textField2,
//                             ),
//                             child: Obx(
//                                   () => TextFormField(
//                                 cursorColor: Colors.black45,
//                                 controller:
//                                 loginController.passwordController.value,
//                                 focusNode:
//                                 loginController.passwordFocusNode.value,
//                                 decoration: InputDecoration(
//                                   hintText: Strings.hintPassword,
//                                   suffixIcon: InkWell(
//                                     onTap: toggleObscurePassword,
//                                     child: Icon(obscurePassword.value
//                                         ? Icons.visibility_off_outlined
//                                         : Icons.visibility),
//                                   ),
//                                   hintStyle: const TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 13,
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     Utils.flushBarErrorMessage(
//                                         Strings.flushPass, context);
//                                   }
//                                   return null;
//                                 },
//                                 obscureText: obscurePassword.value,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: screenHeight * 0.02),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 24.0,
//                                 width: 24.0,
//                                 child: Obx(
//                                       () => Checkbox(
//                                     checkColor: Colors.black45,
//                                     activeColor: Colors.blue,
//                                     value: loginController.remember.value,
//                                     onChanged: (value) {
//                                       loginController.remember.value =
//                                       !loginController.remember.value;
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               TextStyles.w400_12(context, Strings.rememberMe,
//                                   color: AllColors.grey),
//                               const Spacer(),
//                               InkWell(
//                                 onTap: () {
//                                   Get.offNamed(
//                                       RoutesName.forgot_password_screen);
//                                 },
//                                 child: TextStyles.w400_12(
//                                     context, Strings.forgotPassword,
//                                     color: AllColors.buttonColor),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 23),
//                           Obx(
//                                 () => CommonButton(
//                               width: screenWidth * 0.8,
//                               title: Strings.button,
//                               loading: loginController.loading.value,
//                               onPress: () async {
//                                 if (formkey.currentState!.validate()) {
//                                   loginController.login(context);
//                                 }
//                               },
//                             ),
//                           ),
//                           const SizedBox(height: 14),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               TextStyles.w400_12(context, Strings.newOn),
//                               InkWell(
//                                 onTap: () {
//                                   Get.toNamed(RoutesName.purchase_now_screen);
//                                 },
//                                 child: TextStyles.w400_12(
//                                     context, Strings.purchaseNow,
//                                     color: AllColors.buttonColor),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 20),
//                       child:
//                       Image.asset(ImageStrings.splashBottomLogo, scale: 4),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           floatingActionButtonLocation:
//           FloatingActionButtonLocation.centerDocked,
//           backgroundColor: AllColors.mediumPurple,
//         );
//       },
//     );
//   }
// }