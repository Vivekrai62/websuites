import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import '../../../data/models/requestModels/master/dashboard/save_changes/SettingDashSaveChangesRequestModel.dart';
import '../../../resources/strings/strings.dart';
import '../../../utils/components/buttons/common_button.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../viewModels/master/dashboard/SettingDashboardListViewModel.dart';
import '../../../../utils/utils.dart';
import 'graph/GraphPage.dart';

import 'dart:math' as math;

class PieChartController extends GetxController {
  var touchedIndex = (-1).obs;

  var isListSelected = false.obs; // Default to 'List' selected
  var isCusSelected = false.obs; // Default to 'List' selected
  var isLeadSourceSelected = false.obs; // Default to 'List' selected
  void setTouchedIndex(int index) {
    touchedIndex.value = index;
  }
}

class SettingDashboardScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const SettingDashboardScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _SettingDashboardScreenState createState() => _SettingDashboardScreenState();
}

class _SettingDashboardScreenState extends State<SettingDashboardScreen> {
  String formatDashboardName(String name, {bool isDivision = false}) {
    name = name.replaceAll('_chart', '').replaceAll('_', ' ');
    if (isDivision) {
      return name.toLowerCase();
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    final PieChartController tabController = Get.put(PieChartController());

    final List<SourceData> data = [
      SourceData(source: "Google", count: 11490, color: AllColors.thinPurple),
      SourceData(source: "Bot", count: 4000, color: Colors.orange.shade200),
      SourceData(
          source: "DirectCall", count: 8000, color: Colors.blue.shade200),
      SourceData(source: "Website", count: 4500, color: Colors.pink.shade200),
      SourceData(source: "OData", count: 3500, color: Colors.blue.shade100),
      SourceData(
          source: "Reference", count: 9000, color: Colors.orange.shade100),
      SourceData(source: "Facebook", count: 7500, color: Colors.blue.shade300),
      SourceData(
          source: "Offline Event", count: 6500, color: Colors.grey.shade400),
      SourceData(source: "Google", count: 8900, color: Colors.blue.shade200),
      SourceData(source: "Bot", count: 10000, color: Colors.orange.shade200),
      SourceData(
          source: "DirectCall", count: 3800, color: Colors.green.shade200),
      SourceData(source: "Website", count: 7000, color: Colors.pink.shade200),
      SourceData(source: "OData", count: 9500, color: Colors.blue.shade100),
      SourceData(source: "Facebook", count: 2800, color: Colors.blue.shade300),
    ];
    final Rx<String> selectedPeriod = 'This month'.obs;
    final Rx<bool> isConfigVisible = true.obs;
    final Rx<bool> isListSelected = true.obs;
    final Rx<Color> borderColor = Colors.grey.shade300.obs;
    final List<double> completedProjects = [
      10,
      15,
      12,
      18,
      20,
      22,
      25,
      23,
      20,
      18,
      15,
      10
    ];

    final List<Color> barColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
      Colors.pink,
      Colors.indigo,
      Colors.teal,
      Colors.yellow,
      Colors.amber,
      Colors.lime,
    ];

    final viewModel = Get.put(SettingDashboardListViewModel());
    RxDouble rotation = 0.0.obs;

    void toggleConfigVisibility() {
      isConfigVisible.value = !isConfigVisible.value;
    }

    void rotateIcon() {
      rotation.value -= 360.0;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchMasterSettingList(context);
    });

