import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/views/reports/taskreport/taskdetails/projectoverview/task/TaskOverView.dart';
// import '../../../../../data/models/responseModels/reports/taskdetails/project_overview/project_overview_list/task_report_project_overview_response_model.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../../utils/appColors/app_colors.dart';
import '../../../../../utils/button/CustomButton.dart';
import '../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../utils/fontfamily/FontFamily.dart';

import '../../../../../viewModels/reports/task_report/project_overview/create_project_reminder/task/ProjectOverviewTaskListViewModel.dart';
import '../../../../../viewModels/reports/task_report/project_overview/project_overview_list/task_report_project_overview_view_model.dart';
import '../../../../../viewModels/reports/task_report/project_overview/report_list/report_task_report_list.dart';
import '../../../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class ProjectOverview extends StatefulWidget {
  final String projectId;

  const ProjectOverview({super.key, required this.projectId});

  @override
  _ProjectOverviewState createState() => _ProjectOverviewState();
}

class _ProjectOverviewState extends State<ProjectOverview> {
  late DropzoneViewController controller;
  ValueNotifier<String> selectedReportTab =
      ValueNotifier<String>('ProjectReport');

  final ProjectOverViewListViewModel viewModel =
      Get.put(ProjectOverViewListViewModel());
  final TaskReportListViewModel reportViewModel =
      Get.put(TaskReportListViewModel());
  late ProjectOverviewTaskListViewModel taskViewModel;
  final repositories = Get.put(Repositories());

