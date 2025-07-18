import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../resources/strings/strings.dart';
import '../../../../../resources/textStyles/text_styles.dart';
import '../../../../../utils/appColors/app_colors.dart';

import '../../../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';

class LeadActivitiesScreenCard extends StatelessWidget {
  final String title;
  final String companyName;

  const LeadActivitiesScreenCard({
    super.key,
    required this.title,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: Get.height / 3.6,
      width: Get.width / 1,
      decoration: BoxDecoration(
          color: AllColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AllColors.blackColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 0))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: AllColors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              companyName,
              style: TextStyle(
                  color: AllColors.welcomeColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 15,
                  color: AllColors.mediumPurple,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  'Wed, June 26, 2024 at 11:08 AM',
                  style: TextStyle(
                      color: AllColors.mediumPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'CALL',
                  style: TextStyle(
                      color: AllColors.blackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                CommonSizedBox.width(context, 2.5),
                const Icon(
                  Icons.arrow_right_alt,
                  size: 15,
                ),
                CommonSizedBox.width(context, 2.5),
                Text(
                  'Number Busy',
                  style: TextStyle(
                    color: AllColors.lightGrey,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: Get.height / 40,
                  decoration: BoxDecoration(
                      color: AllColors.lighterPurple,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Manish Jindal',
                      style: TextStyle(
                          color: AllColors.mediumPurple, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.09,
              color: AllColors.blackColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextStyles.w500_12(
                            color: AllColors.blackColor,
                            context,
                            Strings.remark),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Icon(
                            Icons.arrow_right_alt,
                            size: 20,
                            color: AllColors.lightGrey,
                          ),
                        ),
                        Text(
                          'Not Answered',
                          style: TextStyle(
                              color: AllColors.lightGrey, fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        TextStyles.w500_12(
                            color: AllColors.blackColor,
                            context,
                            Strings.reminder),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Icon(
                            Icons.arrow_right_alt,
                            size: 20,
                            color: AllColors.lightGrey,
                          ),
                        ),
                        Text(
                          '28/06/2024 11:59 am',
                          style: TextStyle(
                              color: AllColors.vividBlue,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: Get.height / 40,
                      decoration: BoxDecoration(
                          color: AllColors.lightBlue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'View',
                          style: TextStyle(
                              color: AllColors.vividBlue,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
