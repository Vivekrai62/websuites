import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../utils/appColors/app_colors.dart';

class LeadActivitiesScreenCard extends StatelessWidget {
  final String title;
  final String companyName;
  final String actionDate;
  final String activity;
  final String info;
  final String action_by;
  final String status;
  final String created_Date;
  final String request_Location;

  const LeadActivitiesScreenCard({
    super.key,
    required this.title,
    required this.companyName,
    required this.actionDate,
    required this.activity,
    required this.info,
    required this.action_by,
    required this.status,
    required this.created_Date,
    required this.request_Location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 180, // Set a fixed height for the card
      width: Get.width,
      decoration: BoxDecoration(
        color: AllColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AllColors.blackColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title and company name
            Flexible(
              child: Text(
                companyName,
                style: TextStyle(
                    color: AllColors.welcomeColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),

            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: AllColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const Spacer(),
                Icon(Icons.calendar_month_outlined,
                    size: 15, color: AllColors.mediumPurple),
                Text(
                  created_Date,
                  style: TextStyle(
                    color: AllColors.mediumPurple,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),

            // SizedBox(height: 5),
            Divider(thickness: 0.09, color: AllColors.blackColor),

            // Date and Activity Info

            // Activity Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Icon(
                    Icons.phone_in_talk,
                    size: 15,
                    color: AllColors.lightGrey,
                  ),
                ),
                // SizedBox(width: 5),

                const SizedBox(width: 5),
                Expanded(
                  flex: 70,
                  child: Text(
                    info,
                    style: TextStyle(color: AllColors.lightGrey, fontSize: 10),
                    overflow: TextOverflow.visible,
                    maxLines: 2, // Allow info to take up to 2 lines
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.menu_open_rounded,
                  size: 14,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  status,
                  style: TextStyle(color: AllColors.lightGrey, fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
            const SizedBox(height: 5),

            // Divider

            // Remark and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.notifications_active_outlined,
                            color: AllColors.vividBlue,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            actionDate,
                            style: TextStyle(
                                color: AllColors.vividBlue,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // Location Button
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: Get.height / 40,
                  decoration: BoxDecoration(
                      color: AllColors.lighterPurple,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      action_by,
                      style: TextStyle(
                          color: AllColors.mediumPurple, fontSize: 10),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // Action to be executed when the button is pressed
                  },
                  icon: Icon(
                    Icons
                        .remove_red_eye_outlined, // Correct usage of Icon widget
                    color: AllColors.vividBlue, // Set the icon color
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
