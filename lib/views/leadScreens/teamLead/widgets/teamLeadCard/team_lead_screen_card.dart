import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/appColors/app_colors.dart';

class TeamLeadScreenCard extends StatelessWidget {
  final String title;
  final String email;

  const TeamLeadScreenCard({
    super.key,
    required this.title,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: Get.height / 6,
      width: Get.width * 1,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AllColors.blackColor.withOpacity(0.06),
          spreadRadius: 2,
          blurRadius: 4,
        )
      ], borderRadius: BorderRadius.circular(10), color: AllColors.whiteColor),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: AllColors.mediumPurple,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                Text(
                  email,
                  style: TextStyle(
                    color: AllColors.lightGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            const Divider(thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'T.Leads',
                      style: TextStyle(
                          color: AllColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '8776',
                      style: TextStyle(
                          color: AllColors.lightGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Cold',
                      style: TextStyle(
                          color: AllColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '10',
                      style: TextStyle(
                          color: AllColors.lightGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Hot',
                      style: TextStyle(
                          color: AllColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '33',
                      style: TextStyle(
                          color: AllColors.lightGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Follow Up',
                      style: TextStyle(
                          color: AllColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '65',
                      style: TextStyle(
                          color: AllColors.lightGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Dead',
                      style: TextStyle(
                          color: AllColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '11',
                      style: TextStyle(
                          color: AllColors.lightGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
