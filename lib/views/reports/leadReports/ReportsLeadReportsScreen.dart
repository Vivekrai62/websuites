import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/views/HRM/leave/plan/add/HrmPlanAdd.dart';
import '../../../utils/button/section_divider/SectionDivider.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../viewModels/leadScreens/leadMasters/types/lead_master_types_viewModel.dart';
import '../../../viewModels/reports/lead_report/activity/ReportActivityViewModel.dart';
import '../../../viewModels/reports/lead_report/team_leads/ReportTeamLeadViewModel.dart';
import '../../../viewModels/reports/lead_report/uniqueMetting/ReportUniqueMetingViewModel.dart';

class HrmLeaveController extends GetxController {
  final RxBool showAdditionalFields =
      false.obs; // Observable for additional fields
  final RxBool isChecked =
      false.obs; // Observable for "Is Employee view description"
  final RxBool isCheckeds = false.obs; // Observable for "Classif
  final TextEditingController leaveNameController = TextEditingController();
  final TextEditingController shortCodeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController isEmployeeView = TextEditingController();
  final TextEditingController isSickMedical = TextEditingController();

  final ReportLeadActivityViewModel reportLeadActivity =
      Get.put(ReportLeadActivityViewModel()); ////   1st screen
  final ReportUniqueMetingViewModel reportLeadUnique =
      Get.put(ReportUniqueMetingViewModel()); ////    2nd screen
  final ReportTeamLeadViewModel reportTeamLead =
      Get.put(ReportTeamLeadViewModel()); //// 3rd screen
  final LeadMasterTypesViewModel hotColdTeamLead =
      Get.put(LeadMasterTypesViewModel());

  final RxInt selectedButtonIndex = 0.obs;

  String? selectedLeaveType; // Add this line

  void onButtonPressed(int index) {
    selectedButtonIndex.value = index;
  }

  Future<void> fetchActivityData(BuildContext context) async {
    await reportLeadActivity.leadActivityList(context);
  }

  Future<void> fetchUniqueData(BuildContext context) async {
    await reportLeadUnique.leadUniqueMeetingList(context);
  }

  Future<void> fetchTeamLeadData(BuildContext context) async {
    await reportTeamLead.leadTeamLead(context);
  }

  Future<void> fetchHotColdLeadData(BuildContext context) async {
    await hotColdTeamLead.leadMasterType(context);
  }

  @override
  void onInit() {
    super.onInit();
    fetchActivityData(
        Get.context!); // Fetch data when controller is initialized
    fetchUniqueData(Get.context!); // Fetch data when controller is initialized
    fetchTeamLeadData(
        Get.context!); // Fetch data when controller is initialized
    fetchHotColdLeadData(
        Get.context!); // Fetch data when controller is initialized
  }
}

class ReportsLeadReportsScreen extends GetView<HrmLeaveController> {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const ReportsLeadReportsScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    Get.put(HrmLeaveController());

