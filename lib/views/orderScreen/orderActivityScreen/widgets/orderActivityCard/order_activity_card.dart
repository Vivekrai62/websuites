import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/appColors/app_colors.dart';
import '../../../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';


class OrderActivityScreenCard extends StatelessWidget {
  final String title;

  const OrderActivityScreenCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: Get.height / 7,
      width: Get.width / 1,
      decoration: BoxDecoration(
          color: AllColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AllColors.blackColor.withOpacity(0.06),
              spreadRadius: 2,
              blurRadius: 4,
            ),
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
                  'Serviceable',
                  style: TextStyle(
                    color: AllColors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  '₹35,300',
                  style: TextStyle(
                    color: AllColors.blackColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              title,
              style: TextStyle(
                  color: AllColors.blackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            const Divider(
              thickness: 0.4,
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 16,
                  color: AllColors.mediumPurple,
                ),
                CommonSizedBox.width(context, 2.5),
                Text(
                  'June 25, 2024',
                  style: TextStyle(
                    color: AllColors.mediumPurple,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Container(
                  height: Get.height / 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: AllColors.lighterPurple,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Count-02',
                      style: TextStyle(
                          color: AllColors.mediumPurple, fontSize: 12),
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
