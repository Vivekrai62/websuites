import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/responseModels/leads/list/lead_list.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import 'package:websuites/views/leadScreens/leadList/widgets/manat.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../resources/imageStrings/image_strings.dart';
import '../../../resources/strings/strings.dart';
import '../../../resources/svg/svg_string.dart';
import '../../../resources/textStyles/responsive/test_responsive.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datafilter/SeletDateFilter.dart';
import '../../../utils/filter_button/filter_buttons.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../utils/responsive/responsive_utils.dart';
import '../../../viewModels/leadScreens/createNewLead/constant_controller/constant_controller.dart';
import '../../../viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import '../../../viewModels/leadScreens/createNewLead/source/source_view_model.dart';
import '../../../viewModels/leadScreens/lead_list/column/column_list/lead_list_column_list_view_model.dart';
import '../../../viewModels/leadScreens/lead_list/delete/LeadDeleteViewmodel.dart';
import '../../../viewModels/leadScreens/lead_list/detail/LeadDetailsViewModel.dart';
import '../../../viewModels/leadScreens/lead_list/filter/city/city.dart';
import '../../../viewModels/leadScreens/lead_list/filter/country_code/country_code.dart';
import '../../../viewModels/leadScreens/lead_list/lead_assign/lead_assign.dart';
import '../../../viewModels/leadScreens/lead_list/lead_list.dart';
import '../../../viewModels/leadScreens/lead_list/lead_type/lead_type.dart';
import '../../../viewModels/product/category/product_category_viewModel.dart';
import '../../homeScreen/home_manager/HomeManagerScreen.dart';

import '../../homeScreen/home_manager/dumy/practicescreen.dart';

class LeadListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(Item, bool)?
      onOrderSelected; // Updated to accept two parameters

  const LeadListScreen({
    Key? key,
    required this.scaffoldKey,
    this.onOrderSelected,
  }) : super(key: key);

  @override
  _LeadListScreenState createState() => _LeadListScreenState();
}

class _LeadListScreenState extends State<LeadListScreen> {
  final LeadListViewModel controller = Get.put(LeadListViewModel());
  final LeadDeleteViewmodel viewmodel = Get.put(LeadDeleteViewmodel());
  final ListLeadTypeViewModel leadTypeItems = Get.put(ListLeadTypeViewModel());

  final ListLeadAssignViewModel searchAssigned =
      Get.put(ListLeadAssignViewModel());
  final ConstantValueViewModel staticText = Get.put(ConstantValueViewModel());
  final DivisionsViewModel divisionList = Get.put(DivisionsViewModel());
  final SourceViewModel leadSourceList = Get.put(SourceViewModel());
  final ProductCategoryViewModel productCategoryList =
      Get.put(ProductCategoryViewModel());
  final LeadListCountryCodeViewModel countryList =
      Get.put(LeadListCountryCodeViewModel());
  final StateListViewModel stateListShow = Get.put(StateListViewModel());

  final FilterCityViewModel leadCityFilter = Get.put(FilterCityViewModel());

  final LeadListColumnListViewModel leadColumn =
      Get.put(LeadListColumnListViewModel());

  final HomeManagerController homeController =
      Get.find<HomeManagerController>();
  bool isFloatingButtonClicked = false;
  TextEditingController searchController =
      TextEditingController(); // Add this line
  String selectedCountryId =
      ""; // This should be set when the user selects a country
  String getSelectedCountryId() {
    return selectedCountryId; // Return the currently selected country ID
  }

  @override
  void initState() {
    super.initState();
    leadTypeItems.leadListLeadType(context);
    searchAssigned.leadListLeadAssign(context);
    staticText.fetchConstantList(context); // Fetch constants
    divisionList.fetchDivisions(); // Fetch constants
    leadSourceList.fetchLeadSources(context); // Fetch sources
    searchAssigned.leadListLeadAssign(context); // Fetch data

    // Get the selected country ID
    String countryId =
        getSelectedCountryId(); // Call the method to get the country ID

    countryList.countryCodeApi(context);

    leadCityFilter.filterCityApi(context);
    leadColumn.leadListColumnList(context); // Fetch column data

    stateListShow.stateFilter(countryId); // Pass the correct countryId here

    productCategoryList.productCategory(context).then((_) {
      setState(() {}); // Trigger a rebuild to reflect the fetched categories
    });
    controller.fetchLeadList();
  }

  void onCountrySelected(String countryId) {
    setState(() {
      selectedCountryId = countryId;
    });

    // Clear previous states
    final stateListViewModel = Get.find<StateListViewModel>();
    stateListViewModel.stateList.clear();

    // Fetch states for the selected country immediately
    fetchStatesForCountry(countryId);
  }

