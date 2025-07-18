import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../../../resources/strings/strings.dart';
import '../../../../../resources/textStyles/text_styles.dart';
import '../../../../../utils/appColors/app_colors.dart';

class LeadMasterScreenCard extends StatelessWidget {
  final String title;
  final String activity;

  const LeadMasterScreenCard({
    super.key,
    required this.title,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return

      ContainerUtils(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: AllColors.blackColor),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),

                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AllColors.lightPurple,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    activity,
                    style: TextStyle(
                        color: AllColors.vividPurple,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.calendar_month_outlined,
                  size: 16, color: AllColors.vividPurple),
              const SizedBox(
                width: 5,
              ),
              Text(
                'June 26, 2024 at 11:29 AM',
                style: TextStyle(
                  color: AllColors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 0.2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyles.w500_universal(
                  fontSize: 13,
                  color: AllColors.blackColor,
                  context,
                  Strings.subtypes),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_right_alt,
                size: 18,
                color: AllColors.lightGrey,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: Get.height / 40,
                        // width: Get.width/3.5,
                        decoration: BoxDecoration(
                            color: AllColors.textField2,
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: [
                            Text(
                              'Not Interested',
                              style: TextStyle(
                                  color: AllColors.darkGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              size: 14,
                              color: AllColors.lightGrey,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: Get.height / 40,
                        decoration: BoxDecoration(
                          color: AllColors.textField2,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Price Issue',
                              style: TextStyle(
                                  color: AllColors.darkGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              size: 14,
                              color: AllColors.lightGrey,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: Get.height / 40,
                        decoration: BoxDecoration(
                          color: AllColors.textField2,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Interested',
                              style: TextStyle(
                                  color: AllColors.darkGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              size: 14,
                              color: AllColors.lightGrey,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: Get.height / 40,
                        decoration: BoxDecoration(
                          color: AllColors.textField2,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Projection',
                              style: TextStyle(
                                color: AllColors.darkGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              size: 14,
                              color: AllColors.lightGrey,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.add_circle_outline,
                        size: 20,
                        color: AllColors.lightGrey,
                      )
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
