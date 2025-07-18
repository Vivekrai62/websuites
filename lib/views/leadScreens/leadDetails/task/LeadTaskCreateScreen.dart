import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/models/responseModels/leads/list/lead_list.dart';
import '../../../../../utils/appColors/app_colors.dart';
import '../../../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../../../utils/fontfamily/FontFamily.dart';

import '../../../homeScreen/home_manager/HomeManagerScreen.dart';
import '../../leadList/lead_deatils/LeadDetails.dart';

class LeadTaskCreateScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Item?
  orderItem; // Optional: Pass lead item if needed for proforma creation

  const LeadTaskCreateScreen({
    super.key,
    required this.scaffoldKey,
    this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeManagerController>();
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
              child: Row(
                children: [
                  if (!isTablet)
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  Text(
                    "Lead Task Create",
                    style: TextStyle(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 17.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Return to LeadDetailsScreen
                        homeController.lastScreen.value = LeadDetailsScreen(
                          orderItem: orderItem,
                          scaffoldKey: homeController.scaffoldKey,
                        );
                        homeController.update();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back, color: Colors.black),
                            const SizedBox(width: 8),
                            Text(
                              "Back to Lead Details",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AllColors.mediumPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Add your proforma creation form or content here
                    Center(
                      child: Text(
                        "Proforma Creation Form for Lead: ${orderItem?.organization ?? 'N/A'}",
                        style: TextStyle(
                          fontSize: 18,
                          color: AllColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
