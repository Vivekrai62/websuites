import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/views/reports/taskreport/taskdetails/projectoverview/ProjectOverView.dart';
import '../../../../../utils/datetrim/DateTrim.dart';
import '../../../../resources/strings/strings.dart';
import '../../../../resources/textStyles/text_styles.dart';
import '../../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../../utils/container_Utils/ContainerUtils.dart';
import '../../../../utils/fontfamily/FontFamily.dart';

import '../../../../utils/responsive/responsive_utils.dart';
import '../../../../viewModels/leadScreens/createNewLead/assignedLeadTo/assigned_lead_to_viewModel.dart';
import '../../../homeScreen/home_manager/HomeManagerScreen.dart';
import '../../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> taskItem; // Accepting task data
  final GlobalKey<ScaffoldState>? scaffoldKey; // Add this if needed

  const TaskDetailsScreen({
    super.key,
    required this.taskItem,
    this.scaffoldKey,
  });

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  bool isStarted = false;
  final AssignedLeadToViewModel _assignedLeadToController =
      Get.put(AssignedLeadToViewModel());
  final homeController = Get.find<HomeManagerController>();

  @override
  void initState() {
    super.initState();

    //
    // _assignedLeadToController
    //     .fetchAssignedLeads(context); // Ensure this is called
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
        backgroundColor: Colors.white,

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
                          widget.scaffoldKey?.currentState
                              ?.openDrawer(); // Use widget.scaffoldKey
                        },
                      ),
                    if (isTablet) const SizedBox(width: 10),
                    Text(
                      'Task Details',
                      style: TextStyle(
                        color: AllColors.blackColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 17.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                  child: Column(
                    children: [
                      ContainerUtils(


                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [

                                    InkWell(
                                      onTap: () {
                                        homeController.resetOrderDetails();
                                      },
                                      child: const Icon(Icons.arrow_back_outlined, size: 22,),
                                    ),

                                    const SizedBox(width: 8),
                                    const Text(
                                      "Back Task",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontFamily.sfPro,
                                          color: Colors.black87),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                  Image.asset(ImageStrings.edit,height: 17,width: 17,),
                                    SizedBox(width: 15,),
                                    Icon(Icons.copy,
                                        color: Colors.black, size: 17),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),



                            const Divider(thickness: 0.5),
                            SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Task Duration : ',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: FontFamily
                                        .sfPro, // Correctly references FontFamily.sfPro
                                  ),
                                ),
                                Text(widget.taskItem['duration'] ?? 'N/A',
                                    style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: FontFamily.sfPro,
                                    )),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // Toggle the state when tapped
                                      isStarted = !isStarted;
                                    });
                                    print(
                                        isStarted ? "Task Started" : "Task Stopped");
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 2.5),
                                    decoration: BoxDecoration(
                                      color: isStarted
                                          ? Colors.red
                                          : AllColors
                                          .greenJungle, // Change color based on state
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      isStarted ? 'Stop' : 'Start',
                                      // Change text based on state
                                      style: TextStyle(
                                        color: AllColors.whiteColor,
                                        fontSize: 14,
                                        fontFamily: FontFamily.sfPro,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'End On - ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontFamily.sfPro),
                                    ),
                                    Text(
                                      formatDate(widget.taskItem['endOn']),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: FontFamily.sfPro,
                                          color: AllColors.figmaGrey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Start On - ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontFamily.sfPro),
                                    ),
                                    Text(
                                      formatDate(widget.taskItem['startOn']),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: FontFamily.sfPro,
                                          color: AllColors.figmaGrey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Task Type - ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w600,
                                      color: AllColors.blackColor

                                    ),
                                    children: [
                                      TextSpan(
                                        text: widget.taskItem['taskType'] ?? 'N/A',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AllColors.figmaGrey,
                                          fontFamily: FontFamily.sfPro,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Subject - ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: FontFamily.sfPro,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            widget.taskItem['subject'] ??
                                                'No task subject',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AllColors.vividPurple,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: FontFamily.sfPro),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  flex: 0,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Status - ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: FontFamily.sfPro,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        widget.taskItem['status'] ?? 'N/A',
                                        style: TextStyle(
                                            color: AllColors.greenishYellow,
                                            fontSize: 14,
                                            fontFamily: FontFamily.sfPro),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Deadline - ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: FontFamily.sfPro,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      widget.taskItem['deadline'] ?? 'N/A',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Priority -   ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: FontFamily.sfPro,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 1.8),
                                      decoration: BoxDecoration(
                                        color: AllColors.thinOrange,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        widget.taskItem['priority'] != null &&
                                            widget.taskItem['priority'].isNotEmpty
                                            ? '${widget.taskItem['priority'][0].toUpperCase()}${widget.taskItem['priority'].substring(1)}'
                                            : 'N/A',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AllColors.darkYellow,
                                          fontFamily: FontFamily.sfPro,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  'Assigned To - ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: FontFamily.sfPro,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Flexible(
                                  flex: 9,
                                  child: Text(
                                    widget.taskItem['assignedTo'] ?? 'N/A',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: FontFamily.sfPro,
                                        fontWeight: FontWeight.w400,
                                        color: AllColors.figmaGrey),
                                    overflow: TextOverflow.ellipsis,
                                    // Ensure text is ellipsed if too long
                                    softWrap:
                                    true, // Allows text to wrap onto next line if too long
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  'Created By - ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: FontFamily.sfPro,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Flexible(
                                  flex: 9,
                                  child: Text(
                                    widget.taskItem['createdBy'] ?? 'N/A',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: FontFamily.sfPro,
                                        fontWeight: FontWeight.w400,
                                        color: AllColors.figmaGrey),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      ContainerUtils(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Related to Project',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: FontFamily.sfPro,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Image.asset(
                                  'assets/icons/edit.png',
                                  color: AllColors.darkGrey,
                                  height: 17,
                                  width: 16,
                                )
                              ],
                            ),
                            const Divider(thickness: 0.5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Project Name - ',
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    fontFamily: FontFamily.sfPro,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Flexible(
                                  flex: 8,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProjectOverview(
                                            projectId: widget.taskItem['projectId'] ??
                                                '', // Ensure this is the correct projectId
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      widget.taskItem['projectName'] ?? 'N/A',
                                      style: TextStyle(
                                        fontSize: 17.5,
                                        color: AllColors.vividPurple,
                                        fontFamily: FontFamily.sfPro,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Start Date - ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontFamily.sfPro),
                                    ),
                                    Text(widget.taskItem['projectStartDate'] ?? 'N/A',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: FontFamily.sfPro,
                                            color: AllColors.figmaGrey))
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'End Date - ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontFamily.sfPro),
                                    ),
                                    Text(widget.taskItem['projectEndDate'] ?? 'N/A',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: FontFamily.sfPro,
                                            color: AllColors.figmaGrey))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: ContainerUtils(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Add New Remark',
                                  style: TextStyle(
                                      fontSize: 16.5,
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w700)),
                              const Divider(height: 32, thickness: 0.5),
                              Text('Remark',
                                  style: TextStyle(
                                      color: AllColors.figmaGrey, fontSize: 15.0)),
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                height: ResponsiveUtilsScreenSize.isMobile(context)
                                    ? MediaQuery.of(context).size.height /
                                    12 // Increased height
                                    : MediaQuery.of(context).size.height /
                                    8, // Increased height
                                width: double.infinity,
                                child: TextFormField(
                                  maxLines: null,
                                  // Allow multiple lines
                                  expands: true,
                                  // Expand to fill container
                                  textAlignVertical: TextAlignVertical.top,
                                  // Align text to top
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        top: 15, // Add more top padding
                                        right: 10,
                                        bottom: 10),
                                    hintText: 'Remark...',
                                    hintStyle: TextStyle(
                                      fontSize: 14, // Slightly larger font
                                      color: AllColors.lighterGrey,
                                    ),
                                    hintMaxLines: 3,
                                    // Allow hint to wrap
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AllColors.lightGrey,
                                        width: 0.3,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AllColors.mediumPurple,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AllColors.lightGrey,
                                        width: 0.3,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                // Adjust the value as needed
                                child: const Text(
                                  'Notified To',
                                  style:
                                  TextStyle(color: Colors.grey, fontSize: 16.0),
                                ),
                              ),
                              CommonTextField(
                                hintText: _assignedLeadToController
                                    .selectedLeadName.value.isEmpty
                                    ? Strings.select
                                    : _assignedLeadToController
                                    .selectedLeadName.value,
                                categories: _assignedLeadToController.namesOnlyRxList,
                                // Use names only list
                                onCategoryChanged: (selectedCategory) {
                                  // Handle selection for only first and last name
                                  final names =
                                  selectedCategory.split(' '); // Split by space
                                  if (names.length >= 2) {
                                    final firstName = names[0];
                                    final lastName = names[1];
                                    _assignedLeadToController.selectedLeadName.value =
                                    '$firstName $lastName';
                                  }
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AllColors.greenJungle,
                                  minimumSize: const Size(0, 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        19), // Adjust the radius as needed
                                  ),
                                ),
                                child: Text(
                                  'Create',
                                  style: TextStyle(
                                    color: AllColors.whiteColor,
                                    fontSize: 12,
                                    fontFamily: FontFamily.sfPro,
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
              ),
            ),
          ],
        ));
  }
}
