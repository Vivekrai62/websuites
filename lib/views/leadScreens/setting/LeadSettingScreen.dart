import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/resources/iconStrings/icon_strings.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/components/widgets/appBar/custom_appBar.dart';
import 'package:websuites/utils/components/widgets/navBar/custom_navBar.dart';
import 'package:websuites/utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:flutter/cupertino.dart';
import 'package:websuites/views/leadScreens/setting/lead_source/lead_source_screen.dart';
import 'package:websuites/views/leadScreens/setting/type/lead_type_screen.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../viewModels/leadScreens/createNewLead/constant_controller/constant_controller.dart';
import '../../../viewModels/leadScreens/setting/dead_reason/lead_dead_reason_view_model.dart';
import '../../../viewModels/leadScreens/setting/lead_source/lead_source_view_model.dart';
import '../../../viewModels/leadScreens/trashLeads/leadTypes/lead_type_viewModel.dart';
import 'column/lead_setting_columns.dart';
import 'dead_reasons/lead_dead_reasons_screen.dart';
import 'field/lead_setting_field_screen.dart';
import '../../../../viewModels/leadScreens/setting/field_setting/field_setting.dart';

// Create a GetX controller to manage the state
class LeadSettingController extends GetxController {
  final searchController = TextEditingController();
  final isFloatingButtonClicked = false.obs;
  final activeTab = 'Columns'.obs;

  // Sample data for the fields
  final standardFields = <Map<String, dynamic>>[
    {
      'name': 'Address',
      'type': 'Text',
      'required': true,
      'icon': 'A',
      'color': Colors.orange[400],
    },
    {
      'name': 'Assignee',
      'type': 'Select',
      'required': false,
      'icon': 'C',
      'color': Colors.green[400],
    },
    {
      'name': 'Lead Source',
      'type': 'Select',
      'required': true,
      'icon': 'L',
      'color': Colors.blue[400],
    },
    {
      'name': 'Phone',
      'type': 'Text',
      'required': true,
      'icon': 'P',
      'color': Colors.purple[400],
    },
    {
      'name': 'Email',
      'type': 'Email',
      'required': true,
      'icon': 'E',
      'color': Colors.red[400],
    },
  ].obs;

  final customFields = <Map<String, dynamic>>[
    {
      'name': 'Custom Field 1',
      'type': 'Text',
      'required': false,
      'icon': 'CF',
      'color': Colors.teal[400],
    },
    {
      'name': 'Custom Field 2',
      'type': 'Number',
      'required': true,
      'icon': 'C2',
      'color': Colors.indigo[400],
    },
  ].obs;

  final fieldTypes = <Map<String, dynamic>>[
    {
      'name': 'Text',
      'description': 'Plain text input',
      'icon': 'T',
      'color': Colors.blue[300],
    },
    {
      'name': 'Select',
      'description': 'Dropdown selection',
      'icon': 'S',
      'color': Colors.green[300],
    },
    {
      'name': 'Email',
      'description': 'Email address input',
      'icon': 'E',
      'color': Colors.red[300],
    },
  ].obs;

  final sources = <Map<String, dynamic>>[
    {
      'name': 'Website',
      'code': 'WEB',
      'icon': 'W',
      'color': Colors.purple[300],
    },
    {
      'name': 'Referral',
      'code': 'REF',
      'icon': 'R',
      'color': Colors.orange[300],
    },
  ].obs;

  void setActiveTab(String tabName) {
    activeTab.value = tabName;
  }

  void toggleFloatingButton() {
    isFloatingButtonClicked.toggle();
  }

