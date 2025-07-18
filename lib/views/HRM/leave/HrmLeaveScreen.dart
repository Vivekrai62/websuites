import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/views/HRM/leave/plan/add/HrmPlanAdd.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../Utils/utils.dart';
import '../../../data/models/requestModels/HRM/type/add/AddLeaveTypeRequestModel.dart';
import '../../../data/models/requestModels/HRM/type/update/UpdateLeaveTypeRequestModel.dart';
import '../../../data/models/responseModels/hrm/leave/type/hrm_leave_type_response_model.dart';
import '../../../utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/button/section_divider/SectionDivider.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../viewModels/hrmScreens/leave/plans/hrm_leave_plan_viewModel.dart';
import '../../../viewModels/hrmScreens/leave/type/add/AddLeaveTypeViewModel.dart';
import '../../../viewModels/hrmScreens/leave/type/hrm_leave_type_viewModel.dart';
import '../../../viewModels/hrmScreens/leave/type/update/UpdateLeaveTypeViewModel.dart';
import '../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class LeadReportsController extends GetxController {
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

  final AddLeaveTypeViewModel hrmLeaveTypeViewModel =
      Get.put(AddLeaveTypeViewModel());
  final UpdateLeaveTypeViewModel hrmLeaveUpdateTypeViewModel =
      Get.put(UpdateLeaveTypeViewModel());

  final RxInt selectedButtonIndex = 0.obs;

  final LeaveTypeViewModel leaveViewModel =
      Get.put(LeaveTypeViewModel()); // Bind the view model
  final LeavePlanViewModel leavePlanViewModel =
      Get.put(LeavePlanViewModel()); // Bind the view model

  String? selectedLeaveType; // Add this line

  void onButtonPressed(int index) {
    selectedButtonIndex.value = index;
  }

  Future<void> addLeaveType(
      BuildContext context, AddLeaveTypeRequestModel requestModel) async {
    await hrmLeaveTypeViewModel.addLeaveTypeApi(context, requestModel);

    if (hrmLeaveTypeViewModel.leaveAddType.isNotEmpty) {
      // Utils.snackbarSuccess('Leave type added successfully');
    } else {
      // Utils.snackbarFailed('Failed to add leave type');
    }
  } // Trigger leave data fetching

  Future<void> updateLeaveType(
      BuildContext context, UpdateLeaveTypeRequestModel requestModel) async {
    await hrmLeaveUpdateTypeViewModel.updateLeaveTypeApi(context, requestModel);

    // Log the response for debugging
    print(hrmLeaveUpdateTypeViewModel.leaveUpdateType);

    if (hrmLeaveUpdateTypeViewModel.leaveUpdateType.isNotEmpty) {
      Utils.snackbarSuccess('Leave type updated successfully');
    } else {
      Utils.snackbarFailed('Failed to update leave type');
    }
  }

  Future<void> fetchLeaveData(BuildContext context) async {
    await leaveViewModel.leaveApi(context);
  }

  Future<void> fetchLeavePlanData(BuildContext context) async {
    await leavePlanViewModel.leavePlanApi(context);
  }

  @override
  void onInit() {
    super.onInit();
    fetchLeaveData(Get.context!); // Fetch data when controller is initialized
    fetchLeavePlanData(
        Get.context!); // Fetch data when controller is initialized
  }
}

