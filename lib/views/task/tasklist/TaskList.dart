import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/button/CustomButton.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/data/models/responseModels/tasks/list/tasks_list_response_model.dart'
    as task_list;
import 'package:websuites/data/models/requestModels/dashboardScreen/db_latest_task.dart'
    as dashboard;
import 'package:websuites/views/reports/taskreport/taskdetails/TaskDetailsScreen.dart';
import '../../../resources/imageStrings/image_strings.dart';
import '../../../resources/strings/strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/container_Utils/ContainerUtils.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/leadScreens/createNewLead/assignedLeadTo/assigned_lead_to_viewModel.dart';
import '../../../viewModels/tasks/list/task_list_view_model.dart';
import '../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class TaskListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(task_list.Item)? onOrderSelected; // Add callback parameter

  const TaskListScreen({super.key, required this.scaffoldKey, this.onOrderSelected});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskListViewModel _taskListViewModel =
      Get.put(TaskListViewModel(), permanent: true);
  final AssignedLeadToViewModel _assignedLeadToController =
      Get.put(AssignedLeadToViewModel());
  final _selectedTaskIndex = 0.obs;
  bool isRed = true; // Initial state is red

  String capitalizeFirstLetter(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }


  // Function to get background and text colors based on status
  Color getBackgroundColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'not started':
        return AllColors.textField2;
      case 'completed':
        return AllColors.darkGreen;
      case 'canceled':
        return AllColors.lightRed;
      case 'pending':
        return AllColors.lightPurple;
      case 'review':
        return AllColors.lightPink;
      case 'testing':
        return AllColors.thinPurple;
      case 'reopen':
        return AllColors.lightOrange;
      case 'in progress':
        return AllColors.greenGoogleForm;
      default:
        return Colors.grey.shade300;
    }
  }

  Color getTextColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'not started':
        return Colors.grey;
      case 'completed':
        return Colors.white;
      case 'canceled':
        return AllColors.darkRed;
      case 'pending':
        return AllColors.mediumPurple;
      case 'review':
        return AllColors.darkPink;
      case 'testing':
        return AllColors.lightPink;
      case 'reopen':
        return AllColors.darkOrange;
      case 'in progress':
        return AllColors.greenishYellow;
      default:
        return Colors.black;
    }
  }

  void toggleButtonColor() {
    setState(() {
      isRed = !isRed; // Toggle the color state
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
                        if (widget.scaffoldKey.currentState != null) {
                          if (!widget.scaffoldKey.currentState!.isDrawerOpen) {
                            widget.scaffoldKey.currentState!.openDrawer();
                          }
                        } else {
                          debugPrint("Scaffold key has no current state");
                        }
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  Text(
                    'Task List',
                    style: TextStyle(
                      color: DarkMode.backgroundColor2(context),
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 18.5,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.filter_list,color: AllColors.mediumPurple,),
                  SizedBox(width: 10,),
                  ContainerUtils(
                    width: 90,
                    height: 20,
                    paddingLeft: 0,
                    paddingRight: 0,
                    paddingTop: 0,
                    paddingBottom: 0,

                    borderRadius: BorderRadius.circular(24),
                    backgroundColor: AllColors.mediumPurple,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle_outline_sharp,
                          color: AllColors.whiteColor,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Add",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45, right: 25, top: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                  height: 30,
                  child: Obx(() => GestureDetector(
                        onTap: () => _selectedTaskIndex.value = 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedTaskIndex.value == 0
                                ? AllColors.mediumPurple
                                : AllColors.textField2,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageStrings.menuDot,
                                height: 12,
                                width: 12,
                                color: _selectedTaskIndex.value == 0
                                    ? AllColors.whiteColor
                                    : AllColors.blackColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Task List',
                                style: TextStyle(
                                  color: _selectedTaskIndex.value == 0
                                      ? AllColors.whiteColor
                                      : AllColors.blackColor,
                                  fontFamily: FontFamily.sfPro,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                const Spacer(),
                SizedBox(
                  width: 140,
                  height: 30,
                  child: Obx(() => GestureDetector(
                        onTap: () => _selectedTaskIndex.value = 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedTaskIndex.value == 1
                                ? AllColors.mediumPurple
                                : AllColors.textField2,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.grid_view_outlined,
                                size: 14,
                                color: _selectedTaskIndex.value == 1
                                    ? AllColors.whiteColor
                                    : AllColors.blackColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Details',
                                style: TextStyle(
                                  color: _selectedTaskIndex.value == 1
                                      ? AllColors.whiteColor
                                      : AllColors.blackColor,
                                  fontFamily: FontFamily.sfPro,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_taskListViewModel.loading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return _selectedTaskIndex.value == 0
                  ? RefreshIndicator(
                      onRefresh: () =>
                          _taskListViewModel.refreshData(Get.context!),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //       top: 15, right: 15, left: 15),
                          //   child: Row(
                          //     children: [
                          //       // Text(
                          //       //   "Task",
                          //       //   style: TextStyle(
                          //       //     fontWeight: FontWeight.w600,
                          //       //     fontSize: 18,
                          //       //     fontFamily: FontFamily.sfPro,
                          //       //   ),
                          //       // ),
                          //       // SizedBox(width: 10,),
                          //
                          //       // CustomButton(
                          //       //   height: 20,
                          //       //   width: 20,
                          //       //   borderRadius: 12,
                          //       //   child: Icon(Icons.add, size: 14),
                          //       //   onPressed: () {},
                          //       // ),
                          //       Expanded(
                          //         child: ContainerUtils(
                          //           paddingBottom: 10,
                          //           paddingRight: 15,
                          //           paddingTop: 20,
                          //           paddingLeft: 15,
                          //           height: 60,
                          //           child: Row(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               const Text(
                          //                 'Running Task : ',
                          //                 style: TextStyle(
                          //                   fontWeight: FontWeight.w600,
                          //                   fontSize: 15,
                          //                   fontFamily: FontFamily.sfPro,
                          //                 ),
                          //               ),
                          //               Expanded(
                          //                 flex: 2,
                          //                 child: Text(
                          //                   _taskListViewModel.tasks.first.subject ?? 'No Subject',
                          //                   style: TextStyle(
                          //                     fontWeight: FontWeight.w600,
                          //                     color: AllColors.mediumPurple,
                          //                     fontSize: 15,
                          //                     fontFamily: FontFamily.sfPro,
                          //                   ),
                          //                   overflow: TextOverflow.ellipsis,
                          //                   maxLines: 1,
                          //                 ),
                          //               ),
                          //               const Spacer(),
                          //               CommonButton(
                          //                 borderRadius: 5,
                          //                 width: 40,
                          //                 fontSize: 12,
                          //                 fontWeight: FontWeight.w400,
                          //                 height: 30,
                          //                 color: _taskListViewModel.tasks.first.assigned.first.status == true
                          //                     ? AllColors.darkRed  // Red when status is true
                          //                     : AllColors.greenJungle, // Green when status is false
                          //                 textColor: Colors.white,
                          //                 title: _taskListViewModel.tasks.first.assigned.first.status == true
                          //                     ? 'Stop'
                          //                     : 'Start', // 'Stop' if true, 'Start' if false
                          //                 onPress: () {
                          //                   toggleButtonColor(); // This toggles the status or isRed logic
                          //                 },
                          //               ),
                          //
                          //             ],
                          //           ),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          Expanded(
                            child: _taskListViewModel.tasks.isEmpty
                                ? const Center(
                                    child: Text("No products available"))
                                : LayoutBuilder(
                                    builder: (context, constraints) {
                                      if (_taskListViewModel.tasks.isEmpty) {
                                        return SingleChildScrollView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          child: SizedBox(
                                            height: constraints.maxHeight,
                                            child: const Center(
                                              child:
                                                  Text("No products available"),
                                            ),
                                          ),
                                        );
                                      }

                                      final double screenWidth =
                                          constraints.maxWidth;
                                      int crossAxisCount = screenWidth < 600
                                          ? 1
                                          : screenWidth < 1200
                                              ? 2
                                              : 3;
                                      final double itemWidth = (screenWidth -
                                              (crossAxisCount - 1) * 16) /
                                          crossAxisCount;
                                      const double itemHeight = 240;
                                      final double childAspectRatio =
                                          itemWidth / itemHeight;

                                      return GridView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        padding: const EdgeInsets.all(16),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: crossAxisCount,
                                          childAspectRatio: childAspectRatio,
                                          crossAxisSpacing: 16,
                                          mainAxisSpacing: 16,
                                        ),
                                        itemCount:
                                            _taskListViewModel.tasks.length,
                                        itemBuilder: (context, index) {
                                          final statusName = _taskListViewModel.tasks[index].status?.name ?? 'No Subject';
                                          final project = _taskListViewModel .tasks[index];
                                          final task = project.id;

                                          return GestureDetector(
                                            onTap: (){
                                              final task = _taskListViewModel.tasks[index];
                                              widget.onOrderSelected?.call(task);

                                            },
                                            child: ContainerUtils(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          _taskListViewModel
                                                                  .tasks[index]
                                                                  .subject ??
                                                              'No Subject',
                                                          style: const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                FontFamily.sfPro,
                                                          ),
                                                          maxLines:
                                                              1, // Limit to one line
                                                          overflow: TextOverflow
                                                              .ellipsis, // Show ellipsis if text overflows
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5.0,
                                                                    vertical: 2),
                                                            decoration:
                                                                BoxDecoration(
                                                              // color: AllColors
                                                              //     .thinOrange,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                // Image.asset(
                                                                //   'assets/icons/Mediums.png',
                                                                //   height: 12,
                                                                //   width: 13,
                                                                //   color: AllColors
                                                                //       .yellowGoogleForm,
                                                                // ),
                                                                // const SizedBox(
                                                                //     width: 3),
                                                                Text(
                                                                  capitalizeFirstLetter(
                                                                      _taskListViewModel
                                                                          .tasks[
                                                                              index]
                                                                          .priority),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AllColors
                                                                        .yellowGoogleForm,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),

                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                                                            decoration: BoxDecoration(
                                                              color: getBackgroundColor(statusName),
                                                              borderRadius: BorderRadius.circular(12),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  statusName,
                                                                  style: TextStyle(
                                                                    fontSize: 10,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: getTextColor(statusName),
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 5),
                                                                Image.asset(
                                                                  'assets/icons/Dropdown.png',
                                                                  height: 12,
                                                                  width: 13,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          ImageStrings.date,
                                                          height: 13,
                                                          width: 13),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        _taskListViewModel
                                                                    .tasks[index]
                                                                    .deadline !=
                                                                null
                                                            ? formatDateToLongMonth2(
                                                                _taskListViewModel
                                                                    .tasks[index]
                                                                    .startDate!)
                                                            : 'N/A',
                                                        style: TextStyle(
                                                          color: AllColors
                                                              .mediumPurple,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      const Text(
                                                        'DEADLINE - ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        _taskListViewModel
                                                                    .tasks[index]
                                                                    .deadline !=
                                                                null
                                                            ? formatDateToLongMonth2(
                                                                _taskListViewModel
                                                                    .tasks[index]
                                                                    .deadline!)
                                                            : 'N/A',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                          color: AllColors.grey,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        'CREATED - ',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        _taskListViewModel
                                                                    .tasks[index]
                                                                    .deadline !=
                                                                null
                                                            ? formatDateToLongMonth2(
                                                                _taskListViewModel
                                                                    .tasks[index]
                                                                    .createdAt!)
                                                            : 'N/A',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                          color: AllColors.grey,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          const Text(
                                                            'ASSIGNEE',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                          Text(
                                                            _taskListViewModel
                                                                    .tasks[index]
                                                                    .assigned
                                                                    .isNotEmpty
                                                                ? '${_taskListViewModel.tasks[index].assigned[0].assignedTo?.firstName} ${_taskListViewModel.tasks[index].assigned[0].assignedTo?.lastName}'
                                                                : 'No Subject',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .mediumPurple,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'ESTIMATED HOURS',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          Text(
                                                            _taskListViewModel
                                                                        .tasks[
                                                                            index]
                                                                        .estimatedMinutes !=
                                                                    null
                                                                ? '${(int.tryParse(_taskListViewModel.tasks[index].estimatedMinutes!.toString()) ?? 0) ~/ 60} Hours'
                                                                : 'No Subject',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              color: AllColors
                                                                  .mediumPurple,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    thickness: 0.5,
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                       Text(
                                                        'PROJECT - ',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                          fontSize: 12,
                                                          color: DarkMode.backgroundColor2(context),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          (_taskListViewModel
                                                                  .tasks[index]
                                                                  .project
                                                                  ?.projectName
                                                                  ?.toString() ??
                                                              'No Subject'),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                FontFamily.sfPro,
                                                            color: AllColors
                                                                .mediumPurple,
                                                            fontSize: 12,
                                                          ),
                                                          maxLines:
                                                              1, // Limit to one line
                                                          overflow: TextOverflow
                                                              .ellipsis, // Show ellipsis if text overflows
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                         TextSpan(
                                                          text: 'TASK TYPE - ',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                FontFamily.sfPro,
                                                            fontSize: 12,
                                                            color: DarkMode.backgroundColor2(context),
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: _taskListViewModel
                                                                  .tasks[index]
                                                                  .taskType
                                                                  ?.name
                                                                  .toString() ??
                                                              'No Subject',
                                                          style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                FontFamily.sfPro,
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                          )
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      // this screen for details screen   ****************************

                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 15, left: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 8.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Entity Header
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Not started', // Static text for task status
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.add),
                                          ),
                                          const Icon(Icons.more_vert),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(height: 20),

                                  // Scrollable Task List
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxHeight: 200),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: 2, // Hardcoded task count
                                      separatorBuilder: (context, index) =>
                                          const Divider(
                                        thickness: 0.5,
                                        height: 30,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                IntrinsicWidth(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 20,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          'assets/icons/Medium.png',
                                                          height: 10,
                                                          width: 20,
                                                        ),
                                                        const Text(
                                                          'Medium',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor:
                                                      AllColors.darkBlue,
                                                  child: const Text(
                                                    'R',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              index == 0 ? 'Task 1' : 'Task 2',
                                              style: TextStyle(
                                                color: AllColors.blackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              index == 0
                                                  ? 'Details for Task 1'
                                                  : 'Details for Task 2',
                                              style: TextStyle(
                                                color: AllColors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.watch_later_outlined,
                                                  color: AllColors.mediumPurple,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  index == 0
                                                      ? '2 days ago'
                                                      : '1 day ago',
                                                  style: TextStyle(
                                                    color:
                                                        AllColors.mediumPurple,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Image.asset(
                                                  'assets/icons/gallery.png',
                                                  height: 14,
                                                  width: 14,
                                                  color: AllColors.grey,
                                                ),
                                                const SizedBox(width: 8),
                                                const Icon(
                                                  Icons.comment,
                                                  color: Colors.grey,
                                                  size: 18,
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            }),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () => Visibility(
          visible: _selectedTaskIndex.value == 1,
          child: FloatingActionButton(
            backgroundColor: AllColors.mediumPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.white,
                  child: Container(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(Icons.close, color: AllColors.grey),
                            ),
                          ],
                        ),
                        const Text(
                          'Add People',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text('Name: *'),
                        const SizedBox(height: 10),
                        CommonTextField(
                          hintText: _assignedLeadToController
                                  .selectedLeadName.value.isEmpty
                              ? Strings.select
                              : _assignedLeadToController
                                  .selectedLeadName.value,
                          categories: _assignedLeadToController.namesOnlyRxList,
                          onCategoryChanged: (selectedCategory) {
                            final names = selectedCategory.split(' ');
                            if (names.length >= 2) {
                              final firstName = names[0];
                              final lastName = names[1];
                              _assignedLeadToController.selectedLeadName.value =
                                  '$firstName $lastName';
                            }
                          },
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: CommonButton(
                              height: 30,
                              title: 'Add People',
                              onPress: () {
                                Get.back();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            child: Icon(
              Icons.person_add_alt_1,
              color: AllColors.whiteColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
