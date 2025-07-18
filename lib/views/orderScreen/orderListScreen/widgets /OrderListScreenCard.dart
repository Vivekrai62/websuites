import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../../../utils/appColors/app_colors.dart';
import '../../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';

class OrderListScreenCardController extends GetxController {
  final RxBool isExpanded = false.obs;

  void toggleExpand() {
    isExpanded.toggle();
  }
}

class OrderListScreenCard extends StatelessWidget {
  final String title;
  final String name;
  final String service;
  final String createdBy;
  final String pendingAmount;
  final String orderId;
  final String paidAmount;
  final String orderDate;
  final String status;
  final String finalPrice;

  // Controller as a required parameter
  final OrderListScreenCardController controller;

  const OrderListScreenCard({
    super.key,
    required this.title,
    required this.name,
    required this.service,
    required this.createdBy,
    required this.pendingAmount,
    required this.orderId,
    required this.paidAmount,
    required this.orderDate,
    required this.status,
    required this.finalPrice,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerUtils(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AllColors.blackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  Obx(() => !controller.isExpanded.value
                      ? Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: AllColors.lightYellow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              status,
                              style: TextStyle(
                                color: AllColors.darkYellow,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink()),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: controller.toggleExpand,
                    child: Obx(() => Icon(
                          controller.isExpanded.value
                              ? Icons.arrow_drop_up_sharp
                              : Icons.arrow_drop_down_sharp,
                          size: 30,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Obx(() => controller.isExpanded.value
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: AllColors.lightGrey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          service,
                          style: TextStyle(
                            color: AllColors.lightGrey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'CREATED BY',
                          style: TextStyle(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'PENDING AMOUNT',
                          style: TextStyle(
                            color: AllColors.blackColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Get.height / 40,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AllColors.lighterPurple,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              createdBy,
                              style: TextStyle(
                                color: AllColors.mediumPurple,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          pendingAmount,
                          style: TextStyle(
                            color: AllColors.vividRed,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    CommonSizedBox.height(context,2.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ORDER ID',
                          style: TextStyle(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'PAID AMOUNT',
                          style: TextStyle(
                            color: AllColors.blackColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orderId,
                          style: TextStyle(
                            color: AllColors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          paidAmount,
                          style: TextStyle(
                            color: AllColors.darkGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SYNC WITH ZOHO',
                          style: TextStyle(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'ORDERED DATE',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AllColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Get.height / 40,
                          width: Get.width / 6.5,
                          decoration: BoxDecoration(
                            color: AllColors.lightBlue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.sync,
                                  size: 13,
                                  color: AllColors.darkBlue,
                                ),
                                Text(
                                  'Sync',
                                  style: TextStyle(
                                    color: AllColors.darkBlue,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          orderDate,
                          style: TextStyle(
                            color: AllColors.lightGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 0.4,
                    ),
                    Row(
                      children: [
                        Container(
                          height: Get.height / 40,
                          width: Get.width / 6,
                          decoration: BoxDecoration(
                            color: AllColors.lightYellow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              status,
                              style: TextStyle(
                                color: AllColors.darkYellow,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          finalPrice,
                          style: TextStyle(
                            color: AllColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: AllColors.lightGrey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          service,
                          style: TextStyle(
                            color: AllColors.lightGrey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Get.height / 40,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AllColors.lighterPurple,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              createdBy,
                              style: TextStyle(
                                color: AllColors.mediumPurple,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          finalPrice,
                          style: TextStyle(
                            color: AllColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
        ],
      ),
    );
  }
}
