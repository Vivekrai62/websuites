import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/views/reports/taskreport/taskdetails/TaskDetailsScreen.dart';
import '../../../Utils/utils.dart';
import 'package:websuites/views/reports/taskdetails/TaskDetailsResponseModel.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/reports/task_report/report_task_view_model.dart';

// Controller to manage timer and UI state using GetX
class TaskReportController extends GetxController {
  // Observable variables for timer and elapsed time
  var elapsedSeconds =
      <String, int>{}.obs; // Map to store elapsed seconds for each task
  var timers = <String, Timer>{}; // Store timers for each task

  // Start timer for a specific task
  void startTimer(String taskId, DateTime startTime) {
    if (!timers.containsKey(taskId)) {
      elapsedSeconds[taskId] = DateTime.now().difference(startTime).inSeconds;
      timers[taskId] = Timer.periodic(const Duration(seconds: 1), (timer) {
        elapsedSeconds[taskId] = DateTime.now().difference(startTime).inSeconds;
      });
    }
  }

  // Format elapsed time
  String formatElapsedTime(int seconds) {
    if (seconds <= 0) {
      return 'N/A';
    }
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    // Cancel all timers when controller is disposed
    timers.forEach((key, timer) => timer.cancel());
    super.onClose();
  }
}

class TaskReportScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const TaskReportScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    final TaskReportsListViewModel viewModel =
        Get.put(TaskReportsListViewModel());
    final TaskReportController controller = Get.put(TaskReportController());

    // Observable for selected limit
    var selectedLimit = '15'.obs;

    // Check if device is tablet
    bool isTablet = MediaQuery.of(context).size.width >= 600;

    // Map for priority images
    const Map<String, String> priorityImages = {
      'highest': 'assets/icons/Highest.png',
      'high': 'assets/icons/High.png',
      'medium': 'assets/icons/Mediums.png',
      'low': 'assets/icons/Low.png',
      'lowest': 'assets/icons/Lowest.png',
      'n/a': '',
    };

    // Function to fetch task reports
    void fetchTaskReports() {
      try {
        viewModel.fetchTaskReports({
          "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
          "limit": int.parse(selectedLimit.value),
          "report_of": null,
          "page": 1
        }, context).then((_) {
          // Initialize timers for each task
          if (viewModel.taskReportResponse.value.items.isNotEmpty) {
            for (var item in viewModel.taskReportResponse.value.items) {
              final createdAt = item.currentTask?.createdAt;
              if (createdAt != null) {
                controller.startTimer(item.currentTask?.task?.id ?? 'unknown',
                    DateTime.parse(createdAt));
              }
            }
          }
        });
      } catch (e) {
        print('Error fetching task reports: $e');
      }
    }

    // Fetch task reports on initialization
    fetchTaskReports();

    return Scaffold(
      backgroundColor:DarkMode.backgroundColor(context),
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
                    'Task Report',
                    style: TextStyle(
                      color: DarkMode.backgroundColor2(context),
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 17.5,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    child:  Icon(Icons.filter_list,  color: DarkMode.backgroundColor2(context),),
                    onTap: () {
                      // Add filter functionality if needed
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Obx(() {
                      // Show loading indicator
                      if (viewModel.loading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      // Show message if no reports found
                      if (viewModel.taskReportResponse.value.items.isEmpty) {
                        return const Center(
                            child: Text('No task reports found.'));
                      }

                      // Collect user data for dropdown
                      List<String> userCategories = viewModel
                          .taskReportResponse.value.items
                          .map((item) => item.user ?? 'Unknown User')
                          .toList();

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ContainerUtils(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Ongoing Task Report',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Divider(
                                      thickness: 1, color: Colors.grey),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: viewModel
                                        .taskReportResponse.value.items.length,
                                    itemBuilder: (context, index) {
                                      final item = viewModel.taskReportResponse
                                          .value.items[index];
                                      final taskId =
                                          item.currentTask?.task?.id ??
                                              'unknown';

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    item.user ?? 'Unknown User',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.timer,
                                                        size: 16,
                                                        color: Colors.green),
                                                    const SizedBox(width: 5),
                                                    Obx(() => Text(
                                                          controller.formatElapsedTime(
                                                              controller.elapsedSeconds[
                                                                      taskId] ??
                                                                  0),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    item.email ?? 'No email',
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                Text(
                                                  item.currentTask?.createdAt !=
                                                          null
                                                      ? formatDateWithTime(item
                                                          .currentTask!
                                                          .createdAt)
                                                      : 'N/A',
                                                  style: const TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () async {
                                                String taskId = item.currentTask
                                                        ?.task?.id ??
                                                    'N/A';
                                                TaskDetailsResponseModel?
                                                    taskDetails;

                                                try {
                                                  taskDetails = await viewModel
                                                      .fetchTaskDetails(taskId);
                                                } catch (error) {
                                                  print(
                                                      "Error fetching task details: $error");
                                                }

                                                // Prepare task details with defaults
                                                String assignedTo = 'N/A';
                                                String duration = 'N/A';
                                                String startOn = 'N/A';
                                                String endOn = 'N/A';
                                                String taskType = 'N/A';
                                                String status = 'N/A';
                                                String deadline = 'N/A';
                                                String priority = item
                                                        .currentTask
                                                        ?.task
                                                        ?.priority ??
                                                    'N/A';
                                                String createdBy = 'N/A';
                                                String projectName = 'N/A';
                                                String projectStartDate = 'N/A';
                                                String projectEndDate = 'N/A';
                                                String projectId = 'N/A';

                                                if (taskDetails != null) {
                                                  if (taskDetails.taskInfo
                                                      .assigned.isNotEmpty) {
                                                    Assigned assignedUser =
                                                        taskDetails.taskInfo
                                                            .assigned[0];
                                                    assignedTo =
                                                        '${assignedUser.assignedTo.firstName} ${assignedUser.assignedTo.lastName}';
                                                  }
                                                  duration = formatHoursMinutes(
                                                      taskDetails.hours
                                                          .toDouble(),
                                                      taskDetails.minutes
                                                          .toDouble());
                                                  startOn = taskDetails
                                                          .taskInfo.timeTracker
                                                          .where((tracker) =>
                                                              tracker.action ==
                                                              'start')
                                                          .isNotEmpty
                                                      ? formatDateWithTime(
                                                          taskDetails.taskInfo
                                                              .timeTracker
                                                              .lastWhere(
                                                                  (tracker) =>
                                                                      tracker
                                                                          .action ==
                                                                      'start')
                                                              .dateTime)
                                                      : 'N/A';
                                                  endOn = taskDetails
                                                          .taskInfo.timeTracker
                                                          .where((tracker) =>
                                                              tracker.action ==
                                                              'end')
                                                          .isNotEmpty
                                                      ? formatDateWithTime(
                                                          taskDetails.taskInfo
                                                              .timeTracker
                                                              .lastWhere(
                                                                  (tracker) =>
                                                                      tracker
                                                                          .action ==
                                                                      'end')
                                                              .dateTime)
                                                      : 'N/A';
                                                  projectId = taskDetails
                                                          .taskInfo
                                                          .project
                                                          .id ??
                                                      'N/A';
                                                  taskType = taskDetails
                                                          .taskInfo
                                                          .taskType
                                                          ?.name ??
                                                      'N/A';
                                                  status = taskDetails.taskInfo
                                                          .status?.name ??
                                                      'N/A';
                                                  deadline = taskDetails
                                                              .taskInfo
                                                              .deadline !=
                                                          null
                                                      ? formatShortDate(
                                                          taskDetails
                                                              .taskInfo.deadline
                                                              .toString())
                                                      : 'N/A';
                                                  createdBy =
                                                      '${taskDetails.taskInfo.createdBy.firstName} ${taskDetails.taskInfo.createdBy.lastName}';
                                                  projectName = taskDetails
                                                          .taskInfo
                                                          .project
                                                          .projectName ??
                                                      '';
                                                  projectStartDate = taskDetails
                                                              .taskInfo
                                                              .project
                                                              .startDate !=
                                                          null
                                                      ? formatShortDate(
                                                          taskDetails.taskInfo
                                                              .project.startDate
                                                              .toString())
                                                      : 'N/A';
                                                  projectEndDate = taskDetails
                                                              .taskInfo
                                                              .project
                                                              .deadline !=
                                                          null
                                                      ? formatShortDate(
                                                          taskDetails.taskInfo
                                                              .project.deadline
                                                              .toString())
                                                      : 'N/A';
                                                } else {
                                                  Utils.snackbarFailed(
                                                      'Failed to fetch task details.');
                                                }

                                                // Navigate to TaskDetailsScreen
                                                Get.to(() => TaskDetailsScreen(
                                                        taskItem: {
                                                          'subject': item
                                                                  .currentTask
                                                                  ?.task
                                                                  ?.subject ??
                                                              'No task subject',
                                                          'duration': duration,
                                                          'startOn': startOn,
                                                          'endOn': endOn,
                                                          'taskType': taskType,
                                                          'status': status,
                                                          'deadline': deadline,
                                                          'priority': priority,
                                                          'assignedTo':
                                                              assignedTo,
                                                          'createdBy':
                                                              createdBy,
                                                          'projectName':
                                                              projectName,
                                                          'projectStartDate':
                                                              projectStartDate,
                                                          'projectEndDate':
                                                              projectEndDate,
                                                          'projectId':
                                                              projectId,
                                                        }));
                                              },
                                              child: Text(
                                                item.currentTask?.task
                                                        ?.subject ??
                                                    'No task subject',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.access_time,
                                                    size: 16,
                                                    color: Colors.orange),
                                                const SizedBox(width: 5),
                                                Text(
                                                  item.currentTask?.task
                                                              ?.estimatedMinutes !=
                                                          null
                                                      ? '${item.currentTask!.task!.estimatedMinutes} min'
                                                      : 'No time estimate',
                                                  style: const TextStyle(
                                                      color: Colors.orange),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                                thickness: 1,
                                                color: Colors.grey),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color:  DarkMode.backgroundColor(context),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Today Task Report',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Obx(() {
                              // Show loading indicator
                              if (viewModel.loading.value) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              // Show message if no reports found
                              if (viewModel
                                  .taskReportResponse.value.items.isEmpty) {
                                return const Center(
                                    child: Text('No task reports found.'));
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: viewModel
                                    .taskReportResponse.value.items.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel
                                      .taskReportResponse.value.items[index];
                                  final taskId =
                                      item.currentTask?.task?.id ?? 'unknown';

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.user ?? 'Unknown User',
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.alarm,
                                                color: Color(0xFFEBA801),
                                                size: 14,
                                              ),
                                              const SizedBox(width: 6.0),
                                              Text(
                                                item.currentTask?.task
                                                            ?.startDate !=
                                                        null
                                                    ? formatTimeDifference(item
                                                        .currentTask!
                                                        .task!
                                                        .startDate!)
                                                    : 'No task subject',
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFEBA801),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item.email ?? 'No email',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.timer,
                                            color: Color(0xFF8E9711),
                                            size: 12,
                                          ),
                                          const SizedBox(width: 6.0),
                                          Text(
                                            item.currentTask?.task
                                                        ?.estimatedMinutes !=
                                                    null
                                                ? '${(item.currentTask!.task!.estimatedMinutes! / 60).floor()} hours'
                                                : 'N/A',
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF8E9711),
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.assignment,
                                            color: AllColors.mediumPurple,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 6.0),
                                          Container(
                                            height: 17.0,
                                            decoration: BoxDecoration(
                                              color: AllColors.lighterPurple,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              item.taskList.isNotEmpty
                                                  ? '${item.taskList.length}'
                                                  : '0',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                                color: AllColors.mediumPurple,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        item.taskList.isNotEmpty
                                            ? '${item.taskList.length}'
                                            : '0',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: AllColors.darkRed),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            item.currentTask?.task?.subject ??
                                                'No task subject',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Text(
                                                item.currentTask?.task
                                                            ?.startDate !=
                                                        null
                                                    ? formatDateWithDay(item
                                                        .currentTask!
                                                        .task!
                                                        .startDate!)
                                                    : 'No task subject',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      IntrinsicWidth(
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 20,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                priorityImages[item.currentTask
                                                        ?.task?.priority
                                                        ?.toLowerCase()] ??
                                                    priorityImages['n/a'] ??
                                                    'assets/svg/error.svg',
                                                height: 10,
                                                width: 20,
                                              ),
                                              Text(
                                                (item.currentTask?.task
                                                                ?.priority ??
                                                            'N/A')
                                                        .isNotEmpty
                                                    ? '${(item.currentTask?.task?.priority ?? 'N/A')[0].toUpperCase()}${(item.currentTask?.task?.priority ?? 'N/A').substring(1)}'
                                                    : 'N/A',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                          thickness: 1.0, height: 20.0),
                                    ],
                                  );
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
