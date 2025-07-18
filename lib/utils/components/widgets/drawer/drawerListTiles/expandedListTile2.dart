// import 'package:flutter/material.dart';
//
// import '../../../../appColors/app_colors.dart';
//
// class CustomExpandedListTile2 extends StatefulWidget {
//   final String title;
//   final List<Widget> children;
//   final bool initiallyExpanded;
//   final ValueChanged<bool>? onExpansionChanged;
//
//   const CustomExpandedListTile2({
//     super.key,
//     required this.title,
//     required this.children,
//     this.initiallyExpanded = false,
//     this.onExpansionChanged,
//   });
//
//   @override
//   State<CustomExpandedListTile2> createState() =>
//       _CustomExpandedListTile2State();
// }
//
// class _CustomExpandedListTile2State extends State<CustomExpandedListTile2> {
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         dividerColor: Colors.transparent,
//         splashColor: Colors.transparent,
//         highlightColor: Colors.transparent,
//       ),
//       child: ExpansionTile(
//         minTileHeight: 45,
//         trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 10),
//         childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
//         title: Text(
//           widget.title,
//           style: TextStyle(
//             color: AllColors.welcomeColor,
//             fontWeight: FontWeight.w300,
//             fontSize: 14,
//           ),
//         ),
//         initiallyExpanded: widget.initiallyExpanded,
//         onExpansionChanged: widget.onExpansionChanged,
//         children: widget.children,
//       ),
//     );
//   }
// }
