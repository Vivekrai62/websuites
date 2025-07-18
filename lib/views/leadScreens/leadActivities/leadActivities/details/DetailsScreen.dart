// import 'package:flutter/cupertino.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../../viewModels/leadScreens/lead_activity/ReportLeadActivityViewModel.dart';
// import '../widgets/leadActivitiesCard/lead_activities_card.dart';
//
// class DetailsScreen extends StatelessWidget {
//   final LeadActivityViewModel leadActivityViewModel;
//
//   const DetailsScreen({Key? key, required this.leadActivityViewModel}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: ListView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: leadActivityViewModel.leadActivityResponse.value.items?.length ?? 0,
//         itemBuilder: (context, index) {
//           final item = leadActivityViewModel.leadActivityResponse.value.items![index];
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 19),
//             child:
//             LeadActivitiesScreenCard(
//               title: item.lead?.firstName ?? "Unknown",
//               companyName: item.lead?.organization ?? "Unknown Company",
//               actionDate: DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(item.createdAt ?? '')),
//               activity: item.activity ?? 'Unknown Activity',
//               info: item.remark ?? 'No Remark',
//               request_Location: 'View',
//               action_by: item.createdBy?.firstName ?? 'Unknown',
//               status: item.subActivity?.name ?? 'Unknown Status',
//               created_Date: item.reminder != null
//                   ? DateFormat('EEE, MMM dd, yyyy').format(DateTime.parse(item.reminder!))
//                   : 'Not Available',
//             ),
//           );
//         },
//       ),
//     );
//   }
// }