// import 'package:flutter/material.dart';
//
// import '../../../../appColors/app_colors.dart';
//
// class CustomListTile extends StatelessWidget {
//   final String leadIconImage;
//   final String title;
//   final VoidCallback onTap;
//
//   const CustomListTile({
//     super.key,
//     required this.leadIconImage,
//     required this.title,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       dense: true,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
//       leading: Image.asset(leadIconImage),
//       // SizedBox(
//       //   height: 20,
//       //     width: 20,
//       //     child: Icon(icon, size : 20, color: AppColors.lightGrey,)),
//       // trailing: Icon(Icons.arrow_drop_down, size: 20, color: AppColors.lightGrey,),
//       title: Text(title,
//           style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w300,
//               color: AllColors.welcomeColor)),
//       onTap: onTap,
//     );
//   }
// }
//
// class CustomListTileTab extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;
//
//   const CustomListTileTab({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       dense: true,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
//       leading: Icon(
//         icon,
//         size: 20,
//         color: AllColors.lightGrey,
//       ),
//       title: Text(title,
//           style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w300,
//               color: AllColors.blackColor)),
//       onTap: onTap,
//     );
//   }
// }