  void fetchStatesForCountry(String countryId) async {
    try {
      final stateListViewModel = Get.find<StateListViewModel>();

      // Call the stateFilter method with the countryId
      await stateListViewModel.stateFilter(countryId);

      // Check if states were fetched
      if (stateListViewModel.stateList.isEmpty) {
        // Handle no states found
      } else {}
    } catch (e) {}
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose the controller here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('LeadListScreen build called');
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return WillPopScope(
      onWillPop: () async {
        homeController.resetOrderDetails();
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavBar(),
        floatingActionButton: CustomFloatingButton(
          onPressed: () {
            setState(() {
              isFloatingButtonClicked =
                  !isFloatingButtonClicked; // Toggle the state
            });
          },
          imageIcon: IconStrings.navSearch3,
          backgroundColor: AllColors.mediumPurple,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[80]
            : AllColors.whiteColor,
        body: Obx(() {
          return Column(
            children: [
              // CustomAppBar(
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
              //     child: Row(
              //       children: [
              //         if (!isTablet)
              //           IconButton(
              //             icon: Icon(
              //               Icons.menu,
              //               color:
              //                   Theme.of(context).brightness == Brightness.dark
              //                       ? Colors.white
              //                       : AllColors.blackColor,
              //               size: 25,
              //             ),
              //             onPressed: () {
              //               widget.scaffoldKey.currentState?.openDrawer();
              //             },
              //           ),
              //         if (isTablet) const SizedBox(width: 10),
              //         Text(
              //           'Lead List',
              //           style: TextStyle(
              //             color: Theme.of(context).brightness == Brightness.dark
              //                 ? Colors.white
              //                 : AllColors.blackColor,
              //             fontWeight: FontWeight.w700,
              //             fontFamily: FontFamily.sfPro,
              //             fontSize: 18.5,
              //           ),
              //         ),
              //         const Spacer(),
              //         InkWell(
              //           onTap: () => openFilterBottomSheet(context),
              //           child: Icon(
              //             Icons.filter_list,
              //             color: Theme.of(context).brightness == Brightness.dark
              //                 ? Colors.white
              //                 : AllColors.blackColor,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              CustomAppBar(
                child: Row(
                  children: [
                    if (ResponsiveUtilsScreenSize.isMobile(context))
                      GestureDetector(
                        onTap: () {
                          widget.scaffoldKey.currentState?.openDrawer();
                        },
                        child: SvgIcon(
                          assetPath: IconStrings.drawer,
                          color: DarkMode.backgroundColor2(context),
                        ),
                      ),
                    if (ResponsiveUtilsScreenSize.isMobile(context))
                      const SizedBox(width: 10),
                    ResponsiveText.getAppBarTextSize(context, Strings.leadList),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => openFilterBottomSheet(context),
                      child: FilterButton(
                        text: Strings.filter,
                        iconPath: 'assets/icons/FilterIcon.png',
                        iconColor: AllColors.mediumPurple,
                        borderColor: AllColors.filterTextColor,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.refreshLeadList();
                  },
                  child: controller.loading.value
                      ? const Center(child: CircularProgressIndicator())
                      :
                  LayoutBuilder(
                          builder: (context, constraints) {
                            if (controller.leadItems.isEmpty) {
                              return SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: SizedBox(
                                  height: constraints
                                      .maxHeight, // Fill available height
                                  child: const Center(
                                      child: Text("No leads available")),
                                ),
                              );
                            }

                            final double screenWidth = constraints.maxWidth;
                            int crossAxisCount;

                            if (screenWidth < 600) {
                              crossAxisCount = 1;
                            } else if (screenWidth < 1200) {
                              crossAxisCount = 2;
                            } else {
                              crossAxisCount = 3; // Desktop
                            }

                            final double itemWidth =
                                (screenWidth - (crossAxisCount - 1) * 16) /
                                    crossAxisCount;
                            const double itemHeight =
                                175; // Desired height of the container
                            final double childAspectRatio =
                                itemWidth / itemHeight;

                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  // Welcome Lead Header
                                  if (isFloatingButtonClicked)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 15, right: 15),
                                      child: CreateNewLeadScreenCard2(
                                        hintText: 'Search',
                                        onSearch: (value) {
                                          // Trigger the search/filtering
                                          controller.filterLeads(value);
                                        },
                                        controller:
                                            searchController, // Pass the controller
                                      ),
                                    ),
                                  // GridView for leads
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: childAspectRatio,
                                    ),
                                    itemCount: controller.leadItems.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index ==
                                          controller.leadItems.length) {
                                        return Center(
                                          child: PaginationWidget(
                                            totalItems:
                                                controller.leadItems.length,
                                            itemsPerPage: 10,
                                            onPageChanged: (int currentPage,
                                                int itemsPerPage) {
                                              // Handle page change
                                            },
                                          ),
                                        );
                                      }

                                      final item = controller.leadItems[index];
                                      return GestureDetector(
                                        onLongPress: () {
                                          _showEditDeleteDialog(item);
                                        },
                                        child: ContainerUtils(
                                          // enableBoxShadow:  true,
                                          // boxShadowSpreadRadius: 0,
                                          // boxShadowColor: Colors.white10,
                                          // borderColor:Colors.grey[800],
                                          // boxShadowBlurRadius: 0,
                                          //  backgroundColor: Theme.of(context).brightness == Brightness.dark
                                          //     ? Colors.black45 : AllColors.whiteColor,
                                          paddingBottom: 0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        // Add any onTap functionality if needed
                                                      },
                                                      child: Text(
                                                        item.organization ??
                                                            "Unknown Organization",
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  // Add spacing between text and icons

                                                  GestureDetector(
                                                    onTap: () {
                                                      if (widget
                                                              .onOrderSelected !=
                                                          null) {
                                                        widget.onOrderSelected!(
                                                            item,
                                                            false); // Pass item and isForEdit=false
                                                        // Fetch lead details using the leadId
                                                        final leadDetailsViewModel =
                                                            Get.put(
                                                                LeadDetailsViewModel());
                                                        leadDetailsViewModel
                                                            .fetchLeadDetails(
                                                                context,
                                                                item.id ?? '');
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .remove_red_eye_outlined,
                                                      color:
                                                          AllColors.figmaGrey,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  // Reduced spacing for better alignment
                                                  GestureDetector(
                                                    onTap: () {
                                                      print(
                                                          'Edit icon tapped for item: ${item.toJson()}');
                                                      if (widget
                                                              .onOrderSelected !=
                                                          null) {
                                                        widget.onOrderSelected!(
                                                            item, true);
                                                        print(
                                                            'Editing item: ${item.toJson()}');
                                                      } else {
                                                        print(
                                                            'onOrderSelected callback is null');
                                                      }
                                                    },
                                                    child: Image.asset(
                                                      ImageStrings.edit,
                                                      color:
                                                          AllColors.figmaGrey,
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      (item.firstName?.isNotEmpty ==
                                                                  true ||
                                                              item.lastName
                                                                      ?.isNotEmpty ==
                                                                  true)
                                                          ? "${item.firstName ?? ""} ${item.lastName ?? ""}"
                                                              .trim()
                                                          : 'N/A',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AllColors.figmaGrey,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Image.asset(
                                                    ImageStrings.call,
                                                    height: 14,
                                                    width: 14,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      item.mobile ??
                                                          "No Mobile",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AllColors.figmaGrey,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/icons/date.png',
                                                    height: 14,
                                                    width: 14,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    formatDateWithTime(item
                                                        .createdAt
                                                        ?.toIso8601String()),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: AllColors
                                                            .mediumPurple),
                                                  ),
                                                  const Spacer(),
                                                  Icon(Icons.language,
                                                      size: 18.5,
                                                      color:
                                                          AllColors.figmaGrey),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    item.source?.name ??
                                                        "Unknown Source",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: AllColors
                                                            .figmaGrey),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              const Divider(thickness: 0.4),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: AllColors
                                                          .lighterPurple,
                                                    ),
                                                    child: Text(
                                                      item.leadAssigned
                                                              .isNotEmpty
                                                          ? item
                                                                  .leadAssigned
                                                                  .first
                                                                  .user
                                                                  ?.firstName ??
                                                              "Unknown User"
                                                          : "No Assignee",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AllColors
                                                            .vividPurple,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    child: Image.asset(
                                                      ImageStrings.call,
                                                      height: 13,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:
                                                        Colors.green,
                                                    child: Image.asset(
                                                      ImageStrings.whatsApp,
                                                      height: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          AllColors.lightBlue,
                                                    ),
                                                    child: Text(
                                                      item.divisions
                                                                  .isNotEmpty &&
                                                              item
                                                                      .divisions
                                                                      .first
                                                                      .name !=
                                                                  null
                                                          ? item.divisions.first
                                                              .name
                                                              .toString()
                                                          : "N/A",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AllColors.darkBlue,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void _showEditDeleteDialog(Item item) {
    showDialog(
      context: context, // Use the parent context
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double dialogWidth =
                  MediaQuery.of(context).size.width * 0.85;
              final double maxDialogWidth =
                  dialogWidth > 300 ? 300 : dialogWidth;

              return SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: DarkMode.backgroundColor(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  width: maxDialogWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      Text(
                        'Are You Sure',
                        style: TextStyle(
                          fontSize: maxDialogWidth < 250 ? 20 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Want To Edit or Delete?',
                        style: TextStyle(
                          fontSize: maxDialogWidth < 250 ? 20 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'This will allow you to modify or remove your item',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: maxDialogWidth < 250 ? 14 : 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Edit action triggered')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AllColors.practiceColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: maxDialogWidth < 250 ? 14 : 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _showDeleteConfirmationDialog(
                                item, context); // Pass parent context
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: maxDialogWidth < 250 ? 14 : 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(Item item, BuildContext parentContext) {
    showGeneralDialog(
      context: parentContext,
      barrierDismissible: true,
      barrierLabel:
          MaterialLocalizations.of(parentContext).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double dialogWidth =
                  MediaQuery.of(context).size.width * 0.85;
              final double maxDialogWidth =
                  dialogWidth > 300 ? 300 : dialogWidth;

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: DarkMode.backgroundColor(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: maxDialogWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.delete,
                        color: AllColors.vividRed,
                        size: maxDialogWidth < 250 ? 28 : 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'You are about to delete',
                      style: TextStyle(
                        fontSize: maxDialogWidth < 250 ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: DarkMode.backgroundColor2(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'This will delete your item permanently. Are you sure?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: maxDialogWidth < 250 ? 14 : 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.grey[700],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: maxDialogWidth < 250 ? 14 : 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              // Close the dialog
                              Navigator.of(context).pop();

                              // Call the delete API with callbacks
                              final leadDeleteViewModel =
                                  Get.find<LeadDeleteViewmodel>();
                              await leadDeleteViewModel.leadDeleteApi(
                                item.id ?? '',
                                onSuccess: () async {
                                  if (parentContext.mounted) {
                                    final leadListViewModel =
                                        Get.find<LeadListViewModel>();
                                    await leadListViewModel.refreshLeadList();
                                  }
                                },
                                onError: (error) {
                                  if (parentContext.mounted) {}
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: maxDialogWidth < 250 ? 14 : 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child,
        );
      },
    );
  }

  void openFilterBottomSheet(BuildContext context) {
    final Map<String, Widget Function(BuildContext)> customBuilders = {};
    final constants = staticText.constantList.first;
    FilterUtils.searchText.value = '';

    final TextEditingController createDateController = TextEditingController();
    final TextEditingController reminderRangeController =
        TextEditingController();
    final TextEditingController assignedRangeController =
        TextEditingController();

    final LeadFilterController filterController =
        Get.put(LeadFilterController());

    final filterData = {
      'create_date': {
        'title': 'Create Date',
        'hintText': 'Select Date',
        'isSingleSelect': true,
        'widget': SelectDate(
          hintText: 'Select Date',
          filterIdentifier: 'create_date',
          controller: createDateController,
          onDateRangeSelected: (start, end) {
            if (start != null && end != null) {
              final formattedRange = {
                'from':
                    "${start.toIso8601String().substring(0, 10)} 00:00:00.000",
                'to': "${end.toIso8601String().substring(0, 10)} 23:59:59.999",
              };
              reminderRangeController.text = jsonEncode(formattedRange);
              print(
                  'reminderRangeController.text set to: ${reminderRangeController.text}');
            } else if (start == null && end == null) {
              // Handle predefined options like "Last 7 Days"
              final now = DateTime.now();
              final last7DaysStart = now.subtract(const Duration(days: 7));
              final formattedRange = {
                'from':
                    "${last7DaysStart.toIso8601String().substring(0, 10)} 00:00:00.000",
                'to': "${now.toIso8601String().substring(0, 10)} 23:59:59.999",
              };
              reminderRangeController.text = jsonEncode(formattedRange);
              print(
                  'reminderRangeController.text set to (Last 7 Days): ${reminderRangeController.text}');
            } else {
              reminderRangeController.text = '';
            }
          },
        ),
      },
      'leads': {
        'title': 'Leads',
        'hintText': 'Search Leads',
        'isSingleSelect': false,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(label: constants.unHandleLeads ?? 'N/A'),
          FilterOptionItem(label: constants.foreignLeads ?? 'N/A'),
          FilterOptionItem(label: constants.leadsWithoutCampaign ?? 'N/A'),
        ]),
      },
      'lead_type': {
        'title': 'Lead Type',
        'hintText': 'Lead Type',
        'isSingleSelect': true,
        'items': leadTypeItems.leadTypeItems,
      },
      'lead_status': {
        'title': 'Lead Status',
        'hintText': '',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(label: constants.newValue ?? 'N/A'),
          FilterOptionItem(label: constants.inProgress ?? 'N/A'),
          FilterOptionItem(label: constants.converted ?? 'N/A'),
          FilterOptionItem(label: constants.dead ?? 'N/A'),
        ]),
      },
      'lead_assigned': {
        'title': 'Lead Assigned',
        'hintText': 'Select Assignee',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(label: constants.withteam ?? 'N/A', id: 'withteam'),
          FilterOptionItem(
              label: constants.individual ?? 'N/A', id: 'individual'),
        ]),
      },
      'search_assigned': {
        'title': 'Search Assigned',
        'hintText': 'Search Assigned',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          searchAssigned.leadAssignList.map((lead) {
            return FilterOptionItem(
                label: lead.firstName ?? 'N/A', id: lead.id);
          }).toList(),
        ),
      },
      'order_by': {
        'title': 'Order By',
        'hintText': 'Search Order By',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(
              label: constants.createDate ?? 'N/A', id: 'create_date'),
          FilterOptionItem(
              label: constants.activityDate ?? 'N/A', id: 'activity_date'),
          FilterOptionItem(
              label: constants.assignDate ?? 'N/A', id: 'assign_date'),
        ]),
      },
      'order_by_list': {
        'title': 'Order By List',
        'hintText': 'Search Order By',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(label: constants.desc ?? 'N/A', id: 'DESC'),
          FilterOptionItem(label: constants.asc ?? 'N/A', id: 'ASC'),
        ]),
      },
      'to_do_leads': {
        'title': 'To-Do-Leads',
        'hintText': 'Search To-Do-Leads',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(
              label: constants.toDoNeedAction ?? 'N/A', id: 'need_action'),
          FilterOptionItem(
              label: constants.toDoActionTaken ?? 'N/A', id: 'action_taken'),
        ]),
      },
      'query_type': {
        'title': 'Query Type',
        'hintText': 'Search Query Type',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(label: constants.queryTypeDirect ?? 'N/A', id: 'W'),
          FilterOptionItem(label: constants.queryTypeBuy ?? 'N/A', id: 'B'),
          FilterOptionItem(label: constants.queryTypeCall ?? 'N/A', id: 'P'),
        ]),
      },
      'assigned_type': {
        'title': 'Assigned Type',
        'hintText': 'Search Assigned Type',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(
              label: constants.assignTypeAssigned ?? 'N/A', id: 'ASSIGNED'),
          FilterOptionItem(
              label: constants.assignTypeUnassigned ?? 'N/A', id: 'UNASSIGNED'),
          FilterOptionItem(
              label: constants.assignTypeAssignFresh ?? 'N/A',
              id: 'ASSIGNED_FRESH'),
          FilterOptionItem(
              label: constants.assignTypeUnAssignFresh ?? 'N/A',
              id: 'UNASSIGNED_FRESH'),
          FilterOptionItem(
              label: constants.reAssigned ?? 'N/A', id: 'RE_ASSIGNED'),
          FilterOptionItem(
              label: constants.reUnAssigned ?? 'N/A', id: 'RE_UNASSIGNED'),
        ]),
      },
      'reminder_type': {
        'title': 'Reminder Type',
        'hintText': 'Search Assigned Type',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(
              label: constants.reminderTypeToday ?? 'N/A', id: "today"),
          FilterOptionItem(
              label: constants.reminderTypeMissed ?? 'N/A', id: "missed"),
          FilterOptionItem(
              label: constants.reminderTypeUpcoming ?? 'N/A', id: "upcoming"),
          FilterOptionItem(
              label: constants.reminderTypeTodayMissed ?? 'N/A',
              id: "today+missed"),
        ]),
      },
      'repeat_type': {
        'title': 'Repeat Type',
        'hintText': 'Search Repeat Type',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(label: constants.all ?? 'N/A', id: "all"),
          FilterOptionItem(label: constants.repeated ?? 'N/A', id: "repeated"),
          FilterOptionItem(
              label: constants.nonRepeated ?? 'N/A', id: "non-repeated"),
        ]),
      },
      'activity_Range': {
        'title': 'Activity Range',
        'hintText': 'Search Activity Range',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(
              label: constants.activityRangeStartDays ?? 'N/A', id: '0-7'),
          FilterOptionItem(
              label: constants.activityRangeSecond ?? 'N/A', id: '8-14'),
          FilterOptionItem(
              label: constants.activityRangeThird ?? 'N/A', id: '15-21'),
          FilterOptionItem(
              label: constants.activityRangeFour ?? 'N/A', id: '22-31'),
          FilterOptionItem(
              label: constants.activityRangeFifth ?? 'N/A', id: '31-60'),
          FilterOptionItem(
              label: constants.activityRangeSix ?? 'N/A', id: '61-90'),
          FilterOptionItem(
              label: constants.activityRangeSeven ?? 'N/A', id: '91-null'),
        ]),
      },
      'division': {
        'title': 'Division',
        'hintText': 'Search Division',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          divisionList.divisionsList.map((division) {
            return FilterOptionItem(
                label: division.name ?? 'N/A', id: division.id);
          }).toList(),
        ),
      },
      'lead_source': {
        'title': 'Lead Source',
        'hintText': 'Search Lead Source',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          leadSourceList.sourceList.map((source) {
            return FilterOptionItem(label: source.name ?? 'N/A', id: source.id);
          }).toList(),
        ),
      },
      'services': {
        'title': 'Services',
        'hintText': 'Search Services',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          productCategoryList.categories.map((source) {
            return FilterOptionItem(label: source.name ?? 'N/A', id: source.id);
          }).toList(),
        ),
      },
      'reminder_range': {
        'title': 'Reminder Range',
        'hintText': 'Select Date',
        'isSingleSelect': true,
        'widget': SelectDate(
          hintText: 'Select Date',
          filterIdentifier: 'reminder_range',
          controller: reminderRangeController,
          onDateRangeSelected: (start, end) {
            if (start != null && end != null) {
              final formattedRange = {
                'from':
                    "${start.toIso8601String().substring(0, 10)} 00:00:00.000",
                'to': "${end.toIso8601String().substring(0, 10)} 23:59:59.999",
              };
              reminderRangeController.text =
                  jsonEncode(formattedRange); // Store as JSON string
            } else {
              reminderRangeController.text = '';
            }
          },
        ),
      },
      'assigned_range': {
        'title': 'Assigned Range',
        'hintText': 'Select Date',
        'isSingleSelect': true,
        'widget': SelectDate(
          hintText: 'Select Date',
          filterIdentifier: 'assigned_range',
          controller: assignedRangeController,
          onDateRangeSelected: (start, end) {
            if (start != null && end != null) {
              assignedRangeController.text =
                  'Start: ${start.toIso8601String()}, End: ${end.toIso8601String()}';
            }
          },
        ),
      },
      'country': {
        'title': 'Country',
        'hintText': 'Search Country',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          countryList.countryListCode.map((country) {
            return FilterOptionItem(
                label: ('+${country.phone ?? ''} ${country.name ?? 'N/A'}'),
                id: country.id);
          }).toList(),
        ),
      },
      'state': {
        'title': 'State',
        'hintText': 'Search State',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          stateListShow.stateList.map((state) {
            return FilterOptionItem(
                label: state.name ?? 'Unknown State', id: state.id);
          }).toList(),
        ),
      },
      'city': {
        'title': 'City',
        'hintText': 'Search City',
        'isSingleSelect': true,
        'items': leadCityFilter.leadCityFilters.isNotEmpty
            ? leadCityFilter.leadCityFilters
            : RxList<FilterOptionItem>(),
      },
    };

    // Restore previous selections from the controller
    filterData.forEach((filterId, data) {
      final items = data['items'] as RxList<FilterOptionItem>?;
      if (items != null) {
        final selectedIds = filterController.selectedFilters[filterId];
        if (selectedIds != null) {
          for (var item in items) {
            item.isSelected.value = selectedIds.contains(item.id ?? item.label);
          }
        }
      }
    });

    // Restore date range selections
    if (filterController.selectedFilters['range'] != null) {
      createDateController.text =
          jsonEncode(filterController.selectedFilters['range']);
    }
    if (filterController.selectedFilters['reminder_range'] != null) {
      reminderRangeController.text =
          filterController.selectedFilters['reminder_range'];
    }
    if (filterController.selectedFilters['assigned_range'] != null) {
      assignedRangeController.text =
          filterController.selectedFilters['assigned_range'];
    }

    // Custom builders
    filterData.forEach((filterId, data) {
      customBuilders[filterId] = (context) {
        final widget = data['widget'] as Widget?;
        if (widget != null) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
              child: widget,
            ),
          );
        }

        final items = data['items'] is RxList<FilterOptionItem>
            ? data['items'] as RxList<FilterOptionItem>
            : RxList<FilterOptionItem>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 9, bottom: 0, left: 10, right: 10),
              child: SizedBox(
                height: 43,
                child: TextField(
                  onChanged: (value) {
                    FilterUtils.searchText.value = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Search ${data['title']}',
                    prefixIcon: Icon(Icons.search,
                        color: AllColors.figmaGrey, size: 25),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: AllColors.mediumPurple, width: 0.6)),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                final filteredItems = FilterUtils.getFilteredItems(items);
                return ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Padding(
                      padding:
                          EdgeInsets.only(top: item.isSelected.value ? 5 : 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: item.isSelected.value
                              ? (Theme.of(context).brightness == Brightness.dark
                                  ? AllColors.whiteColor.withOpacity(0.1)
                                  : AllColors.mediumPurple.withOpacity(0.1))
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: Text(item.label,
                                    style: TextStyle(
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.5,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AllColors.whiteColor
                                          : (item.isSelected.value
                                              ? AllColors.mediumPurple
                                              : Colors.black),
                                    )),
                              ),
                              const Spacer(),
                              Obx(() => Transform.scale(
                                    scale: 0.8,
                                    child: Checkbox(
                                      value: item.isSelected.value,
                                      onChanged: (newValue) {
                                        FilterUtils.handleSelection(items, item,
                                            data['isSingleSelect'] as bool);

                                        if (data['isSingleSelect'] as bool &&
                                            newValue == true) {
                                          FilterUtils.searchText.value = '';
                                        }

                                        if (item.isSelected.value &&
                                            filterId == 'country') {
                                          fetchStatesForCountry(item.id!);
                                        }

                                        // Update persistent storage
                                        final selectedItems = items
                                            .where((i) => i.isSelected.value)
                                            .toList();
                                        filterController.updateFilter(
                                            filterId,
                                            selectedItems
                                                .map((i) => i.id ?? i.label)
                                                .toList());
                                      },
                                      activeColor: AllColors.mediumPurple,
                                      checkColor: Colors.white,
                                      side: BorderSide(
                                          color: AllColors.mediumPurple,
                                          width: 2),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      };
    });

    // Show the filter bottom sheet
    showManatFilter(
      context,
      FilterConfig(
        title: "My Filters",
        primaryColor: AllColors.mediumPurple,
        filterOptionss: [
          FilterOption(
              id: 'create_date',
              label: 'Create Date',
              hintText: 'Select Date',
              icon: Icons.person,
              isMultiSelect: false),
          FilterOption(
              id: 'leads',
              label: 'Leads',
              hintText: 'Search Leads',
              icon: Icons.person,
              isMultiSelect: false),
          FilterOption(
              id: 'lead_status',
              label: 'Lead Status',
              hintText: 'Select Status',
              icon: Icons.check_circle,
              isMultiSelect: false),
          FilterOption(
              id: 'lead_type',
              label: 'Lead Type',
              hintText: 'Select Type',
              icon: Icons.category,
              isMultiSelect: false),
          FilterOption(
              id: 'lead_assigned',
              label: 'Lead Assigned',
              hintText: 'Select Assignee',
              icon: Icons.people,
              isMultiSelect: false),
          FilterOption(
              id: 'search_assigned',
              label: 'Search Assigned',
              hintText: 'Search Assigned',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'order_by',
              label: 'Order By',
              hintText: 'Search OrderBy',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'order_by_list',
              label: 'Order By List',
              hintText: 'Search OrderBy',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'to_do_leads',
              label: 'To-Do-Leads',
              hintText: 'Search OrderBy',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'query_type',
              label: 'Query Type',
              hintText: 'Search Query Type',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'assigned_type',
              label: 'Assigned Type',
              hintText: 'Search Assigned Type',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'reminder_type',
              label: 'Reminder Type',
              hintText: 'Search Reminder Type',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'repeat_type',
              label: 'Repeat Type',
              hintText: 'Search Repeat Type',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'activity_Range',
              label: 'Activity Range',
              hintText: 'Activity Range',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'division',
              label: 'Division',
              hintText: 'Division',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'lead_source',
              label: 'Lead Source',
              hintText: 'Search Lead Source',
              icon: Icons.search,
              isMultiSelect: true),
          FilterOption(
              id: 'services',
              label: 'Services',
              hintText: 'Search Services',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'reminder_range',
              label: 'Reminder Range',
              hintText: 'Search Reminder Range',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'assigned_range',
              label: 'Assigned Range',
              hintText: 'Search Assigned Range',
              icon: Icons.business,
              isMultiSelect: true),
          FilterOption(
              id: 'country',
              label: 'Country',
              hintText: 'Search Country',
              icon: Icons.business,
              isMultiSelect: false),
          FilterOption(
              id: 'state',
              label: 'State',
              hintText: 'Search State',
              icon: Icons.business,
              isMultiSelect: false),
          FilterOption(
              id: 'city',
              label: 'City',
              hintText: 'Search City',
              icon: Icons.business,
              isMultiSelect: false),
        ],
        customBuilders: customBuilders,
        onFilterApplied: (filterId, selectedItems) {
          Map<String, dynamic> selectedFilters = {};

          final activityRangeMap = {
            constants.activityRangeStartDays ?? 'N/A': {'from': 0, 'to': 7},
            constants.activityRangeSecond ?? 'N/A': {'from': 8, 'to': 14},
            constants.activityRangeThird ?? 'N/A': {'from': 15, 'to': 21},
            constants.activityRangeFour ?? 'N/A': {'from': 22, 'to': 31},
            constants.activityRangeFifth ?? 'N/A': {'from': 31, 'to': 60},
            constants.activityRangeSix ?? 'N/A': {'from': 61, 'to': 90},
            constants.activityRangeSeven ?? 'N/A': {'from': 91, 'to': null},
          };

          for (final entry in filterData.entries) {
            final filterId = entry.key;
            final data = entry.value;
            final isSingleSelect = data['isSingleSelect'] as bool? ?? true;
            final items = data['items'] as RxList<FilterOptionItem>? ??
                RxList<FilterOptionItem>();

            final selected =
                items.where((item) => item.isSelected.value).toList();

            if (selected.isNotEmpty) {
              final mappedFilterId =
                  filterId == 'repeat_type' ? 'repeatType' : filterId;
              if (isSingleSelect) {
                final selectedItem = selected.first;
                switch (filterId) {
                  case 'activity_Range':
                    final selectedLabel = selectedItem.label;
                    if (activityRangeMap.containsKey(selectedLabel)) {
                      selectedFilters['lastActivityRange'] =
                          activityRangeMap[selectedLabel];
                    } else {
                      print(
                          'Warning: Invalid activity range label: $selectedLabel');
                    }
                    break;
                  case 'created_by':
                    selectedFilters['created_by'] = {'id': selectedItem.id};
                    break;
                  case 'division':
                    selectedFilters[mappedFilterId] = selectedItem.id;
                    break;
                  case 'lead_source':
                    selectedFilters['source'] = selectedItem.id;
                    break;
                  case 'services':
                    selectedFilters['productCategory'] = selectedItem.id;
                    break;
                  case 'state':
                    selectedFilters[mappedFilterId] = selectedItem.id;
                    break;
                  default:
                    selectedFilters[mappedFilterId] =
                        selectedItem.id ?? selectedItem.label;
                }
              } else {
                selectedFilters[mappedFilterId] =
                    selected.map((item) => item.id ?? item.label).toList();
              }
            }
          }

          try {
            if (createDateController.text.isNotEmpty) {
              selectedFilters['range'] = jsonDecode(createDateController.text);
              filterController.updateFilter('range', selectedFilters['range']);
            }
            if (reminderRangeController.text.isNotEmpty) {
              selectedFilters['reminder_range'] = jsonDecode(
                  reminderRangeController.text); // Parse JSON string to object
              filterController.updateFilter(
                  'reminder_range', selectedFilters['reminder_range']);
            }
            if (assignedRangeController.text.isNotEmpty) {
              selectedFilters['assigned_range'] = assignedRangeController.text;
              filterController.updateFilter(
                  'assigned_range', assignedRangeController.text);
            }
          } catch (e) {
            print('Error parsing date range filters: $e');
          }

          final leadAssignedValue = selectedFilters['lead_assigned'];
          if (leadAssignedValue != null) {
            selectedFilters['leadAssignedToTeam'] =
                leadAssignedValue == 'withteam';
          }

          final searchAssignedSelected = selectedFilters['search_assigned'];
          if (searchAssignedSelected != null) {
            selectedFilters['lead_assigned'] = searchAssignedSelected is List
                ? searchAssignedSelected.first
                : searchAssignedSelected;
          }

          print('Selected Filters: $selectedFilters');
          Get.find<LeadListViewModel>().applyFilters(selectedFilters);
        },
      ),
    );
  }

// Controller to persist filter selections
}

