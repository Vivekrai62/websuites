// import 'package:flutter/material.dart';
// import '../../../../utils/appColors/app_colors.dart';
//
// class TaskGridDetailsScreen extends StatefulWidget {
//   const TaskGridDetailsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TaskGridDetailsScreen> createState() => _TaskGridDetailsScreenState();
// }
//
// class _TaskGridDetailsScreenState extends State<TaskGridDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return
//       SingleChildScrollView(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     blurRadius: 8.0,
//                     spreadRadius: 2.0,
//                   ),
//                 ],
//               ),
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Entity Header
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Not started', // Static text for task status
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.add),
//                           ),
//                           Icon(Icons.more_vert),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Divider(height: 20),
//
//                   // Scrollable Task List
//                   ConstrainedBox(
//                     constraints: BoxConstraints(maxHeight: 200),
//                     child: ListView.separated(
//                       shrinkWrap: true,
//                       itemCount: 2, // Hardcoded task count
//                       separatorBuilder: (context, index) => Divider(
//                         thickness: 0.5,
//                         height: 30,
//                       ),
//                       itemBuilder: (context, index) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 IntrinsicWidth(
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 20,
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 5.0),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(color: Colors.grey),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       children: [
//                                         Image.asset(
//                                           'assets/icons/Medium.png',
//                                           height: 10,
//                                           width: 20,
//                                         ),
//                                         Text(
//                                           'Medium',
//                                           style: const TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 CircleAvatar(
//                                   radius: 12,
//                                   backgroundColor: AllColors.darkBlue,
//                                   child: Text(
//                                     'R',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               index == 0 ? 'Task 1' : 'Task 2',
//                               style: TextStyle(
//                                 color: AllColors.blackColor,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             Text(
//                               index == 0
//                                   ? 'Details for Task 1'
//                                   : 'Details for Task 2',
//                               style: TextStyle(
//                                 color: AllColors.grey,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.watch_later_outlined,
//                                   color: AllColors.mediumPurple,
//                                   size: 16,
//                                 ),
//                                 SizedBox(width: 4),
//                                 Text(
//                                   index == 0 ? '2 days ago' : '1 day ago',
//                                   style: TextStyle(
//                                     color: AllColors.mediumPurple,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Image.asset(
//                                   'assets/icons/gallery.png',
//                                   height: 14,
//                                   width: 14,
//                                   color: AllColors.grey,
//                                 ),
//                                 SizedBox(width: 8),
//                                 Icon(
//                                   Icons.comment,
//                                   color: Colors.grey,
//                                   size: 18,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
