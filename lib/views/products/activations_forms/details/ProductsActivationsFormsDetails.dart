import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/utils/components/widgets/appBar/custom_appBar.dart';
import '../../../../data/models/responseModels/customers/list/customers_list_response_model.dart';
import '../../../../data/models/responseModels/products/activation_forms/ProductsActivationsFormsResModel.dart'
    as productsActivations;
import '../../../homeScreen/home_manager/HomeManagerScreen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/utils/components/widgets/appBar/custom_appBar.dart';
import '../../../../data/models/responseModels/customers/list/customers_list_response_model.dart'
    as customer_model;
import '../../../homeScreen/home_manager/HomeManagerScreen.dart';

class ProductsActivationsFormsDetails extends StatelessWidget {
  final String ActivationsId; // This should be a String
  final productsActivations.ProductsActivationsFormsResModel
      ActivationsData; // Ensure this is the correct type
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const ProductsActivationsFormsDetails({
    super.key,
    required this.ActivationsId,
    required this.ActivationsData,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeManagerController>();
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
              child: Row(
                children: [
                  if (!isTablet)
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black),
                      onPressed: () {
                        scaffoldKey?.currentState?.openDrawer();
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  Text(
                    'Activation Form Details',
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
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        homeController
                            .resetOrderDetails(); // Reset order details when going back
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back, color: Colors.black),
                            SizedBox(width: 8),
                            Text(
                              "Back to Activation Forms List",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Row(
                      children: [],
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Main container with shadow, rounded corners, and content
                        const ContainerUtils(
                          child: Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("1234"),
                                CreateNewLeadScreenCard2(hintText: "1234")
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 152),
                          child: ContainerUtils(
                            child: Padding(
                              padding: EdgeInsets.only(top: 120),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CreateNewLeadScreenCard2(hintText: "1234")
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Ribbon in the top-left corner
                        Positioned(
                          top: 18,
                          left: -7,
                          child: Transform.rotate(
                            angle: -0.785, // Rotate 45 degrees (in radians)
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 2),
                              decoration: BoxDecoration(
                                color: AllColors.vividPurple,
                                borderRadius: BorderRadius.circular(
                                    12), // Adjust this value to control the radius
                              ),
                              child: const Text(
                                'PREVIEW',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.sfPro),
                              ),
                            ),
                          ),
                        ),

                        // Text on the ribbon
                        Positioned(
                          top: 20,
                          left: 60,
                          child: Row(
                            children: [
                              Text(
                                "Note : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: AllColors.blackColor),
                              ),
                              Text(
                                "Only for view purpose",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: AllColors.blackColor,
                                    fontFamily: FontFamily.sfPro),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.remove_red_eye,
                                size: 20,
                                color: AllColors.blackColor,
                              )
                            ],
                          ),
                        ),

                        Positioned(
                          top: 160,
                          left: 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Details :-",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: AllColors.blackColor),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    ActivationsData.name ?? 'Unnamed Product',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 0),
                                    decoration: BoxDecoration(
                                      color: ActivationsData.parent
                                                  ?.isActivationFormEnabled ==
                                              true
                                          ? AllColors.background_green
                                          : AllColors.lightRed,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      ActivationsData.parent
                                                  ?.isActivationFormEnabled ==
                                              true
                                          ? 'Active'
                                          : 'Inactive',
                                      style: TextStyle(
                                        color: ActivationsData.parent
                                                    ?.isActivationFormEnabled ==
                                                true
                                            ? AllColors.text__green
                                            : AllColors.darkRed,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: FontFamily.sfPro,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "CC to user : ",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: AllColors.lightBlue,
                                    child: Icon(
                                      Icons.person_rounded,
                                      color: AllColors.darkBlue,
                                      size: 13,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    ActivationsData.requirementsCcToUsers
                                                .isNotEmpty ==
                                            true
                                        ? (() {
                                            // Get the first user from the list
                                            final user = ActivationsData
                                                .requirementsCcToUsers.first;
                                            // Combine first and last name
                                            String fullName =
                                                '${user.firstName ?? ''} ${user.lastName ?? ''}'
                                                    .trim();
                                            return fullName.isNotEmpty
                                                ? fullName
                                                : 'N/A'; // Return full name or 'N/A' if empty
                                          }())
                                        : 'N/A',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AllColors.figmaGrey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Mail to : ",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(
                                    width: 31,
                                  ),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: AllColors.greenJungle,
                                    child: Icon(
                                      Icons.person_rounded,
                                      color: AllColors.whiteColor,
                                      size: 13,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    ActivationsData.requirementsMailToUser !=
                                            null
                                        ? (() {
                                            // Get the user object
                                            final user = ActivationsData
                                                .requirementsMailToUser!;
                                            // Combine first and last name
                                            String fullName =
                                                '${user.firstName ?? ''} ${user.lastName ?? ''}'
                                                    .trim();
                                            return fullName.isNotEmpty
                                                ? fullName
                                                : 'N/A'; // Return full name or 'N/A' if empty
                                          }())
                                        : 'N/A',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AllColors.figmaGrey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
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
