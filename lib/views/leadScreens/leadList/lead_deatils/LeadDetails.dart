import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/views/leadScreens/leadList/lead_deatils/proposals/Unlayer.dart';
import 'package:websuites/views/leadScreens/leadList/lead_deatils/status/Update/LeadStatusDialog.dart';
import '../../../../data/models/responseModels/leads/list/details/LeadDetails.dart';
import '../../../../data/models/responseModels/leads/list/lead_list.dart';
import '../../../../resources/imageStrings/image_strings.dart';
import '../../../../resources/strings/strings.dart';
import '../../../../utils/appColors/app_colors.dart';
import '../../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../../utils/container_Utils/ContainerUtils.dart';
import '../../../../utils/fontfamily/FontFamily.dart';
import '../../../../viewModels/leadScreens/lead_list/detail/LeadDetailsViewModel.dart';
import '../../../../viewModels/leadScreens/lead_list/lead_detail_view/update_status/dead_reason/LeadDetailsStatusDeadReason.dart';
import '../../../homeScreen/home_manager/HomeManagerScreen.dart';
import '../../leadDetails/addProjection/LeadDetailsAddProjectionScreen.dart';
import '../../leadDetails/proforma/LeadProformaCreateScreen.dart';
import '../../leadDetails/task/LeadTaskCreateScreen.dart';
import '../../../../utils/datetrim/DateTrim.dart';
import '../widgets/status_convert_to _custome/LeadCustomerConverStatus.dart';
import 'actionUpdate/LeadActionUpdateCreate.dart';
import 'actionUpdate/assisgned/LeadActivitiesAssignedScreen.dart';
import 'actionUpdate/lead_activities_call/LeadDetailsActiMeetingScreen.dart';
import 'actionUpdate/lead_details_activities_call/LeadDetailsActiCallScreen.dart';
import 'actionUpdate/lead_details_activities_reminder/LeadDetailsActivitiesReminderScreen.dart';
import 'actionUpdate/notes/LeadActivitiesNotesScreen.dart';
import 'add_call/LeadDetailsAddCallScreen.dart';
import 'lead_details_activities_all/LeadDetailsActivitiesAllScreen.dart';


class LeadDetailsController extends GetxController {
  final RxString selectedTab = 'Actions'.obs;
  final RxString selectedButton = 'Call'.obs;
  final RxString selectedActivityFilter = 'All'.obs;


  final LeadDetailsStatusDeadReason _deadReasonController = Get.put(LeadDetailsStatusDeadReason());

  void updateSelectedTab(String tab) => selectedTab.value = tab;

  void updateSelectedButton(String button) => selectedButton.value = button;

  void updateSelectedActivityFilter(String filter) =>
      selectedActivityFilter.value = filter;

  @override
  void onInit() {
    super.onInit();

    _deadReasonController.leadDetailDeadReasonApi(Get.context!);
  }
}

class LeadDetailsScreen extends StatelessWidget {
  final Item? orderItem;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? leadId;

  const LeadDetailsScreen({
    this.leadId,
    super.key,
    this.orderItem,
    required this.scaffoldKey,
  });


