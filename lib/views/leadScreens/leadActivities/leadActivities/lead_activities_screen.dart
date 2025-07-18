// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../../../data/models/responseModels/login/login_response_model.dart';
// import '../../../../utils/appColors/app_colors.dart';
// import '../../../../viewModels/leadScreens/lead_activity/ReportLeadActivityViewModel.dart';
// import '../../../../viewModels/leadScreens/lead_activity/lead_reports/lead_reports.dart';
// import '../../../../viewModels/leadScreens/lead_activity/no_activities/no_activities.dart';
// import '../../../../viewModels/leadScreens/lead_activity/team_leads/ReportTeamLeadReqModel.dart';
// import '../../../../viewModels/saveToken/save_token.dart';
// import 'dailySalesReport/DailySalesReport.dart';
// import 'details/DetailsScreen.dart';
// import 'leadReport/LeadReport.dart';
// import 'noActivities/NoActivities.dart';
// import 'uniqueMeeting/UniqueMeeting.dart';
// import 'teamLeads/TeamLeads.dart';
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
//   late final LeadActivityViewModel _leadActivityViewModel;
//   late final LeadActivityNoActivityViewModel _leadActivityno;
//   late final LeadActivityLeadReportViewModel  _leadactivitiesreport ;
//   late final  TeamLeadsViewModel  _leadactivitiesteamreports ;
//   String? userName = '';
//   String? userEmail = '';
//   String selectedButton = "Details";
//
//   final List<Map<String, dynamic>> buttonData = [
//     {"text": "Details", "icon": Icons.info_outline},
//     {"text": "Daily Sales Report", "icon": Icons.bar_chart},
//     {"text": "No Activities", "icon": Icons.event},
//     {"text": "Lead Report", "icon": Icons.person_outline},
//     {"text": "Unique Meeting", "icon": Icons.handshake},
//     {"text": "Team leads", "icon": Icons.group_add_outlined},
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _leadActivityViewModel = Get.put(LeadActivityViewModel());
//     _leadActivityno = Get.put(LeadActivityNoActivityViewModel());
//     _leadactivitiesreport = Get.put(LeadActivityLeadReportViewModel());
//     _leadactivitiesteamreports = Get.put(TeamLeadsViewModel());
//
//     _fetchUserData();
//     _fetchInitialData();
//   }
//
//   Future<void> _fetchInitialData() async {
//     if (_leadActivityViewModel.leadActivityResponse.value.items == null ||
//         _leadActivityViewModel.leadActivityResponse.value.items!.isEmpty) {
//       await _leadActivityViewModel.leadActivityList(context);
//     }
//     // if (selectedButton == "Lead Report") {
//     //   await _leadactivitiesreport.fetchNoActivities(context);
//     // }
//
//
//   }
//
//   Future<void> _fetchUserData() async {
//     try {
//       LoginResponseModel response = await SaveUserData().getUser();
//       setState(() {
//         userEmail = response.user?.email;
//         userName = response.user?.firstName;
//       });
//     } catch (e) {
//       print('Error fetching userData: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _globalKey,
//       backgroundColor: AllColors.whiteColor,
//
//       body: Obx(() {
//         if (_leadActivityViewModel.loading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         return Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
//               color: Colors.white,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child:
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: buttonData.map((data) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: IntrinsicWidth(
//                         child: Container(
//                           height: 35,
//                           decoration: BoxDecoration(
//                             color: selectedButton == data["text"]
//                                 ? AllColors.background_green
//                                 : AllColors.lightPurple,
//                             borderRadius: BorderRadius.circular(19),
//                           ),
//                           child: Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               borderRadius: BorderRadius.circular(19),
//                               onTap: () async {
//                                 setState(() {
//                                   selectedButton = data["text"] as String;
//                                 });
//                                 if (data["text"] == "Lead Report") {
//                                   await _leadActivityno.fetchNoActivities(context);
//                                 }
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       data["icon"] as IconData,
//                                       color: selectedButton == data["text"]
//                                           ? AllColors.text__green
//                                           : AllColors.mediumPurple,
//                                       size: 15,
//                                     ),
//                                     const SizedBox(width: 5),
//                                     Text(
//                                       data["text"] as String,
//                                       style: TextStyle(
//                                         color: selectedButton == data["text"]
//                                             ? AllColors.text__green
//                                             : AllColors.mediumPurple,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: Builder(
//                 builder: (context) {
//                   switch (selectedButton) {
//                     case "Details":
//                       return DetailsScreen(leadActivityViewModel: _leadActivityViewModel);
//                     case "Daily Sales Report":
//                       return DailySalesReportScreen();
//                     case "No Activities":
//                       return NoActivitiesScreen(leadActivityView: _leadActivityno);
//                     case "Lead Report":
//                       return LeadReportScreen(leadactivitiesreport: _leadactivitiesreport,);
//                     case "Unique Meeting":
//                       return UniqueMeetingScreen();
//                     case "Team leads":
//                       return TeamLeadsScreen( teamLeadsViewModel:_leadactivitiesteamreports,);
//                     default:
//                       return const Center(child: Text("Unknown selection"));
//                   }
//                 },
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
