// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:websuites/utils/responsive/bodies/responsive%20scaffold.dart';
// import '../../../data/models/controller.dart';
// import '../../../data/models/responseModels/login/login_response_model.dart';
// import '../../../utils/appColors/app_colors.dart';
// import '../../../utils/components/widgets/appBar/custom_appBar.dart';
// import '../../../utils/components/widgets/drawer/custom_drawer.dart';
// import '../../../utils/components/widgets/sizedBoxes/sizedBox_10w.dart';
// import '../../../utils/components/widgets/sizedBoxes/sizedBox_5w.dart';
// import '../../../utils/responsive/bodies/Responsive.dart';
// import '../../../viewModels/saveToken/save_token.dart';
//
// class CustomerMyTeamScreen extends StatefulWidget {
//   const CustomerMyTeamScreen({super.key});
//
//   @override
//   State<CustomerMyTeamScreen> createState() => _CustomerMyTeamScreenState();
// }
//
// class _CustomerMyTeamScreenState extends State<CustomerMyTeamScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
//   final ScreenController _screenController = Get.put(ScreenController());
//   SaveUserData userPreference = SaveUserData();
//
//   String userName = '';
//   String userEmail = '';
//
//   @override
//   void initState() {
//     FetchUserData();
//     super.initState();
//   }
//
//   Future<void> FetchUserData () async {
//     try{
//       LoginResponseModel response = await userPreference.getUser();
//       String? first_name = response.user!.first_name;
//       String? email = response.user!.email;
//
//       setState(() {
//         userName = first_name!;
//         userEmail = email!;
//       });
//
//     }catch (e){
//       print('Error fetching userData: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return ResponsiveScaffold(
//        scaffoldKey: _scaffoldKey,
//       key: _globalKey,
//       backgroundColor: AllColors.whiteColor,
//
//       drawer: CustomDrawer(
//         selectedIndex: 0, // Customize as needed
//         onItemSelected: (index) {
//           // Handle item selection
//         },
//         isCollapsed: false,
//         onCollapseToggle: () {
//           // Handle drawer collapse/expand
//         },
//         isTabletOrDesktop: screenWidth >= 500,
//       ),
//
//       body:
//           Stack(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 35),
//                 child: Column(
//                   children: [
//
//                     SizedBox(height: 150,),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('User', style: TextStyle(
//                             color: AllColors.blackColor,
//
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14
//                         ),
//                         ),
//
//                         Text('T.Customers', style: TextStyle(
//                           color: AllColors.blackColor,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//
//                         ),)
//                       ],
//                     ),
//
//                     SizedBox(height: 30,),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Anshuman Khurana', style: TextStyle(
//                             color: AllColors.grey,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//
//                         ),),
//
//                         Text('234', style: TextStyle(
//                             color: AllColors.grey,
//
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14
//                         ),)
//                       ],
//                     ),
//
//                     const Divider(
//                       thickness: 0.7,
//                     ),
//
//                     SizedBox(height: 3,),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Anmol Rana' , style: TextStyle(
//                             color: AllColors.grey,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//
//                         ),),
//
//                         Text('345', style: TextStyle(
//                             color: AllColors.grey,
//
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14
//                         ),)
//                       ],
//                     ),
//
//                     Divider(
//                       thickness: 0.7,
//                     ),
//
//                     SizedBox(height: 3,),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Ashu Kumar' , style: TextStyle(
//                             color: AllColors.grey,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//
//                         ),),
//
//                         Text('265', style: TextStyle(
//                             color: AllColors.grey,
//
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14
//                         ),)
//                       ],
//                     ),
//
//                     Divider(
//                       thickness: 0.7,
//                     ),
//
//                     SizedBox(height: 3,),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Ankit Pathak' , style: TextStyle(
//                             color: AllColors.grey,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//
//                         ),),
//
//                         Text('143', style: TextStyle(
//                             color: AllColors.grey,
//
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14
//                         ),)
//                       ],
//                     ),
//
//
//                   ],
//                 ),
//               ),
//
//               //================================================================
//               //CUSTOM APP BAR
//
//               CustomAppBar(child:
//               Row(
//                 children: [
//                   InkWell(
//                       onTap:(){
//                         _globalKey.currentState?.openDrawer();
//                       },
//                       child: Icon(Icons.menu_sharp, size: 25,)),
//                   SizedBox10w(),
//                   Text('My Team' ,style: TextStyle(
//                     color: AllColors.blackColor,
//                     fontSize: 17,
//                     fontWeight: FontWeight.w700,
//
//                   ),),
//
//                   Spacer(),
//
//                   Icon(Icons.filter_list_outlined, size: 15, color: AllColors.lightGrey,),
//                   SizedBox5w(),
//                   Text('Filter', style: TextStyle(
//                     color: AllColors.lightGrey,
//
//                     fontWeight: FontWeight.w400,
//                     fontSize: 15
//                   ),
//                   ),
//                 ],
//               ))
//
//             ]
//
//            ,),
//
//
//
//
//
//     );
//   }
// }
