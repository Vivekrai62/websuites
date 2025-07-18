import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import 'package:websuites/viewModels/sales/sales_viewModel.dart';
import '../../resources/iconStrings/icon_strings.dart';
import '../../utils/appColors/app_colors.dart';
import '../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../utils/fontfamily/FontFamily.dart';
import '../salesTargetScreen/salesDetailsScreen/SalesDetailsScreen.dart';
import 'package:websuites/data/models/responseModels/sales/sales_response_model.dart'
    as salesModel; // Alias for customer model

class SalesTargetScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(salesModel.Item)? onOrderSelected; // Correct type?

  const SalesTargetScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<SalesTargetScreen> createState() => _SalesTargetScreenState();
}

class _SalesTargetScreenState extends State<SalesTargetScreen> {
  final SalesViewModel salesViewModel = Get.put(SalesViewModel());
  bool isFloatingButtonClicked = false;
  TextEditingController searchController = TextEditingController();

  Future<void> _refreshCustomerList() async {
    salesViewModel.loading.value = true;
    await salesViewModel.salesApi(context);
  }

  @override
  void initState() {
    super.initState();
    salesViewModel.salesApi(context);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          setState(() {
            isFloatingButtonClicked = !isFloatingButtonClicked;
          });
        },
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(() {
        if (salesViewModel.loading.value && !salesViewModel.dataLoaded.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
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
                      'Sales Target',
                      style: TextStyle(
                        color: AllColors.blackColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 17.5,
                      ),
                    ),
                    const Spacer(),
                    const InkWell(
                      child: Icon(Icons.filter_list, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshCustomerList,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (salesViewModel.sales.isEmpty) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: constraints.maxHeight,
                          child: const Center(
                            child: Text("No sales targets available"),
                          ),
                        ),
                      );
                    }

                    final double screenWidth = constraints.maxWidth;
                    int crossAxisCount = screenWidth < 600
                        ? 1
                        : screenWidth < 1200
                            ? 2
                            : 3;
                    final double itemWidth =
                        (screenWidth - (crossAxisCount - 1) * 16) /
                            crossAxisCount;
                    const double itemHeight = 175;
                    final double childAspectRatio = itemWidth / itemHeight;

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          if (isFloatingButtonClicked)
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, right: 15),
                              child: TextField(
                                controller: searchController,
                                decoration: const InputDecoration(
                                  hintText: 'Search sales targets...',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  // Add search logic here if needed
                                },
                              ),
                            ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemCount: salesViewModel.sales.length,
                            itemBuilder: (context, index) {
                              final item = salesViewModel.sales[index];
                              return GestureDetector(
                                onTap: () {
                                  if (widget.onOrderSelected != null) {
                                    widget.onOrderSelected!(item);
                                  } else {
                                    Get.to(() => const Salesdetailsscreen());
                                  }
                                },
                                child: ContainerUtils(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              (item.name != null &&
                                                      item.name!.isNotEmpty)
                                                  ? item.name![0]
                                                          .toUpperCase() +
                                                      item.name!.substring(1)
                                                  : 'N/A',
                                              style: TextStyle(
                                                color: AllColors.blackColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'START DATE - ',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AllColors.blackColor,
                                            ),
                                          ),
                                          Text(
                                            formatDateToLongMonth2(
                                              item.startDate != null
                                                  ? DateTime.parse(
                                                      item.startDate.toString())
                                                  : DateTime.now(),
                                            ),
                                            style: TextStyle(
                                              color: AllColors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            item.members.isNotEmpty &&
                                                    item.members[0]
                                                            .saleTarget !=
                                                        null
                                                ? '₹${item.members[0].saleTarget}'
                                                : '₹N/A',
                                            style: TextStyle(
                                              color: AllColors.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            size: 16,
                                            color: AllColors.mediumPurple,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            formatDateWithTime(
                                                item.createdAt.toString() ??
                                                    'N/A'),
                                            style: TextStyle(
                                              color: AllColors.mediumPurple,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            'DEADLINE - ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: AllColors.blackColor,
                                            ),
                                          ),
                                          // Text(
                                          //   item.deadline != null
                                          //       ? formatDateToLongMonth2(
                                          //       DateTime.parse(
                                          //           item.deadline!))
                                          //       : 'N/A', // Assuming deadline is a field
                                          //   style: TextStyle(
                                          //     fontWeight: FontWeight.w400,
                                          //     color: AllColors.grey,
                                          //     fontSize: 12,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      const Divider(thickness: 0.4),
                                      Row(
                                        children: [
                                          Text(
                                            'MEMBERS - ',
                                            style: TextStyle(
                                              color: AllColors.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          if (item.members.isNotEmpty)
                                            Text(
                                              "${item.members[0].saleTarget ?? 'N/A'}",
                                              style: TextStyle(
                                                color: AllColors.blackColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          const Spacer(),
                                          Image.asset(
                                            'assets/svg/report.svg',
                                            height: 14,
                                            width: 14,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            'REPORT',
                                            style: TextStyle(
                                              color: AllColors.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
