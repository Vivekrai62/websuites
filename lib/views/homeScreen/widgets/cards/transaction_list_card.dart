import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';

import '../../../../utils/appColors/app_colors.dart';

class TransactionListCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String name;

  const TransactionListCard({
    super.key,
    required this.title,
    required this.name,
    required this.amount,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        // height: Get.height / 9.5,
        // width: Get.width / 1.05,
        // decoration: BoxDecoration(
        //   color: App_Colors.whiteColor,
        //   borderRadius: BorderRadius.circular(10),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.black45.withOpacity(0.06),
        //       spreadRadius: 0.5,
        //       blurRadius: 4,
        //       offset: Offset(0, 0),
        //     ),
        //   ],
        // ),
        Container(
      margin: const EdgeInsets.only(right: 0, left: 0, top: 4, bottom: 4),
      height: Get.height / 12.5,
      width: Get.width / 1.05,
      decoration: BoxDecoration(
        color: AllColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            // color: Colors.greenAccent,
            height: Get.height / 8.4,

            padding: const EdgeInsets.only(
              left: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: AllColors.blackColor,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      size: 16,
                      color: AllColors.mediumPurple,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 11.5,
                        color: AllColors.mediumPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            // color: Colors.green,
            height: Get.height / 9.4,
            width: Get.width / 4.5,
            padding: const EdgeInsets.only(
              right: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  amount,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AllColors.blackColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13.2,
                    color: AllColors.figmaGrey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AppCardsThreeTab extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String name;

  const AppCardsThreeTab({
    super.key,
    required this.title,
    required this.name,
    required this.amount,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return
        // Container(
        // height: Get.height / 9.5,
        // width: Get.width / 1.05,
        // decoration: BoxDecoration(
        //   color: App_Colors.whiteColor,
        //   borderRadius: BorderRadius.circular(10),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.black45.withOpacity(0.06),
        //       spreadRadius: 0.5,
        //       blurRadius: 4,
        //       offset: Offset(0, 0),
        //     ),
        //   ],
        // ),
        Container(
      margin: const EdgeInsets.only(right: 12, left: 10, top: 5, bottom: 5),
      height: screenSize.height / 7.5,
      width: screenSize.width / 1.05,
      decoration: BoxDecoration(
        color: AllColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black45.withOpacity(0.06),
            spreadRadius: 0.5,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            // color: Colors.greenAccent,
            height: Get.height / 8.4,

            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AllColors.blackColor,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: AllColors.mediumPurple,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AllColors.mediumPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            // color: Colors.green,
            // height: Get.height / 9.4,
            // width: Get.width / 4.5,
            padding: const EdgeInsets.only(right: 12, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  amount,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                    color: AllColors.blackColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AllColors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
