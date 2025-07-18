import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/responseModels/roles/roles_response_model.dart';
import '../../../utils/appColors/app_colors.dart';

class RoleDetailsScreen extends StatelessWidget {
  final RolesResponseModel role;

  const RoleDetailsScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTabletOrDesktop = MediaQuery.of(context).size.width >= 500;

    return Scaffold(
        // drawer: !isTabletOrDesktop
        //     ? Drawer(
        //   child: Obx(() => CustomDrawer(
        //     selectedIndex: controller.selectedIndex.value,
        //     onItemSelected: (index) => controller.onDrawerItemTapped(index, context),
        //     isCollapsed: controller.isCollapsed.value,
        //     onCollapseToggle: controller.toggleDrawerCollapse,
        //     isTabletOrDesktop: isTabletOrDesktop,
        //   )),
        // )
        //     : null,
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(role.name ?? 'Role Details'),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
              child: Column(
                children: [
                  // Display details for each user in the role
                  ...role.users.asMap().entries.map((entry) {
                    final int index = entry.key; // Index of the current user
                    final user = entry.value;

                    // Define your custom color logic here based on index
                    Color backgroundColor;
                    Color textColor;

                    if (index % 4 == 0) {
                      backgroundColor = AllColors.lightRed;
                      textColor = AllColors.vividRed;
                    } else if (index % 4 == 1) {
                      backgroundColor = AllColors.lighterPurple;
                      textColor = AllColors.mediumPurple;
                    } else if (index % 4 == 2) {
                      backgroundColor = AllColors.lightBlue;
                      textColor = AllColors.vividBlue;
                    } else {
                      backgroundColor = AllColors.lightYellow;
                      textColor = AllColors.darkYellow;
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Increased CircleAvatar size
                          Container(
                            height: screenHeight /
                                16, // Increased height for bigger circle
                            width: screenWidth /
                                9, // Increased width for bigger circle
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                user.firstName.substring(0, 1).toUpperCase() ??
                                    'N',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize:
                                      16, // Increased font size to match the bigger circle
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${user.firstName ?? ''} ${user.lastName ?? ''}"
                                        .trim()
                                        .isNotEmpty
                                    ? "${user.firstName ?? ''} ${user.lastName ?? ''}"
                                        .trim()
                                    : "No Name",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                role.name ?? 'No Role Name',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              )),
        ));
  }
}