class FilterUtils {
  static RxString searchText = ''.obs;

  static List<FilterOptionItem> getFilteredItems(
      RxList<FilterOptionItem> items) {
    if (searchText.value.isEmpty) {
      return items.toList()
        ..sort((a, b) => a.isSelected.value && !b.isSelected.value
            ? -1
            : !a.isSelected.value && b.isSelected.value
                ? 1
                : 0);
    }

    final List<FilterOptionItem> filtered = [];
    final List<FilterOptionItem> unfiltered = [];
    for (var item in items) {
      if (item.isSelected.value) {
        filtered.add(item);
      } else if (item.label
          .toLowerCase()
          .contains(searchText.value.toLowerCase())) {
        unfiltered.add(item);
      }
    }
    filtered.addAll(unfiltered);
    return filtered;
  }

  static void handleSelection(RxList<FilterOptionItem> items,
      FilterOptionItem item, bool isSingleSelect) {
    if (isSingleSelect) {
      if (item.isSelected.value) {
        item.isSelected.value = false;
      } else {
        for (var i in items) {
          i.isSelected.value = false;
        }
        item.isSelected.value = true;
      }
    } else {
      item.isSelected.value = !item.isSelected.value;
    }
  }
}

class LeadFilterController extends GetxController {
  RxMap<String, dynamic> selectedFilters = RxMap<String, dynamic>();

  void updateFilter(String filterId, dynamic selectedItems) {
    selectedFilters[filterId] = selectedItems;
    update();
  }

  void clearFilters() {
    selectedFilters.clear();
    update();
  }
}
