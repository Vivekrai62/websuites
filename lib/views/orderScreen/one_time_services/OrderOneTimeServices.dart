import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/responseModels/customers/list/customers_list_response_model.dart'
    as customer_model;
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/container_Utils/ContainerUtils.dart';
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
import '../../../viewModels/order/one_time_services/OrderOneTimeServicesViewModel.dart';
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

class OrderOneTimeServices extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const OrderOneTimeServices({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _OrderOneTimeServicesState createState() => _OrderOneTimeServicesState();
}

class _OrderOneTimeServicesState extends State<OrderOneTimeServices> {
  Map<String, List<String>> selectedFiltersMap = {};

  final CustomerListViewModel _viewModel = Get.put(CustomerListViewModel());
  final CustomerTypeViewModels customerTypeItems = Get.put(CustomerTypeViewModels());
  final ListLeadAssignViewModel searchAssigned = Get.put(ListLeadAssignViewModel());
  final CustomerListDetailViewListModel _detailViewModel = Get.put(CustomerListDetailViewListModel());
  final OrderOneTimeServicesViewModel _orderOneTime = Get.put(OrderOneTimeServicesViewModel());
  final ConstantValueViewModel staticText = Get.put(ConstantValueViewModel());
  final DivisionsViewModel divisionList = Get.put(DivisionsViewModel());
  final SourceViewModel leadSourceList = Get.put(SourceViewModel());

  final ProductCategoryViewModel productCategoryList = Get.put(ProductCategoryViewModel());
  final LeadListCountryCodeViewModel countryList = Get.put(LeadListCountryCodeViewModel());
  final StateListViewModel stateListShow = Get.put(StateListViewModel());
  final FilterCityViewModel leadCityFilter = Get.put(FilterCityViewModel());
  final LeadListColumnListViewModel leadColumn = Get.put(LeadListColumnListViewModel());
  final HomeManagerController homeController = Get.find<HomeManagerController>();

  bool isFloatingButtonClicked = false;
  TextEditingController searchController = TextEditingController();
  String selectedCountryId = "";

  String getSelectedCountryId() {
    return selectedCountryId;
  }

  Future<void> _refreshOrderList() async {
    _orderOneTime.loading.value = true;
    await _orderOneTime.orderOneTimeServices(forceRefresh: true);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_orderOneTime.orderOneTimeSer.isEmpty) {
        _orderOneTime.orderOneTimeServices();
      }
      _viewModel.customersListApi(context);
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
      backgroundColor: Colors.white,
      body: Obx(() {
        if (_orderOneTime.loading.value) {
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
                      'One Time Service',
                      style: TextStyle(
                        color: AllColors.blackColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 17.5,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        // Implement filter logic here if needed
                      },
                      child: const Icon(Icons.filter_list, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshOrderList,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (_orderOneTime.orderOneTimeSer.isEmpty) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: constraints.maxHeight,
                          child: const Center(child: Text("No services available")),
                        ),
                      );
                    }

                    final double screenWidth = constraints.maxWidth;
                    int crossAxisCount = screenWidth < 600
                        ? 1
                        : screenWidth < 1200
                        ? 2
                        : 3;
                    final double itemWidth = (screenWidth - (crossAxisCount - 1) * 16) / crossAxisCount;
                    const double itemHeight = 185;
                    final double childAspectRatio = itemWidth / itemHeight;

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          if (isFloatingButtonClicked)
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                              child: TextField(
                                controller: searchController,
                                decoration: const InputDecoration(
                                  hintText: 'Search services...',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  // Implement search logic here if needed
                                },
                              ),
                            ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemCount: _orderOneTime.orderOneTimeSer.length,
                            itemBuilder: (context, index) {
                              final item = _orderOneTime.orderOneTimeSer[index];

                              return GestureDetector(
                                onTap: () {
                                  widget.onOrderSelected?.call();
                                },
                                child: ContainerUtils(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${item.customer?.firstName ?? 'No Name'} ${item.customer?.lastName ?? ''}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                fontFamily: FontFamily.sfPro,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Spacer(),
                                          const Icon(Icons.more_vert_rounded),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.company?.companyName ?? 'N/A',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: FontFamily.sfPro,
                                          fontWeight: FontWeight.w500,
                                          color: AllColors.blackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.productName ?? 'N/A',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: FontFamily.sfPro,
                                                    fontWeight: FontWeight.w500,
                                                    color: AllColors.mediumPurple,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  "Order No:- ${item.orderProduct?.order?.orderSerialNumber ?? 'N/A'}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: FontFamily.sfPro,
                                                    fontWeight: FontWeight.w400,
                                                    color: AllColors.figmaGrey,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.add_circle_outline_sharp,
                                            color: AllColors.figmaGrey,
                                            size: 22,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            "Start Date:- ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AllColors.mediumPurple,
                                              fontFamily: FontFamily.sfPro,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            item.startDate != null
                                                ? formatDateToYMD(item.startDate!)
                                                : 'N/A',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AllColors.figmaGrey,
                                              fontFamily: FontFamily.sfPro,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "End Date:- ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AllColors.mediumPurple,
                                              fontFamily: FontFamily.sfPro,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            item.endDate != null
                                                ? formatDateToYMD(item.endDate!)
                                                : 'N/A',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AllColors.figmaGrey,
                                              fontFamily: FontFamily.sfPro,
                                              fontSize: 16,
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
