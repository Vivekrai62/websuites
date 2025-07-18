// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../utils/fontfamily/FontFamily.dart';
//
// class ProgressStatus extends StatefulWidget {
//   const ProgressStatus({super.key});
//
//   @override
//   State<ProgressStatus> createState() => _ProgressStatusState();
// }
//
// class _ProgressStatusState extends State<ProgressStatus> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.only(
//               top: 10, left: 10, right: 10, bottom: 0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 blurRadius: 8.0,
//                 spreadRadius: 2.0,
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Task Overview",
//                 style: TextStyle(
//                   fontFamily: FontFamily.sfPro,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const Divider(
//                 thickness: 0.5,
//               ),
//               LayoutBuilder(
//                 builder: (context, constraints) {
//                   // Helper function to get grid configuration based on screen width
//                   Map<String, dynamic> getGridConfig(
//                       double width) {
//                     if (width < 500) {
//                       return {
//                         'crossAxisCount': 2,
//                         'childAspectRatio': 2.2,
//                         'containerHeightFactor': 0.35,
//                       };
//                     } else if (width < 1024) {
//                       return {
//                         'crossAxisCount': 2,
//                         'childAspectRatio': 4.5,
//                         'containerHeightFactor': 0.25,
//                       };
//                     } else {
//                       return {
//                         'crossAxisCount': 3,
//                         'childAspectRatio': 4.5,
//                         'containerHeightFactor': 0.2,
//                       };
//                     }
//                   }
//
//                   final gridConfig =
//                   getGridConfig(constraints.maxWidth);
//
//                   return GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate:
//                     SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount:
//                       gridConfig['crossAxisCount'],
//                       // Use a responsive crossAxisCount
//                       childAspectRatio:
//                       gridConfig['childAspectRatio'],
//                       // Use a responsive aspect ratio
//                       crossAxisSpacing: 12,
//                       mainAxisSpacing: 12,
//                     ),
//                     itemCount:
//                     (projectDetail?.tasks?.standard.length ??
//                         0) +
//                         1,
//                     // Add 1 to itemCount
//                     itemBuilder: (context, index) {
//                       if (index ==
//                           (projectDetail?.tasks?.standard
//                               ?.length ??
//                               0)) {
//                         return Container(
//                           height: constraints.maxWidth *
//                               gridConfig['containerHeightFactor'],
//                           // Responsive container height
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius:
//                             BorderRadius.circular(8.0),
//                             border: Border.all(
//                                 color: Colors.grey,
//                                 width: 0.2),
//                             boxShadow: [
//                               BoxShadow(
//                                 color:
//                                 Colors.grey.withOpacity(0.1),
//                                 blurRadius: 8.0,
//                                 spreadRadius: 2.0,
//                               ),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(
//                                 12.0),
//                             child: Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       'Others',
//                                       // Show the task count for others
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight:
//                                         FontWeight.w500,
//                                         fontFamily: 'SFPro',
//                                       ),
//                                     ),
//                                     Text(
//                                       '${projectDetail?.tasks
//                                           ?.others?.count ??
//                                           0}',
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight:
//                                         FontWeight.w700,
//                                         fontFamily: 'SFPro',
//                                         overflow:
//                                         TextOverflow.ellipsis,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     // Grey background circle (100%)
//                                     SizedBox(
//                                       height: 44.0,
//                                       width: 44.0,
//                                       child:
//                                       CircularProgressIndicator(
//                                         color: AllColors
//                                             .greyGoogleForm,
//                                         value: 1.0,
//                                         strokeWidth: 8,
//                                         valueColor:
//                                         AlwaysStoppedAnimation<
//                                             Color>(
//                                             AllColors
//                                                 .greyGoogleForm),
//                                       ),
//                                     ),
//                                     // Blue progress circle (over the gray one)
//                                     SizedBox(
//                                       height: 44.0,
//                                       width: 44.0,
//                                       child:
//                                       CircularProgressIndicator(
//                                         value: projectDetail?.tasks?.others?.count != null
//                                             ? (projectDetail!.tasks!.others!.count! / 100.0).clamp(0.0, 1.0) // Ensure the value is between 0.0 and 1.0
//                                             : 0.0, // Default to 0.0 if count is null
//                                         strokeWidth: 8,
//                                         valueColor: AlwaysStoppedAnimation<Color>(AllColors.darkBlue),
//                                       ),
//                                     ),
//                                     // Centered text displaying percentage
//                                     Text(
//                                       '${projectDetail?.tasks
//                                           ?.others?.count ??
//                                           0}%',
//                                       // Show the percentage
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                         fontWeight:
//                                         FontWeight.bold,
//                                         fontFamily: 'SFPro',
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }
//
//                       // Regular task item
//                       final task =
//                       projectDetail?.tasks!.standard![index];
//                       return Container(
//                         height: constraints.maxWidth *
//                             gridConfig['containerHeightFactor'],
//                         // Responsive container height
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius:
//                           BorderRadius.circular(8.0),
//                           border: Border.all(
//                               color: Colors.grey, width: 0.2),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(
//                                   0.1),
//                               blurRadius: 8.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       task?.statusName ??
//                                           'No Status',
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                         fontWeight:
//                                         FontWeight.w500,
//                                         fontFamily: 'SFPro',
//                                         overflow:
//                                         TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                     Text(
//                                       task?.tasks ??
//                                           'No Task Name',
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight:
//                                         FontWeight.w700,
//                                         fontFamily: 'SFPro',
//                                         overflow:
//                                         TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 8),
//                               Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   // Grey background circle (100%)
//                                   SizedBox(
//                                     height: 44.0,
//                                     width: 44.0,
//                                     child:
//                                     CircularProgressIndicator(
//                                       color: AllColors
//                                           .greyGoogleForm,
//                                       value: 1.0,
//                                       strokeWidth: 8,
//                                       valueColor:
//                                       AlwaysStoppedAnimation<
//                                           Color>(
//                                           AllColors
//                                               .greyGoogleForm),
//                                     ),
//                                   ),
//                                   // Blue progress circle (over the gray one)
//                                   SizedBox(
//                                     height: 44.0,
//                                     width: 44.0,
//                                     child:
//                                     CircularProgressIndicator(
//                                       value: task?.tasks !=
//                                           null
//                                           ? getProgressValue(
//                                           task?.tasks)
//                                           : null,
//                                       strokeWidth: 8,
//                                       valueColor:
//                                       AlwaysStoppedAnimation<
//                                           Color>(
//                                           AllColors.darkBlue),
//                                     ),
//                                   ),
//                                   // Centered text displaying percentage
//                                   Text(
//                                     '${task?.tasks != null ? '${task!.tasks!}%' : 'No Task Name'}',
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'SFPro',
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//
//             ],
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 blurRadius: 8.0,
//                 spreadRadius: 2.0,
//               ),
//             ],
//           ),
//           child:
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Project Reminder Setting',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Add Time',
//                 style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
//               ),
//               const SizedBox(height: 10),
//
//               // Use a Container to hold the ListView
//               Container(
//                 height: (controller.addedRows.length * 65).toDouble(), // Assuming each item takes about 60 pixels in height
//                 child: Obx(
//                       () => ListView.builder(
//                     itemCount: controller.addedRows.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 15,),
//                         child:
//                         Column(
//                           children: [
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: 40,
//
//                                   child: index == 0
//                                       ? IconButton(
//                                     icon: controller.canAddMore
//                                         ? const Icon(Icons.add, color: Colors.green)
//                                         : Icon(Icons.add_box_outlined, color: Colors.grey.shade300),
//                                     onPressed: controller.canAddMore
//                                         ? () {
//                                       controller.addNewRow(); // Add new row
//                                     }
//                                         : null,
//                                   )
//                                       : IconButton(
//                                     icon: const Icon(Icons.close, color: Colors.red),
//                                     onPressed: () => controller.removeRow(index),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Expanded(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return AlertDialog(
//                                             title: const Text("Select Month"),
//                                             content: SingleChildScrollView(
//                                               child: ListBody(
//                                                 children: controller.months.map((month) {
//                                                   return GestureDetector(
//                                                     child: Padding(
//                                                       padding: const EdgeInsets.symmetric(vertical: 8),
//                                                       child: Text(month),
//                                                     ),
//                                                     onTap: () {
//                                                       controller.updateMonth(index, month);
//                                                       Navigator.of(context).pop();
//                                                     },
//                                                   );
//                                                 }).toList(),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     },
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(color: Colors.grey),
//                                       ),
//                                       child: Text(
//                                         controller.addedRows[index]['month'] ?? 'Select Month',
//                                         style: const TextStyle(color: Colors.grey),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Expanded(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return AlertDialog(
//                                             title: const Text("Select Day"),
//                                             content: SingleChildScrollView(
//                                               child: ListBody(
//                                                 children: List.generate(31, (i) {
//                                                   return GestureDetector(
//                                                     child: Padding(
//                                                       padding: const EdgeInsets.symmetric(vertical: 8),
//                                                       child: Text((i + 1).toString()),
//                                                     ),
//                                                     onTap: () {
//                                                       controller.updateDay(index, (i + 1).toString());
//                                                       Navigator.of(context).pop();
//                                                     },
//                                                   );
//                                                 }),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     },
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(color: Colors.grey),
//                                       ),
//                                       child: Text(
//                                         controller.addedRows[index]['day'] ?? 'Select Day',
//                                         style: const TextStyle(color: Colors.grey),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//
//
//                               ],
//                             ),
//
//                           ],
//                         ),
//
//                       );
//                     },
//                   ),
//                 ),
//               ),
//
//               Obx(() {
//                 if (_assignedLeadToController.loading.value) {
//                   return const CircularProgressIndicator();
//                 } else {
//                   return CreateNewLeadScreenCard(
//                     hintText: _assignedLeadToController
//                         .selectedLeadName.value.isEmpty
//                         ? Strings.select
//                         : _assignedLeadToController
//                         .selectedLeadName.value,
//                     categories:
//                     _assignedLeadToController.fullCategoriesRxList,
//                     onCategoryChanged: (selectedCategory) {
//                       // Handle selection for full names with emails
//                       final names =
//                       selectedCategory.split('\n')[0].split(' ');
//                       if (names.length >= 2) {
//                         final firstName = names[0];
//                         final lastName = names[1];
//                         _assignedLeadToController.selectedLeadName
//                             .value = '$firstName $lastName';
//                       }
//                     },
//                     isMultiSelect: true,
//                     isForDivisions: true,
//                   );
//                 }
//               }),
//               const SizedBox(height: 15),
//               CustomButton2(
//                 height: 25,
//                 width: 90,
//                 borderRadius: 30,
//                 child: Text(
//                   'Save Setting',
//                   style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//                 ),
//                 color: Colors.green,
//                 onTap: () {},
//               ),
//               SizedBox(height: 60),
//
//             ],
//           ),
//         ),
//       ],
//
//     );
//   }
// }
