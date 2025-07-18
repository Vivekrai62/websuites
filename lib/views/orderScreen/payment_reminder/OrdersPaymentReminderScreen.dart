import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../data/models/responseModels/customers/list/customers_list_response_model.dart'
    as customer_model; // Alias to resolve conflict
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';

import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../utils/fontfamily/FontFamily.dart';
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
import '../../customerScreens/customerList/customerdetails/CustomerDetailsScreen.dart';
import '../../homeScreen/home_manager/HomeManagerScreen.dart';
import '../../homeScreen/home_manager/dumy/practicescreen.dart';
import '../../leadScreens/leadList/leadlist_screen.dart';
import '../../leadScreens/leadList/widgets/manat.dart';

class FilterStateController extends GetxController {
  RxMap<String, RxList<FilterOptionItem>> selectedFilterItems =
      <String, RxList<FilterOptionItem>>{}.obs;

  void setSelectedItems(String filterId, List<FilterOptionItem> items) {
    selectedFilterItems[filterId] = RxList<FilterOptionItem>.from(items);
  }

  RxList<FilterOptionItem> getSelectedItems(String filterId) {
    return selectedFilterItems[filterId] ?? RxList<FilterOptionItem>();
  }

  void clearSelections() {
    selectedFilterItems.clear();
  }
}

final FilterStateController filterStateController =
    Get.put(FilterStateController());

class OrdersPaymentReminderScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const OrdersPaymentReminderScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _OrdersPaymentReminderScreenState createState() =>
      _OrdersPaymentReminderScreenState();
}

class _OrdersPaymentReminderScreenState
    extends State<OrdersPaymentReminderScreen> {
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
    await _viewModel.customersListApi(context);
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
    bool isTablet = MediaQuery.of(context).size.width >= 600;

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
                      'Payment Reminder',
                      style: TextStyle(
                        color: DarkMode.backgroundColor2(context),
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 17.5,
                      ),
                    ),
                    const Spacer(),
                     InkWell(
                      child: Icon(Icons.filter_list,  color: DarkMode.backgroundColor2(context),),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshCustomerList,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (_viewModel.customers.isEmpty) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: constraints.maxHeight,
                          child: const Center(
                              child: Text("No customers available")),
                        ),
                      );
                    }

                    final double screenWidth = constraints.maxWidth;
                    int crossAxisCount = screenWidth < 600
                        ? 1
                        : screenWidth < 1200
                            ? 2
                            : 3;
                    final double itemWidth =
                        (screenWidth - (crossAxisCount - 1) * 16) /
                            crossAxisCount;
                    const double itemHeight = 175;
                    final double childAspectRatio = itemWidth / itemHeight;

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          if (isFloatingButtonClicked)
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, right: 15),
                              child: TextField(
                                controller: searchController,
                                decoration: const InputDecoration(
                                  hintText: 'Search customers...',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemCount: _viewModel.customers.length + 1,
                            itemBuilder: (context, index) {
                              if (index == _viewModel.customers.length) {
                                return Center(
                                  child: PaginationWidget(
                                    totalItems: _viewModel.customers.length,
                                    itemsPerPage: 15,
                                    onPageChanged:
                                        (int currentPage, int itemsPerPage) {},
                                  ),
                                );
                              }

                              final customer_model.Item customer =
                                  _viewModel.customers[index];
                              return GestureDetector(
                                onTap: () {
                                  // Get.to(() => CustomerDetailsScreen(
                                  //       customerId: customer.id ?? '',
                                  //       customerData: customer,
                                  //       scaffoldKey: widget.scaffoldKey,
                                  //     ));
                                },
                                child: ContainerUtils(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              child: Text(
                                                '${customer.firstName} ${customer.lastName}'
                                                    .trim(),
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: FontFamily.sfPro,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(Icons.more_vert_sharp,
                                              color: AllColors.grey),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              customer.companies.isNotEmpty
                                                  ? customer.companies.first
                                                      .companyName
                                                  : 'N/A',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: AllColors.grey,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Icon(Icons.email,
                                              size: 16.5,
                                              color: AllColors.grey),
                                          const SizedBox(width: 5),
                                          Text(
                                            customer.primaryEmail
                                                    ?.toLowerCase() ??
                                                'No Email',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AllColors.grey),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(Icons.date_range_sharp,
                                                size: 16,
                                                color: AllColors.mediumPurple),
                                            const SizedBox(width: 5),
                                            Text(
                                              formatDateWithTime(customer
                                                  .createdAt
                                                  ?.toIso8601String()),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      AllColors.mediumPurple),
                                            ),
                                            const Spacer(),
                                            Icon(Icons.call,
                                                size: 16,
                                                color: AllColors.grey),
                                            const SizedBox(width: 5),
                                            Text(
                                              customer.primaryContact ??
                                                  'No Contact',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: AllColors.grey,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Divider(thickness: 0.4),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: AllColors.lighterPurple,
                                            ),
                                            child: Text(
                                              customer.customerAssigned
                                                          .isNotEmpty &&
                                                      customer.customerAssigned
                                                              .first.user !=
                                                          null
                                                  ? customer.customerAssigned
                                                      .first.user!.firstName
                                                  : 'N/A',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AllColors.mediumPurple,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: AllColors.lightBlue,
                                            ),
                                            child: Text(
                                              customer.divisions.isNotEmpty
                                                  ? customer.divisions.first
                                                          .name ??
                                                      'N/A'
                                                  : 'N/A',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AllColors.darkBlue,
                                              ),
                                              overflow: TextOverflow.ellipsis,
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
    );
  }
}
