import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/utils/components/widgets/appBar/custom_appBar.dart';
import 'package:websuites/views/customerScreens/customerList/customerdetails/payments/customer_details_payment_screen.dart';
import 'package:websuites/views/customerScreens/customerList/customerdetails/projects/customer_details_project_screen.dart' hide CustomerDetailsPaymentsScreen;
import 'package:websuites/views/customerScreens/customerList/customerdetails/service_area/customer_details_service_area_screen.dart';
import 'package:websuites/views/customerScreens/customerList/customerdetails/services/customer_details_services_screen.dart';
import '../../../../data/models/responseModels/customers/list/customer_detail_view/list/customer_list_detail_view_list_response_model.dart';
import '../../../../resources/iconStrings/icon_strings.dart';
import '../../../../resources/imageStrings/image_strings.dart';
import '../../../../resources/strings/strings.dart';
import '../../../../resources/svg/svg_string.dart';
import '../../../../resources/textStyles/responsive/test_responsive.dart';
import '../../../../utils/container_Utils/ContainerUtils.dart';
import '../../../../utils/dark_mode/dark_mode.dart';
import '../../../../utils/datetrim/DateTrim.dart';
import '../../../../utils/responsive/responsive_utils.dart';
import '../../../../viewModels/customerScreens/customer_list/customer_detail_view/list/customer_detail_view_list_model.dart';
import '../../../homeScreen/home_manager/HomeManagerScreen.dart';
import 'activities/all/customer_details_activities_all_screen.dart';
import 'activities/assigned/customer_details_activities_assigned_sceen.dart';
import 'activities/attachements/customer_details_attachments_screen.dart';
import 'activities/call/customer_details_activites_call_screen.dart';
import 'activities/meeting/customer_details_meeting_screen.dart' hide CustomerDetailsActivitiesCallScreen;
import 'activities/notes/customer_details_activities_notes_screen.dart';
import 'activities/reminder/customer_details_activities_reminder_screen.dart';
import 'activities/visit_only/customer_details__activities_visit_only_screen.dart';
import 'create_projetion/create_projection_screen.dart';
import 'customer_assigned/customer_assigned_screen.dart';
import 'customer_performa/customer_performa_create_screen.dart';
import 'customer_to_customer_merge/customer_to_customer_merge_screen.dart';
import 'lead/customer_details_lead_screen.dart';
import 'orders/customers_details_order_screen.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final String customerId;
  final CustomerListDetailViewListResponseModel? customerData;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final dynamic orderItem;

  const CustomerDetailsScreen({
    super.key,
    required this.customerId,
    this.customerData,
    required this.scaffoldKey,
    this.orderItem,
  });

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final homeController = Get.find<HomeManagerController>();
  final viewModel = Get.find<CustomerListDetailViewListModel>();
  CustomerListDetailViewListResponseModel? currentCustomerData;
  bool isLoading = false;
  String selectedTab = "Activities";
  String selectedSubTab = "All";
  String selectedInteraction = "Call";
  bool showAllCallsText = true;

  @override
  void initState() {
    super.initState();
    _initializeCustomerData();
  }

  Future<void> _initializeCustomerData() async {
    if (widget.customerData != null) {
      currentCustomerData = widget.customerData;
      if (mounted) setState(() => isLoading = false);
    } else {
      setState(() => isLoading = true);
      final minLoadingFuture =
      Future.delayed(const Duration(milliseconds: 500));
      try {
        currentCustomerData =
        await viewModel.customerDetailViewList(context, widget.customerId);
        homeController.selectedCustomerDetail.value = currentCustomerData;
        await minLoadingFuture;
        if (mounted) setState(() => isLoading = false);
      } catch (e) {
        await minLoadingFuture;
        if (mounted) {
          setState(() => isLoading = false);
        }
      }
    }
  }


  void _showMergeOptionsDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            constraints: BoxConstraints(
              maxWidth: 400, // Maximum width for larger screens
            ),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: DarkMode.backgroundColor(context),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with title and close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        Strings.selectMergeType,
                        style: _textStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),


                SizedBox(

                  width: double.infinity,
                  child: CommonButton(
                    onPress: () {
                      Navigator.pop(context);
                      homeController.lastScreen.value = CustomerToCustomerMerge(
                        scaffoldKey: widget.scaffoldKey,
                        orderItem: null,
                        customerId: widget.customerId,
                        customerData: currentCustomerData,
                      );
                      homeController.update();
                    },
                    width: double.infinity,

                    color: AllColors.vividPurple,
                    borderRadius: 8,
                    title: Strings.customerToCustomerMerge,
                    fontSize: 15,
                    height: 35,
                  ),
                ),
                const SizedBox(height: 12),


                SizedBox(
                  width: double.infinity,
                  child: CommonButton(
                    onPress: () {
                      Navigator.pop(context);
                      homeController.lastScreen.value = CustomerToCustomerMerge(
                        scaffoldKey: widget.scaffoldKey,
                        orderItem: null,
                        customerId: widget.customerId,
                      );
                      homeController.update();
                    },
                    width: double.infinity,

                    color: AllColors.greenJungle,
                    borderRadius: 8,
                    title:  Strings.customerToLeadMerge,
                    fontSize: 15,
                    height: 35,
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery
        .of(context)
        .size
        .width > 600;

    return Scaffold(
      backgroundColor: DarkMode.backgroundColor(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          CustomAppBar(
            child: Row(
              children: [
                // if (ResponsiveUtilsScreenSize.isMobile(context))
                  GestureDetector(
                    onTap: () => homeController.resetOrderDetails(),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.back,
                          color: DarkMode.backgroundColor2(context),),
                        const SizedBox(width: 8),
                        ResponsiveText.getAppBarTextSize(context, Strings.back),
                      ],
                    ),
                  ),
                // if (ResponsiveUtilsScreenSize.isMobile(context))
                //   SizedBox(width: 10,),
                Spacer(),
                ResponsiveText.getAppBarTextSize(context, Strings.cusDe),


              ],
            ),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) return _buildLoading();
    if (currentCustomerData == null) return _buildError();
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomerDetailsCard(),
          _buildScrollableContent(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLoading() =>
      Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AllColors.mediumPurple)),
      );

  Widget _buildError() =>
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: AllColors.darkRed, size: 40),
            const SizedBox(height: 16),
            Text(Strings.failed,
                style: _textStyle(color: AllColors.grey, fontSize: 14,)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  setState(() {
                    isLoading = true;
                    _initializeCustomerData();
                  }),
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColors.mediumPurple,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text('Retry',
                  style: _textStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      );

  Widget _buildCustomerDetailsCard() =>
      ContainerUtils(
        paddingTop: 19,
        paddingRight: 14,
        paddingLeft: 14,
        paddingBottom: 26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomerName(),
            const SizedBox(height: 8),
            _buildCustomerContactInfo(),
            const SizedBox(height: 11),
            _buildCustomerAddress(),
            const SizedBox(height: 8),
            _buildCustomerCompany(),
            const SizedBox(height: 8),
            _buildCustomerActions(),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      homeController.lastScreen.value =
                          CustomerProformaCreateScreen(
                            scaffoldKey: widget.scaffoldKey,
                            customerId: widget.customerId,
                          );
                      homeController.update();
                    },
                    child:
                    buildTagButton(
                      textColor: AllColors.darkYellow,
                      color: AllColors.lightYellow,
                      Strings.proforma,
                      SvgIcon(
                        assetPath: IconStrings.commentsEdit,
                        size: 9.0, // Adjust size as needed
                        color:AllColors.darkYellow
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      LeadAssignmentBottomSheet.show(
                        context,
                        [widget.customerId],
                            (leadId) {},
                      );
                    },
                    child:
                    buildTagButton(

                      'Assigned',
                      SvgIcon(
                        assetPath: IconStrings.add,
                        size: 9.0, // Adjust size as needed
                        color: AllColors.darkBlue
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      homeController.lastScreen.value =
                          CustomerCreateProjectionScreen(
                            scaffoldKey: widget.scaffoldKey,
                            orderItem: null,
                            customerId: widget.customerId,
                          );
                      homeController.update();
                    },
                    child:
                    buildTagButton(
                      textColor: AllColors.mediumPurple,
                      color: AllColors.microPurple,
                      Strings.projection,
                      SvgIcon(
                        assetPath: IconStrings.commentsEdit,
                        size: 9.0, // Adjust size as needed
                        color: AllColors.mediumPurple,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _showMergeOptionsDialog,
                    child: buildTagButton(
                      color: AllColors.background_green,
                      textColor: AllColors.text__green,
                      Strings.merge,
                      SvgIcon(
                        assetPath: IconStrings.arrowCircle,
                        size: 9.0,
                        color: AllColors.text__green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7.5),
            const Divider(thickness: 0.4),
            const SizedBox(height: 7.5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: currentCustomerData!.divisions.asMap().entries.map((entry) {
                final index = entry.key;
                final division = entry.value;

                return Row(
                   // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index == 0) // 👈 icon sirf 0 index pe dikhega
                      SvgIcon(
                        assetPath: IconStrings.dashboard,
                        size: 14.0,
                        color: DarkMode.subTitleColor(context),
                      )
                    else
                      const SizedBox(width: 11.0),
                    const SizedBox(width: 11),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResponsiveText.getTitle(context, division.name.toString(),
                          fontSize: 13,

                        ),
                      ],
                    )
                  ],
                );
              }).toList(),
            ),
          const SizedBox(height: 8),
            _buildCustomerMetaInfo(),

          ],
        ),
      );

  Widget _buildCustomerName() =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:
            // Text(
            //   '${currentCustomerData!.firstName ?? 'N/A'} ${currentCustomerData!.lastName ?? 'N/A'}',
            //   style: _textStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w700,
            //     color: DarkMode.backgroundColor2(context)
            //   ),
            //   overflow: TextOverflow.ellipsis,
            //   maxLines: 2,
            //
            // ),

            ResponsiveText.getTitleText(context,
              '${currentCustomerData!.firstName ?? 'N/A'} ${currentCustomerData!
                  .lastName ?? 'N/A'}',
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: SvgIcon(
              assetPath: IconStrings.editOpp,
              size: 17.0,
              color: DarkMode.editColor(context),
            ),
          ),
        ],
      );

  Widget _buildCustomerContactInfo() =>
      Row(
        children: [
          SvgIcon(
            assetPath: IconStrings.email,
            size: 14.0,
            color: DarkMode.subTitleColor(context),
          ),
          const SizedBox(width: 8),
          Expanded(
              flex: 9,
              child:
              ResponsiveText.getEmailTitle(
                context,
                currentCustomerData?.primaryEmail?.toLowerCase() ?? 'No Email',
              )


          ),
          const Spacer(),
          SvgIcon(
            assetPath: IconStrings.phone,
            size: 14.0,
            color: DarkMode.subTitleColor(context),
            // color: AllColors.,
          ),
          const SizedBox(width: 8),

          ResponsiveText.getMobileTitle(context,
              '+${currentCustomerData!.countryCode ?? ''}-${currentCustomerData!
                  .primaryContact ?? 'No Mobile'}')
        ],
      );

  Widget _buildCustomerAddress() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Baseline(
            baseline: 15.5,
            baselineType: TextBaseline.alphabetic,
            child:
            SvgIcon(
              assetPath: IconStrings.location,
              size: 14.0,
              color: DarkMode.subTitleColor(context),
              // color: AllColors.,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:
            ResponsiveText.getSubTitle(
                context,
                currentCustomerData!.primaryAddress ?? 'Address not provided'
            ),
          ),
        ],
      );

  Widget _buildCustomerCompany() =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Baseline(
            baseline: 18,
            baselineType: TextBaseline.alphabetic,
            child: SvgIcon(
              assetPath: IconStrings.building,
              size: 16,
              color: DarkMode.building(context),
              // color: AllColors.,
            ),
          ),
          // getHeader
          const SizedBox(width: 7.5),
          Expanded(
            child:
            ResponsiveText.getHeader(
                context,
                currentCustomerData!.companies.isNotEmpty
                    ? currentCustomerData!.companies
                    .map((c) => c.companyName ?? 'N/A')
                    .join(', ')
                    : 'No company'
            ),
          ),
        ],
      );

  Widget _buildCustomerActions() =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Image.asset(ImageStrings.send,
              height: 14, width: 15.69, color: AllColors.mediumPurple),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {},
            child:
            ResponsiveText.getDateTitle(
                fontSize: 12,
                context,
                Strings.checkService
            ),
          ),
          const Spacer(),
          SvgIcon(
            assetPath: IconStrings.leadCall,
            size: 18,
            color: DarkMode.leadCall(context),
            // color: AllColors.,
          ),
          const SizedBox(width: 20),
          SvgIcon(
            assetPath: IconStrings.whatsApp,
            size: 18,
            color: DarkMode.whatsApp(context),
            // color: AllColors.,
          ),


        ],
      );

  Widget _buildCustomerMetaInfo() =>
      Column(
        children: [
          Row(
            children: [
              SvgIcon(
                assetPath: IconStrings.calender,
                size: 12,
                color: DarkMode.mobileColor(context),
              ),
              const SizedBox(width: 10),

              ResponsiveText.getDateTitle(context, '${formatDateWithTime(  currentCustomerData!.createdAt?.toString() ?? 'N/A')}',
              ),
              const Spacer(),
              SvgIcon(
                assetPath: IconStrings.documents,
                size: 12.0,
                color: AllColors.yellowGoogleForm,
              ),
              const SizedBox(width:9),
              ResponsiveText.getTitle(context, currentCustomerData?.gstin,
               fontWeight: FontWeight.w400,
                color: AllColors.yellowGoogleForm,
                fontSize: 12,


              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SvgIcon(
                assetPath: IconStrings.assigned,
                size: 15.0,
                color: AllColors.figmaGrey,
              ),
              const SizedBox(width: 11),

              ResponsiveText.getTitle
                (context,   currentCustomerData!.customerAssigned.isNotEmpty
                  ? currentCustomerData!.customerAssigned
                  .map((ca) =>
              '${ca.user?.firstName ?? ''} ${ca.user?.lastName ?? ''}')
                  .join(', ')
                  : 'No assignees',
                fontWeight: FontWeight.w400,
                color: AllColors.figmaGrey,
                   fontSize: 12,
              ),
              Spacer(),
              SvgIcon(
                assetPath: IconStrings.navAccount3,
                size: 12.0,
                color: AllColors.darkBlue,
              ),
              const SizedBox(width: 9),


              ResponsiveText.getTitle
                (context,  currentCustomerData!.customerType ?? 'N/A',
                fontWeight: FontWeight.w400,
                color: AllColors.darkBlue,
                fontSize: 12,
              ),
            ],
          ),
          const SizedBox(height: 8),

        ],
      );

  Widget _buildScrollableContent() =>
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerUtils(child: _buildTabsSection()),
              const SizedBox(height: 5),
              ContainerUtils(child: _buildInteractionSection()),
            ],
          ),
        ),
      );

  Widget _buildTabsSection() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                'Activities',
                'Services',
                'Services Area',
                'Payments',
                'Projects',
                'Activation List',
                'Leads',
                'Orders',
                'Credit-Debit Notes',
                'Attachments'
              ]
                  .map((label) =>
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _buildTabButton(label),
                  ))
                  .toList(),
            ),
          ),
          if (selectedTab == 'Activities')
            _buildActivitiesContent(),
          if (selectedTab == 'Services')
            CustomerDetailsServicesScreen(customerId: widget.customerId,),

          if (selectedTab == 'Services Area')
            CustomerDetailsServicesAreaScreen(customerId: widget.customerId,),

          if (selectedTab == 'Payments')
            CustomerDetailsPaymentsScreen(customerId: widget.customerId,),
          if (selectedTab == 'Projects')
            CustomerDetailsProjectScreen(customerId: widget.customerId,),
          if (selectedTab == 'Leads')
            CustomerDetailsLeadsScreen(customerId: widget.customerId,),
          if (selectedTab == 'Orders')
            CustomersDetailsOrderScreen(customerId: widget.customerId,),

          if (selectedTab == 'Attachments')
            CustomerDetailsAttachmentsScreen(customerId: widget.customerId)


        ],
      );

  Widget _buildActivitiesContent() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(
            thickness: 0.4,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                'All',
                'Call',
                'Meeting',
                'Visit Only',
                'Reminders',
                'Notes',
                'Assigned History'
              ]
                  .map((label) =>
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildSubTabButton(label),
                  ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getContentForSubTab(selectedSubTab),
            ],
          ),
        ],
      );

  Widget _getContentForSubTab(String subTab) {
    switch (subTab) {
      case 'All':
        final customerId = currentCustomerData?.id;
        if (customerId == null || customerId.isEmpty) {
          return Center(
            child: Text(
              'Customer ID not available',
              style: _textStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }
        return CustomerDetailsActivitiesAllScreen(customerId: customerId,);

      case 'Call':
        final customerId = currentCustomerData?.id;
        if (customerId == null || customerId.isEmpty) {
          return Center(
            child: Text(
              'Customer ID not available',
              style: _textStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }
        return CustomerDetailsActivitiesCallScreen(customerId: customerId,);


      case 'Meeting':
        final customerId = currentCustomerData?.id;
        if (customerId == null || customerId.isEmpty) {
          return Center(
            child: Text(
              'Customer ID not available',
              style: _textStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }
        return CustomerDetailsActivitiesMeetingScreen(customerId: customerId);

      case 'Visit Only':
        final customerId = currentCustomerData?.id;
        if (customerId == null || customerId.isEmpty) {
          return Center(
            child: Text(
              'Customer ID not available',
              style: _textStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }
        return CustomerDetailsVisitOnlyScreen(customerId: customerId);

      case 'Reminders':
        final customerId = currentCustomerData?.id;
        if (customerId == null || customerId.isEmpty) {
          return Center(
            child: Text(
              'Customer ID not available',
              style: _textStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }
        return CustomerDetailsActivitiesReminderScreen(customerId: customerId,);

      case 'Notes':
        final customerId = currentCustomerData?.id;
        if (customerId == null || customerId.isEmpty) {
          return Center(
            child: Text(
              'Customer ID not available',
              style: _textStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }
        return CustomerDetailsActivitiesNotesScreen(customerId: customerId,);

      case 'Assigned History':
        final customerId = currentCustomerData?.id;
        if (customerId == null || customerId.isEmpty) {
          return Center(
            child: Text(
              'Customer ID not available',
              style: _textStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }
        return CustomerDetailsActivitiesAssignedScreen(customerId: customerId,);

      default:
        return Text('Activities Content', style: _textStyle(fontSize: 16));
    }
  }

  // Widget _buildTabContent(String tab) => Container(
  //       height: 200,
  //       // decoration: BoxDecoration(
  //       //   border: Border.all(color: AllColors.mediumPurple.withOpacity(0.5)),
  //       //   borderRadius: BorderRadius.circular(12),
  //       // ),
  //       child: Center(child: Text('$tab Content')),
  //     );

  Widget _buildInteractionSection() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Call', 'Meeting', 'Notes', 'Reminder']
                  .map((label) =>
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildInteractionButton(label),
                  ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          _buildInteractionContent(),
        ],
      );

  Widget _buildInteractionContent() =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: AllColors.mediumPurple),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getInteractionIcon(selectedInteraction),
                    color: AllColors.mediumPurple),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _getInteractionTitle(selectedInteraction),
                    style: _textStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _getInteractionContent(selectedInteraction),
          ],
        ),
      );

  IconData _getInteractionIcon(String interaction) {
    switch (interaction) {
      case 'Call':
        return Icons.phone;
      case 'Meeting':
        return Icons.meeting_room;
      case 'Notes':
        return Icons.note;
      case 'Reminder':
        return Icons.alarm;
      default:
        return Icons.info;
    }
  }

  String _getInteractionTitle(String interaction) {
    switch (interaction) {
      case 'Call':
        return 'Add a call for ${currentCustomerData?.firstName ?? 'Customer'}';
      case 'Meeting':
        return 'Schedule a meeting for ${currentCustomerData?.firstName ??
            'Customer'}';
      case 'Notes':
        return 'Add notes for ${currentCustomerData?.firstName ?? 'Customer'}';
      case 'Reminder':
        return 'Set a reminder for ${currentCustomerData?.firstName ??
            'Customer'}';
      default:
        return 'Interaction';
    }
  }

  Widget _getInteractionContent(String interaction) {
    switch (interaction) {
      case 'Call':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Call Notes',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColors.mediumPurple,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text('Log Call',
                  style: _textStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        );
      case 'Meeting':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Meeting Agenda',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Meeting Date and Time',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2026),
                );
                if (picked != null) {
                  // Handle date selection
                }
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColors.mediumPurple,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text('Schedule Meeting',
                  style: _textStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        );
      case 'Notes':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Note Content',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColors.mediumPurple,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text('Save Note',
                  style: _textStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        );
      case 'Reminder':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Reminder Description',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Reminder Date and Time',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: const Icon(Icons.alarm),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2026),
                );
                if (picked != null) {
                  // Handle date selection
                }
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColors.mediumPurple,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text('Set Reminder',
                  style: _textStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        );
      default:
        return Text('Select an interaction type',
            style: _textStyle(fontSize: 16));
    }
  }

  Widget _buildInteractionButton(String label) =>
      ElevatedButton(
        onPressed: () =>
            setState(() {
              selectedInteraction = label;
            }),
        style: _buttonStyle(
          selectedInteraction == label
              ? AllColors.mediumPurple
              : AllColors.lighterPurple,
          selectedInteraction == label
              ? AllColors.whiteColor
              : AllColors.mediumPurple,
        ),
        child: Text(
          label,
          style: _textStyle(
            color: selectedInteraction == label
                ? AllColors.whiteColor
                : AllColors.mediumPurple,
            fontSize: 14,
          ),
        ),
      );

  ButtonStyle _buttonStyle(Color bgColor, Color fgColor) =>
      ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 11, vertical: 3)),
        minimumSize: MaterialStateProperty.all(const Size(0, 5)),
        elevation: MaterialStateProperty.all(0),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(fgColor),
      );

  TextStyle _textStyle(
      {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
        color: color ?? AllColors.welcomeColor,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontFamily: FontFamily.sfPro,
        letterSpacing: 0
      );

  Widget _buildTabButton(String label) =>
      ElevatedButton(
        onPressed: () =>
            setState(() {
              selectedTab = label;
              if (label == 'Activities') {
                selectedSubTab = 'All';
                showAllCallsText = true;
              } else {
                showAllCallsText = false;
              }
            }),
        style: _buttonStyle(
          selectedTab == label
              ? AllColors.mediumPurple
              : AllColors.lighterPurple,
          selectedTab == label ? Colors.white : AllColors.mediumPurple,
        ),
        child: Text(
          label,
          style: _textStyle(
            color: selectedTab == label ? Colors.white : AllColors.mediumPurple,
            fontSize: 14,
          ),
        ),
      );

  Widget _buildSubTabButton(String label) =>
      ElevatedButton(
        onPressed: () =>
            setState(() {
              selectedSubTab = label;
              showAllCallsText = label == 'All';
            }),
        style: _buttonStyle(
          selectedSubTab == label
              ? AllColors.lightBlue
              : AllColors.lighterPurple,
          selectedSubTab == label ? AllColors.darkBlue : AllColors.mediumPurple,
        ),
        child: Text(
          label,
          style: _textStyle(
            color: selectedSubTab == label
                ? AllColors.darkBlue
                : AllColors.mediumPurple,
            fontSize: 14,
          ),
        ),
      );
  Widget buildTagButton(
      String label,
      Widget icon, {
        Color? color,
        Color? textColor,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: color ?? Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 0,
              fontFamily: FontFamily.sfPro,
              fontWeight: FontWeight.w400,
              color: textColor ?? Colors.blue, // default to blue text
            ),
          ),
        ],
      ),
    );
  }


}