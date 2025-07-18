import 'package:flutter/material.dart';

import '../../../appColors/app_colors.dart';
import '../../../dark_mode/dark_mode.dart';
import '../../../responsive/responsive_utils.dart';
// class CustomAppBar extends StatelessWidget {
//   final Widget child;
//
//   const CustomAppBar({super.key,
//     required this.child});
//
//   @override
//   Widget build(BuildContext context){
//     final Size screenSize = MediaQuery.of(context).size;
//     final double aspectRatio = screenSize.width / screenSize.height;
//
//     double aspectRatioValue;
//     if (screenSize.shortestSide <= 550) {
//       aspectRatioValue = 20/6;
//     } else {
//       aspectRatioValue = 20/3;
//     }
//     return AspectRatio(
//       aspectRatio: aspectRatioValue,
//         child: Container(
//         decoration: BoxDecoration(
//           color: AllColors.whiteColor,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black45.withOpacity(0.06),
//               spreadRadius: 0.5,
//               blurRadius: 8,
//               offset: Offset(0, 0),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(left: 15, right: 15, top: 60),
//           child: child,
//         ),
//         ),
//     );
//   }
// }

class CustomAppBar extends StatelessWidget {
  final Widget child;
  const CustomAppBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    // Use ResponsiveUtilsScreenSize for breakpoints
    final bool isPhone = ResponsiveUtilsScreenSize.isMobile(context);
    final bool isTablet = ResponsiveUtilsScreenSize.isTablet(context);
    final bool isDesktop = ResponsiveUtilsScreenSize.isDesktop(context);


    final double appBarHeight = statusBarHeight + (isPhone ? 56.0 : isTablet ? 70 : 70);


    final double horizontalPadding = isPhone ? 15.0 : isTablet ? 16.0 : 24.0;

    return Container(
      height: appBarHeight,
      decoration: BoxDecoration(
        color: DarkMode.backgroundColor(context),
        boxShadow: MediaQuery.of(context).size.width < 550
            ? [
          BoxShadow(
            color: Colors.black45.withOpacity(0.10),
            spreadRadius: 0.5,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ]
            : [],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          top: statusBarHeight + (MediaQuery.of(context).size.width > 550 ? 28 : 12),
          bottom: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
          ],
        ),
      ),

    );
  }
}