    return Scaffold(
      backgroundColor: DarkMode.backgroundColor(context),
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
                        scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  Text(
                    'Lead Report',
                    style: TextStyle(
                      color: DarkMode.backgroundColor2(context),
                      fontWeight: FontWeight.w700,
                      fontSize: 17.5,
                    ),
                  ),
                  const Spacer(),
                  // Commented button section
                  Obx(() => CommonButton(
                        color: AllColors.practiceColor,
                        borderRadius: 30,
                        width: 80,
                        height: 25,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        icon: Icon(
                          Icons.add,
                          color: AllColors.whiteColor,
                          size: 15,
                        ),
                        iconSpacing: true,
                        title: controller.selectedButtonIndex.value == 0
                            ? 'Type'
                            : controller.selectedButtonIndex.value == 1
                                ? 'Plan'
                                : 'Lead',
                        onPress: () {
                          if (controller.selectedButtonIndex.value == 0) {
                            // _showBottomSheet1(context); // Show bottom sheet for Leave Type
                          } else if (controller.selectedButtonIndex.value ==
                              1) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.white,
                                  child:
                                      HrmPlanDiliouge(), // Your custom dialog widget
                                );
                              },
                            );
                          } else {
                            // Handle index 2 (Lead+) - Add your logic here if needed
                            print(
                                "Lead+ clicked - Add your functionality here");
                          }
                        },
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                CustomToggleButtonGroup(
                  initialSelectedIndex: controller.selectedButtonIndex.value,
                  onIndexChanged: (index) {
                    controller.selectedButtonIndex.value = index;
                  },
                  options: [
                    ToggleButtonUtils.createIconTextOption(
                      width: 110,
                      // icon: Icons.view_list,
                      selectedTextColor: AllColors.whiteColor,
                      text: 'Activities',
                      selectedColor: AllColors.practiceColor,
                    ),
                    ToggleButtonUtils.createIconTextOption(
                      // icon: Icons.bar_chart,
                      selectedTextColor: AllColors.whiteColor,
                      text: 'Unique Meeting',
                      selectedColor: AllColors.practiceColor,
                    ),
                    ToggleButtonUtils.createIconTextOption(
                      // icon: Icons.bar_chart,
                      selectedTextColor: AllColors.whiteColor,
                      text: 'Team Leads',
                      selectedColor: AllColors.practiceColor,
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Obx(() {
      switch (controller.selectedButtonIndex.value) {
        case 0: // Activities tab
          if (controller.reportLeadActivity.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.reportLeadActivity.activityDataList.isEmpty) {
            return const Center(child: Text("No data available"));
          }
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.reportLeadActivity.activityDataList.length,
            itemBuilder: (context, index) {
              final activity =
                  controller.reportLeadActivity.activityDataList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ContainerUtils(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Activity Message",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.sfPro,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        activity.message ?? "No message available",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AllColors.figmaGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

        case 1:
          if (controller.reportLeadUnique.uniqueDataList.isEmpty) {
            return const Center(child: Text("No Leave Plans Available"));
          }
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.reportLeadUnique.uniqueDataList.length,
            itemBuilder: (context, index) {
              final activity =
                  controller.reportLeadActivity.activityDataList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ContainerUtils(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Activity Message",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.sfPro,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        activity.message ?? "No message available",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AllColors.figmaGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

        case 2: // Team Leads tab
          if (controller.reportTeamLead.loading.value ||
              controller.hotColdTeamLead.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.reportTeamLead.teamLeadDataList.isEmpty) {
            return const Center(child: Text("No team leads available"));
          }
          if (controller.hotColdTeamLead.hotColdDataList.isEmpty) {
            return const Center(child: Text("No lead types available"));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              if (controller.reportTeamLead.teamLeadDataList.isEmpty) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: const Center(
                      child: Text("No data available"),
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
                  (screenWidth - (crossAxisCount - 1) * 16) / crossAxisCount;
              const double itemHeight = 289;
              final double childAspectRatio = itemWidth / itemHeight;

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                            top: 16,
                            bottom: 40,
                            left: 16,
                            right: 16,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemCount:
                              controller.reportTeamLead.teamLeadDataList.length,
                          itemBuilder: (context, index) {
                            final teamLead = controller
                                .reportTeamLead.teamLeadDataList[index];

                            // Create a map of lead types from reportTeamLead for quick lookup
                            final leadTypeMap = {
                              for (var lead in teamLead.leadType)
                                lead.name?.toLowerCase(): lead.leadCount ?? 0
                            };

                            // Get all lead types from hotColdTeamLead and map their counts
                            final allLeadTypes = controller
                                .hotColdTeamLead.hotColdDataList
                                .map((masterLead) {
                              final name = masterLead.name ?? 'N/A';
                              final count =
                                  leadTypeMap[name.toLowerCase()] ?? 0;
                              return {'name': name, 'count': count};
                            }).toList();

                            return GestureDetector(
                              onTap: () {},
                              child: ContainerUtils(
                                paddingBottom: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Display User Name
                                    Text(
                                      "${teamLead.user?.firstName ?? ''} ${teamLead.user?.lastName ?? ''}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17.5,
                                        fontFamily: 'SFPro',
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Divider(thickness: 0.4),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Total Leads",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              fontFamily: 'SFPro',
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: AllColors.practiceColor
                                                  .withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              (teamLead.total ?? 0).toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: AllColors.practiceColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Display All Lead Types and Counts in a Column of Rows
                                    for (int i = 0;
                                        i < allLeadTypes.length;
                                        i += 2)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // First lead type
                                            if (i < allLeadTypes.length)
                                              _buildLeadTypeRow(
                                                allLeadTypes[i]['name']
                                                        as String? ??
                                                    'N/A',
                                                allLeadTypes[i]['count'] as int,
                                              ),
                                            // Second lead type (if exists)
                                            if (i + 1 < allLeadTypes.length)
                                              _buildLeadTypeRow(
                                                allLeadTypes[i + 1]['name']
                                                        as String? ??
                                                    'N/A',
                                                allLeadTypes[i + 1]['count']
                                                    as int,
                                              ),
                                            // Spacer if only one item in the row
                                            if (i + 1 >= allLeadTypes.length)
                                              const Spacer(),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        if (controller.reportTeamLead.loading.value)
                          const Positioned.fill(
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );

        default:
          return const SizedBox.shrink();
      }
    });
  }

  Color _getStatusColor(String name) {
    switch (name.toLowerCase()) {
      case 'hot':
        return Colors.red;
      case 'cool':
        return Colors.green;
      case 'dead':
        return Colors.grey;
      case 'follow-up':
        return Colors.blue;
      case 'on-going':
        return Colors.purple;
      case 'mature':
        return Colors.orange;
      case 'cold':
        return Colors.teal;
      default:
        return AllColors.practiceColor; // Default color
    }
  }

  Widget _buildLeadTypeRow(String name, int count) {
    return Row(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: FontFamily.sfPro,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: _getStatusColor(name).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: _getStatusColor(name),
            ),
          ),
        ),
      ],
    );
  }
}