  bool get isTabWithoutFieldInfo =>
      activeTab.value == 'Types' ||
          activeTab.value == 'Source' ||
          activeTab.value == 'Dead Reasons';

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

class LeadSettingScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  LeadSettingScreen({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  // Initialize the controller
  final LeadSettingController controller = Get.put(LeadSettingController());
  final ConstantValueViewModel staticText = Get.put(ConstantValueViewModel());

  Widget buildFieldItem(Map<String, dynamic> field) {
    return Obx(() {
      bool isTabWithoutFieldInfo = controller.isTabWithoutFieldInfo;

      return Container(
        margin: const EdgeInsets.only(bottom: 1),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: field['color'] ?? Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  field['icon'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field['name'],
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  if (!isTabWithoutFieldInfo && (field['description'] != null || field['code'] != null))
                    Text(
                      field['description'] ?? field['code'] ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
            if (!isTabWithoutFieldInfo) ...[
              Row(
                children: [
                  if (field['type'] != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AllColors.textField2,
                      ),
                      child: Text(
                        field['type'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(width: 10),
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: Icon(
                      field['required'] ?? false
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: field['required'] ?? false
                          ? AllColors.mediumPurple
                          : Colors.grey[400],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 60,
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Image.asset(
                        ImageStrings.edit,
                        height: 17,
                        width: 16,
                        color: AllColors.figmaGrey,
                      ),
                      onPressed: () {
                        // Handle update action
                      },
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget buildTabButton(String tabName, IconData icon) {
    return Obx(() {
      return GestureDetector(
        onTap: () => controller.setActiveTab(tabName),
        child: Container(
          decoration: BoxDecoration(
            color: controller.activeTab.value == tabName
                ? AllColors.mediumPurple.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton.icon(
            onPressed: () => controller.setActiveTab(tabName),
            icon: Icon(
              icon,
              color: controller.activeTab.value == tabName
                  ? AllColors.mediumPurple
                  : AllColors.microGreyHeader,
            ),
            label: Text(
              tabName,
              style: TextStyle(
                color: controller.activeTab.value == tabName
                    ? AllColors.mediumPurple
                    : AllColors.microGreyHeader,
                fontSize: 14,
                fontWeight:
                controller.activeTab.value == tabName ? FontWeight.w600 : FontWeight.normal,
                fontFamily: FontFamily.sfPro,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildTabContent() {
    return Obx(() {
      switch (controller.activeTab.value) {
        case 'Columns':
          return LeadSettingColumnScreen();
        case 'Fields':
          return LeadSettingFieldScreen();
        case 'Types':
          return LeadSettingTypeScreen();
        case 'Source':
          return LeadSourceScreen();
        case 'Dead Reasons':
          return LeadDeadReasonsScreen();
        default:
          return const Center(
            child: Text(
              'Select a tab',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    final LeadFieldSettingViewModel fieldViewModel = Get.put(LeadFieldSettingViewModel());
    final LeadTypeViewModel typeViewModel = Get.put(LeadTypeViewModel());
    final LeadSourceListViewModel sourceViewModel = Get.put(LeadSourceListViewModel());
    final LeadDeadReasonViewModel deadViewModel = Get.put(LeadDeadReasonViewModel());

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () => controller.toggleFloatingButton(),
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: DarkMode.backgroundColor(context),
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
                        if (scaffoldKey.currentState != null &&
                            !scaffoldKey.currentState!.isDrawerOpen) {
                          scaffoldKey.currentState!.openDrawer();
                        }
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  Text(
                    'Settings',
                    style: TextStyle(
                      color:  DarkMode.backgroundColor2(context),
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 18.5,
                    ),
                  ),
                  const Spacer(),
                  Obx(() => TextButton.icon(
                    onPressed: () {
                      final tab = controller.activeTab.value;

                      if (tab == 'Columns') {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Save Changes'),
                            content: Text('Do you want to save the changes you made to the columns?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                              TextButton(
                                  onPressed: () {
                                    // Save action
                                    Navigator.pop(context);
                                  },
                                  child: Text('Save')),
                            ],
                          ),
                        );
                      } else if (tab == 'Fields') {

                        LeadSettingFieldScreen.showCreateFieldDialog(context, fieldViewModel);
                      } else if (tab == 'Types') {

                        LeadSettingTypeScreen.showCreateTypeDialog(context, typeViewModel);
                      } else if (tab == 'Source') {
                        LeadSourceScreen.showCreateSourceDialog(context, sourceViewModel);
                      } else {
                        LeadDeadReasonsScreen.showCreateDeadDialog(context, deadViewModel);
                      }
                    },
                    icon: Icon(
                      controller.activeTab.value == 'Columns' ? Icons.save : Icons.add,
                      color: controller.activeTab.value == 'Columns'
                          ? AllColors.greenJungle
                          : AllColors.whiteColor,
                      size: 16,
                    ),
                    label: Text(
                      controller.activeTab.value == 'Columns'
                          ? 'Save Changes'
                          : controller.activeTab.value == 'Fields'
                          ? 'New Custom Field'
                          : controller.activeTab.value == 'Types'
                          ? 'Add Lead Type'
                          : controller.activeTab.value == 'Source'
                          ? 'Add Lead Source'
                          : 'Dead Reasons',
                      style: TextStyle(
                        color: controller.activeTab.value == 'Columns'
                            ? AllColors.greenJungle
                            : AllColors.whiteColor,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        controller.activeTab.value == 'Columns'
                            ? AllColors.whiteColor
                            : AllColors.mediumPurple,
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 11.0, vertical: 14),
                      ),
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      side: MaterialStateProperty.all(
                        controller.activeTab.value == 'Columns'
                            ? BorderSide(color: AllColors.greenJungle)
                            : BorderSide.none,
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Text(
                    'Lead Standard & Custom Fields',
                    style: TextStyle(
                      color:  DarkMode.backgroundColor(context),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          buildTabButton('Columns', Icons.edit_note),
                          const SizedBox(width: 7),
                          buildTabButton('Fields', Icons.edit_calendar),
                          const SizedBox(width: 7),
                          buildTabButton('Types', Icons.view_column),
                          const SizedBox(width: 7),
                          buildTabButton('Source', Icons.source),
                          const SizedBox(width: 7),
                          buildTabButton('Dead Reasons', Icons.source),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  if (!controller.isTabWithoutFieldInfo) {
                    return Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Divider(thickness: 0.9),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, right: 15, left: 65),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Columns',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Type',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  'Req.',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                width: 60,
                                alignment: Alignment.center,
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                Expanded(child: buildTabContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}