  final selectedTab = 'Overview'.obs;
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    taskViewModel = Get.put(ProjectOverviewTaskListViewModel(repositories));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.taskReportProjectOverview(context, widget.projectId);
      reportViewModel.fetchTaskProjectReportList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Project Overview',
          style: TextStyle(
            fontFamily: FontFamily.sfPro,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final projectData = viewModel.projectOverViewResponse;
        return projectData != null
            ? SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => selectedTab.value = 'Overview',
                              child: Container(
                                height: Get.height / 30,
                                decoration: BoxDecoration(
                                  color: selectedTab.value == 'Overview'
                                      ? AllColors.mediumPurple
                                      : AllColors.textField2,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'Overview',
                                    style: TextStyle(
                                      color: selectedTab.value == 'Overview'
                                          ? AllColors.whiteColor
                                          : AllColors.blackColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => selectedTab.value = 'Task',
                              child: Container(
                                height: Get.height / 30,
                                decoration: BoxDecoration(
                                  color: selectedTab.value == 'Task'
                                      ? AllColors.mediumPurple
                                      : AllColors.textField2,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'Task',
                                    style: TextStyle(
                                      color: selectedTab.value == 'Task'
                                          ? AllColors.whiteColor
                                          : AllColors.blackColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => selectedTab.value = 'SequentialTask',
                              child: Container(
                                height: Get.height / 30,
                                decoration: BoxDecoration(
                                  color: selectedTab.value == 'SequentialTask'
                                      ? AllColors.mediumPurple
                                      : AllColors.textField2,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'SequentialTask',
                                    style: TextStyle(
                                      color:
                                          selectedTab.value == 'SequentialTask'
                                              ? AllColors.whiteColor
                                              : AllColors.blackColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Obx(() {
                      switch (selectedTab.value) {
                        case 'Overview':
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 30, left: 15, right: 15, bottom: 30),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.arrow_back_outlined),
                                        const SizedBox(width: 5),
                                        Flexible(
                                          flex: 9,
                                          child: Text(
                                            '${projectData.project?.projectName}',
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color(0x1F47BD82),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Text(
                                            'Activation Sent',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF47BD82),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.mode_edit_outline_outlined,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    const Divider(thickness: 0.5),
                                    Row(
                                      children: [
                                        const Text(
                                          'Project Overview',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: FontFamily.sfPro),
                                        ),
                                        const Spacer(),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AllColors.darkOrange,
                                            minimumSize: const Size(0, 20),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 4),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(19),
                                            ),
                                          ),
                                          child: Text(
                                            '${projectData.project?.status}',
                                            style: TextStyle(
                                              color: AllColors.whiteColor,
                                              fontSize: 12,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

// Wrap(
//   spacing: 16.0,
//   runSpacing: 8.0,
//   children: [
//
//     buildRow('Created - ', '2024-12-05', 'Start Date - ',
//         '2024-12-04'),
//     buildRow('Deadline - ', 'N/A', 'Estimated Hours - ', '0'),
//   ],
// ),

                                    Row(
                                      children: [
                                        const Text(
                                          'Billing Type - ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: FontFamily.sfPro,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '${projectData.project?.billingType}',
                                        ),
                                        const Spacer(),
                                        const Text(
                                          'Customer - ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: FontFamily.sfPro,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                            '${projectData.project?.customer?.firstName} ${projectData.project?.customer?.lastName}')
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Text(
                                          'Created - ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: FontFamily.sfPro,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(formatShortDate(
                                            projectData.project?.createdAt)),
                                        const Spacer(),
                                        const Text(
                                          'Start Date - ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: FontFamily.sfPro,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(formatShortDate(
                                            projectData.project?.createdAt)),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Text(
                                          'Deadline - ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: FontFamily.sfPro,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(projectData.project?.deadline ??
                                            'N/A'),
                                        const Spacer(),
                                        const Text(
                                          'Total Estimated Hours - ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: FontFamily.sfPro,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                            '${projectData.project?.estimatedHours ?? 'N/A'}')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Company Phone - ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        Text(projectData.project?.company
                                                ?.companyPhone ??
                                            'N/A'),
                                        const Spacer(),
                                        const Text(
                                          'Tags - ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                color: AllColors.thinOrange,
                                                borderRadius:
                                                    BorderRadius.circular(19),
                                              ),
                                              child: Expanded(
                                                child: Text(
                                                  projectData.project?.tags
                                                          ?.map(
                                                              (tag) => tag.name)
                                                          .join(', ') ??
                                                      'N/A',
                                                  style: TextStyle(
                                                    color: AllColors.darkYellow,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text(
                                          'Company Name - ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(projectData.project?.company
                                                ?.companyName ??
                                            'N/A'),
                                      ],
                                    ),
                                    Text(
                                      projectData
                                              .project?.company?.companyEmail ??
                                          'N/A',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text(
                                          'Contact Person Name - ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          projectData.project?.company
                                                  ?.contactPersonName ??
                                              'N/A',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: FontFamily.sfPro,
                                            // color: AllColors.vividPurple,
                                            color: AllColors.mediumPurple,
                                            // fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            const Text(
                                              'Total Rate - ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              ' ${projectData.project?.totalRate ?? 'N/A'}',
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Members',
                                          style: TextStyle(
                                            fontFamily: FontFamily.sfPro,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          height: 15,
                                          width: 100,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: projectData
                                                    .project?.members
                                                    ?.asMap()
                                                    .entries
                                                    .map((entry) {
                                                  int index = entry.key;
                                                  var member = entry.value;

                                                  // List of colors and labels to be used for avatars
                                                  List<Map<String, dynamic>>
                                                      memberColors = [
                                                    {
                                                      'label': '',
                                                      'color': Colors.purple
                                                    },
                                                    {
                                                      'label': '',
                                                      'color': Colors.pink
                                                    },
                                                    {
                                                      'label': '',
                                                      'color': Colors.blue
                                                    },
                                                    {
                                                      'label': '',
                                                      'color': Colors.yellow
                                                    },
                                                  ];

                                                  // Get the first letter of the member's first name
                                                  String firstInitial = member
                                                              .firstName
                                                              ?.isNotEmpty ==
                                                          true
                                                      ? member.firstName![0]
                                                      : '';

                                                  // Choose the color based on the index or use the default color
                                                  Color avatarColor =
                                                      memberColors[index %
                                                          memberColors
                                                              .length]['color'];

                                                  return Positioned(
                                                    left: index *
                                                        (screenWidth / 27),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        print(
                                                            'Avatar for ${member.firstName} ${member.lastName} tapped!');
                                                      },
                                                      child: CircleAvatar(
                                                        radius:
                                                            screenWidth / 45,
                                                        backgroundColor:
                                                            avatarColor,
                                                        // Set the color based on the list
                                                        child: Text(
                                                          firstInitial
                                                              .toUpperCase(),
                                                          // Show only the first letter of the first name
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList() ??
                                                [],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 15, right: 15, bottom: 0),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Task Overview",
                                      style: TextStyle(
                                        fontFamily: FontFamily.sfPro,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 0.5,
                                    ),
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        // Helper function to get grid configuration based on screen width
                                        Map<String, dynamic> getGridConfig(
                                            double width) {
                                          if (width < 500) {
                                            return {
                                              'crossAxisCount': 2,
                                              'childAspectRatio': 2.2,
                                              'containerHeightFactor': 0.35,
                                            };
                                          } else if (width < 1024) {
                                            return {
                                              'crossAxisCount': 2,
                                              'childAspectRatio': 4.5,
                                              'containerHeightFactor': 0.25,
                                            };
                                          } else {
                                            return {
                                              'crossAxisCount': 3,
                                              'childAspectRatio': 4.5,
                                              'containerHeightFactor': 0.2,
                                            };
                                          }
                                        }

                                        final gridConfig =
                                            getGridConfig(constraints.maxWidth);

                                        return GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                gridConfig['crossAxisCount'],
                                            // Use a responsive crossAxisCount
                                            childAspectRatio:
                                                gridConfig['childAspectRatio'],
                                            // Use a responsive aspect ratio
                                            crossAxisSpacing: 12,
                                            mainAxisSpacing: 12,
                                          ),
                                          itemCount: (projectData.tasks
                                                      ?.standard?.length ??
                                                  0) +
                                              1,
                                          // Add 1 to itemCount
                                          itemBuilder: (context, index) {
                                            if (index ==
                                                (projectData.tasks?.standard
                                                        ?.length ??
                                                    0)) {
                                              return Container(
                                                height: constraints.maxWidth *
                                                    gridConfig[
                                                        'containerHeightFactor'],
                                                // Responsive container height
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0.2),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                      blurRadius: 8.0,
                                                      spreadRadius: 2.0,
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                            'Others',
                                                            // Show the task count for others
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'SFPro',
                                                            ),
                                                          ),
                                                          Text(
                                                            '${projectData.tasks?.others?.count ?? 0}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  'SFPro',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          // Grey background circle (100%)
                                                          SizedBox(
                                                            height: 44.0,
                                                            width: 44.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: AllColors
                                                                  .greyGoogleForm,
                                                              value: 1.0,
                                                              strokeWidth: 8,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      AllColors
                                                                          .greyGoogleForm),
                                                            ),
                                                          ),
                                                          // Blue progress circle (over the gray one)
                                                          SizedBox(
                                                            height: 44.0,
                                                            width: 44.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: projectData
                                                                          .tasks
                                                                          ?.others
                                                                          ?.count !=
                                                                      null
                                                                  ? (projectData
                                                                          .tasks!
                                                                          .others!
                                                                          .count! /
                                                                      100.0) // Assuming count is out of 100
                                                                  : null,
                                                              strokeWidth: 8,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      AllColors
                                                                          .darkBlue),
                                                            ),
                                                          ),
                                                          // Centered text displaying percentage
                                                          Text(
                                                            '${projectData.tasks?.others?.count ?? 0}%',
                                                            // Show the percentage
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'SFPro',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }

                                            // Regular task item
                                            final task = projectData
                                                .tasks!.standard![index];
                                            return Container(
                                              height: constraints.maxWidth *
                                                  gridConfig[
                                                      'containerHeightFactor'],
                                              // Responsive container height
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0.2),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    blurRadius: 8.0,
                                                    spreadRadius: 2.0,
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            task.statusName ??
                                                                'No Status',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'SFPro',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          Text(
                                                            task.tasks ??
                                                                'No Task Name',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  'SFPro',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        // Grey background circle (100%)
                                                        SizedBox(
                                                          height: 44.0,
                                                          width: 44.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: AllColors
                                                                .greyGoogleForm,
                                                            value: 1.0,
                                                            strokeWidth: 8,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    AllColors
                                                                        .greyGoogleForm),
                                                          ),
                                                        ),
                                                        // Blue progress circle (over the gray one)
                                                        SizedBox(
                                                          height: 44.0,
                                                          width: 44.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: task.tasks !=
                                                                    null
                                                                ? getProgressValue(
                                                                    task.tasks)
                                                                : null,
                                                            strokeWidth: 8,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    AllColors
                                                                        .darkBlue),
                                                          ),
                                                        ),
                                                        // Centered text displaying percentage
                                                        Text(
                                                          task.tasks != null
                                                              ? '${task.tasks!}%'
                                                              : 'No Task Name',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: 'SFPro',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 8.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    ValueListenableBuilder<String>(
                                      valueListenable: selectedReportTab,
                                      builder: (context, selectedTab, _) {
                                        return Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Project Report Tab
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      selectedReportTab.value =
                                                          'ProjectReport';
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 0,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: selectedTab ==
                                                                'ProjectReport'
                                                            ? AllColors
                                                                .mediumPurple
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13),
                                                      ),
                                                      child: Text(
                                                        'Project Report',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: selectedTab ==
                                                                  'ProjectReport'
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Attachments Tab
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      selectedReportTab.value =
                                                          'Attachments';
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 0,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: selectedTab ==
                                                                'Attachments'
                                                            ? AllColors
                                                                .mediumPurple
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13),
                                                      ),
                                                      child: Text(
                                                        'Attachments',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: selectedTab ==
                                                                  'Attachments'
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Credential Tab
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      selectedReportTab.value =
                                                          'Credential';
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 12,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: selectedTab ==
                                                                'Credential'
                                                            ? AllColors
                                                                .mediumPurple
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13),
                                                      ),
                                                      child: Text(
                                                        'Credential',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: selectedTab ==
                                                                  'Credential'
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(thickness: 0.5),
                                            // Content based on selected report tab
                                            if (selectedTab == 'ProjectReport')
                                              Obx(() {
                                                // Access the reports from the TaskReportListViewModel
                                                final reports =
                                                    reportViewModel.reports;
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Project Report List',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  FontFamily
                                                                      .sfPro,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        const Spacer(),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .add_circle_outline_sharp,
                                                            color: AllColors
                                                                .greenJungle,
                                                            // Make sure AllColors.greenJungle is defined
                                                            size: 18,
                                                          ),
                                                          onPressed: () {
                                                            _showDialog(
                                                                context); // Assuming the dialog function is _showDialog
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                    const Divider(
                                                        thickness: 0.5),
                                                    // Display each report
                                                    for (var report in reports)
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                  'Project - '),
                                                              Text(
                                                                  report.title ??
                                                                      'N/A',
                                                                  style: TextStyle(
                                                                      color: AllColors
                                                                          .greenJungle)),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                  'Start Date - ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                              Text(
                                                                  formatDateToYMD(
                                                                      report
                                                                          .startDate),
                                                                  style:
                                                                      const TextStyle()),
                                                              // Use the new formatting function

                                                              const Spacer(),
                                                              const Text(
                                                                  'End Date - ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                              Text(
                                                                  formatDateToYMD(
                                                                      report
                                                                          .endDate),
                                                                  style:
                                                                      const TextStyle()),
                                                              // Use the new formatting function
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                  'Created Date - ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                              Text(
                                                                  formatDateWithCustomFormat(
                                                                      report
                                                                          .createdAt),
                                                                  style:
                                                                      const TextStyle()),
                                                              // Use the new formatting function
                                                            ],
                                                          ),
                                                          const Divider(
                                                              thickness: 0.5),
                                                        ],
                                                      ),
                                                  ],
                                                );
                                              })
                                            else if (selectedTab ==
                                                'Attachments')
                                              Row(
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Add Attachments',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons
                                                          .add_circle_outline_sharp,
                                                      color:
                                                          AllColors.greenJungle,
                                                      // Make sure AllColors.greenJungle is defined
                                                      size: 18,
                                                    ),
                                                    onPressed: () {
                                                      _showDialogs(
                                                          context); // Assuming the dialog function is _showDialog
                                                    },
                                                  )
                                                ],
                                              )
                                            else if (selectedTab ==
                                                'Credential')
                                              const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Project Credentials',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                  Text('Sr No : -'),
                                                  Text('Title : -'),
                                                  Text('User Name: -'),
                                                  Text('Password : -'),
                                                  Text('Url & Attachements : -')
                                                ],
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          );

