import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import '../../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../../viewModels/reports/task_report/project_overview/create_project_reminder/task/ProjectOverviewTaskListViewModel.dart';

class ProjectOverViewTaskScreen extends StatelessWidget {
  final ProjectOverviewTaskListViewModel _viewModel = Get.find();

  // Define a map to store selected values for each task
  final Map<int, String?> _selectedValues = {};

  // Define a map for priority images
  static const Map<String, String> _priorityImages = {
    'highest': 'assets/icons/Highest.png',
    'high': 'assets/icons/High.png',
    'medium': 'assets/icons/Mediums.png',
    'low': 'assets/icons/Low.png',
    'lowest': 'assets/icons/Lowest.png',
    'n/a': 'assets/icons',
  };

  ProjectOverViewTaskScreen({super.key}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.fetchTaskList(Get.context!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_viewModel.isLoading.value && !_viewModel.isDataLoaded) {
        return const Center(child: CircularProgressIndicator());
      }

      final taskList = _viewModel.taskListResponse.value?.items;

      if (taskList == null || taskList.isEmpty) {
        return const Center(
          child: Text(
            'No tasks found',
            style: TextStyle(
              fontSize: 16,
              fontFamily: FontFamily.sfPro,
            ),
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          children: List.generate(taskList.length, (index) {
            final task = taskList[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: _selectedValues[index] == null
                    ? Colors.white
                    : AllColors.mediumPurple,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          task.subject ?? 'N/A',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: FontFamily.sfPro,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(task.priority),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  _priorityImages[
                                          task.priority?.toLowerCase()] ??
                                      'assets/svg/error.svg',
                                  height: 12,
                                  width: 13,
                                  color: _getPriorityTextColor(task.priority),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  '${task.priority?.substring(0, 1).toUpperCase() ?? 'N/A'}${task.priority?.substring(1).toLowerCase() ?? ''}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: _getPriorityTextColor(task.priority),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2),
                            decoration: BoxDecoration(
                              color: AllColors.greenGoogleForm,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  (task.status?.name ?? 'N/A').toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: AllColors.greenishYellow,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    // Get the RenderBox of the dropdown icon
                                    final RenderBox renderBox =
                                        context.findRenderObject() as RenderBox;
                                    _showDropdownMenu(
                                        context, renderBox, index);
                                  },
                                  child: const Icon(
                                      Icons.arrow_drop_down_outlined),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset(ImageStrings.date, height: 13, width: 13),
                      Text(
                        '   ${task.startDate != null ? '${task.startDate!.day}/${task.startDate!.month}/${task.startDate!.year}' : 'N/A'}',
                        style: TextStyle(
                          color: AllColors.mediumPurple,
                          fontFamily: FontFamily.sfPro,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'DEADLINE - ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.sfPro,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        task.deadline != null
                            ? '${task.deadline!.day}/${task.deadline!.month}/${task.deadline!.year}'
                            : 'N/A',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: FontFamily.sfPro,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'CREATED - ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.sfPro,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        task.createdAt != null
                            ? formatDateToLongMonth2(task.createdAt)
                            : 'N/A',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.sfPro,
                          color: AllColors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'ASSIGNEE - ',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: FontFamily.sfPro,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        task.assigned.isNotEmpty
                            ? '${task.assigned[0].assignedTo?.firstName ?? 'N/A'} ${task.assigned[0].assignedTo?.lastName ?? ''}'
                            : 'N/A',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.sfPro,
                          color: AllColors.mediumPurple,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ESTIMATED HOURS',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.sfPro,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            task.estimatedMinutes?.toString() ?? 'N/A',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.sfPro,
                              color: AllColors.mediumPurple,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Text(
                        'TASK DURATION - ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.sfPro,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        task.estimatedMinutes?.toString() ?? 'N/A',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.sfPro,
                          color: AllColors.mediumPurple,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 35, thickness: 0.5),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'TASK TYPE ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: FontFamily.sfPro,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        const WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.arrow_forward_sharp,
                              size: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: task.taskType?.name ?? 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.sfPro,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    });
  }

  // Method to show the dropdown menu
  void _showDropdownMenu(BuildContext context, RenderBox renderBox, int index) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    // Calculate the position for the dropdown menu
    const double marginTop = 10.0;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(Offset(renderBox.size.width, marginTop),
            ancestor: overlay),
        renderBox.localToGlobal(renderBox.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(width: 0.1),
      ),
      color: Colors.white,
      context: context,
      position: position,
      items: [
        const PopupMenuItem<String>(
          value: 'todo',
          child: Text('To Do'),
        ),
        const PopupMenuItem<String>(
          value: 'in_progress',
          child: Text('In Progress'),
        ),
        const PopupMenuItem<String>(
          value: 'done',
          child: Text('Done'),
        ),
      ],
    ).then((value) {
      if (value != null) {
        _selectedValues[index] = value; // Store the selected value
        print('Selected: $value'); // Handle selected item here
      }
    });
  }

  Color _getPriorityColor(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'high':
        return Colors.red.withOpacity(0.1);
      case 'low':
        return Colors.green.withOpacity(0.1);
      default:
        return AllColors.thinOrange;
    }
  }

  Color _getPriorityTextColor(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'low':
        return Colors.green;
      default:
        return AllColors.yellowGoogleForm;
    }
  }
}
