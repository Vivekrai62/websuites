import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/appColors/app_colors.dart';

class LeadTypeCountCard extends StatelessWidget {
  final String? count;
  final String? statusText;
  final Color? countColor;
  final Color? statusColor;
  final IconData? icon;
  final Color? iconColor;
  final Color? containerColor;

  const LeadTypeCountCard({
    super.key,
    this.count = '0',
    this.statusText = 'Status',
    this.countColor = Colors.black,
    this.statusColor = Colors.grey,
    this.icon = Icons.info,
    this.iconColor = Colors.white,
    this.containerColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 3, right: 10),
      padding: const EdgeInsets.only(left: 14, top: 2),
      height: 60,
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count ?? '0',
                style: TextStyle(
                    color: countColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                statusText ?? 'Status',
                style: TextStyle(
                  color: statusColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  icon,
                  size: 14,
                  color: iconColor,
                ),
              )
            ],
          )
        ],
      ),
    );

    // Container(
    //   margin: EdgeInsets.only(top: 10, bottom: 10),
    //   padding: EdgeInsets.only(left: 18, top: 2),
    //   height: Get.height / 13,
    //   width: Get.width / 4,
    //   decoration: BoxDecoration(
    //     color: App_Colors.whiteColor,
    //     borderRadius: BorderRadius.circular(10),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black45.withOpacity(0.06),
    //         spreadRadius: 0.5,
    //         blurRadius: 4,
    //         offset: Offset(0, 0),
    //       ),
    //     ],
    //   ),
    //   child: Row(
    //     children: [
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             count,
    //             style: TextStyle(
    //               color: countColor,
    //               fontSize: 13,
    //               fontFamily: Fonts.nunitoRegular,
    //             ),
    //           ),
    //           Text(
    //             statusText,
    //             style: TextStyle(
    //               color: statusColor,
    //               fontSize: 17,
    //               fontFamily: Fonts.nunitoRegular,
    //               fontWeight: FontWeight.w400,
    //             ),
    //           )
    //         ],
    //       ),
    //       Spacer(),
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Container(
    //             margin: EdgeInsets.only(right: 16),
    //             height: Get.height / 20,
    //             width: Get.width / 13.5,
    //             decoration: BoxDecoration(
    //               color: containerColor,
    //               borderRadius: BorderRadius.circular(5),
    //             ),
    //             child: Icon(
    //               icon,
    //               size: 28,
    //               color: iconColor,
    //             ),
    //           )
    //         ],
    //       )
    //     ],
    //   ),
    // ));
  }
}

class AppRowContainerTwoTab extends StatelessWidget {
  final String count;
  final String statusText;
  final Color countColor;
  final Color statusColor;
  final IconData icon;
  final Color iconColor;
  final Color containerColor;

  const AppRowContainerTwoTab({
    super.key,
    required this.count,
    required this.statusText,
    required this.countColor,
    required this.statusColor,
    required this.icon,
    required this.iconColor,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 4, left: 4),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      height: Get.height / 10,
      width: Get.width / 3.4,
      decoration: BoxDecoration(
        color: AllColors.whiteColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black45.withOpacity(0.06),
            spreadRadius: 0.5,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  color: countColor,
                  fontSize: 15,
                ),
              ),
              Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Get.height / 14,
                width: Get.width / 10,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: iconColor,
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
