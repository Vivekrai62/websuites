import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/appColors/app_colors.dart';

class SalesTargetScreenCard extends StatelessWidget {
  final String title;
  final String startDate;
  final String price;
  final String created_Date;
  final String deadline;
  final String member;

  const SalesTargetScreenCard({
    super.key,
    required this.title,
    required this.startDate,
    required this.price,
    required this.created_Date,
    required this.deadline,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: Get.height / 5.3,
      width: Get.width / 1,
      decoration: BoxDecoration(
          color: AllColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AllColors.blackColor.withOpacity(0.06),
                spreadRadius: 2,
                blurRadius: 4)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'START DATE - ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AllColors.blackColor,
                  ),
                ),
                Text(
                  startDate,
                  style: TextStyle(
                      color: AllColors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
                const Spacer(),
                Text(
                  price,
                  style: TextStyle(
                      color: AllColors.blackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 16,
                  color: AllColors.mediumPurple,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  created_Date,
                  style: TextStyle(
                    color: AllColors.mediumPurple,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  'DEADLINE - ',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AllColors.blackColor),
                ),
                Text(
                  deadline,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AllColors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 0.4,
            ),
            Row(
              children: [
                Text(
                  'MEMBERS - ',
                  style: TextStyle(
                      color: AllColors.blackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  member,
                  style: TextStyle(
                    color: AllColors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  'assets/svg/report.svg',
                  height: 14,
                  width: 14,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'REPORT',
                  style: TextStyle(
                      color: AllColors.blackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