                        case 'Task':
                          return ProjectOverViewTaskScreen();

                        case 'SequentialTask':
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(
                                      top: 30, left: 15, right: 15, bottom: 30),
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
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Sub SequentialTask',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: FontFamily.sfPro),
                                      ),
                                      const Spacer(),
                                      CustomButton(
                                        borderRadius: 8,
                                        height: 35.0, // Set custom height
                                        width: 45.0, // Set custom width
                                        onPressed: () {},
                                        child: Center(
                                            child: Icon(
                                          Icons.add,
                                          color: AllColors.whiteColor,
                                          size: 18,
                                        )),
                                      )
                                    ],
                                  ))
                            ],
                          );
                        default:
                          return const Center(
                            child: Text(
                              'No valid tab selected',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          );
                      }
                    }),
                  ],
                ),
              )
            : const Center(child: Text('No project data available'));
      }),
    );
  }

  double getProgressValue(String? task) {
    if (task == null || task.isEmpty) {
      return 0.0; // Default to 0.0 if task is null or empty
    }

    // Convert the string to a double and divide by 100 if it represents a percentage.
    double? progress = double.tryParse(task);
    if (progress != null) {
      return progress / 100;
    }

    return 0.0; // Default to 0.0 if parsing fails
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white, // Set the background color to white
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text('Add Report'),
                ),
                const Text('Title'),
                CommonTextField(
                    hintText: 'Enter Title',
                    allowCustomBorderInput: BorderRadius.circular(8)),
                const SizedBox(height: 5), // Adds spacing between the cards
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Start Date *'),
                          CommonTextField(
                            hintText: 'Select start date',
                            controller: _startDateController,
                            isDateField: true, // Mark as a date field
                            isLoading: false, // Set to true if loading
                            allowCustomBorderInput: BorderRadius.circular(8),
                            prefixIcon: const Icon(
                              Icons.date_range,
                              color: Colors.grey,
                              size: 19,
                            ),
                            suffixIcon: const Icon(Icons.clear,
                                color: Colors.grey, size: 19),
                            onSuffixPressed: () {
                              setState(() {
                                _startDateController.clear(); // Clear the date
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10), // Adds spacing between the cards
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('End Date *'),
                          CommonTextField(
                            hintText: 'Select end date',
                            controller: _endDateController,
                            prefixIcon: const Icon(
                              Icons.date_range,
                              color: Colors.grey,
                              size: 19,
                            ),
                            suffixIcon: const Icon(Icons.clear,
                                color: Colors.grey, size: 10),
                            isDateField: true, // Mark as a date field

                            allowCustomBorderInput: BorderRadius.circular(8),

                            isLoading: false, // Set to true if loading
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Text('Title'),
                CommonTextField(
                  hintText: 'Enter Title',
                  allowCustomBorderInput: BorderRadius.circular(
                      8), // Ensure allowCustomInput accepts BorderRadius
                ),
                const SizedBox(height: 5),
                const Text('To : '),
                const SizedBox(height: 5),
                const Text('CC : '),
                const SizedBox(height: 5),
                const Text('Add more CC'),
                CommonTextField(
                    hintText: 'Enter Title',
                    allowCustomBorderInput: BorderRadius.circular(8)),
                const SizedBox(height: 5),
                CommonTextField(
                    hintText: 'Enter Title',
                    allowCustomBorderInput: BorderRadius.circular(8)),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  borderRadius: 8.0,
                  onPressed: () {},
                  child: const Text('Submit'),
                ) // Example with a border radius of 16.0
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDialogs(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Get.back(); // Close the dialog using GetX
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Add Project Attachment',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('Title *'),
                  CommonTextField(
                      hintText: 'Please Add Title',
                      allowCustomBorderInput: BorderRadius.circular(8)),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('Upload Attachments*'),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        top: 30, left: 15, right: 15, bottom: 30),
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
                    child: const Text(' Drop Files here or click to upload'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
