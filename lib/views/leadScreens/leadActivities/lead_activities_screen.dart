// import 'package:flutter/material.dart';
// import 'package:websuites/views/leadScreens/leadActivities/widgets/leadActivitiesCard/lead_activities_card.dart';
// import '../../../data/models/responseModels/login/login_response_model.dart';
// import '../../../resources/iconStrings/icon_strings.dart';
// import '../../../resources/strings/strings.dart';
// import '../../../resources/textStyles/text_styles.dart';
// import '../../../utils/appColors/app_colors.dart';
// import '../../../utils/components/widgets/appBar/custom_appBar.dart';
// import '../../../utils/components/widgets/drawer/custom_drawer.dart';
// import '../../../utils/components/widgets/navBar/custom_navBar.dart';
// import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
// import '../../../viewModels/saveToken/save_token.dart';
//
//
//
// class LeadActivitiesScreen extends StatefulWidget {
//   const LeadActivitiesScreen({super.key});
//
//   @override
//   State<LeadActivitiesScreen> createState() => _LeadActivitiesScreenState();
// }
//
// class _LeadActivitiesScreenState extends State<LeadActivitiesScreen> {
//   final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
//   SaveUserData userPreference = SaveUserData();
//
//   String? userName = '';
//   String? userEmail = '';
//
//   @override
//   void initState() {
//     FetchUserData();
//     super.initState();
//   }
//
//   Future<void> FetchUserData() async {
//     try {
//       LoginResponseModel response = await userPreference.getUser();
//       String? first_name = response.user!.firstName;
//       String? email = response.user!.email;
//
//       setState(() {
//         userEmail = email;
//         userName = first_name;
//       });
//     } catch (e) {
//       print('Error fetching userData: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _globalKey,
//         backgroundColor: AllColors.whiteColor,
//         bottomNavigationBar: CustomBottomNavBar(),
//         floatingActionButton: CustomFloatingButton(
//             onPressed: (){},
//             imageIcon: IconStrings.navSearch3,
//             backgroundColor: AllColors.mediumPurple
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//
//         drawer:
//         CustomDrawer(
//             userName: '$userName',
//             phoneNumber: '$userEmail',
//             version: '1.0.12'),
//         body: Stack(
//           children: [
//             const SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 125),
//                     LeadActivitiesScreenCard(
//                         title: 'Dr. Nitasha Gupta',
//                         companyName: 'Nitasha Gupta (Infertility Specialist)'),
//                     LeadActivitiesScreenCard(
//                         title: 'Dr. Nitasha Gupta',
//                         companyName: 'Nitasha Gupta (Infertility Specialist)'),
//                     LeadActivitiesScreenCard(
//                         title: 'Dr. Nitasha Gupta',
//                         companyName: 'Nitasha Gupta (Infertility Specialist)'),
//                     LeadActivitiesScreenCard(
//                         title: 'Dr. Nitasha Gupta',
//                         companyName: 'Nitasha Gupta (Infertility Specialist)'),
//                     LeadActivitiesScreenCard(
//                         title: 'Dr. Nitasha Gupta',
//                         companyName: 'Nitasha Gupta (Infertility Specialist)'),
//                   ],
//                 ),
//               ),
//             ),
//
//             //==================================================================
//             //CUSTOM APP BAR
//
//             CustomAppBar(
//               child: Row(
//                 children: [
//                   InkWell(
//                     onTap: (){
//                       _globalKey.currentState?.openDrawer();
//                     },
//                     child: const Icon(
//                       Icons.menu_sharp,
//                       size: 25,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 12,
//                   ),
//                  TextStyles.w600_universal(fontSize: 18, color: AllColors.blackColor, context, Strings.leadActivities),
//                   Spacer(),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.filter_list_outlined,
//                         size: 15,
//                         color: AllColors.lightGrey,
//                       ),
//                       const SizedBox(
//                         width: 2,
//                       ),
//                       TextStyles.w400_13(color: AllColors.lightGrey, context, Strings.filter),
//                       const SizedBox(
//                         width: 13,
//                       ),
//                      TextStyles.w400_13(color: AllColors.blackColor, context, Strings.details),
//                       const Icon(
//                         Icons.keyboard_arrow_right,
//                         size: 20,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }
