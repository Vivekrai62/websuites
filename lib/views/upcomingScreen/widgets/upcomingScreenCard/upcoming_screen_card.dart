import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../resources/imageStrings/image_strings.dart';
import '../../../../utils/appColors/app_colors.dart';

class UpcomingScreenCard extends StatelessWidget {
  final String title;
  final String companyName;

  const UpcomingScreenCard({
    super.key,
    required this.title,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 15),
      margin: const EdgeInsets.only(bottom: 10),
      height: Get.height / 3.8,
      width: Get.width / 1,
      decoration: BoxDecoration(
          color: AllColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black45.withOpacity(0.06),
              spreadRadius: 0.5,
              blurRadius: 8,
              offset: const Offset(0, 0),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AllColors.welcomeColor),
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_month_rounded,
                size: 17,
                color: AllColors.vividPurple,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Mon, 03 June 2024 at 12:29 pm',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AllColors.mediumPurple),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                size: 18,
                color: AllColors.grey,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '01 Hr, 30 Min',
                style: TextStyle(
                  color: AllColors.blackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 25),
              Icon(
                Icons.access_time_rounded,
                size: 18,
                color: AllColors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                '55 minutes',
                style: TextStyle(
                    color: AllColors.blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Divider(
            thickness: 0.4,
            color: AllColors.lighterGrey,
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AllColors.lightPurple,
                backgroundImage: const AssetImage(ImageStrings.splashWHLogo),
                radius: 14,
              ),
              const Spacer(),
              Container(
                height: Get.height / 45,
                width: Get.width / 4,
                decoration: BoxDecoration(
                  color: AllColors.lighterPurple,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Prakash Sethi',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: AllColors.vividPurple),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
