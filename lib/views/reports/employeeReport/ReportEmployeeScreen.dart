import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/imageStrings/image_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/section_divider/SectionDivider.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/container_Utils/ContainerUtils.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../../../data/models/responseModels/reports/employeeReport/ReportEmployeeResModel.dart';
import '../../../viewModels/reports/employeeReport/ReportEmployeeViewModel.dart';

class ReportEmployeeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const ReportEmployeeScreen({super.key, required this.scaffoldKey});

  @override
  _ReportEmployeeScreenState createState() => _ReportEmployeeScreenState();
}

class _ReportEmployeeScreenState extends State<ReportEmployeeScreen> {
  late ReportEmployeeViewModel viewModel;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    viewModel = Get.put(ReportEmployeeViewModel());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchEmployeeReports(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;
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
                        if (widget.scaffoldKey.currentState?.isDrawerOpen ==
                            false) {
                          widget.scaffoldKey.currentState?.openDrawer();
                        }
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  Text(
                    'Employee Report',
                    style: TextStyle(
                      color: DarkMode.backgroundColor2(context),
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 18.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildMainContent(), // here my main working screen
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Expanded(
      child: Obx(() {
        if (viewModel.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildToggleButtons(),
              Expanded(child: _buildContent()),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildToggleButtons() {
    return CustomToggleButtonGroup(
      initialSelectedIndex: _selectedIndex,
      height: 40,
      borderRadius: 24,
      onIndexChanged: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      options: [
        ToggleButtonUtils.createIconTextOption(
          text: 'Activities',
          selectedColor: AllColors.practiceColor,
          unselectedColor: Colors.transparent,
          selectedTextColor: AllColors.whiteColor,
          unselectedTextColor: AllColors.blackColor,
          width: 120,
          height: 40,
        ),
        ToggleButtonUtils.createIconTextOption(
          text: 'Daily Sales Report',
          selectedColor: AllColors.practiceColor,
          unselectedColor: Colors.transparent,
          selectedTextColor: AllColors.whiteColor,
          unselectedTextColor: AllColors.blackColor,
          width: 160,
          height: 40,
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (viewModel.employeeDataList.isEmpty) {
      return Center(
        child: Text(
          'No data available',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AllColors.figmaGrey,
            fontFamily: FontFamily.sfPro,
          ),
        ),
      );
    }

    return _selectedIndex == 1 ? _buildActivitiesTab() : _buildDailySalesTab();
  }

  Widget _buildActivitiesTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15).copyWith(bottom: 35),
        child: Column(
          children: [
            _buildCallsSection(),
            const SizedBox(height: 20),
            _buildMeetingsSection(),
            const SizedBox(height: 20),
            _buildVisitOnlySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCallsSection() {
    final callSummary = viewModel.employeeDataList.first.summary?.calls;
    final callDetails = callSummary?.callDetails ?? {};

    return ContainerUtils(
      paddingBottom: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Total Calls', Icons.call_outlined,
              callSummary?.total.toString() ?? '0', "Total Call Engagement"),
          const SizedBox(height: 10),
          const Divider(thickness: 0.4),
          const SizedBox(height: 10),
          const Text(
            "Call Status Breakdown",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.5,
              fontFamily: FontFamily.sfPro,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                _buildStatusRow(
                  [
                    _buildStatusCard(
                      ImageStrings.call,
                      "Answered",
                      callDetails['Answered'] ?? 0,
                      AllColors.background_green,
                      AllColors.text__green,
                    ),
                    _buildStatusCard(
                      ImageStrings.call,
                      "No Answered",
                      callDetails['Not Answered'] ?? 0,
                      AllColors.thinOrange,
                      AllColors.darkOrange,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildStatusRow(
                  [
                    _buildStatusCard(
                      ImageStrings.call,
                      "Wrong Number",
                      callDetails['Wrong Number'] ?? 0,
                      AllColors.lightRed,
                      AllColors.darkRed,
                    ),
                    _buildStatusCard(
                      ImageStrings.call,
                      "Busy",
                      callDetails['Busy'] ?? 0,
                      AllColors.microPurple,
                      AllColors.mediumPurple,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildStatusRow(
                  [
                    _buildStatusCard(
                      ImageStrings.call,
                      "Not Reachable",
                      callDetails['Not Reachable'] ?? 0,
                      AllColors.background_green,
                      AllColors.text__green,
                    ),
                    _buildStatusCard(
                      ImageStrings.call,
                      "Rejected",
                      callDetails['Rejected'] ?? 0,
                      AllColors.lightRed,
                      AllColors.darkRed,
                      isIcon: true,
                      icon: Icons.error_outline,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildSingleStatusCard(
                  "Switched off",
                  callDetails['Switched Off'] ?? 0,
                  AllColors.textField2,
                  AllColors.blackColor,
                  isIcon: true,
                  icon: Icons.power_settings_new,
                  iconColor: AllColors.figmaGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingsSection() {
    final meetingSummary = viewModel.employeeDataList.first.summary?.meetings;
    final meetingDetails = meetingSummary?.callDetails ?? {};

    return ContainerUtils(
      paddingBottom: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
              'Total Meetings',
              Icons.people,
              meetingSummary?.total.toString() ?? '0',
              "Total Meeting Engagement"),
          const SizedBox(height: 10),
          const Divider(thickness: 0.4),
          const SizedBox(height: 10),
          const Text(
            "Meeting Status Breakdown",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.5,
              fontFamily: FontFamily.sfPro,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _buildStatusRow(
              [
                _buildStatusCard(
                  null,
                  "Virtual",
                  meetingDetails['Virtual'] ?? 0,
                  AllColors.microPurple,
                  AllColors.mediumPurple,
                  isIcon: true,
                  icon: Icons.videocam_outlined,
                ),
                _buildStatusCard(
                  null,
                  "Physical",
                  meetingDetails['Physical'] ?? 0,
                  AllColors.textField2,
                  AllColors.blackColor,
                  isIcon: true,
                  icon: Icons.person_outline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitOnlySection() {
    return ContainerUtils(
      child: _buildSectionHeader(
        'Visit Only',
        Icons.location_on_outlined,
        "${viewModel.employeeDataList.first.summary?.visitOnly ?? 0}",
        "Total Visits Without Call or Meetings",
        isWide: true,
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, IconData icon, String value, String subtitle,
      {bool isWide = false}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.5,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.sfPro,
            color: DarkMode.backgroundColor2(context),
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, size: 20),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                color: DarkMode.backgroundColor2(context),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: isWide ? 180 : null,
              child: Text(
                subtitle,
                style:  TextStyle(
                  fontFamily: FontFamily.sfPro,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                    color: DarkMode.backgroundColor2(context),
                ),
                textAlign: TextAlign.end,
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusRow(List<Widget> children) {
    return Row(
      children: List.generate(children.length * 2 - 1, (index) {
        if (index.isEven) {
          return Expanded(child: children[index ~/ 2]);
        } else {
          return const SizedBox(width: 20);
        }
      }),
    );
  }

  Widget _buildStatusCard(
    String? imagePath,
    String label,
    dynamic value,
    Color bgColor,
    Color textColor, {
    bool isIcon = false,
    IconData? icon,
    Color? iconColor,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isIcon)
                  Icon(icon, color: iconColor ?? textColor)
                else if (imagePath != null)
                  Image.asset(
                    imagePath,
                    height: 20,
                    width: 20,
                    color: textColor,
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleStatusCard(
    String label,
    dynamic value,
    Color bgColor,
    Color textColor, {
    bool isIcon = false,
    IconData? icon,
    Color? iconColor,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isIcon) Icon(icon, color: iconColor ?? textColor),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailySalesTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Sales Report',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AllColors.blackColor,
                fontFamily: FontFamily.sfPro,
              ),
            ),
            const SizedBox(height: 16),
            ContainerUtils(
              borderRadius: BorderRadius.circular(12),
              backgroundColor: AllColors.whiteColor,

              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Total Sales',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AllColors.figmaGrey,
                        fontFamily: FontFamily.sfPro,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AllColors.background_green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Sales Chart Placeholder',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
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
    );
  }
}
