// import 'package:flutter/cupertino.dart';
//
// class UserScreenTree extends StatefulWidget {
//   const UserScreenTree({super.key});
//
//   @override
//   State<UserScreenTree> createState() => _UserScreenTreeState();
// }
//
// class _UserScreenTreeState extends State<UserScreenTree> {
//   @override
//   Widget build(BuildContext context) {
//     return   SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: InteractiveViewer(
//         transformationController: _controller,
//         boundaryMargin: const EdgeInsets.all(0),
//         minScale: 0.1,
//         maxScale: 2.0,
//         child: Center(
//           child: Stack(
//             children: [
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (userListViewModel.userList.isNotEmpty) ...[
//                     OrgChartNode(
//                       initials: userListViewModel.userList.firstWhere(
//                               (user) => user.parent == null // Parent has no parent
//                       ).firstName?.substring(0, 1) ?? 'N',
//                       name: '${userListViewModel.userList.firstWhere(
//                               (user) => user.parent == null
//                       ).firstName ?? ''} ${userListViewModel.userList.firstWhere(
//                               (user) => user.parent == null
//                       ).lastName ?? ''}'.trim(),
//                       role: userListViewModel.userList.firstWhere(
//                               (user) => user.parent == null
//                       ).roleList.first.name ?? '',
//                       backgroundColor: AllColors.mediumPurple,
//                       onDelete: () {},
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 18),
//                       child: Container(
//                         width: 0.5,
//                         height: 55,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 800,
//                       child: Column(
//                         children: [
//                           Container(
//                             width: 601,
//                             height: 0.5,
//                             color: Colors.black,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: List.generate(
//                               (userListViewModel.userList.length - 1).clamp(0, 4),
//                                   (index) => Container(
//                                 width: 0.5,
//                                 height: 50,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: List.generate(
//                               userListViewModel.userList
//                                   .where((user) => user.parent?.id == userListViewModel.userList.firstWhere(
//                                       (user) => user.parent == null
//                               ).id) // Find children based on parent id
//                                   .toList()
//                                   .length,
//                                   (index) {
//                                 final user = userListViewModel.userList
//                                     .where((user) => user.parent?.id == userListViewModel.userList.firstWhere(
//                                         (user) => user.parent == null
//                                 ).id)
//                                     .toList()[index];
//                                 return OrgChartNode(
//                                   initials: user.firstName?.substring(0, 1) ?? 'N',
//                                   name: '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim(),
//                                   role: user.roleList.first.name ?? '',
//                                   backgroundColor: Colors.deepPurple,
//                                   onDelete: () {},
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ] else ...[
//                     Text('No users available'),
//                   ],
//                 ],
//               ),
//               // Positioned remove icon
//               Positioned(
//                 top: 38, // Adjust this value to position the icon correctly
//                 left: 375, // Align it with the OrgChartNode
//                 child: IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.remove_circle),
//                   color: AllColors.vividRed,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   }
// }
