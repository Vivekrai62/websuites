import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';

import '../../../data/models/responseModels/master/divisions/master_divisions_response_model.dart';
import '../../../data/repositories/repositories.dart';
import '../../../resources/strings/strings.dart';
import '../../../resources/textStyles/text_styles.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/commonfilter/FilterBottomSheet.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import 'daily/DailySalesAnaltics.dart';

class SaleAnalyticsController extends GetxController {
  final Repositories _api = Repositories();
  RxList<MasterDivisionsResponseModel> divisions =
      <MasterDivisionsResponseModel>[].obs;

  var selectedIndex = 0.obs;
  var selectedMenuItem = 'Division'.obs;
  var selectedFilterItem =
      'Division'.obs; // Add this new variable for filter selection
  var isLoading = true.obs; // Loading state
}

class SaleAnalyticsScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const SaleAnalyticsScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _SaleAnalyticsScreenState createState() => _SaleAnalyticsScreenState();
}

class _SaleAnalyticsScreenState extends State<SaleAnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    final SaleAnalyticsController controller =
        Get.put(SaleAnalyticsController());

    void openFilterBottomSheet() {
      // Directly call showResponsiveFilter instead of showModalBottomSheet
      showResponsiveFilter(
        context, // Add context parameter
        FilterConfig(
          title: "My Filters",
          primaryColor: Colors.blue,
          filterOptions: [
            FilterOption(
              id: 'vivek',
              label: 'Vivek',
              hintText: 'Select date',
            ),
            FilterOption(
              id: 'ridhi',
              label: 'Ridhi',
              hintText: 'Search division',
            ),
            FilterOption(
              id: 'bikku',
              label: 'Bikku',
              hintText: 'Select categories',
            ),
          ],
          customBuilders: {
            'vivek': (context) => const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Date',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    // Add your date picker widget here
                  ],
                ),
            'ridhi': (context) => const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Division',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    // Add your division selection widget here
                  ],
                ),
            'bikku': (context) => const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    // Add your categories selection widget here
                  ],
                ),
          },
          onFilterApplied: (filterId, value) {
            print('Filter $filterId applied with value: $value');
            // Handle filter application here
          },
        ),
      );
    }

    final List<String> labels = [
      Strings.daily,
      Strings.monthly,
      Strings.division,
      Strings.category,
      Strings.product,
      Strings.customer,
      Strings.executive,
      Strings.team,
      Strings.country,
      Strings.state,
      Strings.district,
      Strings.city,
    ];

    // Method to get dynamic text based on selected index
    Widget getDynamicText(int index) {
      switch (index) {
        case 0:
          return const DailySalesAnalytics();
        case 1:
          return InkWell(
              onTap: () {},
              child: const Text("Hello Monthly, going to Chandigarh!"));
        case 2:
          return const Text("Hello Division, what's up?");
        case 3:
          return const Text("Hello Category, great to see you!");
        case 4:
          return const Text("Hello Product, ready for action?");
        case 5:
          return const Text("Hello Customer, hope you're doing well!");
        case 6:
          return const Text("Hello Executive, let's get things done!");
        case 7:
          return const Text("Hello Team, keep up the good work!");
        case 8:
          return const Text("Hello Country, let's make progress!");
        case 9:
          return const Text("Hello State, time to shine!");
        case 10:
          return const Text("Hello District, let's collaborate!");
        case 11:
          return const Text("Hello City, how's the vibe?");
        default:
          return const Text("Hello! Please select a category.");
      }
    }

    return Scaffold(
      backgroundColor: DarkMode.backgroundColor(context),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   surfaceTintColor: Colors.white,
      //   title: Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'Sale Analytics',
      //         style: TextStyle(
      //           fontWeight: FontWeight.w700,
      //           fontSize: 18,
      //           fontFamily: FontFamily.sfPro,
      //         ),
      //       ),
      //       Spacer(),
      //       Obx(() {
      //         String buttonTitle = 'Filter'; // Default title
      //         switch (controller.selectedIndex.value) {
      //           case 0:
      //             buttonTitle = 'Daily Filter';
      //             break;
      //           case 1:
      //             buttonTitle = 'Monthly Filter';
      //             break;
      //           case 2:
      //             buttonTitle = 'Division Filter';
      //             break;
      //           case 3:
      //             buttonTitle = 'Category Filter';
      //             break;
      //           case 4:
      //             buttonTitle = 'Product Filter';
      //             break;
      //           case 5:
      //             buttonTitle = 'Customer Filter';
      //             break;
      //           case 6:
      //             buttonTitle = 'Executive Filter';
      //             break;
      //           case 7:
      //             buttonTitle = 'Team Filter';
      //             break;
      //           case 8:
      //             buttonTitle = 'Country Filter';
      //             break;
      //           case 9:
      //             buttonTitle = 'State Filter';
      //             break;
      //           case 10:
      //             buttonTitle = 'District Filter';
      //             break;
      //           case 11:
      //             buttonTitle = 'City Filter';
      //             break;
      //           default:
      //             buttonTitle = 'Filter';
      //         }
      //
      //         return CommonButton(
      //           height: 25,
      //           width: 80,
      //           color: AllColors.mediumPurple,
      //
      //           // Optional
      //           // textColor: AllColors.whiteColor,
      //           title: buttonTitle,
      //           onPress: () {
      //             _openFilterBottomSheet(); // Use the function to open the sheet
      //           },
      //         );
      //       }),
      //     ],
      //   ),
      // ),

      body: Column(
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
                        widget.scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  Text(
                    'Setting',
                    style: TextStyle(
                      color: DarkMode.backgroundColor2(context),

                      fontWeight: FontWeight.w700,
                      fontSize: 17.5,
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    backgroundColor: AllColors.practiceColor,
                    width: 70,
                    height: 22,
                    borderRadius: 54,
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add,
                              color: AllColors.whiteColor, size: 18),
                          const SizedBox(width: 5),
                          const Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.sfPro,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // Horizontal scroll
                      child: Row(
                        children: List.generate(labels.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 10), // Add space between each container
                            child: GestureDetector(
                              onTap: () {
                                controller.selectedIndex.value = index;
                              },
                              child: Obx(() => Container(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 20, right: 20, bottom: 5),
                                    decoration: BoxDecoration(
                                      color: controller.selectedIndex.value ==
                                              index
                                          ? AllColors.practiceColor
                                          : AllColors.textField2,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: TextStyles.w400_15(
                                        color: controller.selectedIndex.value ==
                                                index
                                            ? AllColors
                                                .whiteColor // Set the text color for selected item
                                            : AllColors
                                                .blackColor, // Set text color for non-selected items
                                        context,
                                        labels[index],
                                      ),
                                    ),
                                  )),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Obx(
                          () => getDynamicText(controller.selectedIndex.value)),
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