    return Scaffold(
      backgroundColor: DarkMode.backgroundColor(context),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   surfaceTintColor: Colors.white,
      //   title: Row(
      //     children: [
      //       Text(
      //         'Dashboard',
      //         style: TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.w600,
      //           fontFamily: FontFamily.sfPro,
      //         ),
      //       ),
      //       Spacer(),
      //       IconButton(
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => ImprovedWidget(),
      //             ),
      //           );
      //         },
      //         icon: Icon(Icons.graphic_eq),
      //       ),
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
                    Strings.dashboard,
                    style: TextStyle(
                      color: DarkMode.backgroundColor2(context),
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 17.5,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      // ImprovedWidget();
                    },
                    child:  Icon(Icons.filter_list, color: DarkMode.backgroundColor2(context),
                  ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (viewModel.loading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              List dashboardNames =
                  viewModel.masterDashboardItems.map((dashboard) {
                bool isDivision =
                    dashboard.name?.toLowerCase().contains('division') ?? false;
                return formatDashboardName(
                    dashboard.name ?? 'UNNAMED DASHBOARD',
                    isDivision: isDivision);
              }).toList();

              return viewModel.masterDashboardItems.isEmpty
                  ? const Center(child: Text('NO DASHBOARDS FOUND'))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10),
                          child: ContainerUtils(
                            paddingTop: 10,
                            paddingBottom: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                        Icons.dashboard_customize_outlined),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Dashboard Configuration',
                                      style: TextStyle(
                                          fontFamily: FontFamily.sfPro,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: toggleConfigVisibility,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_up_sharp),
                                    ),
                                  ],
                                ),
                                Obx(() => Visibility(
                                      visible: isConfigVisible.value,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Select Role For config',
                                            style: TextStyle(
                                                fontFamily: FontFamily.sfPro,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(height: 5),
                                          GestureDetector(
                                            onTap: () {
                                              borderColor.value =
                                                  AllColors.mediumPurple;
                                              showModalBottomSheet(
                                                backgroundColor: Colors.white,
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context) {
                                                  return Container(
                                                    height: 400,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          'SELECT DIVISION',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                FontFamily
                                                                    .sfPro,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            children:
                                                                dashboardNames
                                                                    .map(
                                                                        (name) {
                                                              return ListTile(
                                                                title: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      name,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            16,
                                                                        fontFamily:
                                                                            FontFamily.sfPro,
                                                                      ),
                                                                    ),
                                                                    if (viewModel
                                                                            .selectedDashboardName
                                                                            .value ==
                                                                        name)
                                                                      Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.transparent,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                AllColors.mediumPurple,
                                                                            width:
                                                                                1.5,
                                                                          ),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              2),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                AllColors.mediumPurple,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              const Icon(
                                                                            Icons.check,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                                onTap: () {
                                                                  viewModel
                                                                      .selectedDashboardName
                                                                      .value = name;
                                                                  var selectedDashboard = viewModel
                                                                      .masterDashboardItems
                                                                      .firstWhere((dashboard) =>
                                                                          formatDashboardName(dashboard.name ??
                                                                              'UNNAMED DASHBOARD') ==
                                                                          name);
                                                                  viewModel
                                                                          .selectedDashboardCharts
                                                                          .value =
                                                                      selectedDashboard
                                                                          .charts;
                                                                  viewModel
                                                                          .selectedDashboardId
                                                                          .value =
                                                                      selectedDashboard
                                                                          .id;
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: borderColor.value),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    formatDashboardName(viewModel
                                                            .selectedDashboardName
                                                            .value ??
                                                        'SELECT DASHBOARD'),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  const Icon(
                                                      Icons.arrow_drop_down),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                'Please Save Your Changes',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  fontFamily: FontFamily.sfPro,
                                                  color: AllColors.mediumPurple,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Icon(
                                                Icons.error_outline_rounded,
                                                color: AllColors.mediumPurple,
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  viewModel.loading.value =
                                                      true;

                                                  final response =
                                                      await viewModel
                                                          .saveCharts();
                                                  if (response != null) {
                                                    Utils.snackbarSuccess(response
                                                            .message ??
                                                        'CHART SAVED SUCCESSFULLY');
                                                  } else {
                                                    Utils.snackbarFailed(
                                                        'FAILED TO SAVE CHART');
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: AllColors.whiteColor,
                                                    border: Border.all(
                                                        color: AllColors
                                                            .darkGreen),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 3),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .bookmark_outline_sharp,
                                                            color: AllColors
                                                                .darkGreen),
                                                        const SizedBox(
                                                            width: 3),
                                                        Text(
                                                          'Save Charts',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AllColors
                                                                .darkGreen,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  viewModel.resetCharts();
                                                  rotateIcon();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    border: Border.all(
                                                        color:
                                                            AllColors.darkRed),
                                                    color: AllColors.lightRed,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 3),
                                                    child: Row(
                                                      children: [
                                                        AnimatedRotation(
                                                          turns:
                                                              rotation.value /
                                                                  360,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          child: Icon(
                                                            Icons
                                                                .settings_backup_restore,
                                                            color: AllColors
                                                                .darkRed,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 3),
                                                        Text(
                                                          'Reset Charts',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AllColors
                                                                .darkRed,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        if (viewModel.selectedDashboardCharts.value != null)
                          Expanded(
                              child: ListView.builder(
                            itemCount:
                                viewModel.selectedDashboardCharts.value!.length,
                            itemBuilder: (context, index) {
                              // Get the deletion states for the currently selected division
                              List<bool>? deletionStates = viewModel
                                      .divisionDeletionStates[
                                  viewModel.selectedDashboardName.value ?? ''];

                              // Skip rendering if the item is deleted
                              if (deletionStates != null &&
                                  index < deletionStates.length &&
                                  deletionStates[index]) {
                                return const SizedBox
                                    .shrink(); // Skip rendering this item
                              }

                              String chartName = formatDashboardName(viewModel
                                  .selectedDashboardCharts.value![index]);

                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  children: [
                                    ContainerUtils(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Row(
                                            children: [
                                              Text(
                                                chartName.toUpperCase(),
                                                style:  TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                  color: DarkMode.backgroundColor2(context),
                                                  fontFamily: FontFamily.sfPro,
                                                ),
                                              ),
                                              const Spacer(),
                                              if (index == 1)
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 10),
                                                    Obx(() {
                                                      return InkWell(
                                                        onTap: () {
                                                          tabController
                                                                  .isListSelected
                                                                  .value =
                                                              true; // Switch to List tab
                                                        },
                                                        highlightColor: Colors
                                                            .transparent, // Disable highlight
                                                        splashColor: Colors
                                                            .transparent, // Disable splash
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.list,
                                                              color: tabController
                                                                      .isListSelected
                                                                      .value
                                                                  ? Colors.blue
                                                                  : Colors.grey,
                                                              size: 24,
                                                            ),
                                                            const SizedBox(
                                                                width: 8),
                                                            Text(
                                                              'List',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: tabController
                                                                        .isListSelected
                                                                        .value
                                                                    ? Colors
                                                                        .blue
                                                                    : Colors
                                                                        .grey,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                    const SizedBox(width: 10),
                                                    Obx(() {
                                                      return InkWell(
                                                        onTap: () {
                                                          tabController
                                                                  .isListSelected
                                                                  .value =
                                                              false; // Switch to Chart tab
                                                        },
                                                        highlightColor: Colors
                                                            .transparent, // Disable highlight
                                                        splashColor: Colors
                                                            .transparent, // Disable splash
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.pie_chart,
                                                              color: !tabController
                                                                      .isListSelected
                                                                      .value
                                                                  ? Colors.blue
                                                                  : Colors.grey,
                                                              size: 17,
                                                            ),
                                                            const SizedBox(
                                                                width: 8),
                                                            Text(
                                                              'Chart',
                                                              style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: !tabController
                                                                        .isListSelected
                                                                        .value
                                                                    ? Colors
                                                                        .blue
                                                                    : Colors
                                                                        .grey,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Obx(() => Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: selectedPeriod.value ==
                                                                            'This month'
                                                                        ? Colors
                                                                            .yellow
                                                                        : Colors
                                                                            .transparent,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                  child:
                                                                      PopupMenuButton<
                                                                          String>(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            40),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    itemBuilder:
                                                                        (context) =>
                                                                            [
                                                                      const PopupMenuItem(
                                                                        value:
                                                                            'This month',
                                                                        child: Text(
                                                                            'This month'),
                                                                      ),
                                                                      const PopupMenuItem(
                                                                        value:
                                                                            'Last 30 Days',
                                                                        child: Text(
                                                                            'Last 30 Days'),
                                                                      ),
                                                                      const PopupMenuItem(
                                                                        value:
                                                                            'Last 3 months',
                                                                        child: Text(
                                                                            'Last 3 months'),
                                                                      ),
                                                                      const PopupMenuItem(
                                                                        value:
                                                                            'Last 6 months',
                                                                        child: Text(
                                                                            'Last 6 months'),
                                                                      ),
                                                                      const PopupMenuItem(
                                                                        value:
                                                                            'Last Year',
                                                                        child: Text(
                                                                            'Last Year'),
                                                                      ),
                                                                    ],
                                                                    onSelected:
                                                                        (String
                                                                            value) {
                                                                      selectedPeriod
                                                                              .value =
                                                                          value;
                                                                    },
                                                                    child:
                                                                        ContainerUtils(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      paddingBottom:
                                                                          0,
                                                                      paddingTop:
                                                                          0,
                                                                      paddingRight:
                                                                          6,
                                                                      paddingLeft:
                                                                          6,
                                                                      backgroundColor:
                                                                          AllColors
                                                                              .mediumPurple,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            selectedPeriod.value,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: FontFamily.sfPro,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                          const Icon(
                                                                            Icons.keyboard_arrow_down,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                  ],
                                                ),
                                              if (index == 4)
                                                Obx(() => Container(
                                                      decoration: BoxDecoration(
                                                        color: selectedPeriod
                                                                    .value ==
                                                                'This month'
                                                            ? Colors.yellow
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: PopupMenuButton<
                                                          String>(
                                                        color: Colors.white,
                                                        offset:
                                                            const Offset(0, 40),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        itemBuilder:
                                                            (context) => [
                                                          const PopupMenuItem(
                                                            value: 'This month',
                                                            child: Text(
                                                              'This month',
                                                            ),
                                                          ),
                                                          const PopupMenuItem(
                                                            value:
                                                                'Last 30 Days',
                                                            child: Text(
                                                                'Last 30 Days'),
                                                          ),
                                                          const PopupMenuItem(
                                                            value:
                                                                'Last 3 months',
                                                            child: Text(
                                                                'Last 3 months'),
                                                          ),
                                                          const PopupMenuItem(
                                                            value:
                                                                'Last 6 months',
                                                            child: Text(
                                                                'Last 6 months'),
                                                          ),
                                                          const PopupMenuItem(
                                                            value: 'Last Year',
                                                            child: Text(
                                                                'Last Year'),
                                                          ),
                                                        ],
                                                        onSelected:
                                                            (String value) {
                                                          selectedPeriod.value =
                                                              value;
                                                        },
                                                        child: ContainerUtils(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          paddingBottom: 2,
                                                          paddingTop: 2,
                                                          paddingRight: 6,
                                                          paddingLeft: 6,
                                                          backgroundColor:
                                                              AllColors
                                                                  .mediumPurple,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                selectedPeriod
                                                                    .value,
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .sfPro,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .keyboard_arrow_down,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              if (index == 5)
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Text(
                                                        Strings
                                                            .latestCustomerSeeAll,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AllColors
                                                              .vividPurple,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 12,
                                                      color:
                                                          AllColors.vividPurple,
                                                    )
                                                  ],
                                                ),
                                              if (index == 8)
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Text(
                                                        Strings
                                                            .latestCustomerSeeAll,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AllColors
                                                              .vividPurple,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 12,
                                                      color:
                                                          AllColors.vividPurple,
                                                    )
                                                  ],
                                                ),
                                              if (index == 9)
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Text(
                                                        Strings
                                                            .latestCustomerSeeAll,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AllColors
                                                              .vividPurple,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 12,
                                                      color:
                                                          AllColors.vividPurple,
                                                    )
                                                  ],
                                                ),
                                              if (index == 11)
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Text(
                                                        Strings
                                                            .latestCustomerSeeAll,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AllColors
                                                              .vividPurple,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 12,
                                                      color:
                                                          AllColors.vividPurple,
                                                    )
                                                  ],
                                                ),
                                              if (index == 12)
                                                Expanded(
                                                    child:
                                                        CreateNewLeadScreenCard2(
                                                  allowCustomBorderInput:
                                                      BorderRadius.circular(30),
                                                  hintText: 'select date',
                                                  isDateField: true,
                                                )),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  viewModel.removeChart(index);
                                                },
                                                child: Image.asset(
                                                  'assets/icons/delete.png',
                                                  height: 17,
                                                  width: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          const Divider(thickness: 0.5),
                                          const SizedBox(height: 10),
                                          const Row(
                                            children: [
                                              SizedBox(width: 15),
                                            ],
                                          ),
                                          if (index == 0)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                CommonButton(
                                                                    height: 35,
                                                                    width: 35,
                                                                    color: AllColors
                                                                        .background_green,
                                                                    title: '',
                                                                    icon: Icon(
                                                                        Icons
                                                                            .arrow_forward_outlined,
                                                                        color: AllColors
                                                                            .text__green),
                                                                    onPress:
                                                                        () {}),
                                                                const SizedBox(
                                                                    width: 10),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              4),
                                                                  child: Text(
                                                                    'New',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            17,
                                                                        fontFamily:
                                                                            FontFamily.sfPro),
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                Text(
                                                                  '+ 0.5%',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          13,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      color: AllColors
                                                                          .text__green),
                                                                ),
                                                              ],
                                                            ),
                                                            const Text(
                                                              '58234',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .sfPro,
                                                                fontSize: 23,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                CommonButton(
                                                                  height: 35,
                                                                  width: 35,
                                                                  color: AllColors
                                                                      .lighterPurple,
                                                                  title: '',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .watch_later_outlined,
                                                                    color: AllColors
                                                                        .mediumPurple,
                                                                  ),
                                                                  onPress:
                                                                      () {},
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Expanded(
                                                                  // Use Expanded to allow the text to take available space
                                                                  child:
                                                                      GestureDetector(
                                                                    // Wrap the Text in GestureDetector for tap action
                                                                    onTap: () {
                                                                      // Add your action here, e.g., show more details
                                                                    },
                                                                    child:
                                                                        const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              4),
                                                                      child:
                                                                          Text(
                                                                        'In Progress.',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              FontFamily.sfPro,
                                                                        ),
                                                                        maxLines:
                                                                            2, // Limit to 2 lines if needed
                                                                        overflow:
                                                                            TextOverflow.ellipsis, // Add ellipsis if text overflows
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        10), // Add some spacing
                                                                Text(
                                                                  '+ 0.5%',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    color: AllColors
                                                                        .text__green,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Text(
                                                              '12',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .sfPro,
                                                                fontSize: 23,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                CommonButton(
                                                                    height: 35,
                                                                    width: 35,
                                                                    color: AllColors
                                                                        .lightRed,
                                                                    title: '',
                                                                    icon: Icon(
                                                                        Icons
                                                                            .compare_arrows_sharp,
                                                                        color: AllColors
                                                                            .darkRed),
                                                                    onPress:
                                                                        () {}),
                                                                const SizedBox(
                                                                    width: 10),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              4),
                                                                  child: Text(
                                                                    'Repeat',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            17,
                                                                        fontFamily:
                                                                            FontFamily.sfPro),
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                Text(
                                                                  '+ 0.5%',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          13,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      color: AllColors
                                                                          .text__green),
                                                                ),
                                                              ],
                                                            ),
                                                            const Text(
                                                              '32',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .sfPro,
                                                                fontSize: 23,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                CommonButton(
                                                                  height: 35,
                                                                  width: 35,
                                                                  color: AllColors
                                                                      .lighterPurple,
                                                                  title: '',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .menu_open,
                                                                    color: AllColors
                                                                        .mediumPurple,
                                                                  ),
                                                                  onPress:
                                                                      () {},
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Expanded(
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () {},
                                                                    child:
                                                                        const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              4),
                                                                      child:
                                                                          Text(
                                                                        'To-Do-Leads',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              FontFamily.sfPro,
                                                                        ),
                                                                        maxLines:
                                                                            2, // Limit to 2 lines if needed
                                                                        overflow:
                                                                            TextOverflow.ellipsis, // Add ellipsis if text overflows
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        10), // Add some spacing
                                                                Text(
                                                                  '+ 0.5%',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    color: AllColors
                                                                        .text__green,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Text(
                                                              '112',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .sfPro,
                                                                fontSize: 23,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                CommonButton(
                                                                  height: 35,
                                                                  width: 35,
                                                                  color: AllColors
                                                                      .background_green,
                                                                  title: '',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .person_remove_outlined,
                                                                    color: AllColors
                                                                        .text__green,
                                                                  ),
                                                                  onPress:
                                                                      () {},
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Expanded(
                                                                  // Use Expanded to allow the text to take available space
                                                                  child:
                                                                      GestureDetector(
                                                                    // Wrap the Text in GestureDetector for tap action
                                                                    onTap: () {
                                                                      // Add your action here, e.g., show more details
                                                                    },
                                                                    child:
                                                                        const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        'Un-Assigned.',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              FontFamily.sfPro,
                                                                        ),
                                                                        maxLines:
                                                                            2, // Limit to 2 lines if needed
                                                                        overflow:
                                                                            TextOverflow.ellipsis, // Add ellipsis if text overflows
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        10), // Add some spacing
                                                                Text(
                                                                  '+ 0.5%',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    color: AllColors
                                                                        .text__green,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Text(
                                                              '100',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .sfPro,
                                                                fontSize: 23,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                CommonButton(
                                                                  height: 35,
                                                                  width: 35,
                                                                  color: AllColors
                                                                      .lightRed,
                                                                  title: '',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .lock_clock_outlined,
                                                                    color: AllColors
                                                                        .darkRed,
                                                                  ),
                                                                  onPress:
                                                                      () {},
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Expanded(
                                                                  // Use Expanded to allow the text to take available space
                                                                  child:
                                                                      GestureDetector(
                                                                    // Wrap the Text in GestureDetector for tap action
                                                                    onTap: () {
                                                                      // Add your action here, e.g., show more details
                                                                    },
                                                                    child:
                                                                        const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        'Unhandled.',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              FontFamily.sfPro,
                                                                        ),
                                                                        maxLines:
                                                                            2, // Limit to 2 lines if needed
                                                                        overflow:
                                                                            TextOverflow.ellipsis, // Add ellipsis if text overflows
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        10), // Add some spacing
                                                                Text(
                                                                  '+ 0.5%',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    color: AllColors
                                                                        .text__green,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Text(
                                                              '240',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .sfPro,
                                                                fontSize: 23,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          if (index == 1)
                                            Obx(() {
                                              return tabController
                                                      .isListSelected.value
                                                  ? Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Obx(() => Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: selectedPeriod.value ==
                                                                            'This month'
                                                                        ? Colors
                                                                            .yellow
                                                                        : Colors
                                                                            .transparent,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                  child:
                                                                      PopupMenuButton<
                                                                          String>(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            40),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    itemBuilder:
                                                                        (context) =>
                                                                            [
                                                                      const PopupMenuItem(
                                                                        value:
                                                                            'This month',
                                                                        child:
                                                                            Text(
                                                                          'This month',
                                                                        ),
                                                                      ),
                                                                      const PopupMenuItem(
                                                                        value:
                                                                            'Last 30 Days',
                                                                        child: Text(
                                                                            'Last 30 Days'),
                                                                      ),
                                                                      const PopupMenuItem(
                                                                        value:
                                                                            'Last 3 months',
                                                                        child: Text(
                                                                            'Last 3 months'),
                                                                      ),
                                                                      const PopupMenuItem(
                                                                        value:
                                                                            'Last 6 months',
                                                                        child: Text(
                                                                            'Last 6 months'),
                                                                      ),
                                                                      const PopupMenuItem(
                                                                        value:
                                                                            'Last Year',
                                                                        child: Text(
                                                                            'Last Year'),
                                                                      ),
                                                                    ],
                                                                    onSelected:
                                                                        (String
                                                                            value) {
                                                                      selectedPeriod
                                                                              .value =
                                                                          value;
                                                                    },
                                                                    child:
                                                                        ContainerUtils(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      paddingBottom:
                                                                          2,
                                                                      paddingTop:
                                                                          2,
                                                                      paddingRight:
                                                                          6,
                                                                      paddingLeft:
                                                                          6,
                                                                      backgroundColor:
                                                                          AllColors
                                                                              .mediumPurple,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            selectedPeriod.value,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: FontFamily.sfPro,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                          const Icon(
                                                                            Icons.keyboard_arrow_down,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            _buildLeadItem(
                                                                '2199',
                                                                'Hot',
                                                                AllColors
                                                                    .thinPurple,
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 5),
                                                                'Lead'),
                                                            _buildLeadItem(
                                                                '892',
                                                                'Cold',
                                                                Colors.green
                                                                    .shade200,
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5),
                                                                'Lead'),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            _buildLeadItem(
                                                                '1050',
                                                                'Dead',
                                                                Colors.pink
                                                                    .shade200,
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 0,
                                                                    right: 5),
                                                                'Lead'),
                                                            _buildLeadItem(
                                                                '14',
                                                                'FollowUp',
                                                                Colors.blue
                                                                    .shade200,
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 5,
                                                                    left: 5),
                                                                'Lead'),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Center(
                                                          child: SizedBox(
                                                            width: 200,
                                                            height: 200,
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                // Using GetX to observe changes in touchedIndex
                                                                GetX<
                                                                    PieChartController>(
                                                                  init:
                                                                      PieChartController(),
                                                                  builder:
                                                                      (controller) {
                                                                    return PieChart(
                                                                      PieChartData(
                                                                        sectionsSpace:
                                                                            0,
                                                                        borderData:
                                                                            FlBorderData(show: false),
                                                                        pieTouchData:
                                                                            PieTouchData(
                                                                          touchCallback:
                                                                              (FlTouchEvent event, pieTouchResponse) {
                                                                            if (!event.isInterestedForInteractions ||
                                                                                pieTouchResponse == null ||
                                                                                pieTouchResponse.touchedSection == null) {
                                                                              // Set touched index to -1 when no section is touched
                                                                              controller.setTouchedIndex(-1);
                                                                              return;
                                                                            }
                                                                            // Set touched index based on the touched section
                                                                            controller.setTouchedIndex(pieTouchResponse.touchedSection!.touchedSectionIndex);
                                                                          },
                                                                        ),
                                                                        sections: List.generate(
                                                                            4,
                                                                            (i) {
                                                                          final isTouched =
                                                                              i == controller.touchedIndex.value;
                                                                          final fontSize = isTouched
                                                                              ? 16.0
                                                                              : 16.0;
                                                                          final radius = isTouched
                                                                              ? 45.0
                                                                              : 40.0;
                                                                          switch (
                                                                              i) {
                                                                            case 0: // Blue section
                                                                              return PieChartSectionData(
                                                                                color: Colors.blue,
                                                                                value: 52,
                                                                                title: '52%',
                                                                                radius: radius,
                                                                                titleStyle: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: fontSize,
                                                                                ),
                                                                              );
                                                                            case 1: // Red section
                                                                              return PieChartSectionData(
                                                                                color: Colors.red,
                                                                                value: 35,
                                                                                title: '35%',
                                                                                radius: radius,
                                                                                titleStyle: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: fontSize,
                                                                                ),
                                                                              );
                                                                            case 2: // Purple section
                                                                              return PieChartSectionData(
                                                                                color: Colors.purple,
                                                                                value: 1,
                                                                                title: '1%',
                                                                                radius: radius,
                                                                                titleStyle: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: fontSize,
                                                                                ),
                                                                              );
                                                                            case 3: // Orange section
                                                                              return PieChartSectionData(
                                                                                color: Colors.orange,
                                                                                value: 35,
                                                                                title: '35%',
                                                                                radius: radius,
                                                                                titleStyle: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: fontSize,
                                                                                ),
                                                                              );
                                                                            default:
                                                                              throw Error();
                                                                          }
                                                                        }),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                // Center text displaying the total
                                                                const Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'Total', // Total label
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            26,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '122', // Total value
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 30),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: 7,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .blue,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    "Hot",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontFamily:
                                                                            FontFamily
                                                                                .sfPro,
                                                                        fontSize:
                                                                            16),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: 7,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .yellow,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Text(
                                                                    "Cold",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontFamily:
                                                                            FontFamily
                                                                                .sfPro,
                                                                        fontSize:
                                                                            16),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: 7,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Text(
                                                                    "Dead",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontFamily:
                                                                            FontFamily
                                                                                .sfPro,
                                                                        fontSize:
                                                                            16),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: 7,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .purple,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Text(
                                                                    "FollowUp",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontFamily:
                                                                            FontFamily
                                                                                .sfPro,
                                                                        fontSize:
                                                                            16),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    );
                                            }),
                                          if (index == 2)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Wrap(
                                                  spacing: 15,
                                                  // Space between the children
                                                  runSpacing: 10,
                                                  // Space between the lines
                                                  children: [
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 16,
                                                              backgroundColor:
                                                                  AllColors
                                                                      .lightYellow,
                                                              child: Icon(
                                                                  Icons
                                                                      .date_range,
                                                                  color: AllColors
                                                                      .vividYellow,
                                                                  size: 16),
                                                            ),
                                                            const SizedBox(
                                                                width: 6),
                                                            const Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Today',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.9,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                Text(
                                                                  '4',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 16,
                                                              backgroundColor:
                                                                  AllColors
                                                                      .lightRed,
                                                              child: Text(
                                                                '!',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    fontSize:
                                                                        14,
                                                                    color: AllColors
                                                                        .darkRed,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 6),
                                                            const Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Missing',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.9,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                Text(
                                                                  '19500',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 16,
                                                              backgroundColor:
                                                                  AllColors
                                                                      .background_green,
                                                              child: Icon(
                                                                  Icons
                                                                      .upcoming,
                                                                  color: AllColors
                                                                      .text__green,
                                                                  size: 16),
                                                            ),
                                                            const SizedBox(
                                                                width: 6),
                                                            const Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'UpComing',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.9,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                Text(
                                                                  '5',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'Today Reminders List',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontSize: 15),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor: AllColors
                                                            .background_green,
                                                        child: Text(
                                                          'VM',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .text__green),
                                                        )),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .email_outlined,
                                                              size: 18,
                                                              color: AllColors
                                                                  .figmaGrey,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            const Text(
                                                              'Varun Mittal (Owner)',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .sfPro,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          '16 October 2024 at 9:23 pm',
                                                          style: TextStyle(
                                                              color: AllColors
                                                                  .greyBlack,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: AllColors
                                                            .lightYellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .notifications_outlined,
                                                            size: 14,
                                                            color: AllColors
                                                                .mediumYellow,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Today',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .mediumYellow,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors.myGreen,
                                                        child: Text(
                                                          'M',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .whiteColor),
                                                        )),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 0.5,
                                                  height: 20,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors
                                                                .lightYellow,
                                                        child: Text(
                                                          'ff',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .mediumYellow),
                                                        )),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .email_outlined,
                                                              size: 18,
                                                              color: AllColors
                                                                  .figmaGrey,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            const Text(
                                                              'frrdf fvdsg',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .sfPro,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          '16 October 2024 at 12:00 pm',
                                                          style: TextStyle(
                                                              color: AllColors
                                                                  .greyBlack,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: AllColors
                                                            .lightYellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .notifications_outlined,
                                                            size: 14,
                                                            color: AllColors
                                                                .mediumYellow,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Today',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .mediumYellow,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors.lightGrey,
                                                        child: Text(
                                                          'R',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .whiteColor),
                                                        )),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 0.5,
                                                  height: 20,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor: AllColors
                                                            .background_green,
                                                        child: Text(
                                                          'VM',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .text__green),
                                                        )),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .email_outlined,
                                                              size: 18,
                                                              color: AllColors
                                                                  .figmaGrey,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            const Text(
                                                              'Varun Mittal (Owner)',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .sfPro,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          '16 October 2024 at 9:23 pm',
                                                          style: TextStyle(
                                                              color: AllColors
                                                                  .greyBlack,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: AllColors
                                                            .lightYellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .notifications_outlined,
                                                            size: 14,
                                                            color: AllColors
                                                                .mediumYellow,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Today',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .mediumYellow,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors.myGreen,
                                                        child: Text(
                                                          'M',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .whiteColor),
                                                        )),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 0.5,
                                                  height: 20,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor: AllColors
                                                            .background_green,
                                                        child: Text(
                                                          'ulg',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .text__green),
                                                        )),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .email_outlined,
                                                              size: 18,
                                                              color: AllColors
                                                                  .figmaGrey,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            const Text(
                                                              'unhandeled lead2',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .sfPro,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          '16 October 2024 at 9:23 pm',
                                                          style: TextStyle(
                                                              color: AllColors
                                                                  .greyBlack,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: AllColors
                                                            .lightYellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .notifications_outlined,
                                                            size: 14,
                                                            color: AllColors
                                                                .mediumYellow,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Today',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .mediumYellow,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors
                                                                .mediumPurple,
                                                        child: Text(
                                                          'D',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .whiteColor),
                                                        )),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 0.5,
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          if (index == 3)
                                            Column(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Obx(() =>
                                                            GestureDetector(
                                                              onTap: () {
                                                                isListSelected
                                                                        .value =
                                                                    true;
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                    'assets/icons/Menuthreedot.png',
                                                                    height: 17,
                                                                    width: 17,
                                                                    cacheHeight:
                                                                        27,
                                                                    cacheWidth:
                                                                        29,
                                                                    color: isListSelected.value
                                                                        ? AllColors
                                                                            .mediumPurple
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    'List',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontSize:
                                                                          19,
                                                                      color: isListSelected.value
                                                                          ? AllColors
                                                                              .mediumPurple
                                                                          : Colors
                                                                              .grey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                        const SizedBox(
                                                            width: 30),
                                                        Obx(
                                                            () =>
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    isListSelected
                                                                            .value =
                                                                        false;
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .pie_chart,
                                                                          color: !isListSelected.value
                                                                              ? AllColors.mediumPurple
                                                                              : Colors.grey,
                                                                          size: 19),
                                                                      const SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                        'Chart',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontFamily:
                                                                              FontFamily.sfPro,
                                                                          fontSize:
                                                                              19,
                                                                          color: !isListSelected.value
                                                                              ? AllColors.mediumPurple
                                                                              : Colors.grey,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Obx(() {
                                                      return isListSelected
                                                              .value
                                                          ? Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    _buildLeadItem(
                                                                        '11490',
                                                                        'Google',
                                                                        AllColors
                                                                            .thinPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                5),
                                                                        'Lead'),
                                                                    _buildLeadItem(
                                                                        '690',
                                                                        'Bot',
                                                                        const Color(
                                                                            0xFFFFE5A3),
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                5),
                                                                        'Lead'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    _buildLeadItem(
                                                                        '150',
                                                                        'Direct Call',
                                                                        AllColors
                                                                            .minorPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                0,
                                                                            right:
                                                                                5),
                                                                        'Lead'),
                                                                    _buildLeadItem(
                                                                        '6',
                                                                        'PPC Facebook',
                                                                        AllColors
                                                                            .thinPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                5,
                                                                            left:
                                                                                5),
                                                                        'Lead'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    _buildLeadItem(
                                                                        '1023',
                                                                        'Tele Tele Services',
                                                                        const Color(
                                                                            0xFFFFE5A3),
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                5),
                                                                        'Lead'),
                                                                    _buildLeadItem(
                                                                        '408',
                                                                        'Old Data',
                                                                        AllColors
                                                                            .minorPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                5,
                                                                            right:
                                                                                5),
                                                                        'Lead'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    _buildLeadItem(
                                                                        '25',
                                                                        'Reference',
                                                                        AllColors
                                                                            .thinPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                5),
                                                                        'Lead'),
                                                                    _buildLeadItem(
                                                                        '54',
                                                                        'JustDial',
                                                                        const Color(
                                                                            0xFFFFE5A3),
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                5),
                                                                        'Lead'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    _buildLeadItem(
                                                                        '51',
                                                                        'DirectVisit',
                                                                        AllColors
                                                                            .minorPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                5,
                                                                            right:
                                                                                5),
                                                                        'Lead'),
                                                                    _buildLeadItem(
                                                                        '8',
                                                                        'Blog',
                                                                        AllColors
                                                                            .thinPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                5,
                                                                            left:
                                                                                5),
                                                                        'Lead'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    _buildLeadItem(
                                                                        '8',
                                                                        'IndiaMart',
                                                                        const Color(
                                                                            0xFFFFE5A3),
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                5),
                                                                        'Lead'),
                                                                    _buildLeadItem(
                                                                        '3',
                                                                        'Facebook',
                                                                        AllColors
                                                                            .minorPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                5,
                                                                            right:
                                                                                5),
                                                                        'Lead'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    _buildLeadItem(
                                                                        '1',
                                                                        'PPC Google',
                                                                        AllColors
                                                                            .thinPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                5),
                                                                        'Lead'),
                                                                    _buildLeadItem(
                                                                        '2',
                                                                        'Offline Event',
                                                                        const Color(
                                                                            0xFFFFE5A3),
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                5),
                                                                        'Lead'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                              ],
                                                            )
                                                          : Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                AspectRatio(
                                                                  aspectRatio:
                                                                      2.2,
                                                                  child:
                                                                      BarChart(
                                                                    BarChartData(
                                                                      maxY: data.map((e) => e.count.toDouble()).reduce((a, b) => a > b
                                                                              ? a
                                                                              : b) *
                                                                          1.1,
                                                                      minY: 0,
                                                                      barGroups: data
                                                                          .asMap()
                                                                          .entries
                                                                          .map(
                                                                              (entry) {
                                                                        int index =
                                                                            entry.key;
                                                                        SourceData
                                                                            source =
                                                                            entry.value;
                                                                        return BarChartGroupData(
                                                                          x: index,
                                                                          barRods: [
                                                                            BarChartRodData(
                                                                              toY: source.count.toDouble(),
                                                                              color: source.color,
                                                                              width: 20,
                                                                              borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(13),
                                                                                topRight: Radius.circular(13),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                          showingTooltipIndicators: [
                                                                            0
                                                                          ],
                                                                        );
                                                                      }).toList(),
                                                                      titlesData:
                                                                          FlTitlesData(
                                                                        leftTitles:
                                                                            AxisTitles(
                                                                          sideTitles:
                                                                              SideTitles(
                                                                            showTitles:
                                                                                true,
                                                                            reservedSize:
                                                                                45,
                                                                            getTitlesWidget:
                                                                                (double value, TitleMeta meta) {
                                                                              return Padding(
                                                                                padding: const EdgeInsets.only(right: 8.0),
                                                                                child: Text(
                                                                                  value.toInt().toString(),
                                                                                  style: const TextStyle(fontSize: 12, color: Colors.green),
                                                                                  textAlign: TextAlign.right,
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                        rightTitles:
                                                                            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                                        topTitles:
                                                                            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                                        bottomTitles:
                                                                            AxisTitles(
                                                                          sideTitles:
                                                                              SideTitles(
                                                                            showTitles:
                                                                                true,
                                                                            reservedSize:
                                                                                50,
                                                                            getTitlesWidget:
                                                                                (double value, TitleMeta meta) {
                                                                              if (value.toInt() < 0 || value.toInt() >= data.length) {
                                                                                return Container();
                                                                              }
                                                                              return Transform.rotate(
                                                                                angle: -0.4,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(top: 8.0),
                                                                                  child: Text(
                                                                                    data[value.toInt()].source,
                                                                                    style: TextStyle(fontSize: 10, color: AllColors.grey),
                                                                                    textAlign: TextAlign.center,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      gridData:
                                                                          FlGridData(
                                                                        show:
                                                                            true,
                                                                        drawVerticalLine:
                                                                            false,
                                                                        drawHorizontalLine:
                                                                            true,
                                                                        getDrawingHorizontalLine:
                                                                            (value) {
                                                                          return FlLine(
                                                                            color: value == 0
                                                                                ? Colors.black
                                                                                : Colors.transparent,
                                                                            strokeWidth: value == 0
                                                                                ? 1
                                                                                : 0,
                                                                          );
                                                                        },
                                                                      ),
                                                                      borderData:
                                                                          FlBorderData(
                                                                              show: false),
                                                                      barTouchData:
                                                                          BarTouchData(
                                                                        enabled:
                                                                            true,
                                                                        touchTooltipData:
                                                                            BarTouchTooltipData(
                                                                          getTooltipColor: (group) =>
                                                                              Colors.transparent,
                                                                          tooltipPadding:
                                                                              EdgeInsets.zero,
                                                                          tooltipMargin:
                                                                              0,
                                                                          getTooltipItem: (group,
                                                                              groupIndex,
                                                                              rod,
                                                                              rodIndex) {
                                                                            return BarTooltipItem(
                                                                              rod.toY.toInt().toString(),
                                                                              const TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                    }),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          if (index == 4)
                                            Column(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Obx(() =>
                                                            GestureDetector(
                                                              onTap: () {
                                                                isListSelected
                                                                        .value =
                                                                    true;
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                    'assets/icons/Menuthreedot.png',
                                                                    height: 17,
                                                                    width: 17,
                                                                    cacheHeight:
                                                                        27,
                                                                    cacheWidth:
                                                                        29,
                                                                    color: isListSelected.value
                                                                        ? AllColors
                                                                            .mediumPurple
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    'List',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontSize:
                                                                          19,
                                                                      color: isListSelected.value
                                                                          ? AllColors
                                                                              .mediumPurple
                                                                          : Colors
                                                                              .grey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                        const SizedBox(
                                                            width: 40),
                                                        Obx(
                                                            () =>
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    isListSelected
                                                                            .value =
                                                                        false;
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .pie_chart,
                                                                          color: !isListSelected.value
                                                                              ? AllColors.mediumPurple
                                                                              : Colors.grey,
                                                                          size: 19),
                                                                      const SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                        'Chart',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontFamily:
                                                                              FontFamily.sfPro,
                                                                          fontSize:
                                                                              19,
                                                                          color: !isListSelected.value
                                                                              ? AllColors.mediumPurple
                                                                              : Colors.grey,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                        const SizedBox(
                                                            width: 15),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Obx(() {
                                                      return isListSelected
                                                              .value
                                                          ? Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    _buildLeadItem(
                                                                        '94',
                                                                        'Project Not Started',
                                                                        AllColors
                                                                            .thinPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                5),
                                                                        'Customer'),
                                                                    _buildLeadItem(
                                                                        '69',
                                                                        'Project On Hold',
                                                                        AllColors
                                                                            .minorPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                5),
                                                                        'Customer'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    _buildLeadItem(
                                                                        '337',
                                                                        'Service Running',
                                                                        AllColors
                                                                            .thinPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                5),
                                                                        'Customer'),
                                                                    _buildLeadItem(
                                                                        '1725',
                                                                        'No Services',
                                                                        const Color(
                                                                            0xFFFFE5A3),
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                5),
                                                                        'Customer'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    _buildLeadItem(
                                                                        '20',
                                                                        'Project In Progress',
                                                                        AllColors
                                                                            .thinPurple,
                                                                        const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                5,
                                                                            left:
                                                                                0),
                                                                        'Customer'),
                                                                    _buildLeadItem(
                                                                        '20',
                                                                        'Project In Progress',
                                                                        AllColors
                                                                            .thinPurple,
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                5),
                                                                        'Custo.'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                              ],
                                                            )
                                                          : Column(
                                                              children: [
                                                                Center(
                                                                  child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            250,
                                                                        height:
                                                                            250,
                                                                        child:
                                                                            PieChart(
                                                                          PieChartData(
                                                                            sectionsSpace:
                                                                                0,
                                                                            centerSpaceRadius:
                                                                                60,
                                                                            // This creates the donut hole
                                                                            sections: [
                                                                              PieChartSectionData(
                                                                                value: 71,
                                                                                color: Colors.purple,
                                                                                title: '71%',
                                                                                titleStyle: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                                radius: 60,
                                                                                showTitle: true,
                                                                              ),
                                                                              PieChartSectionData(
                                                                                value: 3,
                                                                                color: Colors.blue,
                                                                                title: '3%',
                                                                                titleStyle: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                                radius: 60,
                                                                                showTitle: true,
                                                                              ),
                                                                              PieChartSectionData(
                                                                                value: 8,
                                                                                color: Colors.orange,
                                                                                title: '8%',
                                                                                titleStyle: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                                radius: 60,
                                                                                showTitle: true,
                                                                              ),
                                                                              PieChartSectionData(
                                                                                value: 2,
                                                                                color: Colors.red,
                                                                                title: '2%',
                                                                                titleStyle: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                                radius: 60,
                                                                                showTitle: true,
                                                                              ),
                                                                              PieChartSectionData(
                                                                                value: 13,
                                                                                color: Colors.purple.shade300,
                                                                                title: '13%',
                                                                                titleStyle: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                                radius: 60,
                                                                                showTitle: true,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Text(
                                                                            'Total',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 24,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            '2428',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 22,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          radius:
                                                                              7,
                                                                          backgroundColor:
                                                                              Colors.blue,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          "Project Not Startd",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontFamily: FontFamily.sfPro,
                                                                              fontSize: 16),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          radius:
                                                                              7,
                                                                          backgroundColor:
                                                                              Colors.yellow,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              8,
                                                                        ),
                                                                        Text(
                                                                          "Projecg On Hold",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontFamily: FontFamily.sfPro,
                                                                              fontSize: 16),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                const Row(
                                                                  children: [
                                                                    CircleAvatar(
                                                                      radius: 7,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Text(
                                                                      "Project  In Progress",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontFamily: FontFamily
                                                                              .sfPro,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    Spacer(),
                                                                    CircleAvatar(
                                                                      radius: 7,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .purple,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Text(
                                                                      "Service Running",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontFamily: FontFamily
                                                                              .sfPro,
                                                                          fontSize:
                                                                              16),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    CircleAvatar(
                                                                      radius: 7,
                                                                      backgroundColor:
                                                                          AllColors
                                                                              .thinPurple,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    const Text(
                                                                      "No Services",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontFamily: FontFamily
                                                                              .sfPro,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    const Spacer(),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                    }),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          if (index == 5)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Wrap(
                                                  spacing: 15,
                                                  // Space between the children
                                                  runSpacing: 10,
                                                  // Space between the lines
                                                  children: [
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 16,
                                                              backgroundColor:
                                                                  AllColors
                                                                      .lightYellow,
                                                              child: Icon(
                                                                  Icons
                                                                      .date_range,
                                                                  color: AllColors
                                                                      .vividYellow,
                                                                  size: 16),
                                                            ),
                                                            const SizedBox(
                                                                width: 6),
                                                            const Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Today',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.9,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                Text(
                                                                  '4',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 16,
                                                              backgroundColor:
                                                                  AllColors
                                                                      .lightRed,
                                                              child: Text(
                                                                '!',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    fontSize:
                                                                        14,
                                                                    color: AllColors
                                                                        .darkRed,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 6),
                                                            const Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Missing',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.9,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                Text(
                                                                  '1043',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 16,
                                                              backgroundColor:
                                                                  AllColors
                                                                      .background_green,
                                                              child: Icon(
                                                                  Icons
                                                                      .upcoming,
                                                                  color: AllColors
                                                                      .text__green,
                                                                  size: 16),
                                                            ),
                                                            const SizedBox(
                                                                width: 6),
                                                            const Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'UpComing',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.9,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                Text(
                                                                  '11',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'Today Reminders List',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontSize: 15),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Row(
                                                          children: [
                                                            Text(
                                                              'Mr. Ajay Bhardwaj',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .sfPro,
                                                                  fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          '16 October 2024 at 12:13 pm',
                                                          style: TextStyle(
                                                              color: AllColors
                                                                  .greyBlack,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AllColors.lightRed,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .notifications_outlined,
                                                            size: 14,
                                                            color: AllColors
                                                                .darkRed,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Missed',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .darkRed,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors.myGreen,
                                                        child: Text(
                                                          'L',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .whiteColor),
                                                        )),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 0.5,
                                                  height: 20,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Row(
                                                          children: [
                                                            Text(
                                                              'frrdf fvdsg',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .sfPro,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          '16 October 2024 at 11:36 pm',
                                                          style: TextStyle(
                                                              color: AllColors
                                                                  .greyBlack,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AllColors.lightRed,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .notifications_outlined,
                                                            size: 14,
                                                            color: AllColors
                                                                .darkRed,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Missed',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .darkRed,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors.myGreen,
                                                        child: Text(
                                                          'L',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .whiteColor),
                                                        )),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 0.5,
                                                  height: 20,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Row(
                                                          children: [
                                                            Text(
                                                              'hello fersdf)',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .sfPro,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          '16 October 2024 at 11:35 pm',
                                                          style: TextStyle(
                                                              color: AllColors
                                                                  .greyBlack,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AllColors.lightRed,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .notifications_outlined,
                                                            size: 14,
                                                            color: AllColors
                                                                .darkRed,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Missed',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .darkRed,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors
                                                                .mediumPurple,
                                                        child: Text(
                                                          'A',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .whiteColor),
                                                        )),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 0.5,
                                                  height: 20,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Row(
                                                          children: [
                                                            Text(
                                                              'hello fersdf',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .sfPro,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          '16 October 2024 at 9:23 pm',
                                                          style: TextStyle(
                                                              color: AllColors
                                                                  .greyBlack,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AllColors.lightRed,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .notifications_outlined,
                                                            size: 14,
                                                            color: AllColors
                                                                .darkRed,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Missed',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .darkRed,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors.greyBlack,
                                                        child: Text(
                                                          'D',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .whiteColor),
                                                        )),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 0.5,
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          if (index == 6)
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    StatusCard(
                                                      number: "3",
                                                      label: "Not Started",
                                                      color:
                                                          AllColors.mediumGrey,
                                                      showBorder: true,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    const StatusCard(
                                                      number: "1",
                                                      label: "In Progress",
                                                      color: Colors.green,
                                                      showBorder: true,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    StatusCard(
                                                      number: "1",
                                                      label: "Pending",
                                                      color: AllColors
                                                          .mediumPurple,
                                                      showBorder: true,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    const StatusCard(
                                                      number: "1",
                                                      label: "Re-Open",
                                                      color: Colors.black,
                                                      showBorder: true,
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.1),
                                                        blurRadius: 10,
                                                        spreadRadius: 2,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 20),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Spacer(),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          6),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[100],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child: const Row(
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .calendar_today,
                                                                      size: 16,
                                                                      color: Color(
                                                                          0xFF76C56F)),
                                                                  SizedBox(
                                                                      width: 6),
                                                                  Text(
                                                                    'Last 7 Days',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF666666),
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 300,
                                                        child: LineChart(
                                                          LineChartData(
                                                            gridData:
                                                                FlGridData(
                                                              show: true,
                                                              drawHorizontalLine:
                                                                  true,
                                                              horizontalInterval:
                                                                  2,
                                                              getDrawingHorizontalLine:
                                                                  (value) {
                                                                return const FlLine(
                                                                  color: Color(
                                                                      0xFFEEEEEE),
                                                                  strokeWidth:
                                                                      1,
                                                                );
                                                              },
                                                              drawVerticalLine:
                                                                  false,
                                                            ),
                                                            titlesData:
                                                                FlTitlesData(
                                                              show: true,
                                                              rightTitles:
                                                                  AxisTitles(
                                                                sideTitles:
                                                                    SideTitles(
                                                                  showTitles:
                                                                      true,
                                                                  interval: 2,
                                                                  reservedSize:
                                                                      40,
                                                                  getTitlesWidget:
                                                                      (value,
                                                                          meta) {
                                                                    return Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              12),
                                                                      child:
                                                                          Text(
                                                                        value
                                                                            .toInt()
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.grey[600],
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              topTitles: const AxisTitles(
                                                                  sideTitles: SideTitles(
                                                                      showTitles:
                                                                          false)),
                                                              bottomTitles:
                                                                  AxisTitles(
                                                                sideTitles:
                                                                    SideTitles(
                                                                  showTitles:
                                                                      true,
                                                                  reservedSize:
                                                                      32,
                                                                  interval: 1,
                                                                  getTitlesWidget:
                                                                      (value,
                                                                          meta) {
                                                                    const days =
                                                                        [
                                                                      'Thu',
                                                                      'Fri',
                                                                      'Sat',
                                                                      'Sun',
                                                                      'Mon',
                                                                      'Tue',
                                                                      'Wed'
                                                                    ];
                                                                    if (value >=
                                                                            0 &&
                                                                        value <
                                                                            days.length) {
                                                                      return Container(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                8.0),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border(
                                                                            top:
                                                                                BorderSide(
                                                                              color: Colors.grey.withOpacity(0.1),
                                                                              width: 1,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          days[value
                                                                              .toInt()],
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.grey[600],
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    return const Text(
                                                                        '');
                                                                  },
                                                                ),
                                                              ),
                                                              leftTitles: const AxisTitles(
                                                                  sideTitles: SideTitles(
                                                                      showTitles:
                                                                          false)), // Hide left titles
                                                            ),
                                                            borderData:
                                                                FlBorderData(
                                                                    show:
                                                                        false),
                                                            minX: 0,
                                                            maxX: 6,
                                                            minY: 0,
                                                            maxY: 16,
                                                            lineBarsData: [
                                                              LineChartBarData(
                                                                spots: const [
                                                                  FlSpot(0, 10),
                                                                  FlSpot(1, 15),
                                                                  FlSpot(2, 8),
                                                                  FlSpot(3, 6),
                                                                  FlSpot(4, 11),
                                                                  FlSpot(5, 4),
                                                                  FlSpot(6, 10),
                                                                ],
                                                                isCurved: true,
                                                                color: const Color(
                                                                    0xFF76C56F),
                                                                barWidth: 3,
                                                                isStrokeCapRound:
                                                                    true,
                                                                dotData:
                                                                    FlDotData(
                                                                  show: true,
                                                                  getDotPainter: (spot,
                                                                          percent,
                                                                          barData,
                                                                          index) =>
                                                                      FlDotCirclePainter(
                                                                    radius: 4,
                                                                    color: Colors
                                                                        .white,
                                                                    strokeWidth:
                                                                        2,
                                                                    strokeColor:
                                                                        const Color(
                                                                            0xFF76C56F),
                                                                  ),
                                                                ),
                                                                belowBarData:
                                                                    BarAreaData(
                                                                  show: true,
                                                                  gradient:
                                                                      LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      const Color(
                                                                              0xFF76C56F)
                                                                          .withOpacity(
                                                                              0.3),
                                                                      const Color(
                                                                              0xFF76C56F)
                                                                          .withOpacity(
                                                                              0.05),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (index == 7)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.date_range_sharp,
                                                      color: AllColors
                                                          .mediumPurple,
                                                      size: 14,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const Text(
                                                      'Last 12 Months Completed Projects Graphical View',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30),
                                                  child: SizedBox(
                                                    height: 300,
                                                    child: BarChart(
                                                      BarChartData(
                                                        alignment:
                                                            BarChartAlignment
                                                                .spaceAround,
                                                        maxY: 25,
                                                        barTouchData:
                                                            BarTouchData(
                                                          enabled: false,
                                                          touchTooltipData:
                                                              BarTouchTooltipData(
                                                            getTooltipColor:
                                                                (group) => Colors
                                                                    .transparent,
                                                            tooltipPadding:
                                                                EdgeInsets.zero,
                                                            tooltipMargin: 0,
                                                            getTooltipItem:
                                                                (group,
                                                                    groupIndex,
                                                                    rod,
                                                                    rodIndex) {
                                                              return BarTooltipItem(
                                                                rod.toY
                                                                    .toStringAsFixed(
                                                                        0),
                                                                const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 11,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        titlesData:
                                                            FlTitlesData(
                                                          show: true,
                                                          bottomTitles:
                                                              AxisTitles(
                                                            sideTitles:
                                                                SideTitles(
                                                              showTitles: true,
                                                              getTitlesWidget:
                                                                  (value,
                                                                      meta) {
                                                                final months = [
                                                                  'Jan',
                                                                  'Feb',
                                                                  'Mar',
                                                                  'Apr',
                                                                  'May',
                                                                  'Jun',
                                                                  'Jul',
                                                                  'Aug',
                                                                  'Sep',
                                                                  'Oct',
                                                                  'Nov',
                                                                  'Dec'
                                                                ];
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              8.0),
                                                                  child: Text(
                                                                    months[value
                                                                        .toInt()],
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                              .grey[
                                                                          700],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          leftTitles:
                                                              AxisTitles(
                                                            sideTitles:
                                                                SideTitles(
                                                              showTitles: true,
                                                              getTitlesWidget:
                                                                  (value,
                                                                      meta) {
                                                                return Text(
                                                                  value
                                                                      .toInt()
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                            .grey[
                                                                        700],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          rightTitles: const AxisTitles(
                                                              sideTitles:
                                                                  SideTitles(
                                                                      showTitles:
                                                                          false)),
                                                          topTitles: const AxisTitles(
                                                              sideTitles:
                                                                  SideTitles(
                                                                      showTitles:
                                                                          false)),
                                                        ),
                                                        gridData:
                                                            const FlGridData(
                                                          show:
                                                              false, // Disable all grid lines (horizontal and vertical)
                                                        ),
                                                        borderData:
                                                            FlBorderData(
                                                                show: false),
                                                        barGroups:
                                                            completedProjects
                                                                .asMap()
                                                                .entries
                                                                .map(
                                                                  (entry) =>
                                                                      BarChartGroupData(
                                                                    x: entry
                                                                        .key,
                                                                    barRods: [
                                                                      BarChartRodData(
                                                                        toY: entry
                                                                            .value,
                                                                        color: barColors[
                                                                            entry.key],
                                                                        width:
                                                                            21,
                                                                        borderRadius:
                                                                            BorderRadius.circular(4),
                                                                      ),
                                                                    ],
                                                                    showingTooltipIndicators: [
                                                                      0
                                                                    ],
                                                                  ),
                                                                )
                                                                .toList(),
                                                      ),
                                                      swapAnimationDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  150),
                                                      swapAnimationCurve:
                                                          Curves.linear,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (index == 8)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Wrap(
                                                  spacing: 15,
                                                  // Space between the children
                                                  runSpacing: 10,
                                                  // Space between the lines
                                                  children: [
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 16,
                                                              backgroundColor:
                                                                  AllColors
                                                                      .lightYellow,
                                                              child: Icon(
                                                                  Icons
                                                                      .date_range,
                                                                  color: AllColors
                                                                      .vividYellow,
                                                                  size: 16),
                                                            ),
                                                            const SizedBox(
                                                                width: 6),
                                                            const Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Today',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.9,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                Text(
                                                                  '2',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 16,
                                                              backgroundColor:
                                                                  AllColors
                                                                      .lightRed,
                                                              child: Text(
                                                                '!',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    fontSize:
                                                                        14,
                                                                    color: AllColors
                                                                        .darkRed,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 6),
                                                            const Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Missing',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.9,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                Text(
                                                                  '414',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ContainerUtils(
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 16,
                                                              backgroundColor:
                                                                  AllColors
                                                                      .background_green,
                                                              child: Icon(
                                                                  Icons
                                                                      .upcoming,
                                                                  color: AllColors
                                                                      .text__green,
                                                                  size: 16),
                                                            ),
                                                            const SizedBox(
                                                                width: 6),
                                                            const Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'UpComing',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.9,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                Text(
                                                                  '29',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'Today Reminders List',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontSize: 15),
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '16 October 2024 at 12:13 pm',
                                                          style: TextStyle(
                                                              color: AllColors
                                                                  .greyBlack,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AllColors.lightRed,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .notifications_outlined,
                                                            size: 14,
                                                            color: AllColors
                                                                .darkRed,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Missed',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .darkRed,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors
                                                                .mediumPurple,
                                                        child: Text(
                                                          'A',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .whiteColor),
                                                        )),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 0.5,
                                                  height: 20,
                                                ),
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '16 October 2024 at 11:36 pm',
                                                          style: TextStyle(
                                                              color: AllColors
                                                                  .greyBlack,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AllColors.lightRed,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .notifications_outlined,
                                                            size: 14,
                                                            color: AllColors
                                                                .darkRed,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Missed',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .darkRed,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors
                                                                .mediumPurple,
                                                        child: Text(
                                                          'A',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .whiteColor),
                                                        )),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 0.5,
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          if (index == 9)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Current Month Projects',
                                                  style: TextStyle(
                                                      color: AllColors.darkGrey,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily:
                                                          FontFamily.sfPro),
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'Special',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              FontFamily.sfPro),
                                                    ),
                                                    const Spacer(),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors.greyBlack,
                                                        child: Text(
                                                          'R',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .whiteColor),
                                                        )),
                                                    CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor:
                                                            AllColors
                                                                .mediumPurple,
                                                        child: Text(
                                                          'D',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .whiteColor),
                                                        )),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 0.3,
                                                )
                                              ],
                                            ),
                                          if (index == 10)
                                            Column(
                                              children: [
                                                IntrinsicHeight(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          color: Colors.white,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,

                                                            // mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AllColors
                                                                      .lighterPurple,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                child: Icon(
                                                                  Icons
                                                                      .shopping_bag_outlined,
                                                                  color: AllColors
                                                                      .mediumPurple,
                                                                  size: 24,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 12),
                                                              const Text(
                                                                "110",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 4),
                                                              const Text(
                                                                "Orders",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFF6B7280),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 1,
                                                        color: Colors.black12,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          color: Colors.white,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AllColors
                                                                      .lighterPurple,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                child: Icon(
                                                                  Icons
                                                                      .medical_services_outlined,
                                                                  color: AllColors
                                                                      .mediumPurple,
                                                                  size: 24,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 12),
                                                              const Text(
                                                                "20000",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 4),
                                                              const Text(
                                                                "Incentive",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFF6B7280),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 1,
                                                  color: Colors.black12,
                                                ),
                                                IntrinsicHeight(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          color: Colors.white,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AllColors
                                                                      .lighterPurple,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                child: Icon(
                                                                  Icons
                                                                      .hexagon_outlined,
                                                                  color: AllColors
                                                                      .mediumPurple,
                                                                  size: 24,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 12),
                                                              const Text(
                                                                "20.06 Cr",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 4),
                                                              const Text(
                                                                "Sales",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFF6B7280),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 1,
                                                        color: Colors.black12,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          color: Colors.white,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AllColors
                                                                      .lighterPurple,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                child: Icon(
                                                                  Icons
                                                                      .bar_chart,
                                                                  color: AllColors
                                                                      .mediumPurple,
                                                                  size: 24,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 12),
                                                              const Text(
                                                                "3.67 L",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 4),
                                                              const Text(
                                                                "Revenue",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFF6B7280),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (index == 11)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Text(
                                                          '.......',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      '₹10 By',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AllColors
                                                              .greenJungle),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: AllColors
                                                            .background_green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Online',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .text__green,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '16 October 2024 at 9:23 pm',
                                                      style: TextStyle(
                                                          color: AllColors
                                                              .greyBlack,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    const Spacer(),
                                                  ],
                                                ),
                                                Text(
                                                  'paid by: Webhopers Infotech Private Limited',
                                                  style: TextStyle(
                                                      color:
                                                          AllColors.greyBlack,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                const Divider(
                                                  thickness: 0.3,
                                                ),
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      '.......',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      '₹10 By',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AllColors
                                                              .greenJungle),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: AllColors
                                                            .background_green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Online',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .text__green,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                                Text(
                                                  '16 October 2024 at 9:23 pm',
                                                  style: TextStyle(
                                                      color:
                                                          AllColors.greyBlack,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  'paid by: Webhopers Infotech Private Limited',
                                                  style: TextStyle(
                                                      color:
                                                          AllColors.greyBlack,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                const Divider(
                                                  thickness: 0.3,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      '.......',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      '₹10 By',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AllColors
                                                              .greenJungle),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: AllColors
                                                            .background_green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Online',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .text__green,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                                Text(
                                                  '16 October 2024 at 9:23 pm',
                                                  style: TextStyle(
                                                      color:
                                                          AllColors.greyBlack,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  'paid by: Webhopers Infotech Private Limited',
                                                  style: TextStyle(
                                                      color:
                                                          AllColors.greyBlack,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                const Divider(
                                                  thickness: 0.3,
                                                ),
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      '.......',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      '₹10 By',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AllColors
                                                              .greenJungle),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: AllColors
                                                            .lightYellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Cash',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .darkYellow,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                                Text(
                                                  '16 October 2024 at 9:23 pm',
                                                  style: TextStyle(
                                                      color:
                                                          AllColors.greyBlack,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  'paid by: Webhopers Infotech Private Limited',
                                                  style: TextStyle(
                                                      color:
                                                          AllColors.greyBlack,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                const Divider(
                                                  thickness: 0.3,
                                                ),
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      '.......',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      '₹10 By',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AllColors
                                                              .greenJungle),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: AllColors
                                                            .lightYellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Cash',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .darkYellow,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                                Text(
                                                  '16 October 2024 at 9:23 pm',
                                                  style: TextStyle(
                                                      color:
                                                          AllColors.greyBlack,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  'paid by: Webhopers Infotech Private Limited',
                                                  style: TextStyle(
                                                      color:
                                                          AllColors.greyBlack,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                const Divider(
                                                  thickness: 0.3,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          if (index == 12)
                                            Column(
                                              children: [
                                                // Row(
                                                //   children: [
                                                //     Expanded(child: CreateNewLeadScreenCard2(hintText: '2025-01-30',isDateField: true,)),
                                                //     Spacer()
                                                //   ],
                                                // ),
                                                // SizedBox(height: 10,),
                                                Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          SizedBox(
                                                            width: 200,
                                                            height: 200,
                                                            child: CustomPaint(
                                                              painter:
                                                                  _CircleProgressPainter(
                                                                progress: 0.07,
                                                                progressColor:
                                                                    Colors
                                                                        .orange
                                                                        .shade200,
                                                                backgroundColor:
                                                                    Colors.grey
                                                                        .shade200,
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                'PROGRESS',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 4),
                                                              Text(
                                                                '7.00%',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      800],
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                            '00',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            ' : ',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const Text(
                                                            '00',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            ' : ',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const Text(
                                                            '56',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const Text(
                                                            ' / 8 Hrs',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ])),
                                  ],
                                ),
                              );
                            },
                          )),
                      ],
                    );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadItem(String count, String source, Color color,
      EdgeInsets margin, String name) {
    return Expanded(
      child: Container(
        margin: margin,
        child: Stack(
          children: [
            ContainerUtils(
              paddingBottom: 8,
              paddingTop: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        count,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontFamily.sfPro,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.sfPro,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    source,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 7,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SourceData {
  final String source;
  final int count;
  final Color color;

  SourceData({required this.source, required this.count, required this.color});
}

class StatusCard extends StatelessWidget {
  final String number;
  final String label;
  final Color color;
  final bool showBorder;

  const StatusCard({
    super.key,
    required this.number,
    required this.label,
    required this.color,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
          border: showBorder
              ? Border(
                  bottom: BorderSide(
                    color: color,
                    width: 2,
                  ),
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;

  _CircleProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 15;
    const strokeWidth = 30.0;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircleProgressPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
