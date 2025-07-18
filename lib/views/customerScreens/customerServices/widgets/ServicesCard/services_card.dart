import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/appColors/app_colors.dart';

class AllServicesScreenCard extends StatelessWidget {
  final String title;

  const AllServicesScreenCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: Get.height / 4.6,
      width: Get.width / 1,
      decoration: BoxDecoration(
          color: AllColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AllColors.blackColor.withOpacity(0.06),
              spreadRadius: 2,
              blurRadius: 4,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Super 50(Quarterly)',
                  style: TextStyle(
                      color: AllColors.mediumGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: Get.height / 45,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: AllColors.lightBlue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Cheque',
                      style: TextStyle(
                          color: AllColors.darkBlue,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '₹ 55,000',
                  style: TextStyle(
                      color: AllColors.mediumGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Text(
              'Events Pharmaceuticals Pvt Ltd',
              style: TextStyle(
                color: AllColors.welcomeColor,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.mail_outline_rounded,
                  size: 16,
                  color: AllColors.lightGrey,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'eventpharma@gmail.com',
                  style: TextStyle(
                      color: AllColors.mediumGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                Text(
                  'ORDER NO',
                  style: TextStyle(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
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
                  width: 8,
                ),
                Text(
                  'Oct 3, 2023 To Oct 3, 2028',
                  style: TextStyle(
                      color: AllColors.mediumPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                Text(
                  '#003246',
                  style: TextStyle(
                    color: AllColors.lightGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 0.4,
            ),
            Container(
              height: Get.height / 40,
              width: Get.width / 3,
              decoration: BoxDecoration(
                color: AllColors.lighterPurple,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Currently Running',
                  style: TextStyle(
                      color: AllColors.mediumPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
