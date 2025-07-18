import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../../../resources/textStyles/text_styles.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/button/section_divider/SectionDivider.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class HrmAttendanceController extends GetxController {
  var selectedIndex = 0.obs;
  var selectedMonthIndex = 0.obs; // Add this for month selection
  var currentTime = ''.obs;
  Timer? timer;
  final RxBool _open = false.obs;

  bool get isOpen => _open.value;

  void toggleFab() {
    _open.toggle();
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    updateTime();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  void updateTime() {
    currentTime.value = DateFormat('hh:mm:ss a').format(DateTime.now());
  }
}

class HrmAttendanceScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const HrmAttendanceScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<HrmAttendanceScreen> createState() => _HrmAttendanceScreenState();
}

class _HrmAttendanceScreenState extends State<HrmAttendanceScreen> {
  int _selectedIndex = 0;
  bool isListView = true;
  final HrmAttendanceController controller = Get.put(HrmAttendanceController());

  final List<String> months = [
    'Jan',
    'Dec',
    'Nov',
    'Oct',
    'Sep',
    'Aug',
    'Jul',
    'Jun',
    'May',
    'Apr',
    'Mar',
    'Feb'
  ];

  Future<void> _refreshList() async {
    // Placeholder for refresh logic
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;

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
                        widget.scaffoldKey.currentState?.openDrawer();
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                CustomToggleButtonGroup(
                  initialSelectedIndex: _selectedIndex,
                  onIndexChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                      isListView = index == 0; // 0 for List, 1 for Graph
                    });
                  },
                  options: [
                    ToggleButtonUtils.createIconTextOption(
                      width: 110,
                      // icon: Icons.view_list,
                      selectedTextColor: AllColors.whiteColor,
                      text: 'Attendance',
                      selectedColor: AllColors.practiceColor,
                    ),
                    ToggleButtonUtils.createIconTextOption(
                      // icon: Icons.bar_chart,
                      selectedTextColor: AllColors.whiteColor,
                      text: 'Datewise',
                      selectedColor: AllColors.practiceColor,
                    ),
                    ToggleButtonUtils.createIconTextOption(
                      // icon: Icons.bar_chart,
                      selectedTextColor: AllColors.whiteColor,
                      text: 'User Activities',
                      selectedColor: AllColors.practiceColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0: // Attendance
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Holidays Section
                ContainerUtils(
                  child: Row(
                    children: [
                      const Text(
                        "Holidays",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.sfPro,
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        'assets/icons/celebration.png',
                        height: 40,
                        width: 39,
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "View All",
                          style: TextStyle(
                              fontFamily: FontFamily.sfPro,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                ContainerUtils(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Actions",
                            style: TextStyle(
                                fontFamily: FontFamily.sfPro,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          Spacer(),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  border:
                                      Border.all(color: AllColors.textField2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    controller.currentTime.value,
                                    style: const TextStyle(
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )),
                          const Spacer(),
                          CommonButton(
                            icon: Icon(
                              Icons.arrow_drop_down_sharp,
                              color: AllColors.whiteColor,
                            ),
                            height: 30,
                            width: 95,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AllColors.practiceColor,
                            title: 'Clock In',
                            onPress: () {
                              controller.toggleFab();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        "Wed, Jan 22, 2025",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.sfPro),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Attendance Logs Section
                ContainerUtils(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Attendance Logs',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.sfPro,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(() => Expanded(
                              child: Row(
                                children: months.asMap().entries.map((entry) {
                                  int idx = entry.key;
                                  String month = entry.value;
                                  bool isSelected = idx ==
                                      controller.selectedMonthIndex.value;

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: InkWell(
                                      onTap: () {
                                        controller.selectedMonthIndex.value =
                                            idx;
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AllColors.lightestPurple
                                              : Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          month,
                                          style: TextStyle(
                                              color: isSelected
                                                  ? AllColors.mediumPurple
                                                  : Colors.black87,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            )),
                      ),
                      const SizedBox(height: 20),

                      // Month-Specific Content
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Obx(() => ContainerUtils(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Attendance for ${months[controller.selectedMonthIndex.value]}',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                              const Spacer()
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 0.4,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Image.asset(
                                ImageStrings.date,
                                height: 13,
                                width: 13,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Dec 31, Tue',
                                style: TextStyle(
                                    fontFamily: FontFamily.sfPro,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AllColors.greenJungle),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(
                                  Icons.check,
                                  color: AllColors.greenJungle,
                                  size: 14,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Effective Hours : ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.sfPro),
                              ),
                              Text(
                                '9h 5m',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.sfPro,
                                    color: AllColors.figmaGrey),
                              ),
                              const Spacer(),
                              // Image.asset('assets/icons/arrival.png',height: 20,width: 20,),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "On Time",
                                style: TextStyle(
                                    fontFamily: FontFamily.sfPro,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Gross Hours : ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.sfPro),
                              ),
                              Text(
                                '9h 5m',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.sfPro,
                                    color: AllColors.figmaGrey),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 0.4,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset(
                                ImageStrings.date,
                                height: 13,
                                width: 13,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Dec 31, Tue',
                                style: TextStyle(
                                    fontFamily: FontFamily.sfPro,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              const Spacer(),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AllColors.greenJungle),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(
                                  Icons.check,
                                  color: AllColors.greenJungle,
                                  size: 14,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Effective Hours : ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.sfPro),
                              ),
                              Text(
                                '9h 5m',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.sfPro,
                                    color: AllColors.figmaGrey),
                              ),
                              const Spacer(),
                              // Image.asset('assets/icons/arrival.png',height: 20,width: 20,),
                              // SizedBox(width: 5,),      Text("On Time",style: TextStyle(fontFamily: FontFamily.sfPro,fontWeight: FontWeight.w500,fontSize: 14),)
                              const Text(
                                '0:02:48 late',
                                style: TextStyle(
                                    fontFamily: FontFamily.sfPro,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Gross Hours : ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.sfPro),
                              ),
                              Text(
                                '9h 5m',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.sfPro,
                                    color: AllColors.figmaGrey),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      case 1: // Datewise
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerUtils(
                  child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        "Attendance logs(Datewise)",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.sfPro,
                            fontSize: 18),
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CommonTextField(hintText: 'Search For User'),
                  const SizedBox(
                    height: 5,
                  ),
                  const CommonTextField(
                    hintText: 'Select Date',
                    isDateField: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 0.4,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: Icon(
                    Icons.do_not_disturb_on_outlined,
                    size: 40,
                    color: AllColors.vividRed,
                  )),
                  const Center(child: Text('Data Not Found'))
                ],
              ))
            ],
          ),
        );
      case 2: // User Activities
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            children: [
              TextStyles.w400_15(
                  color: Colors.black, context, "User Activities"),
              Center(
                  child: Icon(
                Icons.do_not_disturb_on_outlined,
                size: 40,
                color: AllColors.vividRed,
              )),
              const Center(child: Text('Data Not Found'))
            ],
          ),
        );
      default:
        return Container();
    }
  }
}
