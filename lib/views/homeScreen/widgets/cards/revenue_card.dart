import 'package:flutter/material.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';

import '../../../../utils/appColors/app_colors.dart';
import '../../../../utils/fontfamily/FontFamily.dart';

class RevenueCard extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final String amount;
  final String title;
  final String subtitle;

  const RevenueCard({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.amount,
    required this.title,
    required this.subtitle,
    required int size,
    required Color color,
  });

  // @override
  // Widget build(BuildContext context) {
  //   return
  //     Container(
  //     margin: EdgeInsets.only(top: 5, bottom: 5),
  //     height: height,
  //     width: width,
  //     decoration: BoxDecoration(
  //       color: backgroundColor,
  //       borderRadius: BorderRadius.circular(10),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black45.withOpacity(0.06),
  //           spreadRadius: 0.5,
  //           blurRadius: 4,
  //           offset: const Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child:
  //     Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         SizedBox(width: width/50),
  //         Container(
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: App_Colors.lighterPurple,
  //           ),
  //           // height: height / 2.6,
  //           width: width / 4.65,
  //           child: Center(
  //             child: Icon(icon, size: 18, color: const Color(0xff7165ec)),
  //           ),
  //         ),
  //          const SizedBox(width:15),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               amount,
  //               style: const TextStyle(
  //                 fontSize: 15,
  //                 fontFamily: 'NunitoRegular', // Replace with your font variable
  //                 fontWeight: FontWeight.w500,
  //                 color: Colors.black, // Replace with your color variable
  //               ),
  //             ),
  //             Text(
  //               title,
  //               style: const TextStyle(
  //                 fontSize: 11,
  //                 fontFamily: 'NunitoRegular', // Replace with your font variable
  //                 fontWeight: FontWeight.w400,
  //                 color: Colors.black, // Replace with your color variable
  //               ),
  //             ),
  //             SizedBox(height: 2,),
  //             Row(
  //               children: [
  //                 Icon(Icons.money_off_rounded, size: 10, color: App_Colors.darkGreen,),
  //                 SizedBox(width: 2,),
  //                 Text(
  //                   subtitle,
  //                   style: const TextStyle(
  //                     fontSize: 8,
  //                     fontFamily: 'NunitoRegular', // Replace with your font variable
  //                     fontWeight: FontWeight.w400,
  //                     color: Colors.black, // Replace with your color variable
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         // const SizedBox(width: 8),
  //       ],
  //     ),
  //   );
  //
  //
  //
  //
  //
  // }\

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final double circleSize = screenSize.width * 0.09;
    final double iconSize = circleSize * 0.4;
    final double amountFontSize = screenSize.width * 0.054;
    final double titleFontSize = screenSize.width * 0.038;
    final double subtitleFontSize = screenSize.width * 0.025;

    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, right: 4, left: 4),
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
      // width: containerWidth,
      // height: containerHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black45.withOpacity(0.06),
            spreadRadius: 0.5,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(width: containerWidth * 0.05),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AllColors.lighterPurple,
            ),
            width: circleSize,
            height: circleSize,
            child: Center(
              child: Icon(icon, size: iconSize, color: const Color(0xff7165ec)),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' ₹20000',
                style: TextStyle(
                  fontSize: amountFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                'Total Revenue',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  CommonButton(
                      height: 30,
                      width: 30,
                      color: AllColors.background_green,
                      title: '',
                      icon: Icon(Icons.compare_arrows_sharp,
                          size: 20, color: AllColors.text__green),
                      onPress: () {}),
                  const SizedBox(width: 4),
                  Text(
                    '4% (30 days)',
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}




// class AppRowContainerOneTab extends StatelessWidget {
//   // final double height;
//   // final double width;
//   final Color backgroundColor;
//   final IconData icon;
//   final String amount;
//   final String title;
//   final String subtitle;
//
//   const AppRowContainerOneTab({
//     Key? key,
//     // required this.height,
//     // required this.width,
//     required this.backgroundColor,
//     required this.icon,
//     required this.amount,
//     required this.title,
//     required this.subtitle,
//     required int size,
//     required Color color,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Get the screen size
//     final Size screenSize = MediaQuery.of(context).size;
//
//     // sizes based on screen size
//     // final double containerWidth = screenSize.width * 0.3;
//     // final double containerHeight = screenSize.height * 0.12;
//     final double circleSize = screenSize.width * 0.07;
//     final double iconSize = circleSize * 0.4;
//     final double amountFontSize = screenSize.width * 0.027;
//     final double titleFontSize = screenSize.width * 0.022;
//     final double subtitleFontSize = screenSize.width * 0.020;
//
//
//     return
//       Container(
//
//       margin: EdgeInsets.only(top: 10, bottom: 10, right: 4, left: 4),
//       padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
//       // width: containerWidth,
//       // height: containerHeight,
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black45.withOpacity(0.06),
//             spreadRadius: 0.5,
//             blurRadius: 4,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // SizedBox(width: containerWidth * 0.05),
//           Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: App_Colors.lighterPurple,
//             ),
//             width: circleSize,
//             height: circleSize,
//             child: Center(
//               child: Icon(icon, size: iconSize, color: const Color(0xff7165ec)),
//             ),
//           ),
//           const SizedBox(width: 15),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 amount,
//                 style: TextStyle(
//                   fontSize: amountFontSize,
//                   fontFamily: Fonts.nunitoRegular,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: titleFontSize,
//                   fontFamily: Fonts.nunitoRegular,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Row(
//                 children: [
//                   Icon(Icons.money_off_rounded, size: 18, color: Colors.green),
//                   SizedBox(width: 4),
//                   Text(
//                     subtitle,
//                     style: TextStyle(
//                       fontSize: subtitleFontSize,
//                       fontFamily: Fonts.nunitoRegular,
//                       fontWeight: FontWeight.w300,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