  @override
  Widget build(BuildContext context) {

    Get.put(LeadDetailsController());
    final homeController = Get.find<HomeManagerController>();
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    final leadDetailsViewModel = Get.put(LeadDetailsViewModel());
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {

      if (leadDetailsViewModel.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }


      final leadDetails = leadDetailsViewModel.leadDetails.value;
      if (leadDetails == null) {
        return const Center(child: Text("No Lead Data Available"));
      }


      return Column(
        children: [
          CustomAppBar(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
              child: Row(
                children: [
                  if (!isTablet)
                    IconButton(
                      icon: const Icon(Icons.menu,
                          color: Colors.black, size: 25),
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      homeController.resetOrderDetails();
                    },
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.back),
                        const SizedBox(width: 8),
                        Text(
                          "Back to Lead List",
                          style: TextStyle(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.sfPro,
                            fontSize: 17.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Lead Details",
                    style: TextStyle(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 17.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // StatusStepper stays outside the scrollable area
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
            child: LeadStatusStepper(),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Lead Details Card and everything else
                    buildLeadDetailsCard(homeController, leadDetails, context),
                    // Action Buttons
                    const SizedBox(height: 10),
                    ContainerUtils(

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildActionButtons(),
                          const SizedBox(height: 15),
                          Obx(() => buildSelectedTabContent(homeController,context,leadDetails)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    ContainerUtils(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                buildInteractionButton('Call'),
                                const SizedBox(width: 10),
                                buildInteractionButton('Meeting'),
                                const SizedBox(width: 10),
                                buildInteractionButton('Notes'),
                                const SizedBox(width: 10),
                                buildInteractionButton('Reminder'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(() => _buildSelectedContent(homeController, context, leadDetails)),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }));
  }

  Widget buildInteractionButton(String label) {
    final controller = Get.find<LeadDetailsController>();
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.updateSelectedButton(label);
        },
        child: Container(
          alignment: Alignment.center,
          width: label == 'Call' ? 60 : 80,
          height: 30,
          decoration: BoxDecoration(
            color: controller.selectedButton.value == label
                ? AllColors.mediumPurple
                : AllColors.lighterPurple,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: controller.selectedButton.value == label
                  ? AllColors.whiteColor
                  : AllColors.mediumPurple,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }






  ///

  //
  // Widget buildActivitiesContent(HomeManagerController homeController,context,LeadDetailsResponseModel leadDetails) {
  //   final controller = Get.find<LeadDetailsController>();
  //   Widget getFilterContent() {
  //     switch (controller.selectedActivityFilter.value) {
  //       case 'All':
  //         return
  //
  //           LeadDetailsActivitiesAllScreen(leadId: leadDetails.id, leadDetails: leadDetails);
  // ///
  //

  // ... Other imports and code remain unchanged

  Widget _buildSelectedContent(HomeManagerController homeController, context, LeadDetailsResponseModel leadDetails) {
    final controller = Get.find<LeadDetailsController>();
    Widget content;

    switch (controller.selectedButton.value) {
      case 'Call':
        content = LeadDetailsAddCallScreen(
          leadId: leadDetails.id,
          leadDetails: leadDetails,
          useContainerStyling: false, // Pass a flag to control styling
        );
        break;
      case 'Meeting':
        content = Row(
          children: [
            Icon(Icons.calendar_today, color: AllColors.mediumPurple),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Schedule a meeting with ${orderItem?.organization ?? 'N/A'}",
                style: TextStyle(fontSize: 16, color: AllColors.blackColor),
              ),
            ),
          ],
        );
        break;
      case 'Notes':
        content = Row(
          children: [
            Icon(Icons.note_alt_outlined, color: AllColors.mediumPurple),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Add notes for ${orderItem?.organization ?? 'N/A'}",
                style: TextStyle(fontSize: 16, color: AllColors.blackColor),
              ),
            ),
          ],
        );
        break;
      case 'Reminder':
        content = Row(
          children: [
            Icon(Icons.alarm, color: Colors.amber[700]),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Set a reminder for ${orderItem?.organization ?? 'N/A'}",
                style: TextStyle(fontSize: 16, color: AllColors.blackColor),
              ),
            ),
          ],
        );
        break;
      default:
        content = const SizedBox.shrink();
    }

    // Only wrap in Container for non-Call cases to avoid nesting
    if (controller.selectedButton.value != 'Call') {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: AllColors.mediumPurple.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: content,
      );
    }

    return content;
  }

// ... Rest of the LeadDetailsScreen code remains unchanged

  Widget buildProgressIndicator() {
    String status = orderItem?.state ?? 'New';
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: status == 'New'
                  ? AllColors.mediumPurple
                  : AllColors.figmaGrey,
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_right_alt, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: status == 'In Progress'
                  ? Colors.green
                  : AllColors.greenJungle,
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'In Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_right_alt, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: status == 'Converted' ? Colors.blue : Colors.grey,
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Converted',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_right_alt, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLeadDetailsCard(HomeManagerController homeController,
      LeadDetailsResponseModel leadDetails, context) {
    return ContainerUtils(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${leadDetails.firstName ?? 'N/A'}${leadDetails.lastName ?? 'N/A'}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: FontFamily.sfPro,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 3.5),

                child: GestureDetector(

                  child: Image.asset(
                    ImageStrings.edit,
                    height: 17,
                    width: 17,
                    color: AllColors.grey,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),

          // Contact Information
          Row(
            children: [
              Image.asset(
                ImageStrings.email,
                height: 17,
                width: 15.69,
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 9,
                child: Text(
                  leadDetails.email ?? 'No Email',
                  style: TextStyle(
                      color: AllColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.sfPro),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const Spacer(),
              Image.asset(
                ImageStrings.call,
                height: 14,
                width: 15.69,
              ),
              const SizedBox(width: 8),
              Text(
                ('+${leadDetails.countryCode}-${orderItem?.mobile ?? 'No Mobile'}'),
                style: TextStyle(
                    color: AllColors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Baseline(
                baseline: 18, // Same as image height or font size
                baselineType: TextBaseline.alphabetic,
                child: Image.asset(
                  ImageStrings.location,
                  height: 14,
                  width: 15.69,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  leadDetails.address ?? 'Address not provided',
                  style: TextStyle(
                    color: AllColors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Image.asset(
                ImageStrings.hospital,
                height: 17,
                width: 17,
                color: AllColors.gridView,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  leadDetails.organization ?? 'N/A',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      fontFamily: FontFamily.sfPro),
                  // overflow: TextOverflow.ellipsis,
                  // maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Second Business Name
          Row(
            children: [
              Image.asset(
                ImageStrings.send,
                height: 14,
                width: 15.69,
                color: AllColors.mediumPurple,
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                onDoubleTap: () {},
                child: Text(
                  Strings.checkService,
                  style: TextStyle(
                      color: AllColors.vividPurple,
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
           const   Spacer(),
            CircleAvatar(
              radius: 14,
              backgroundColor: Colors.blue,
              child: Image.asset(ImageStrings.call,height: 16,color: Colors.white,),
            ),
             SizedBox(width: 15,),
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.green,
                child: Image.asset(ImageStrings.whatsApp,height: 16,color: Colors.white,),
              )




            ],
          ),
          const SizedBox(height: 15),

          // Tag Buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    homeController.lastScreen.value = LeadProformaCreateScreen(
                      scaffoldKey: scaffoldKey,
                      orderItem: orderItem,
                    );
                    homeController.update();
                  },
                  child: buildTagButton(
                    'Proforma',
                    Icons.mode_comment_outlined,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    homeController.lastScreen.value = LeadTaskCreateScreen(
                      scaffoldKey: scaffoldKey,
                      orderItem: orderItem,
                    );
                    homeController.update();
                  },
                  child: buildTagButton('Task', Icons.add,
                      backgroundColor: AllColors.lightBlue,
                      textColor: AllColors.darkBlue),
                ),
                const SizedBox(width: 10),

                //************************************
                //************************************
                //************************************
                //************************************




                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context, // Use the context from the surrounding widget tree
                      builder: (BuildContext context) {
                        return LeadStatusDialog();
                      },
                    );
                  },
                  child: buildTagButton(
                    'Status',
                    Icons.edit_outlined,
                    backgroundColor: AllColors.statusBackground,
                    textColor: AllColors.greenJungle,
                  ),
                ),







              const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    homeController.lastScreen.value = LeadDetailsAddProjectionScreen(
                      scaffoldKey: scaffoldKey,
                      orderItem: orderItem,
                    );
                    homeController.update();
                  },
                  child: buildTagButton(
                    'Projection',
                    Icons.mode_comment_outlined,
                    backgroundColor: AllColors.microPurple,
                    textColor: AllColors.vividPurple,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 15,
          ),
          const Divider(
            thickness: 0.4,
          ),
          SizedBox(
            height: 15,
          ),

          Row(
            children: [
              Icon(
                Icons.grid_view,
                color: AllColors.gridView,
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                leadDetails.divisions.isNotEmpty
                    ? leadDetails.divisions.first.name ?? 'Not Available'
                    : 'Not Available',
                style: TextStyle(
                  fontSize: 15,
                  color: AllColors.gridView,
                  fontFamily: FontFamily.sfPro,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                decoration: BoxDecoration(
                  color: AllColors.lightRed,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  leadDetails?.type?.name ?? 'Not Available',
                  style: TextStyle(
                    color: AllColors.vividRed,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.sfPro,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Image.asset(
                ImageStrings.date,
                height: 14,
                width: 15.69,
              ),
              SizedBox(width: 10),
              Text(
                formatDateWithTime(leadDetails.createdAt.toString() ?? '0/0'),
                style: TextStyle(fontSize: 14, color: AllColors.mediumPurple),
              ),
              Spacer(),
              Row(
                children: [
                  Image.asset(
                    ImageStrings.circleArrow,
                    height: 14,
                    width: 15.69,
                    color: AllColors.greenJungle,
                  ),
                  SizedBox(width: 8),
                  Text(
                    leadDetails.queryType == 'W'
                        ? 'Direct'
                        : leadDetails.queryType == 'B'
                            ? 'Buy Lead'
                            : 'N/A',
                    style: TextStyle(
                      color: AllColors.greenJungle,
                      fontSize: 14,
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Image.asset(
                ImageStrings.groupPeople,
                height: 17,
                width: 17,
                color: AllColors.grey,
              ),
              SizedBox(width: 10),
              Text(
                'N/A',
                style: TextStyle(
                    fontSize: 14,
                    color: AllColors.grey,
                    fontFamily: FontFamily.sfPro,
                    fontWeight: FontWeight.w400),
              ),
              Spacer(),
              Row(
                children: [
                  Image.asset(
                    ImageStrings.location,
                    height: 15,
                    width: 15,
                    color: AllColors.grey,
                  ),
                  SizedBox(width: 8),
                  Text(
                    leadDetails.source?.name ?? 'N/A',
                    style: TextStyle(
                      fontSize: 14,
                      color: AllColors.grey,
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Image.asset(
                ImageStrings.person,
                height: 15,
                width: 15,
                color: AllColors.darkBlue,
              ),
              SizedBox(width: 10),
              Text(
                '${leadDetails.createdBy?.firstName ?? 'N/A'} ${leadDetails.createdBy?.lastName ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 14,
                  color: AllColors.darkBlue,
                  fontFamily: FontFamily.sfPro,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    color: AllColors.darkYellow,
                    size: 21,
                  ),
                  SizedBox(width: 8),
                  Text(
                    leadDetails.leadToCustomFields
                            .where((field) =>
                                field.fieldName == "aadhar_card number")
                            .isEmpty
                        ? 'Not Available'
                        : leadDetails.leadToCustomFields
                                .firstWhere((field) =>
                                    field.fieldName == "aadhar_card number")
                                .value ??
                            'Not Available',
                    style: TextStyle(
                      fontSize: 14,
                      color: AllColors.darkYellow,
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          //  Row(
          //
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //   Baseline(
          //       baseline: -15, // Same as image height or font size
          //       baselineType: TextBaseline.alphabetic,
          //       child: Image.asset(ImageStrings.descriptionPage,height: 16,width: 16,)),
          //     SizedBox(width: 10),
          //     Expanded(
          //       child: Text(
          //         'Best Homeopathic Treatment in Ahmedabad by Dr. Shital C. Shah a leading Homoeopathy Doctor',
          //         style: TextStyle(fontSize: 16),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }


  Widget buildSelectedTabContent(HomeManagerController homeController,context,LeadDetailsResponseModel leadDetails) {

    final controller = Get.find<LeadDetailsController>();

    switch (controller.selectedTab.value) {
      case 'Actions':

        return Column(
          children: [

            LeadActionUpdateCreate(leadId: leadDetails.id, leadDetails: leadDetails,), // Pass leadId here

          ],
        );

      case 'Activities':
        return buildActivitiesContent(homeController, context, leadDetails);

      case 'Task':
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.task_alt,
                  color: Colors.blue,
                  size: 50,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create and manage tasks for ${orderItem?.organization ?? 'this lead'}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          homeController.lastScreen.value =
                              LeadTaskCreateScreen(
                                scaffoldKey: scaffoldKey,
                                orderItem: orderItem,
                              );
                          homeController.update();
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Add Task',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      case 'Projections':
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.auto_graph,
                  color: AllColors.mediumPurple,
                  size: 50,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Track projected revenue for ${orderItem?.organization ?? 'this lead'}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          homeController.lastScreen.value = LeadDetailsAddProjectionScreen(
                            scaffoldKey: scaffoldKey,
                            orderItem: orderItem,
                          );
                          homeController.update();
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Add Projection',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AllColors.mediumPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );

      case 'Proposal':
        return UnLayer();
      default:
        return const SizedBox.shrink();
    }
  }





  Widget _buildDetailRow({required IconData icon, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: AllColors.grey, fontSize: 16),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget buildTagButton(
    String text,
    IconData icon, {
    Color? backgroundColor,
    Color? textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor ?? AllColors.lightYellow,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor ?? AllColors.yellowGoogleForm),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: textColor ?? AllColors.yellowGoogleForm,
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActionButtons() {
    final controller = Get.find<LeadDetailsController>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildTabButton('Actions'),
          const SizedBox(width: 10),
          _buildTabButton('Activities'),
          const SizedBox(width: 10),
          _buildTabButton('Task'),
          const SizedBox(width: 10),
          _buildTabButton('Projections'),
          const SizedBox(width: 10),
          _buildTabButton('Convert to Customer'),
          const SizedBox(width: 10),
          _buildTabButton('Attachments'),
          const SizedBox(width: 10),
          _buildTabButton('Proposals'),
          const SizedBox(width: 10),
          _buildTabButton('Repeated Leads'),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label) {
    final controller = Get.find<LeadDetailsController>();
    return Obx(
      () =>
          ElevatedButton(
            onPressed: () {
              controller.updateSelectedTab(label);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                return controller.selectedTab.value == label
                    ? AllColors.mediumPurple
                    : AllColors.lighterPurple;
              }),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 11, vertical: 3),
              ),
              minimumSize: MaterialStateProperty.all<Size>(const Size(0, 5)),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: MaterialStateProperty.all<double>(0),
              overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
              enableFeedback: false,
              animationDuration: Duration.zero,
              // Only keep the properties that are actually valid for ButtonStyle
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
              surfaceTintColor: MaterialStateProperty.all<Color>(Colors.transparent),
              foregroundColor: MaterialStateProperty.all<Color>(
                  controller.selectedTab.value == label
                      ? Colors.white
                      : AllColors.mediumPurple
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                // Text style should match the foregroundColor set above
                color: controller.selectedTab.value == label
                    ? Colors.white
                    : AllColors.mediumPurple,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.sfPro,
                fontSize: 14,
              ),
            ),
          )

    );
  }





  Widget buildActivitiesContent(HomeManagerController homeController,context,LeadDetailsResponseModel leadDetails) {
    final controller = Get.find<LeadDetailsController>();
    Widget getFilterContent() {
      switch (controller.selectedActivityFilter.value) {
        case 'All':
          return

            LeadDetailsActivitiesAllScreen(leadId: leadDetails.id, leadDetails: leadDetails);

        case 'Reminder':

          return  LeadDetailsActivitiesReminderScreen(leadId: leadDetails.id, leadDetails: leadDetails);

        case 'Call':
          return    LeadDetailsActiCallScreen(leadId: leadDetails.id, leadDetails: leadDetails);
        case 'Meeting':
          return  LeadDetailsActiMeetingScreen(leadId: leadDetails.id, leadDetails: leadDetails);
        case 'Notes':
       return  LeadActivitiesNotesScreen(leadId: leadDetails.id, leadDetails: leadDetails);

        case 'Assigned':
          return  LeadActivitiesAssignedScreen(leadId: leadDetails.id, leadDetails: leadDetails);
        default:
          return const SizedBox.shrink();
      }
    }

    Widget buildFilterButton(String filterName) {
      return Obx(
        () => GestureDetector(
          onTap: () {
            controller.updateSelectedActivityFilter(filterName);
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 2),
            decoration: BoxDecoration(
              color: controller.selectedActivityFilter.value == filterName
                  ? AllColors.lightBlue
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              filterName,
              style: TextStyle(
                color: controller.selectedActivityFilter.value == filterName
                    ? AllColors.darkBlue
                    : AllColors.grey,
                fontFamily: FontFamily.sfPro,
                fontSize: 14,
                fontWeight:
                    controller.selectedActivityFilter.value == filterName
                        ? FontWeight.w400
                        : FontWeight.w400,
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Divider(thickness: 0.4,),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildFilterButton('All'),
                const SizedBox(width: 10),
                buildFilterButton('Reminder'),
                const SizedBox(width: 10),
                buildFilterButton('Call'),
                const SizedBox(width: 10),
                buildFilterButton('Meeting'),
                const SizedBox(width: 10),
                buildFilterButton('Notes'),
                const SizedBox(width: 10),
                buildFilterButton('Assigned'),
              ],
            ),
          ),

          const SizedBox(height: 15),
          Obx(() => getFilterContent()),
        ],
      ),
    );
  }

  Widget buildReportingSection() {
    return Row(
      children: [
        const Text(
          'REPORTING TO',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.5,
              fontFamily: FontFamily.sfPro),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            '- N/A',
            style: TextStyle(
              color: AllColors.grey,
              fontFamily: FontFamily.sfPro,
              fontWeight: FontWeight.w400,
              fontSize: 15.5,
            ),
          ),
        ),
      ],
    );
  }




}