class HrmLeaveScreen extends GetView<LeadReportsController> {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const HrmLeaveScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    Get.put(LeadReportsController());

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
                    'Attendance',
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
                          : 'Plan',
                      onPress: () {
                        if (controller.selectedButtonIndex.value == 0) {
                          _showBottomSheet1(
                              context); // Show bottom sheet for Leave Type
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.white,
                                child:
                                    HrmPlanDiliouge(), // This is your custom bottom sheet widget
                              );
                            },
                          );
                        }
                      }))
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
                      text: 'Leave Type',
                      selectedColor: AllColors.practiceColor,
                    ),
                    ToggleButtonUtils.createIconTextOption(
                      // icon: Icons.bar_chart,
                      selectedTextColor: AllColors.whiteColor,
                      text: 'Leave Plan',
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
        case 0:
          if (controller.leaveViewModel.leaveDataList.isEmpty) {
            return const Center(child: Text("No data available"));
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              if (controller.leaveViewModel.leaveDataList.isEmpty) {
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
                  (screenWidth - (crossAxisCount - 1) * 16) / crossAxisCount;
              const double itemHeight = 143;
              final double childAspectRatio = itemWidth / itemHeight;

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // if (isFloatingButtonClicked)
                    //   Padding(
                    //     padding:
                    //         const EdgeInsets.only(top: 10, left: 15, right: 15),
                    //     child: TextField(
                    //       controller: searchController,
                    //       decoration: const InputDecoration(
                    //         hintText: 'Search sales targets...',
                    //         border: OutlineInputBorder(),
                    //       ),
                    //       onChanged: (value) {
                    //         // Add search logic here if needed
                    //       },
                    //     ),
                    //   ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemCount: controller.leaveViewModel.leaveDataList.length,
                      itemBuilder: (context, index) {
                        // final item = controller.leaveViewModel.leaveDataList[index];
                        return GestureDetector(
                          onTap: () {
                            // if (widget.onOrderSelected != null) {
                            //   widget.onOrderSelected!(item);
                            // } else {
                            //   Get.to(() => const Salesdetailsscreen());
                            // }
                          },
                          child: ContainerUtils(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.leaveViewModel.leaveDataList[index]
                                          .name ??
                                      'Leave Type',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: FontFamily.sfPro,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text(
                                      'Is Paid : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      controller
                                              .leaveViewModel
                                              .leaveDataList[index]
                                              .paidOption ??
                                          'Unknown',
                                      style: TextStyle(
                                          color: AllColors.figmaGrey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'Code : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      controller.leaveViewModel
                                              .leaveDataList[index].shortCode ??
                                          'N/A',
                                      style: TextStyle(
                                          color: AllColors.figmaGrey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 0.4),
                                Row(
                                  children: [
                                    const Text(
                                      'Type : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      controller.leaveViewModel
                                              .leaveDataList[index].type ??
                                          'N/A',
                                      style: TextStyle(
                                          color: AllColors.figmaGrey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        _showBottomSheet2(
                                            context,
                                            controller.leaveViewModel
                                                .leaveDataList[index]);
                                      },
                                      child: Image.asset(
                                        'assets/icons/edit.png',
                                        height: 18,
                                        width: 18,
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
          );

        case 1:
          if (controller.leavePlanViewModel.leaveTypeList.isEmpty) {
            return const Center(child: Text("No Leave Plans Available"));
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              if (controller.leavePlanViewModel.leaveTypeList.isEmpty) {
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
                  (screenWidth - (crossAxisCount - 1) * 16) / crossAxisCount;
              const double itemHeight = 155;
              final double childAspectRatio = itemWidth / itemHeight;

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // if (isFloatingButtonClicked)
                    //   Padding(
                    //     padding:
                    //         const EdgeInsets.only(top: 10, left: 15, right: 15),
                    //     child: TextField(
                    //       controller: searchController,
                    //       decoration: const InputDecoration(
                    //         hintText: 'Search sales targets...',
                    //         border: OutlineInputBorder(),
                    //       ),
                    //       onChanged: (value) {
                    //         // Add search logic here if needed
                    //       },
                    //     ),
                    //   ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemCount:
                          controller.leavePlanViewModel.leaveTypeList.length,
                      itemBuilder: (context, index) {
                        final leavePlan =
                            controller.leavePlanViewModel.leaveTypeList[index];
                        return GestureDetector(
                          onTap: () {
                            // if (widget.onOrderSelected != null) {
                            //   widget.onOrderSelected!(item);
                            // } else {
                            //   Get.to(() => const Salesdetailsscreen());
                            // }
                          },
                          child: ContainerUtils(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        leavePlan.name ?? 'Leave Plan',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamily.sfPro,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImageStrings.date,
                                            width: 13,
                                            height: 13,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            formatDateWithTime(leavePlan
                                                    .createdAt
                                                    .toString() ??
                                                'N/A'),
                                            style: TextStyle(
                                                color: AllColors.mediumPurple,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text(
                                      'Start Date : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      formatDateWithDay(
                                        leavePlan.startDate.toString() ?? 'N/A',
                                      ),
                                      style: TextStyle(
                                          color: AllColors.figmaGrey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    const Spacer(),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: Get.width * 0.4),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AllColors.background_green,
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        child: Text(
                                          leavePlan.status != null &&
                                                  leavePlan.status == true
                                              ? 'Active'
                                              : 'Inactive',
                                          style: TextStyle(
                                            color: AllColors.text__green,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 0.4),
                                const SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Description: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: FontFamily.sfPro,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        leavePlan.description ??
                                            'No description',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: FontFamily.sfPro,
                                          color: AllColors.figmaGrey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        // Show ellipsis when the text overflows
                                        maxLines:
                                            1, // Ensure only one line of text
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // Adds spacing between icons
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.settings,
                                        color: AllColors.figmaGrey,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {},
                                      child: Image.asset(
                                        'assets/icons/edit.png',
                                        height: 17,
                                        width: 17,
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
          );

        default:
          return const SizedBox.shrink();
      }
    });
  }

  void _showBottomSheet1(BuildContext context) {
    final TextEditingController leaveTypeController = TextEditingController();
    final TextEditingController leaveNameController = TextEditingController();
    final TextEditingController shortCodeController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController genderController = TextEditingController();
    final TextEditingController marriageController = TextEditingController();
    final TextEditingController reasonController = TextEditingController();

    final LeadReportsController controller =
        Get.find<LeadReportsController>(); // Get the controller instance

    // Sample categories for leave types
    List<String> categories = controller.leaveViewModel.leaveDataList
        .map((leave) => leave.type ?? 'Unknown')
        .toSet()
        .toList();

    String noRegularLeaveMessage = 'No Regular Leave Available';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      // Make it scrollable
      isDismissible: true,
      // Allows dismissing by tapping outside

      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          height: MediaQuery.of(context).size.height *
              0.75, // Set height to 75% of screen height
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Add Leave Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AllColors.blackColor,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Leave Type Field
                const Text('Select Leave Type *'),
                const SizedBox(height: 5),
                CreateNewLeadScreenCard2(
                  hintText: 'Select',
                  controller: leaveTypeController,
                  categories: categories.isNotEmpty
                      ? categories
                      : [noRegularLeaveMessage],
                  onCategoryChanged: (String selectedCategory) {
                    controller.selectedLeaveType =
                        selectedCategory; // Update the selected value
                  },
                ),
                const SizedBox(height: 8),
                // Leave Name Field
                const Text('Leave Name *'),
                const SizedBox(height: 5),
                CommonTextField(
                  controller: leaveNameController,
                  hintText: 'Jury Duty, Privileged leave etc.',
                ),
                const SizedBox(height: 8),
                // Short Code Field
                const Text('Short Code'),
                const SizedBox(height: 5),
                CommonTextField(
                  controller: shortCodeController,
                  hintText: 'EX: PTO',
                ),
                const SizedBox(height: 8),
                // Description Field
                const Text('Description *'),
                const SizedBox(height: 5),
                CommonTextField(
                  controller: descriptionController,
                  hintText: '',
                ),
                const SizedBox(height: 8),

                Obx(() => Row(
                      children: [
                        Checkbox(
                          checkColor: AllColors.whiteColor,
                          activeColor: AllColors.mediumPurple,
                          value: controller.isChecked.value,
                          onChanged: (bool? value) {
                            controller.isChecked.value = value ?? false;
                          },
                        ),
                        const Text('Is Employee view description'),
                      ],
                    )),
                Obx(() => Row(
                      children: [
                        Checkbox(
                          checkColor: AllColors.whiteColor,
                          activeColor: AllColors.mediumPurple,
                          value: controller.isCheckeds.value,
                          onChanged: (bool? value) {
                            controller.isCheckeds.value = value ?? false;
                          },
                        ),
                        const Text('Classify as Sick/Medical'),
                      ],
                    )),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    controller.showAdditionalFields.value = !controller
                        .showAdditionalFields.value; // Toggle visibility
                  },
                  child: Row(
                    children: [
                      Icon(
                        controller.showAdditionalFields.value
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'More Options',
                        style: TextStyle(
                          fontFamily: FontFamily.sfPro,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Conditionally show additional fields
                Obx(() {
                  if (controller.showAdditionalFields.value) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Limit to Gender Field
                        const Text('Limit to Gender'),
                        const SizedBox(height: 5),
                        CreateNewLeadScreenCard2(
                          controller: genderController,
                          hintText: 'Select...',
                          categories: const [
                            'Male',
                            'Female',
                            'Transgender',
                            'Non Binary',
                            'Prefer Not To Respond'
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Limit marital status Field
                        const Text('Limit marital status'),
                        const SizedBox(height: 5),
                        CreateNewLeadScreenCard2(
                          hintText: 'Select...',
                          controller: marriageController,
                          categories: const [
                            'Single',
                            'Married',
                            'Widowed',
                            'Separated'
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Reasons Field
                        const Text('Reasons'),
                        const SizedBox(height: 5),
                        CommonTextField(
                          controller: reasonController,
                          hintText: 'Select...',
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }
                  return const SizedBox
                      .shrink(); // Return an empty widget if not showing additional fields
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      width: 80,
                      height: 30,
                      borderRadius: 25,
                      onPressed: () async {
                        // Create the request model
                        AddLeaveTypeRequestModel requestModel =
                            AddLeaveTypeRequestModel(
                          type: controller.selectedLeaveType,
                          name: leaveNameController.text,
                          shortCode: shortCodeController.text.isNotEmpty
                              ? shortCodeController.text
                              : '',
                          description: descriptionController.text,
                          isEmployeeView: controller.isChecked.value,
                          isSickMedical: controller.isCheckeds.value,
                        );

                        await controller.addLeaveType(context, requestModel);

                        // Close the bottom sheet after the API call
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.sfPro),
                      ),
                    ),
                    CustomButton(
                      backgroundColor: AllColors.textField,
                      width: 80,
                      height: 30,
                      borderRadius: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.sfPro,
                            color: AllColors.blackColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet2(
      BuildContext context, HrmLeaveTypeResponseModel leave) {
    final TextEditingController leaveTypeController = TextEditingController();
    final TextEditingController leaveNameController = TextEditingController();
    final TextEditingController shortCodeController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController genderController = TextEditingController();
    final TextEditingController marriageController = TextEditingController();
    final TextEditingController reasonController = TextEditingController();
    final LeadReportsController controller =
        Get.find<LeadReportsController>(); // Get the controller instance

    leaveTypeController.text = leave.type ?? '';
    leaveNameController.text = leave.name ?? '';
    shortCodeController.text = leave.shortCode ?? '';
    descriptionController.text = leave.description ?? '';
    controller.selectedLeaveType = leave.type;

    List<String> leaveTypes = controller.leaveViewModel.leaveDataList
        .map((leave) => leave.type ?? '')
        .toList();

    String noRegularLeaveMessage = 'No Regular Leave Available';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      // Allows the bottom sheet to be scrollable
      isDismissible: true,
      // Allows dismissing the bottom sheet
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          height: MediaQuery.of(context).size.height *
              0.75, // Set height to 75% of screen height
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Update Leave Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AllColors.blackColor,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Leave Type Field
                const Text('Select Leave Type *'),
                const SizedBox(height: 5),

                CreateNewLeadScreenCard2(
                  hintText:
                      controller.selectedLeaveType ?? leave.type ?? 'Select',
                  controller: leaveTypeController,
                  categories: leaveTypes.isNotEmpty
                      ? leaveTypes
                      : [noRegularLeaveMessage],
                  onCategoryChanged: (String selectedCategory) {
                    controller.selectedLeaveType = selectedCategory;
                  },
                ),

                const SizedBox(height: 8),
                // Leave Name Field
                const Text('Leave Name *'),
                const SizedBox(height: 5),
                CreateNewLeadScreenCard2(
                  controller: leaveNameController,
                  hintText: leave.name ?? '',
                ),
                const SizedBox(height: 8),
                // Short Code Field
                const Text('Short Code'),
                const SizedBox(height: 5),
                CommonTextField(
                  controller: shortCodeController,
                  hintText: leave.shortCode ?? '',
                ),
                const SizedBox(height: 8),
                // Description Field
                const Text('Description *'),
                const SizedBox(height: 5),

                CreateNewLeadScreenCard2(
                  controller: descriptionController,
                  hintText: '',
                ),

                const SizedBox(height: 8),

                Obx(() => Row(
                      children: [
                        Checkbox(
                          checkColor: AllColors.whiteColor,
                          activeColor: AllColors.mediumPurple,
                          value: controller.isChecked.value,
                          onChanged: (bool? value) {
                            controller.isChecked.value = value ?? false;
                          },
                        ),
                        const Text('Is Employee view description'),
                      ],
                    )),
                Obx(() => Row(
                      children: [
                        Checkbox(
                          checkColor: AllColors.whiteColor,
                          activeColor: AllColors.mediumPurple,
                          value: controller.isCheckeds.value,
                          onChanged: (bool? value) {
                            controller.isCheckeds.value = value ?? false;
                          },
                        ),
                        const Text('Classify as Sick/Medical'),
                      ],
                    )),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    controller.showAdditionalFields.value =
                        !controller.showAdditionalFields.value;
                  },
                  child: Row(
                    children: [
                      Icon(
                        controller.showAdditionalFields.value
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'More Options',
                        style: TextStyle(
                          fontFamily: FontFamily.sfPro,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Conditionally show additional fields
                Obx(() {
                  if (controller.showAdditionalFields.value) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Limit to Gender Field
                        const Text('Limit to Gender'),
                        const SizedBox(height: 5),
                        CreateNewLeadScreenCard2(
                          controller: genderController,
                          hintText: 'Select...',
                          categories: const [
                            'Male',
                            'Female',
                            'Transgender',
                            'Non Binary',
                            'Prefer Not To Respond'
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Limit marital status Field
                        const Text('Limit marital status'),
                        const SizedBox(height: 5),
                        CreateNewLeadScreenCard2(
                          hintText: 'Select...',
                          controller: marriageController,
                          categories: const [
                            'Single',
                            'Married',
                            'Widowed',
                            'Separated'
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Reasons Field
                        const Text('Reasons'),
                        const SizedBox(height: 5),
                        CommonTextField(
                          controller: reasonController,
                          hintText: 'Select...',
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }
                  return const SizedBox
                      .shrink(); // Return an empty widget if not showing additional fields
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      width: 80,
                      height: 30,
                      borderRadius: 25,
                      onPressed: () async {
                        // Create the request model
                        UpdateLeaveTypeRequestModel requestModel =
                            UpdateLeaveTypeRequestModel(
                          id: leave.id,
                          // Ensure you pass the ID
                          type: controller.selectedLeaveType ?? '',
                          name: leaveNameController.text.isNotEmpty
                              ? leaveNameController.text
                              : '',
                          shortCode: shortCodeController.text.isNotEmpty
                              ? shortCodeController.text
                              : '',
                          description: descriptionController.text.isNotEmpty
                              ? descriptionController.text
                              : '',
                          isEmployeeView:
                              controller.isChecked.value ? 'true' : 'false',
                          isSickMedical:
                              controller.isCheckeds.value ? 'true' : 'false',
                        );
                        await controller.updateLeaveType(context, requestModel);
                        await controller.fetchLeaveData(
                            context); // Refresh the data after update

                        // Close the bottom sheet after the API call
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.sfPro),
                      ),
                    ),
                    CustomButton(
                      backgroundColor: AllColors.textField,
                      width: 80,
                      height: 30,
                      borderRadius: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.sfPro,
                            color: AllColors.blackColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
