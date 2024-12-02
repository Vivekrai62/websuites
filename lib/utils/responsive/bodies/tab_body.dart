// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import '../../Utils/Routes/routes_name.dart';
// // import '../../Utils/utils.dart';
// // import '../../resources/imageStrings/image_strings.dart';
// // import '../../resources/strings/strings.dart';
// // import '../../resources/textStyles/text_styles.dart';
// // import '../../utils/appColors/app_colors.dart';
// // import '../../utils/components/buttons/common_button.dart';
// // import '../../viewModels/loginScreen/login_view_model.dart';
// //
// //
// //
// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});
// //
// //   @override
// //   State<LoginScreen> createState() => _Login_ScreenState();
// // }
// //
// // class _Login_ScreenState extends State<LoginScreen> {
// //
// //   final LoginViewModel loginController= Get.put(LoginViewModel());
// //   final RxBool rememberMe = false.obs;
// //   final RxBool obscurePassword = true.obs;
// //
// //   final formkey = GlobalKey<FormState>();
// //
// //
// //   void toggleObscurePassword() {
// //     obscurePassword.value = !obscurePassword.value;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return
// //       Scaffold(
// //           backgroundColor: AllColors.whiteColor,
// //           body:
// //           SingleChildScrollView(scrollDirection: Axis.vertical,
// //             child: Center(
// //               child:
// //               Container(
// //
// //                 margin: EdgeInsets.symmetric(
// //                   horizontal: MediaQuery.of(context).size.width * 0.08,),
// //                 height: Get.height/1,
// //                 width: Get.width/1.2,
// //                 child:
// //                 Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //
// //                   children: [
// //                     SizedBox(height: Get.height/5),
// //
// //                     Image.asset(ImageStrings.splashWHLogo, scale: 7),
// //                     SizedBox(height: Get.height/28),
// //
// //
// //                     TextStyles.w500_universal(fontSize: 25, context, Strings.login, color: AllColors.welcomeColor),
// //
// //                     SizedBox(height: Get.height/100),
// //                     TextStyles.w400_13( color: AllColors.lightGrey, context, Strings.pleaseSignIn),
// //                     TextStyles.w400_13( color: AllColors.lightGrey, context, Strings.theAdventure),
// //
// //
// //
// //                     Column(
// //                       mainAxisAlignment: MainAxisAlignment.start,
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //
// //
// //                         TextStyles.w400_15(context, Strings.email),
// //
// //                         Form(
// //                           key: formkey,
// //                           child: Column(
// //                             mainAxisAlignment: MainAxisAlignment.start,
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Container(
// //                                 padding: EdgeInsets.only(
// //                                   left: MediaQuery.of(context).size.width * 0.01,
// //                                 ),
// //
// //
// //                                 decoration: BoxDecoration(
// //                                   borderRadius: BorderRadius.circular(5.0),
// //                                   color: AllColors.textField2,
// //                                 ),
// //
// //                                 child:
// //                                 Column(
// //                                   mainAxisAlignment: MainAxisAlignment.center,
// //                                   children: [
// //                                     Obx(() =>
// //                                         TextFormField(
// //                                           cursorColor: Colors.black45,
// //                                           controller: loginController.emailController.value,
// //                                           focusNode: loginController.emailFocusNode.value,
// //                                           validator: (value){
// //                                             if(value!.isEmpty){
// //                                               Utils.flushBarErrorMessage(Strings.flushEmail, context);
// //                                             }
// //                                             return null;
// //
// //                                           },
// //                                           decoration: InputDecoration(
// //                                             border: InputBorder.none,
// //                                             hintText: Strings.hintEmail,
// //                                             hintStyle: TextStyles.textFormHintStyle(context), // Use the custom hint style.
// //                                           ),
// //
// //
// //
// //
// //
// //                                           onFieldSubmitted: (value){
// //                                             Utils.fieldFocusChange(context,
// //                                                 loginController.emailFocusNode.value,
// //                                                 loginController.passwordFocusNode.value);
// //                                           },
// //                                         ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                               const SizedBox(height: 20,),
// //
// //                               TextStyles.w400_15(context, Strings.password),
// //
// //                               Container(
// //                                 padding: EdgeInsets.only(left: 5),
// //                                 decoration: BoxDecoration(
// //                                   borderRadius: BorderRadius.circular(5.0),
// //                                   color: AllColors.textField2,
// //                                 ),
// //
// //                                 child: Column(
// //                                   mainAxisAlignment: MainAxisAlignment.center,
// //                                   children: [
// //                                     Obx((){
// //                                       return TextFormField(
// //                                         cursorColor: Colors.black45,
// //                                         controller: loginController.passwordController.value,
// //                                         focusNode: loginController.passwordFocusNode.value,
// //                                         decoration: InputDecoration(
// //                                           hintText: Strings.hintPassword,
// //                                           suffixIcon: InkWell(
// //                                               onTap:(){
// //                                                 obscurePassword.value = ! obscurePassword.value;
// //                                               },
// //                                               child:Icon(obscurePassword.value ?
// //                                               Icons.visibility_off_outlined:
// //                                               Icons.visibility)
// //                                           ),
// //                                           hintStyle: TextStyles.textFormHintStyle(context), // Use the custom hint style.
// //                                           border: InputBorder.none,
// //                                         ),
// //                                         validator: (value) {
// //                                           if(value!.isEmpty) {
// //
// //                                             Utils.flushBarErrorMessage(
// //                                                 Strings.flushPass, context);
// //                                           }
// //                                           return null;
// //                                         },
// //                                         obscureText: obscurePassword.value,
// //                                       );
// //                                     }, // child: null,
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                         SizedBox(height: Get.height/90),
// //
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.start,
// //                           children: [
// //                             SizedBox(
// //                               height: 24.0,
// //                               width: 24.0,
// //                               child: Obx(()=> Checkbox(
// //                                 checkColor: Colors.black45,
// //                                 activeColor: Colors.blue,
// //                                 value: rememberMe.value,
// //                                 onChanged: (value){
// //                                   rememberMe.value = value!;
// //                                 },
// //                               ),
// //                               ),
// //                             ),
// //
// //                             TextStyles.w400_12(context, Strings.rememberMe, color: AllColors.grey),
// //                             const Spacer(),
// //
// //                             InkWell(
// //                               onTap: (){
// //                                 Get.offNamed(RoutesName.forgot_password_screen);
// //                               },
// //                               child:
// //
// //                               TextStyles.w400_12(context, Strings.forgotPassword, color: AllColors.buttonColor),
// //                             ),
// //                           ],
// //                         ),
// //                         const SizedBox(height: 23,),
// //                         Obx(() =>
// //                         // CommonButton(
// //                         //   width: Get.width*1,
// //                         //   title: Strings.button,
// //                         //   loading: loginController.loading.value,
// //                         //
// //                         //   onPress: (){
// //                         //     if(formkey.currentState != null && formkey.currentState!.validate()){
// //                         //        loginController.login(context);
// //                         //     }
// //                         //     },
// //                         // ),
// //
// //                         CommonButton(
// //                           width: Get.width * 1,
// //                           title: Strings.button,
// //                           loading: loginController.loading.value,
// //                           onPress: () {
// //                             String email = loginController.emailController.value.text;
// //                             String password = loginController.passwordController.value.text;
// //                             final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
// //                             if (formkey.currentState != null) {
// //                               if (email.isEmpty && password.isEmpty) {
// //                                 Utils.flushBarErrorMessage(Strings.flushEmailPassword, context);
// //                               }
// //                               else if (email.isEmpty) {
// //                                 Utils.flushBarErrorMessage(Strings.flushEmail, context);
// //                               }
// //                               else if (!emailRegex.hasMatch(email)) {
// //                                 Utils.flushBarErrorMessage(Strings.validemailpassword, context);
// //                               }
// //
// //                               else if (password.isEmpty) {
// //                                 Utils.flushBarErrorMessage(Strings.hintPassword, context);
// //                               }
// //
// //                               else if (formkey.currentState!.validate()) {
// //                                 loginController.login(context);
// //                               }
// //                             }
// //                           },
// //                         ),
// //
// //
// //                         ),
// //
// //                         const SizedBox(height: 14,),
// //
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             TextStyles.w400_12(context, Strings.newOn),
// //                             InkWell(
// //                               onTap: () async {
// //                                 final Uri url = Uri.parse('https://www.whsuites.com/');
// //                                 if (!await launchUrl(url)) {
// //                                   throw 'Could not launch $url';
// //                                 }
// //                               },
// //                               child: TextStyles.w400_12(
// //                                 context,
// //                                 Strings.purchaseNow,
// //                                 color: AllColors.buttonColor,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                     const Spacer(),
// //                     Padding(
// //                       padding: const EdgeInsets.only(bottom: 20),
// //                       child: Image.asset(
// //                           ImageStrings.splashBottomLogo,
// //                           scale: 4),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           )
// //       );
// //   }
// // }
// //
// //
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import '../../../Utils/Routes/routes_name.dart';
// import '../../../Utils/utils.dart';
// import '../../../data/models/responseModels/login/login_response_model.dart';
// import '../../../resources/imageStrings/image_strings.dart';
// import '../../../resources/strings/strings.dart';
// import '../../../viewModels/saveToken/save_token.dart';
// import '../../../views/homeScreen/widgets/cards/latest_customers_card.dart';
// import '../../../views/homeScreen/widgets/cards/latest_task_card.dart';
// import '../../../views/homeScreen/widgets/cards/lead_type_count_card.dart';
// import '../../../views/homeScreen/widgets/cards/revenue_card.dart';
// import '../../../views/homeScreen/widgets/cards/transaction_list_card.dart';
// import '../../appColors/app_colors.dart';
// import '../../components/buttons/common_button.dart';
// import '../../components/widgets/drawer/custom_drawer.dart';
// import '../../components/widgets/drawer/drawerListTiles/custom_list_tile.dart';
//
//
// class MyTabBody extends StatefulWidget {
//   const MyTabBody({super.key});
//
//   @override
//   State<MyTabBody> createState() => _MyTabBodyState();}
//
// class _MyTabBodyState extends State<MyTabBody> {
//
//   String userName = '';
//   String? userEmail = "";
//   SaveUserData userPreference = SaveUserData();
//
//   @override
//   void initState(){
//     fetchUserData();
//     super.initState();
//     }
//
//   Future<void> fetchUserData() async {
//     try {
//       LoginResponseModel response = await userPreference.getUser();
//       String? first_name = response.user!.first_name;
//       String? email = response.user!.email;
//       setState(() {
//         userName = first_name!;
//         userEmail = email!;
//       });
//     } catch(e){
//       print('Error fetching userData: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: OrientationBuilder(
//           builder: (context, orientation) {
//             if (orientation == Orientation.portrait) {
//               return portraitMode();
//             } else {
//               return landscapeMode();
//             }
//           },
//         ),
//       );
//   }
//
//   Widget
//   portraitMode() {
//     return
//       Row(
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 1,
//             child:
//             SingleChildScrollView(scrollDirection: Axis.vertical,
//               child: Column(
//                 children: [
//                   Container(
//                       color: AllColors.whiteColor,
//                       width: Get.width / 2,
//                       height: Get.height * 1,
//                       child: AppTabDrawer(
//                           userName: '$userName',
//                           phoneNumber: '$userEmail',
//                           version: '1.0.12'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             height: Get.height * 1,
//             width: 0.08,
//             margin: EdgeInsets.only(top: 30, bottom: 30),
//             color: AllColors.grey,
//           ),
//
//           const SizedBox(width: 10,),
//
//           Expanded(
//             flex: 2,
//             child:
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Stack(
//                     alignment: Alignment.topCenter,
//                     children: [
//                       Container(
//                         height: Get.height/5.4,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               AllColors.appBarColorTop,
//                               AllColors.appBarColorBottom,
//                             ],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                         ),
//                       ),
//
//                       Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             // App Bar
//                             Container(
//                               // color: Colors.blue,
//                               margin: const EdgeInsets.only(
//                                   left: 2, right: 12, top: 45, bottom: 25),
//                               child:
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: AllColors.whiteColor,
//                                     ),
//                                     height: Get.height/13,
//                                     width: Get.width/13,
//                                     child: Center(
//                                         child:
//                                         Image.asset(
//                                           ImageStrings. welcomeCompanyLogo,
//                                           scale:10,)
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//
//                             Container(
//                               // color: Colors.blue,
//                               padding: EdgeInsets.only(left: 8, right: 8,),
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child:
//                                 Row( //SCROLLER ROW WITH CONTAINERS
//                                   children: [
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 5,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'),
//
//
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 15,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'),
//
//
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 15,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'),
//
//
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 15,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'),
//
//
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 15,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'),
//
//
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 15,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'),
//
//
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 15,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ]
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: Get.height / 50,),
//
//                   Container(
//                     // color: Colors.grey,
//                     margin: const EdgeInsets.only(left: 10, right: 8,),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//
//                       children: [
//
//                         const Icon(Icons.list_alt_outlined, size: 20,),
//
//                         const SizedBox(width: 8,),
//
//                         Text(Strings.taskPerformance,
//                           style: TextStyle(
//                             fontSize: 17,
//
//                             fontWeight: FontWeight.w500,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         Text(Strings.taskPerformanceDate,
//                           style: TextStyle(
//                             fontSize: 15,
//
//                             fontWeight: FontWeight.w300,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Icon(Icons.arrow_drop_down, size: 40,)
//
//                       ],
//                     ),
//                   ), // ROW BAR
//
//                   const SizedBox(height: 20,),
//
//                   Container(
//                     margin: const EdgeInsets.only(right: 6, left: 6),
//                     padding: EdgeInsets.only(top: 50, bottom: 50),
//                     // height: Get.height/4,
//                     // width: Get.width/1.05,
//                     decoration: BoxDecoration(
//                       color: AllColors.whiteColor,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black45.withOpacity(0.06),
//                           spreadRadius: 0.5,
//                           blurRadius: 4,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           // height: Get.height/1,
//                           decoration: BoxDecoration(
//                             color: AllColors.whiteColor,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: AllColors.vividPurple.withOpacity(0.10),
//                                 spreadRadius: 10,
//                                 blurRadius: 8,
//                                 offset: const Offset(0, 0),
//                               ),
//                             ],
//                           ),
//
//                           child:
//                           CircularPercentIndicator(
//                             progressColor: AllColors.mediumPurple,
//                             backgroundColor: AllColors.lighterPurple,
//                             lineWidth: 14,
//                             radius: 90,
//                             percent: 0.4,
//                             startAngle: 0,
//                             animation: true,
//                             animationDuration: 2000,
//                             // backgroundWidth: 30,
//                             curve: Curves.decelerate,
//                             circularStrokeCap: CircularStrokeCap.round,
//                             center: Container(
//
//                               height: Get.height / 10,
//                               width: Get.width * 1,
//                               decoration: BoxDecoration(
//                                 color: AllColors.whiteColor,
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: AllColors.vividPurple.withOpacity(
//                                         0.04),
//                                     spreadRadius: 10,
//                                     blurRadius: 3,
//                                     offset: const Offset(0, 0),
//                                   ),
//                                 ],
//                               ),
//                               child: const
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(Strings.completed,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//
//                                       fontSize: 15,
//                                     ),
//                                   ),
//
//                                   // SizedBox(height: 5,),
//
//                                   Text('40%',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//
//
//                         Container(
//
//                           child:
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const Text(Strings.taskProgress,
//                                 style: TextStyle(
//                                   fontSize: 20,
//
//                                   fontWeight: FontWeight.w600,
//                                 ),),
//                               SizedBox(height: 5,),
//
//                               Row(
//                                 children: [
//                                   const Text('06:06:15 /',
//                                     style: TextStyle(
//                                       fontSize: 16,
//
//                                       fontWeight: FontWeight.w600,
//                                     ),),
//
//                                   SizedBox(width: 5,),
//
//                                   Text('4hrs',
//                                     style: TextStyle(
//                                       fontSize: 16,
//
//                                       fontWeight: FontWeight.w600,
//                                       color: AllColors.vividPurple,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//
//
//                   const SizedBox(height: 40,),
//
//                   Container(
//                     // color: Colors.grey,
//                     margin: const EdgeInsets.only(left: 10, right: 12,),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//
//                       children: [
//
//                         const Icon(Icons.list_alt_outlined, size: 20,),
//
//                         const SizedBox(width: 8,),
//
//                         Text(Strings.latestTask,
//                           style: TextStyle(
//                             fontSize: 17,
//
//                             fontWeight: FontWeight.w500,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         InkWell(
//                           onTap: () {},
//                           child: Text(Strings.latestTaskSeeAll,
//                             style: TextStyle(
//                               fontSize: 15,
//
//                               fontWeight: FontWeight.w400,
//                               color: AllColors.vividPurple,
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(width: 4,),
//
//                         Icon(Icons.arrow_forward_ios, size: 12,
//                           color: AllColors.vividPurple,)
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 30,),
//
//                   AppCardOneTab(
//                       title: 'Designing Task',
//                       subtitle: 'Somacare inner Images',
//                       date: '15 May, 2024 at 12:30 pm',
//                       ContainerIcon: Icons.access_time,
//                       IconColor: AllColors.vividPink,
//                       statusBackgroundColor: AllColors.lightPink,
//                       statusText: 'In Progress'),
//
//
//                   AppCardOneTab(
//                       title: 'Designing Task',
//                       subtitle: 'Somacare inner Images',
//                       date: '15 May, 2024 at 12:30 pm',
//                       ContainerIcon: Icons.access_time,
//                       IconColor: AllColors.darkGreen,
//                       statusBackgroundColor: AllColors.lightGreen,
//                       statusText: 'In Progress'),
//
//
//                   AppCardOneTab(
//                       title: 'Designing Task',
//                       subtitle: 'Somacare inner Images',
//                       date: '15 May, 2024 at 12:30 pm',
//                       ContainerIcon: Icons.access_time,
//                       IconColor: AllColors.darkBlue,
//                       statusBackgroundColor: AllColors.lightBlue,
//                       statusText: 'In Progress'),
//
//
//                   AppCardOneTab(
//                       title: 'Designing Task',
//                       subtitle: 'Somacare inner Images',
//                       date: '15 May, 2024 at 12:30 pm',
//                       ContainerIcon: Icons.access_time,
//                       IconColor: AllColors.darkRed,
//                       statusBackgroundColor: AllColors.lightRed,
//                       statusText: 'In Progress'),
//
//
//                   AppCardOneTab(
//                       title: 'Designing Task',
//                       subtitle: 'Somacare inner Images',
//                       date: '15 May, 2024 at 12:30 pm',
//                       ContainerIcon: Icons.access_time,
//                       IconColor: AllColors.darkYellow,
//                       statusBackgroundColor: AllColors.lightYellow,
//                       statusText: 'In Progress'),
//
//
//                   const SizedBox(height: 30,),
//                   Container(
//                     // color: Colors.grey,
//                     margin: const EdgeInsets.only(left: 10, right: 8,),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//
//                       children: [
//
//                         const Icon(Icons.list_alt_outlined, size: 20,),
//
//                         const SizedBox(width: 8,),
//
//                         Text(Strings.leadTypeCount,
//                           style: TextStyle(
//                             fontSize: 17,
//
//                             fontWeight: FontWeight.w500,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         Text(Strings.leadTypeDate,
//                           style: TextStyle(
//                             fontSize: 15,
//
//                             fontWeight: FontWeight.w300,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Icon(Icons.arrow_drop_down, size: 30,)
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20,),
//
//
//                   Container(
//                     padding: const EdgeInsets.only(
//                         left: 8, right: 8, top: 4, bottom: 4),
//                     child:
//                     SingleChildScrollView(scrollDirection: Axis.horizontal,
//                       child:
//                       Row( //SCROLLER ROW WITH CONTAINERS
//                         children: [
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.access_time,
//                               iconColor: AllColors.vividPink,
//                               containerColor: AllColors.lightPink),
//
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.task,
//                               iconColor: AllColors.vividBlue,
//                               containerColor: AllColors.lightBlue),
//
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.account_balance_rounded,
//                               iconColor: AllColors.vividGreen,
//                               containerColor: AllColors.lightGreen),
//
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.timelapse,
//                               iconColor: AllColors.mediumPurple,
//                               containerColor: AllColors.lighterPurple),
//
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.place,
//                               iconColor: AllColors.darkRed,
//                               containerColor: AllColors.lightRed),
//
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.policy,
//                               iconColor: AllColors.darkYellow,
//                               containerColor: AllColors.lightYellow),
//
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.title,
//                               iconColor: AllColors.darkGreen,
//                               containerColor: AllColors.lightGreen
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//
//                   const SizedBox(height: 20,),
//
//                   Container(
//                     // color: Colors.grey,
//                     margin: const EdgeInsets.only(left: 10, right: 12,),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//
//                       children: [
//
//                         const Icon(Icons.list_alt_outlined, size: 20,),
//
//                         const SizedBox(width: 8,),
//
//                         Text(Strings.latestCustomer,
//                           style: TextStyle(
//                             fontSize: 17,
//
//                             fontWeight: FontWeight.w500,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         InkWell(
//                           onTap: () {},
//                           child: Text(Strings.latestCustomerSeeAll,
//                             style: TextStyle(
//                               fontSize: 15,
//
//                               fontWeight: FontWeight.w400,
//                               color: AllColors.vividPurple,
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(width: 4,),
//
//                         Icon(Icons.arrow_forward_ios, size: 12,
//                           color: AllColors.vividPurple,)
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 40,),
//
//                   AppCardsTwoTab(
//                     title: 'Dermi Derm',
//                     subtitle: 'AYUSH GOYAL',
//                     date: '26 May, 2024 at 12:30 pm',
//                     circleColorOne: AllColors.lightPink,
//                     circleColorTwo: AllColors.lighterPurple,
//                     circleTextColorTwo: AllColors.mediumPurple,
//                     circleTextColorOne: AllColors.darkPink,),
//
//
//                   AppCardsTwoTab(
//                     title: 'Dermi Derm',
//                     subtitle: 'AYUSH GOYAL',
//                     date: '26 May, 2024 at 12:30 pm',
//                     circleColorOne: AllColors.lightPink,
//                     circleColorTwo: AllColors.lighterPurple,
//                     circleTextColorTwo: AllColors.mediumPurple,
//                     circleTextColorOne: AllColors.darkPink,),
//
//
//                   AppCardsTwoTab(
//                     title: 'Dermi Derm',
//                     subtitle: 'AYUSH GOYAL',
//                     date: '26 May, 2024 at 12:30 pm',
//                     circleColorOne: AllColors.lightPink,
//                     circleColorTwo: AllColors.lighterPurple,
//                     circleTextColorTwo: AllColors.mediumPurple,
//                     circleTextColorOne: AllColors.darkPink,),
//
//
//                   AppCardsTwoTab(
//                     title: 'Dermi Derm',
//                     subtitle: 'AYUSH GOYAL',
//                     date: '26 May, 2024 at 12:30 pm',
//                     circleColorOne: AllColors.lightPink,
//                     circleColorTwo: AllColors.lighterPurple,
//                     circleTextColorTwo: AllColors.mediumPurple,
//                     circleTextColorOne: AllColors.darkPink,),
//
//
//                   AppCardsTwoTab(
//                     title: 'Dermi Derm',
//                     subtitle: 'AYUSH GOYAL',
//                     date: '26 May, 2024 at 12:30 pm',
//                     circleColorOne: AllColors.lightPink,
//                     circleColorTwo: AllColors.lighterPurple,
//                     circleTextColorTwo: AllColors.mediumPurple,
//                     circleTextColorOne: AllColors.darkPink,),
//
//
//                   const SizedBox(height: 30,),
//                   Container(
//                     // color: Colors.grey,
//                     margin: const EdgeInsets.only(left: 10, right: 12,),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//
//                       children: [
//
//                         const Icon(Icons.list_alt_outlined, size: 20,),
//
//                         const SizedBox(width: 8,),
//
//                         Text(Strings.leadSource,
//                           style: TextStyle(
//                             fontSize: 17,
//
//                             fontWeight: FontWeight.w500,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         Icon(Icons.list, color: AllColors.lightGrey, size: 20,),
//
//                         const SizedBox(width: 10,),
//
//                         Text(Strings.leadSourceList,
//                           style: TextStyle(
//                             fontSize: 15,
//
//                             fontWeight: FontWeight.w300,
//                             color: AllColors.grey,
//                           ),
//                         ),
//
//                         const SizedBox(width: 10,),
//
//                         Icon(
//                           Icons.pie_chart, color: AllColors.vividBlue, size: 20,),
//
//                         const SizedBox(width: 5,),
//
//                         InkWell(
//                           onTap: () {},
//                           child: Text(Strings.leadSourceChart,
//                             style: TextStyle(
//                               fontSize: 12,
//
//                               fontWeight: FontWeight.w400,
//                               color: AllColors.vividBlue,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20,),
//                   Container(
//                     height: Get.height / 5,
//                     width: Get.width / 1.05,
//                     decoration: BoxDecoration(
//                       color: AllColors.whiteColor,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black45.withOpacity(0.06),
//                           spreadRadius: 0.5,
//                           blurRadius: 4,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],),
//                     child: Center(child: Text('Graph',
//                       style: TextStyle(
//                           fontSize: 12,
//                           color: AllColors.lightGrey),)),
//                   ),
//                   const SizedBox(height: 30,),
//                   Container(
//                     // color: Colors.grey,
//                     margin: const EdgeInsets.only(left: 10, right: 12,),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//
//                       children: [
//
//                         const Icon(Icons.money, size: 20,),
//
//                         const SizedBox(width: 8,),
//
//                         Text(Strings.transactions,
//                           style: TextStyle(
//                             fontSize: 17,
//
//                             fontWeight: FontWeight.w500,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         InkWell(
//                           onTap: () {},
//                           child: Text(Strings.transactionsSeeAll,
//                             style: TextStyle(
//                               fontSize: 15,
//
//                               fontWeight: FontWeight.w400,
//                               color: AllColors.vividPurple,
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(width: 4,),
//
//                         Icon(Icons.arrow_forward_ios, size: 12,
//                           color: AllColors.vividPurple,)
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 30,),
//
//                   const AppCardsThreeTab(
//                       title: 'Premium 60 Packages Self Done...',
//                       name: 'Prakash shah',
//                       amount: '₹4000',
//                       subtitle: '25 May, 2024 at 12:30 pm'),
//
//                   const AppCardsThreeTab(
//                       title: 'Premium 60 Packages Self Done...',
//                       name: 'Prakash shah',
//                       amount: '₹4000',
//                       subtitle: '25 May, 2024 at 12:30 pm'),
//
//                   const AppCardsThreeTab(
//                       title: 'Premium 60 Packages Self Done...',
//                       name: 'Prakash shah',
//                       amount: '₹4000',
//                       subtitle: '25 May, 2024 at 12:30 pm'),
//
//                   const AppCardsThreeTab(
//                       title: 'Premium 60 Packages Self Done...',
//                       name: 'Prakash shah',
//                       amount: '₹4000',
//                       subtitle: '25 May, 2024 at 12:30 pm'),
//
//                   const AppCardsThreeTab(
//                       title: 'Premium 60 Packages Self Done...',
//                       name: 'Prakash shah',
//                       amount: '₹4000',
//                       subtitle: '25 May, 2024 at 12:30 pm'),
//
//                   SizedBox(height: 30,),
//                 ],
//               ),
//             ),
//           ),
//
//         ],
//       );
//   }
//
//   Widget
//   landscapeMode(){
//     return
//       Row(
//         //crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 1,
//             child:
//             SingleChildScrollView(scrollDirection: Axis.vertical,
//               child: Column(
//                 children: [
//                   Container(
//                       color: AllColors.lightBlue,
//                       width: Get.width / 4,
//                       height: Get.height * 1,
//                       child:
//                       Drawer(
//                         backgroundColor: AllColors.whiteColor,
//                         child:
//                         ListView(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.only(left: 13),
//                               height: Get.height / 9,
//                               child: Row(
//
//                                 children: [
//                                   Container(
//
//                                     height: Get.height / 14,
//                                     width: Get.width / 14,
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: AllColors.whiteColor,
//                                     ),
//                                     child: Center(
//                                         child: Image.asset(
//                                             ImageStrings.splashWHLogo)),
//                                   ),
//                                   SizedBox(width: Get.width / 40,),
//
//                                   const Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment
//                                         .start,
//
//                                     children: [
//                                       Text('Sunil Kumar',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 17,
//
//
//                                         ),),
//                                       Text('+91-8810529887',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: 13,
//
//                                             color: Colors.grey
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//
//                             Column(
//                               children: [
//                                 CustomListTileTab(
//                                     icon: Icons.dashboard,
//                                     title: Strings.dashboard,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.leaderboard,
//                                     title: Strings.lead,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.person,
//                                     title: Strings.customer,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.shopping_bag,
//                                     title: Strings.orders,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.group,
//                                     title: Strings.hrm,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.analytics,
//                                     title: Strings.analytics,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.dashboard,
//                                     title: Strings.campaign,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.bar_chart,
//                                     title: Strings.sales,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.person_2,
//                                     title: Strings.roles,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.verified_user,
//                                     title: Strings.users,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.add_task,
//                                     title: Strings.tasks,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.data_object,
//                                     title: Strings.projects,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.location_city_sharp,
//                                     title: Strings.serviceArea,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.shopping_bag,
//                                     title: Strings.products,
//                                     onTap: () {}
//                                 ),
//                                 CustomListTileTab(
//                                     icon: Icons.grade,
//                                     title: Strings.master,
//                                     onTap: () {}
//                                 ),
//                               ],
//                             ),
//
//                             SizedBox(height: 30,),
//
//                             const Divider(
//                               thickness: 1,
//                               indent: 20,
//                               endIndent: 20,
//
//                             ),
//
//                             Container(
//                                 height: Get.height / 20,
//                                 width: Get.width / 2,
//                                 padding: EdgeInsets.only(left: 20),
//
//                                 child: Text(Strings.versions,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w300,
//
//                                       fontSize: 10,
//                                       color: AllColors.grey
//                                   ),)
//                             ),
//
//                             Container(
//                               margin: EdgeInsets.only(left: 20, right: 20),
//                               child: CommonButton(
//                                   height: Get.height / 22,
//                                   width: Get.width / 4,
//                                   title: Strings.buttonLogout,
//                                   onPress: () {
//                                     SaveUserData().removeUser();
//                                     Get.toNamed(RoutesName.login_screen);
//                                     Utils.snackbarSuccess(Strings.snackbar);
//                                   }
//                                   ),
//                             ),
//                             SizedBox(height: 10,),
//                           ],
//                         ),
//                       )
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           Container(
//             height: Get.height * 1,
//             width: 0.08,
//             margin: const EdgeInsets.only(top: 30, bottom: 30),
//             color: AllColors.grey,
//           ),
//
//           const SizedBox(width: 10),
//
//           Expanded(
//             flex: 3,
//             child:
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Stack(
//                     alignment: Alignment.topCenter,
//                     children: [
//                       Container(
//                         height: Get.height / 4.8,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               AllColors.appBarColorTop,
//                               AllColors.appBarColorBottom,
//                             ],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                         ),
//                       ),
//
//                       Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             // App Bar
//                             Container(
//                               // color: Colors.blue,
//                               margin: const EdgeInsets.only(
//                                   left: 2, right: 12, top: 45, bottom: 25),
//                               child:
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: AllColors.whiteColor,
//                                     ),
//                                     height: Get.height / 13,
//                                     width: Get.width / 13,
//                                     child: Center(
//                                         child:
//                                         Image.asset(
//                                           ImageStrings. welcomeCompanyLogo,
//                                           scale: 10,
//                                         )
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             Container(
//                               // color: Colors.blue,
//                               padding: const EdgeInsets.only(left: 8, right: 8,),
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child:
//                                 Row( //SCROLLER ROW WITH CONTAINERS
//                                   children: [
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 5,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'),
//
//
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 15,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'),
//
//
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 15,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'
//                                     ),
//
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 15,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'
//                                     ),
//
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 15,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'),
//
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 15,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'),
//
//                                     AppRowContainerOneTab(
//                                         backgroundColor: AllColors.whiteColor,
//                                         icon: Icons.currency_rupee,
//                                         size: 15,
//                                         color: AllColors.mediumPurple,
//                                         amount: '₹20000',
//                                         title: 'Total revenue',
//                                         subtitle: '4% (30 days)'
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ]
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: Get.height / 50,),
//
//                   Container(
//                     // color: Colors.grey,
//                     margin: const EdgeInsets.only(left: 10, right: 8,),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//
//                       children: [
//
//                         const Icon(Icons.list_alt_outlined, size: 20,),
//
//                         const SizedBox(width: 8,),
//
//                         Text(Strings.taskPerformance,
//                           style: TextStyle(
//                             fontSize: 17,
//
//                             fontWeight: FontWeight.w500,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         Text(Strings.taskPerformanceDate,
//                           style: TextStyle(
//                             fontSize: 15,
//
//                             fontWeight: FontWeight.w300,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Icon(Icons.arrow_drop_down, size: 40,)
//
//                       ],
//                     ),
//                   ), // ROW BAR
//
//                   const SizedBox(height: 20,),
//
//                   Container(
//                     margin: const EdgeInsets.only(right: 6, left: 6),
//                     padding: EdgeInsets.only(top: 50, bottom: 50),
//                     // height: Get.height/4,
//                     // width: Get.width/1.05,
//                     decoration: BoxDecoration(
//                       color: AllColors.whiteColor,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black45.withOpacity(0.06),
//                           spreadRadius: 0.5,
//                           blurRadius: 4,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           // height: Get.height/1,
//                           decoration: BoxDecoration(
//                             color: AllColors.whiteColor,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: AllColors.vividPurple.withOpacity(0.10),
//                                 spreadRadius: 10,
//                                 blurRadius: 8,
//                                 offset: const Offset(0, 0),
//                               ),
//                             ],
//                           ),
//
//                           child:
//                           CircularPercentIndicator(
//                             progressColor: AllColors.mediumPurple,
//                             backgroundColor: AllColors.lighterPurple,
//                             lineWidth: 14,
//                             radius: 90,
//                             percent: 0.4,
//                             startAngle: 0,
//                             animation: true,
//                             animationDuration: 2000,
//                             // backgroundWidth: 30,
//                             curve: Curves.decelerate,
//                             circularStrokeCap: CircularStrokeCap.round,
//                             center: Container(
//
//                               height: Get.height / 7,
//                               width: Get.width * 1,
//                               decoration: BoxDecoration(
//                                 color: AllColors.whiteColor,
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: AllColors.vividPurple.withOpacity(
//                                         0.04),
//                                     spreadRadius: 10,
//                                     blurRadius: 3,
//                                     offset: const Offset(0, 0),
//                                   ),
//                                 ],
//                               ),
//                               child: const
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(Strings.completed,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//
//                                       fontSize: 15,
//                                     ),
//                                   ),
//
//                                   // SizedBox(height: 5,),
//
//                                   Text('40%',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//
//
//                         Container(
//
//                           child:
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const Text(Strings.taskProgress,
//                                 style: TextStyle(
//                                   fontSize: 20,
//
//                                   fontWeight: FontWeight.w600,
//                                 ),),
//                               SizedBox(height: 5,),
//
//                               Row(
//                                 children: [
//                                   const Text('06:06:15 /',
//                                     style: TextStyle(
//                                       fontSize: 16,
//
//                                       fontWeight: FontWeight.w600,
//                                     ),),
//
//                                   SizedBox(width: 5,),
//
//                                   Text('4hrs',
//                                     style: TextStyle(
//                                       fontSize: 16,
//
//                                       fontWeight: FontWeight.w600,
//                                       color: AllColors.vividPurple,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//
//
//                   const SizedBox(height: 40,),
//
//                   Container(
//                     // color: Colors.grey,
//                     margin: const EdgeInsets.only(left: 10, right: 12,),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//
//                       children: [
//
//                         const Icon(Icons.list_alt_outlined, size: 20,),
//
//                         const SizedBox(width: 8,),
//
//                         Text(Strings.latestTask,
//                           style: TextStyle(
//                             fontSize: 17,
//
//                             fontWeight: FontWeight.w500,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         InkWell(
//                           onTap: () {},
//                           child: Text(Strings.latestTaskSeeAll,
//                             style: TextStyle(
//                               fontSize: 15,
//
//                               fontWeight: FontWeight.w400,
//                               color: AllColors.vividPurple,
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(width: 4,),
//
//                         Icon(Icons.arrow_forward_ios, size: 12,
//                           color: AllColors.vividPurple,)
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 30,),
//
//                   AppCardOneTab(
//                       title: 'Designing Task',
//                       subtitle: 'Somacare inner Images',
//                       date: '15 May, 2024 at 12:30 pm',
//                       ContainerIcon: Icons.access_time,
//                       IconColor: AllColors.vividPink,
//                       statusBackgroundColor: AllColors.lightPink,
//                       statusText: 'In Progress'),
//
//
//                   AppCardOneTab(
//                       title: 'Designing Task',
//                       subtitle: 'Somacare inner Images',
//                       date: '15 May, 2024 at 12:30 pm',
//                       ContainerIcon: Icons.access_time,
//                       IconColor: AllColors.darkGreen,
//                       statusBackgroundColor: AllColors.lightGreen,
//                       statusText: 'In Progress'),
//
//
//                   AppCardOneTab(
//                       title: 'Designing Task',
//                       subtitle: 'Somacare inner Images',
//                       date: '15 May, 2024 at 12:30 pm',
//                       ContainerIcon: Icons.access_time,
//                       IconColor: AllColors.darkBlue,
//                       statusBackgroundColor: AllColors.lightBlue,
//                       statusText: 'In Progress'),
//
//
//                   AppCardOneTab(
//                       title: 'Designing Task',
//                       subtitle: 'Somacare inner Images',
//                       date: '15 May, 2024 at 12:30 pm',
//                       ContainerIcon: Icons.access_time,
//                       IconColor: AllColors.darkRed,
//                       statusBackgroundColor: AllColors.lightRed,
//                       statusText: 'In Progress'),
//
//
//                   AppCardOneTab(
//                       title: 'Designing Task',
//                       subtitle: 'Somacare inner Images',
//                       date: '15 May, 2024 at 12:30 pm',
//                       ContainerIcon: Icons.access_time,
//                       IconColor: AllColors.darkYellow,
//                       statusBackgroundColor: AllColors.lightYellow,
//                       statusText: 'In Progress'),
//
//
//                   const SizedBox(height: 30,),
//                   Container(
//                     // color: Colors.grey,
//                     margin: const EdgeInsets.only(left: 10, right: 8,),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//
//                       children: [
//
//                         const Icon(Icons.list_alt_outlined, size: 20,),
//
//                         const SizedBox(width: 8,),
//
//                         Text(Strings.leadTypeCount,
//                           style: TextStyle(
//                             fontSize: 17,
//
//                             fontWeight: FontWeight.w500,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         Text(Strings.leadTypeDate,
//                           style: TextStyle(
//                             fontSize: 15,
//
//                             fontWeight: FontWeight.w300,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Icon(Icons.arrow_drop_down, size: 30,)
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20,),
//
//
//                   Container(
//                     padding: const EdgeInsets.only(
//                         left: 8, right: 8, top: 4, bottom: 4),
//                     child:
//                     SingleChildScrollView(scrollDirection: Axis.horizontal,
//                       child:
//                       Row( //SCROLLER ROW WITH CONTAINERS
//                         children: [
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.access_time,
//                               iconColor: AllColors.vividPink,
//                               containerColor: AllColors.lightPink),
//
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.task,
//                               iconColor: AllColors.vividBlue,
//                               containerColor: AllColors.lightBlue),
//
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.account_balance_rounded,
//                               iconColor: AllColors.vividGreen,
//                               containerColor: AllColors.lightGreen),
//
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.timelapse,
//                               iconColor: AllColors.mediumPurple,
//                               containerColor: AllColors.lighterPurple),
//
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.place,
//                               iconColor: AllColors.darkRed,
//                               containerColor: AllColors.lightRed),
//
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.policy,
//                               iconColor: AllColors.darkYellow,
//                               containerColor: AllColors.lightYellow),
//
//
//                           AppRowContainerTwoTab(
//                               count: '15 Leads',
//                               statusText: 'Pending',
//                               countColor: AllColors.grey,
//                               statusColor: AllColors.blackColor,
//                               icon: Icons.title,
//                               iconColor: AllColors.darkGreen,
//                               containerColor: AllColors.lightGreen
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 20,),
//
//                   Container(
//                     // color: Colors.grey,
//                     margin: const EdgeInsets.only(left: 10, right: 12,),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//
//                         const Icon(Icons.list_alt_outlined, size: 20,),
//
//                         const SizedBox(width: 8,),
//
//                         Text(Strings.latestCustomer,
//                           style: TextStyle(
//                             fontSize: 17,
//
//                             fontWeight: FontWeight.w500,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         InkWell(
//                           onTap: () {},
//                           child: Text(Strings.latestTaskSeeAll,
//                             style: TextStyle(
//                               fontSize: 15,
//
//                               fontWeight: FontWeight.w400,
//                               color: AllColors.vividPurple,
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(width: 4,),
//
//                         Icon(Icons.arrow_forward_ios, size: 12,
//                           color: AllColors.vividPurple,)
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 40,),
//
//                   AppCardsTwoTab(
//                     title: 'Dermi Derm',
//                     subtitle: 'AYUSH GOYAL',
//                     date: '26 May, 2024 at 12:30 pm',
//                     circleColorOne: AllColors.lightPink,
//                     circleColorTwo: AllColors.lighterPurple,
//                     circleTextColorTwo: AllColors.mediumPurple,
//                     circleTextColorOne: AllColors.darkPink,),
//
//
//                   AppCardsTwoTab(
//                     title: 'Dermi Derm',
//                     subtitle: 'AYUSH GOYAL',
//                     date: '26 May, 2024 at 12:30 pm',
//                     circleColorOne: AllColors.lightPink,
//                     circleColorTwo: AllColors.lighterPurple,
//                     circleTextColorTwo: AllColors.mediumPurple,
//                     circleTextColorOne: AllColors.darkPink,),
//
//
//                   AppCardsTwoTab(
//                     title: 'Dermi Derm',
//                     subtitle: 'AYUSH GOYAL',
//                     date: '26 May, 2024 at 12:30 pm',
//                     circleColorOne: AllColors.lightPink,
//                     circleColorTwo: AllColors.lighterPurple,
//                     circleTextColorTwo: AllColors.mediumPurple,
//                     circleTextColorOne: AllColors.darkPink,),
//
//
//                   AppCardsTwoTab(
//                     title: 'Dermi Derm',
//                     subtitle: 'AYUSH GOYAL',
//                     date: '26 May, 2024 at 12:30 pm',
//                     circleColorOne: AllColors.lightPink,
//                     circleColorTwo: AllColors.lighterPurple,
//                     circleTextColorTwo: AllColors.mediumPurple,
//                     circleTextColorOne: AllColors.darkPink,),
//
//
//                   AppCardsTwoTab(
//                     title: 'Dermi Derm',
//                     subtitle: 'AYUSH GOYAL',
//                     date: '26 May, 2024 at 12:30 pm',
//                     circleColorOne: AllColors.lightPink,
//                     circleColorTwo: AllColors.lighterPurple,
//                     circleTextColorTwo: AllColors.mediumPurple,
//                     circleTextColorOne: AllColors.darkPink,),
//
//
//                   const SizedBox(height: 30,),
//                   Container(
//                     // color: Colors.grey,
//                     margin: const EdgeInsets.only(left: 10, right: 12,),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//
//                       children: [
//
//                         const Icon(Icons.list_alt_outlined, size: 20,),
//
//                         const SizedBox(width: 8,),
//
//                         Text(Strings.leadSource,
//                           style: TextStyle(
//                             fontSize: 17,
//
//                             fontWeight: FontWeight.w500,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         Icon(Icons.list, color: AllColors.lightGrey, size: 20,),
//
//                         const SizedBox(width: 10,),
//
//                         Text(Strings.leadSourceList,
//                           style: TextStyle(
//                             fontSize: 15,
//
//                             fontWeight: FontWeight.w300,
//                             color: AllColors.grey,
//                           ),
//                         ),
//
//                         const SizedBox(width: 10,),
//
//                         Icon(
//                           Icons.pie_chart, color: AllColors.vividBlue, size: 20,),
//
//                         const SizedBox(width: 5,),
//
//                         InkWell(
//                           onTap: () {},
//                           child: Text(Strings.leadSourceChart,
//                             style: TextStyle(
//                               fontSize: 12,
//
//                               fontWeight: FontWeight.w400,
//                               color: AllColors.vividBlue,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20,),
//                   Container(
//                     height: Get.height / 5,
//                     width: Get.width / 1.05,
//                     decoration: BoxDecoration(
//                       color: AllColors.whiteColor,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black45.withOpacity(0.06),
//                           spreadRadius: 0.5,
//                           blurRadius: 4,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],),
//                     child: Center(child: Text('Graph',
//                       style: TextStyle(
//                           fontSize: 12,
//                           color: AllColors.lightGrey),)),
//                   ),
//                   const SizedBox(height: 30,),
//                   Container(
//                     // color: Colors.grey,
//                     margin: const EdgeInsets.only(left: 10, right: 12,),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//
//                       children: [
//
//                         const Icon(Icons.money, size: 20,),
//
//                         const SizedBox(width: 8,),
//
//                         Text(Strings.transactions,
//                           style: TextStyle(
//                             fontSize: 17,
//
//                             fontWeight: FontWeight.w500,
//                             color: AllColors.blackColor,
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         InkWell(
//                           onTap: () {},
//                           child: Text(Strings.transactionsSeeAll,
//                             style: TextStyle(
//                               fontSize: 15,
//
//                               fontWeight: FontWeight.w400,
//                               color: AllColors.vividPurple,
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(width: 4,),
//
//                         Icon(Icons.arrow_forward_ios, size: 12,
//                           color: AllColors.vividPurple,)
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 30,),
//
//                   const AppCardsThreeTab(
//                       title: 'Premium 60 Packages Self Done...',
//                       name: 'Prakash shah',
//                       amount: '₹4000',
//                       subtitle: '25 May, 2024 at 12:30 pm'),
//
//                   const AppCardsThreeTab(
//                       title: 'Premium 60 Packages Self Done...',
//                       name: 'Prakash shah',
//                       amount: '₹4000',
//                       subtitle: '25 May, 2024 at 12:30 pm'),
//
//                   const AppCardsThreeTab(
//                       title: 'Premium 60 Packages Self Done...',
//                       name: 'Prakash shah',
//                       amount: '₹4000',
//                       subtitle: '25 May, 2024 at 12:30 pm'),
//
//                   const AppCardsThreeTab(
//                       title: 'Premium 60 Packages Self Done...',
//                       name: 'Prakash shah',
//                       amount: '₹4000',
//                       subtitle: '25 May, 2024 at 12:30 pm'),
//
//                   const AppCardsThreeTab(
//                       title: 'Premium 60 Packages Self Done...',
//                       name: 'Prakash shah',
//                       amount: '₹4000',
//                       subtitle: '25 May, 2024 at 12:30 pm'),
//
//
//                   SizedBox(height: 30,),
//                 ],
//               ),
//             ),
//           ),
//
//         ],
//       );
//   }
//
//
// }
//
//
//
