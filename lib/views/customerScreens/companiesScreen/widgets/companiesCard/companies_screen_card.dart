import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/appColors/app_colors.dart';

class CustomerCompaniesScreenCard extends StatelessWidget {
  final String title;

  const CustomerCompaniesScreenCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: Get.height / 5.6,
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
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Pulkit Surana',
                  style: TextStyle(
                      color: AllColors.mediumGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                Text(
                  'eraasinternational@gmail.com',
                  style: TextStyle(
                      color: AllColors.mediumGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ],
            ),
            Text(
              title,
              style: TextStyle(
                  color: AllColors.welcomeColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
            ),
            const Divider(
              thickness: 0.4,
            ),
            Row(
              children: [
                Icon(
                  Icons.call,
                  size: 17,
                  color: AllColors.lighterGrey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '+91-9818402350',
                  style: TextStyle(
                      color: AllColors.lightGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
                const Spacer(),
                Text(
                  'PARENT COMPANY',
                  style: TextStyle(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.language,
                  size: 17,
                  color: AllColors.lightGrey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'https://www.eraasinternational.com',
                  style: TextStyle(
                      color: AllColors.lightGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
                const Spacer(),
                Container(
                  height: Get.height / 40,
                  width: Get.width / 7,
                  decoration: BoxDecoration(
                      color: AllColors.lighterPurple,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      'N/A',
                      style: TextStyle(
                        color: AllColors.mediumPurple,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
