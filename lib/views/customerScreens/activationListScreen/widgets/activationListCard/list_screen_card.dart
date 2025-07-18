import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/appColors/app_colors.dart';
import '../../../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';

class CustomerActivationListCard extends StatelessWidget {
  final String title;

  const CustomerActivationListCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: Get.height / 6,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Pharmahopers',
                  style: TextStyle(
                    color: AllColors.lightGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: Get.height / 40,
                  decoration: BoxDecoration(
                    color: AllColors.lightBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'View',
                      style: TextStyle(
                        color: AllColors.darkBlue,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Text(
              title,
              style: TextStyle(
                  color: AllColors.welcomeColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 14,
                  color: AllColors.mediumPurple,
                ),
                CommonSizedBox.width(context, 2.5),
                Text(
                  'Wed, June 26, 2024 at 11:08 AM',
                  style: TextStyle(
                    color: AllColors.mediumPurple,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.inventory,
                  size: 14,
                  color: AllColors.vividBlue,
                ),
                CommonSizedBox.width(context, 2.5),
                Text(
                  'Invalid Date',
                  style: TextStyle(
                      color: AllColors.vividBlue,
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
                const Spacer(),
                Container(
                  height: Get.height / 40,
                  width: Get.width / 4,
                  decoration: BoxDecoration(
                    color: AllColors.lightBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Nitin Sharma',
                      style: TextStyle(
                        color: AllColors.darkBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
