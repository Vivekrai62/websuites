import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../resources/strings/strings.dart';
import '../../../../../resources/textStyles/text_styles.dart';
import '../../../../../utils/appColors/app_colors.dart';
import '../../../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';

class CustomerActivitiesScreenCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomerActivitiesScreenCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: Get.height / 4,
      width: Get.width / 1,
      decoration: BoxDecoration(
          color: AllColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AllColors.blackColor.withOpacity(0.06),
                spreadRadius: 2,
                blurRadius: 4),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AllColors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: AllColors.welcomeColor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 17,
                  color: AllColors.mediumPurple,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Wed, Jun 26, 2024 at 11:39 AM',
                  style: TextStyle(
                    color: AllColors.mediumPurple,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Call',
                  style: TextStyle(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                ),
                CommonSizedBox.width(context, 5),
                const Icon(
                  Icons.arrow_right_alt,
                  size: 20,
                ),
                CommonSizedBox.width(context, 5),
                Text(
                  'Number Busy',
                  style: TextStyle(
                    color: AllColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: Get.height / 40,
                  decoration: BoxDecoration(
                    color: AllColors.lighterPurple,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Roshan Jha',
                      style: TextStyle(
                          color: AllColors.mediumPurple,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 0.4,
            ),
            Row(
              children: [
                TextStyles.w500_universal(
                    fontSize: 13,
                    color: AllColors.blackColor,
                    context,
                    Strings.remark),
                CommonSizedBox.width(context, 5),
                Icon(
                  Icons.arrow_right_alt,
                  size: 15,
                  color: AllColors.lightGrey,
                ),
                CommonSizedBox.width(context, 5),
                Text(
                  'Not Answered',
                  style: TextStyle(
                      color: AllColors.lightGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
              ],
            ),
            Row(
              children: [
                TextStyles.w500_universal(
                    fontSize: 13,
                    color: AllColors.blackColor,
                    context,
                    Strings.reminderTo),
                CommonSizedBox.width(context, 5),
                Icon(
                  Icons.arrow_right_alt,
                  size: 15,
                  color: AllColors.lightGrey,
                ),
                CommonSizedBox.width(context, 5),
                Text(
                  'Anil Kumar',
                  style: TextStyle(
                      color: AllColors.darkBlue,
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
                const Spacer(),
                Container(
                  height: Get.height / 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AllColors.lightBlue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'View',
                      style: TextStyle(
                        color: AllColors.vividBlue,
                        fontSize: 13,
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
