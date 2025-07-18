import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../../../data/models/responseModels/customers/list/customers_list_response_model.dart'
    as customer_model;

import '../../../resources/iconStrings/icon_strings.dart';
import '../../../resources/imageStrings/image_strings.dart';
import '../../../resources/strings/strings.dart';
import '../../../resources/svg/svg_string.dart';
import '../../../resources/textStyles/responsive/test_responsive.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/common_responsive_list/common_responsive_list.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/container_Utils/ContainerUtils.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datafilter/SeletDateFilter.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../utils/filter_button/filter_buttons.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../utils/pagination/list_pagination.dart';
import '../../../utils/responsive/responsive_utils.dart';
import '../../../viewModels/customerScreens/customer_list/customer_detail_view/list/customer_detail_view_list_model.dart';
import '../../../viewModels/customerScreens/customer_list/customer_list_viewModel.dart';
import '../../../viewModels/customerScreens/customer_list/customer_type/customer_type.dart';
import '../../../viewModels/leadScreens/createNewLead/constant_controller/constant_controller.dart';
import '../../../viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import '../../../viewModels/leadScreens/createNewLead/source/source_view_model.dart';
import '../../../viewModels/leadScreens/lead_list/column/column_list/lead_list_column_list_view_model.dart';
import '../../../viewModels/leadScreens/lead_list/filter/city/city.dart';
import '../../../viewModels/leadScreens/lead_list/filter/country_code/country_code.dart';
import '../../../viewModels/leadScreens/lead_list/lead_assign/lead_assign.dart';
import '../../../viewModels/product/category/product_category_viewModel.dart';
import '../../../views/homeScreen/home_manager/HomeManagerScreen.dart';
import '../../../views/leadScreens/leadList/leadlist_screen.dart';
import '../../../views/leadScreens/leadList/widgets/manat.dart';

import 'package:websuites/utils/appColors/app_colors.dart';

import '../../calender/Calender.dart'; // For ReusablePagination

class CustomersListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(customer_model.Item)? onOrderSelected;

  const CustomersListScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _CustomersListScreenState createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends State<CustomersListScreen> {
  Map<String, List<String>> selectedFiltersMap = {};

  final CustomerListViewModel _viewModel = Get.put(CustomerListViewModel());
  final CustomerTypeViewModels customerTypeItems =
      Get.put(CustomerTypeViewModels());
  final ListLeadAssignViewModel searchAssigned =
      Get.put(ListLeadAssignViewModel());
  final CustomerListDetailViewListModel _detailViewModel =
      Get.put(CustomerListDetailViewListModel());
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
  TextEditingController searchController = TextEditingController();
  String selectedCountryId = "";

  String getSelectedCountryId() {
    return selectedCountryId;
  }

  Future<void> _refreshCustomerList() async {
    _viewModel.loading.value = true;
    await _viewModel.customersListApi(context, forceRefresh: true);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_viewModel.customers.isEmpty) {
        _viewModel.customersListApi(context);
      }
      customerTypeItems.customerTypeFilters();
      searchAssigned.leadListLeadAssign(context);
      customerTypeItems.customerTypeList(context);
      searchAssigned.leadAssignList();
      staticText.fetchConstantList(context);
      divisionList.fetchDivisions();
      leadSourceList.fetchLeadSources(context);
      countryList.countryCodeApi(context);
      leadCityFilter.filterCityApi(context);
      leadColumn.leadListColumnList(context);
      productCategoryList.productCategory(context).then((_) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 550;

    Widget _buildCustomerCard(
        BuildContext context, customer_model.Item customer, int index) {
      return GestureDetector(
        child: ContainerUtils(
          paddingTop: 19,
          paddingLeft: 14,
          paddingRight: 14,
          paddingBottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child:
                    ResponsiveText.getTitleText(
                      context,
                      '${customer.firstName} ${customer.lastName}'.trim(),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (widget.onOrderSelected != null) {
                        widget.onOrderSelected!(customer);
                      }
                    },
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: AllColors.figmaGrey,
                    ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {},
                    child: SvgIcon(
                      assetPath: IconStrings.edit,
                      size: 19.0,
                      color: AllColors.figmaGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ResponsiveText.getSubTitle(
                      context,
                      '${customer.companies.isNotEmpty ? customer.companies.first.companyName : 'Unknown'}',
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgIcon(
                    assetPath: IconStrings.email,
                    size: 14.0,
                    color: DarkMode.subTitleColor(context),
                  ),
                  const SizedBox(width: 9),
                  ResponsiveText.getEmailTitle(
                    context,
                    customer.primaryEmail?.toLowerCase() ?? 'No Email',
                  )
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Row(
                  children: [
                    SvgIcon(
                      assetPath: IconStrings.calender,
                      size: 14.0,
                      color: DarkMode.mobileColor(context),
                    ),
                    const SizedBox(width: 10),
                    // Text(
                    //   formatDateWithTime(customer.createdAt?.toIso8601String()),
                    //   style: TextStyle(
                    //       fontSize: 12, color: AllColors.mediumPurple),
                    // ),

                    ResponsiveText.getDateTitle(
                      context,
                      '${formatDateWithDay(customer.createdAt?.toIso8601String())}',
                    ),
                    const Spacer(),
                    SvgIcon(
                      assetPath: IconStrings.phone,
                      size: 14.0,
                      color: DarkMode.subTitleColor(context),
                      // color: AllColors.,
                    ),
                    const SizedBox(width: 10),
                    // Text(
                    //   customer.primaryContact ?? 'No Contact',
                    //   style: TextStyle(
                    //     fontSize: 13,
                    //     fontWeight: FontWeight.w400,
                    //     color: AllColors.grey,
                    //   ),
                    //   overflow: TextOverflow.ellipsis,
                    //   maxLines: 1,
                    // ),

                    ResponsiveText.getMobileTitle(
                      context,
                      '${customer.primaryContact ?? 'No Contact'}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Divider(thickness: 0.4),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: DarkMode.assignedBackColor(context),
                      ),
                      child:

                          // Text(
                          //   customer.customerAssigned.isNotEmpty &&
                          //       customer.customerAssigned.first.user != null
                          //       ? customer.customerAssigned.first.user!.firstName
                          //       : 'N/A',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.w400,
                          //     color: AllColors.mediumPurple,
                          //   ),
                          //   overflow: TextOverflow.ellipsis,
                          // ),

                          ResponsiveText.assignedTextColor(
                        context,
                        customer.customerAssigned.isNotEmpty &&
                                customer.customerAssigned.first.user != null
                            ? customer.customerAssigned.first.user!.firstName
                            : 'N/A',
                      )),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: DarkMode.divisionBackColor(context),
                      ),
                      child: ResponsiveText.divisionTextColor(
                        context,
                        customer.divisions.isNotEmpty
                            ? customer.divisions.first.name ?? 'N/A'
                            : 'No Email',
                      )),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          setState(() {
            isFloatingButtonClicked = !isFloatingButtonClicked;
          });
        },
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: DarkMode.backgroundColor(context),
      body: Obx(() {
        if (_viewModel.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            CustomAppBar(
              child: Row(
                children: [
                  if (ResponsiveUtilsScreenSize.isMobile(context))

                    GestureDetector(
                      onTap: (){
                        widget.scaffoldKey.currentState?.openDrawer();
                      },
                      child: SvgIcon(
                        assetPath: IconStrings.drawer,
                        // size: 22.0,

                      ),
                    ),
                  if (ResponsiveUtilsScreenSize.isMobile(context))
                    SizedBox(width: 10,),

                  ResponsiveText.getAppBarTextSize(context, Strings.customers),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => openCustomerFilterBottomSheet(context),
                    child:

                    FilterButton(
                      text: Strings.filter,
                      iconPath: 'assets/icons/FilterIcon.png',
                      iconColor: AllColors.mediumPurple,
                      borderColor: AllColors.filterTextColor,

                    )
                  ),
                  SizedBox(width: ResponsiveUtilsScreenSize.isMobile(context) ? 12 : 16),
                  CustomButton(
                    width: ResponsiveUtilsScreenSize.isMobile(context) ? 70 : 85,
                    height: ResponsiveUtilsScreenSize.isMobile(context) ? 28 : 28,
                    borderRadius: 54,
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: AllColors.whiteColor,
                          size: ResponsiveUtilsScreenSize.isMobile(context) ? 16 : 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          Strings.add2,
                          style: TextStyle(
                            fontSize: ResponsiveUtilsScreenSize.isMobile(context) ? 11 : 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.sfPro,
                            color: AllColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshCustomerList,
                child: Obx(() {
                  if (_viewModel.displayedCustomers.isEmpty &&
                      !_viewModel.loading.value) {
                    return const Center(child: Text("No customers available"));
                  }

                  return Column(
                    children: [
                      if (isFloatingButtonClicked)
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 15, right: 15),
                          child: CommonTextField(hintText: 'Search'),
                        ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child:
                          Column(
                            children: [

                              ResponsiveMasonryGridView(
                                items: _viewModel.displayedCustomers,

                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 16.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10
                                ),


                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, customer, index) {
                                  return SizedBox(
                                    height: 175,
                                    child: _buildCustomerCard(
                                        context, customer, index),
                                  );
                                },
                              ),
                              CustomerListPaginationExample(
                                  viewModel: _viewModel
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        );
      }),
    );
  }

  void openCustomerFilterBottomSheet(BuildContext context) {
    final Map<String, Widget Function(BuildContext)> customBuilders = {};
    final constants = staticText.constantList.first;
    FilterUtils.searchText.value = '';

    final TextEditingController createDateController = TextEditingController();
    final TextEditingController reminderRangeController =
        TextEditingController();
    final TextEditingController assignedRangeController =
        TextEditingController();

    // Define filter options with hintText in FilterOption
    final List<FilterOption> filterOptions = [
      FilterOption(
        id: 'search_assigned',
        label: 'Search Assigned',
        hintText: 'Search Assigned',
        icon: Icons.search,
        isMultiSelect: true,
      ),
      FilterOption(
        id: 'create_date',
        label: 'Create Date',
        hintText: 'Select Date',
        icon: Icons.search,
        isMultiSelect: false,
      ),
      FilterOption(
        id: 'reminder_range',
        label: 'Reminder Range',
        hintText: 'Select Date',
        icon: Icons.search,
        isMultiSelect: true,
      ),
      FilterOption(
        id: 'assigned_range',
        label: 'Assigned Range',
        hintText: 'Select Date',
        icon: Icons.search,
        isMultiSelect: true,
      ),
      FilterOption(
        id: 'service_status',
        label: 'Service Status',
        hintText: 'Search Status',
        icon: Icons.search,
        isMultiSelect: false,
      ),
      FilterOption(
        id: 'customer_type',
        label: 'Customer Type',
        hintText: 'Search Type',
        icon: Icons.search,
        isMultiSelect: false,
      ),
      FilterOption(
        id: 'project_status',
        label: 'Project Status',
        hintText: 'Search Status',
        icon: Icons.search,
        isMultiSelect: false,
      ),
      FilterOption(
        id: 'reminder_type',
        label: 'Reminder Type',
        hintText: 'Search Reminder Type',
        icon: Icons.search,
        isMultiSelect: true,
      ),
      FilterOption(
        id: 'division',
        label: 'Division',
        hintText: 'Search Division',
        icon: Icons.search,
        isMultiSelect: true,
      ),
      FilterOption(
        id: 'product_category',
        label: 'Product Category',
        hintText: 'Search Category',
        icon: Icons.search,
        isMultiSelect: true,
      ),
      FilterOption(
        id: 'city',
        label: 'City',
        hintText: 'Search City',
        icon: Icons.search,
        isMultiSelect: false,
      ),
      FilterOption(
        id: 'source',
        label: 'Source',
        hintText: 'Search Source',
        icon: Icons.search,
        isMultiSelect: true,
      ),
    ];

    // Define filterData using filterOptions
    final filterData = {
      'create_date': {
        'title': 'Create Date',
        'isSingleSelect': true,
        'widget': SelectDate(
          hintText: filterOptions
              .firstWhere((option) => option.id == 'create_date')
              .hintText,
          filterIdentifier: 'create_date',
          controller: createDateController,
          onDateRangeSelected: (start, end) {
            if (start != null && end != null) {
              final formattedRange = {
                'from':
                    "${start.toIso8601String().substring(0, 10)} 00:00:00.000",
                'to': "${end.toIso8601String().substring(0, 10)} 23:59:59.999",
              };
              createDateController.text = jsonEncode(formattedRange);
            } else {
              createDateController.text = '';
            }
          },
        ),
      },
      'service_status': {
        'title': 'Service Status',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(label: 'Active', id: 'active'),
          FilterOptionItem(label: 'Inactive', id: 'inactive'),
        ]),
      },
      'leads': {
        'title': 'Leads',
        'isSingleSelect': false,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(label: constants.unHandleLeads ?? 'N/A'),
          FilterOptionItem(label: constants.foreignLeads ?? 'N/A'),
          FilterOptionItem(label: constants.leadsWithoutCampaign ?? 'N/A'),
        ]),
      },
      'customer_type': {
        'title': 'Customer Type',
        'isSingleSelect': true,
        'items': customerTypeItems.customerTypeFilters,
      },
      'search_assigned': {
        'title': 'Search Assigned',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          searchAssigned.leadAssignList.map((lead) {
            return FilterOptionItem(
                label: lead.firstName ?? 'N/A', id: lead.id);
          }).toList(),
        ),
      },
      'project_status': {
        'title': 'Project Status',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(
              label: constants.notStarted ?? 'Not Started', id: 'Not Started'),
          FilterOptionItem(
              label: constants.inProgress ?? 'In Progress', id: 'In Progress'),
          FilterOptionItem(label: constants.onHold ?? 'On Hold', id: 'On Hold'),
        ]),
      },
      'reminder_type': {
        'title': 'Reminder Type',
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
      'division': {
        'title': 'Division',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          divisionList.divisionsList.map((division) {
            return FilterOptionItem(
                label: division.name ?? 'N/A', id: division.id);
          }).toList(),
        ),
      },
      'source': {
        'title': 'Lead Source',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          leadSourceList.sourceList.map((source) {
            return FilterOptionItem(label: source.name ?? 'N/A', id: source.id);
          }).toList(),
        ),
      },
      'product_category': {
        'title': 'Product Category',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          productCategoryList.categories.map((source) {
            return FilterOptionItem(label: source.name ?? 'N/A', id: source.id);
          }).toList(),
        ),
      },
      'reminder_range': {
        'title': 'Reminder Range',
        'isSingleSelect': true,
        'widget': SelectDate(
          hintText: filterOptions
              .firstWhere((option) => option.id == 'reminder_range')
              .hintText,
          filterIdentifier: 'reminder_range',
          controller: reminderRangeController,
          onDateRangeSelected: (start, end) {
            if (start != null && end != null) {
              final formattedRange = {
                'from':
                    "${start.toIso8601String().substring(0, 10)} 00:00:00.000",
                'to': "${end.toIso8601String().substring(0, 10)} 23:59:59.999",
              };
              reminderRangeController.text = jsonEncode(formattedRange);
            } else {
              reminderRangeController.text = '';
            }
          },
        ),
      },
      'assigned_range': {
        'title': 'Assigned Range',
        'isSingleSelect': true,
        'widget': SelectDate(
          hintText: filterOptions
              .firstWhere((option) => option.id == 'assigned_range')
              .hintText,
          filterIdentifier: 'assigned_range',
          controller: assignedRangeController,
          onDateRangeSelected: (start, end) {
            if (start != null && end != null) {
              final formattedRange = {
                'from':
                    "${start.toIso8601String().substring(0, 10)} 00:00:00.000",
                'to': "${end.toIso8601String().substring(0, 10)} 23:59:59.999",
              };
              assignedRangeController.text = jsonEncode(formattedRange);
            } else {
              assignedRangeController.text = '';
            }
          },
        ),
      },
      'city': {
        'title': 'City',
        'isSingleSelect': true,
        'items': leadCityFilter.leadCityFilters.isNotEmpty
            ? leadCityFilter.leadCityFilters
            : RxList<FilterOptionItem>(),
      },
    };

    filterData.forEach((filterId, data) {
      final items = data['items'] as RxList<FilterOptionItem>?;
      if (items != null) {
        final previouslySelected =
            filterStateController.getSelectedItems(filterId);
        for (var item in items) {
          item.isSelected.value = previouslySelected.any((selected) =>
              selected.label == item.label && selected.id == item.id);
        }
      }
    });

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

        final items = data['items'] as RxList<FilterOptionItem>? ??
            RxList<FilterOptionItem>();

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
                    hintText: filterOptions
                        .firstWhere((option) => option.id == filterId)
                        .hintText,
                    prefixIcon: Icon(Icons.search,
                        color: AllColors.figmaGrey, size: 25),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide:
                          BorderSide(color: AllColors.mediumPurple, width: 0.6),
                    ),
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
                      padding: EdgeInsets.only(
                          top: item.isSelected.value ? 5 : 0,
                          bottom: item.isSelected.value ? 0 : 0),
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

    showManatFilter(
      context,
      FilterConfig(
        title: "My Filters",
        primaryColor: AllColors.mediumPurple,
        filterOptionss: filterOptions,
        customBuilders: customBuilders,
        onFilterApplied: (filterId, selectedItems) {
          Map<String, dynamic> selectedFilters = {};

          filterData.forEach((filterId, data) {
            final items = data['items'] as RxList<FilterOptionItem>? ??
                RxList<FilterOptionItem>();
            final selected =
                items.where((item) => item.isSelected.value).toList();
            if (selected.isNotEmpty) {
              filterStateController.setSelectedItems(filterId, selected);
              final isSingleSelect = data['isSingleSelect'] as bool? ?? true;
              final mappedFilterId =
                  filterId == 'repeat_type' ? 'repeatType' : filterId;
              if (isSingleSelect) {
                final selectedItem = selected.first;
                switch (filterId) {
                  case 'division':
                    selectedFilters[mappedFilterId] = selectedItem.id;
                    break;
                  case 'source':
                    selectedFilters['source'] = selectedItem.id;
                    break;
                  case 'product_category':
                    selectedFilters['product_category'] = selectedItem.id;
                    break;
                  case 'service_status':
                    selectedFilters['service_status'] = selectedItem.id;
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
          });

          try {
            if (createDateController.text.isNotEmpty) {
              selectedFilters['range'] = jsonDecode(createDateController.text);
            }
            if (reminderRangeController.text.isNotEmpty) {
              selectedFilters['reminder_range'] =
                  jsonDecode(reminderRangeController.text);
            }
            if (assignedRangeController.text.isNotEmpty) {
              selectedFilters['assigned_range'] =
                  jsonDecode(assignedRangeController.text);
            }
          } catch (e) {
            // print('Error parsing date range filters: $e');
          }

          final searchAssignedSelected = selectedFilters['search_assigned'];
          if (searchAssignedSelected != null) {
            selectedFilters['lead_assigned'] = searchAssignedSelected is List
                ? searchAssignedSelected.first
                : searchAssignedSelected;
          }

          // print('Selected Filters: $selectedFilters');
          Get.find<CustomerListViewModel>().applyFilters(selectedFilters);
        },
      ),
    );
  }
}
