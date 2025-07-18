import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';

import 'package:websuites/views/leadScreens/leadList/widgets/manat.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../utils/appColors/app_colors.dart';

import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';

import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/leadScreens/createNewLead/constant_controller/constant_controller.dart';
import '../../../viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import '../../../viewModels/leadScreens/lead_list/lead_assign/lead_assign.dart';
import '../../homeScreen/home_manager/HomeManagerScreen.dart';

import '../../../viewModels/customerScreens/credential/CustomerCredentialListViewModel.dart';
import '../../../viewModels/customerScreens/customer_list/customer_list_viewModel.dart';

import '../../../viewModels/order/list/order_list_viewModel.dart';

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

class OrderListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const OrderListScreen({
    super.key,
    required this.scaffoldKey,
  });

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final CustomerCredentialListViewModel _viewModel =
      Get.put(CustomerCredentialListViewModel());
  final TextEditingController searchController = TextEditingController();
  bool isFloatingButtonClicked = false;
  final OrderListViewModel viewModel = Get.put(OrderListViewModel());
  final ListLeadAssignViewModel searchAssigned =
      Get.put(ListLeadAssignViewModel());
  final ConstantValueViewModel staticText = Get.put(ConstantValueViewModel());
  final DivisionsViewModel divisionList = Get.put(DivisionsViewModel());
  final CustomerListViewModel customerList = Get.put(CustomerListViewModel());
  final HomeManagerController homeController =
      Get.find<HomeManagerController>();

  final Map<String, bool> _expandedState = {};
  // Refresh method to fetch order role data
  Future<void> _refreshOrderList() async {
    try {
      await viewModel.orderList(forceRefresh: true);
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchAssigned.leadListLeadAssign(context);
      searchAssigned.leadAssignList();
      staticText.fetchConstantList(context);
      divisionList.fetchDivisions();
      customerList.customersListApi(context);
      viewModel.orderList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: DarkMode.backgroundColor(context),
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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        if (widget.scaffoldKey.currentState != null) {
                          if (!widget.scaffoldKey.currentState!.isDrawerOpen) {
                            widget.scaffoldKey.currentState!.openDrawer();
                          }
                        } else {
                          debugPrint("Scaffold key has no current state");
                        }
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  Text(
                    'Order List',
                    style: TextStyle(
                      backgroundColor: DarkMode.backgroundColor(context),
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 18.5,
                    ),
                  ),
                  const Spacer(),
                  ContainerUtils(
                    width: 95,
                    height: 25,
                    paddingLeft: 0,
                    paddingRight: 0,
                    paddingTop: 0,
                    paddingBottom: 0,

                    borderRadius: BorderRadius.circular(24),
                    backgroundColor: AllColors.mediumPurple,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Filter",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (viewModel.loading.value && viewModel.orders.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return RefreshIndicator(
                onRefresh: _refreshOrderList,
                color: AllColors.mediumPurple, // Custom refresh indicator color
                backgroundColor: Colors.white,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (viewModel.orders.isEmpty) {
                      return const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Center(child: Text("No Orders available")),
                      );
                    }

                    final double screenWidth = constraints.maxWidth;
                    int columns = screenWidth < 600
                        ? 1
                        : screenWidth < 1200
                            ? 2
                            : 3;
                    int rowCount = (viewModel.orders.length / columns).ceil();
                    List<Widget> rows = [];

                    for (int i = 0; i < rowCount; i++) {
                      List<Widget> rowChildren = [];

                      for (int j = 0; j < columns; j++) {
                        final int index = i * columns + j;
                        if (index < viewModel.orders.length) {
                          dynamic order = viewModel.orders[index];
                          final orderId = order.id ?? index.toString();
                          _expandedState.putIfAbsent(orderId, () => false);

                          rowChildren.add(
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: GestureDetector(
                                  onTap: () {
                                    debugPrint('View order for ${order.id}');
                                  },
                                  child: ContainerUtils(
                                    child: SingleChildScrollView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                order.customer?.firstName ??
                                                    'N/A',
                                                style: TextStyle(
                                                  color: DarkMode.backgroundColor2(context),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  if (!_expandedState[orderId]!)
                                                    Container(
                                                      height: 20,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15),
                                                      decoration: BoxDecoration(
                                                        color: AllColors
                                                            .lightYellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          order.status != null
                                                              ? '${order.status![0].toUpperCase()}${order.status!.substring(1).toLowerCase()}'
                                                              : 'N/A',
                                                          style: TextStyle(
                                                            color: AllColors
                                                                .darkYellow,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  const SizedBox(width: 8),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _expandedState[
                                                                orderId] =
                                                            !_expandedState[
                                                                orderId]!;
                                                      });
                                                    },
                                                    child: Icon(
                                                      _expandedState[orderId]!
                                                          ? Icons
                                                              .arrow_drop_down
                                                          : Icons.arrow_drop_up,
                                                        color: DarkMode.backgroundColor2(context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                order.salesPerson?.firstName ??
                                                    'Unknown',
                                                style: TextStyle(
                                                  color: AllColors.lightGrey,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Services: ',
                                                    style: TextStyle(
                                                      color:
                                                          AllColors.lightGrey,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    'N/A',
                                                    style: TextStyle(
                                                      color:
                                                          AllColors.lightGrey,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          if (!_expandedState[orderId]!)
                                            const SizedBox(height: 15),
                                          if (!_expandedState[orderId]!)
                                            const Divider(thickness: 0.4),
                                          if (!_expandedState[orderId]!)
                                            const SizedBox(height: 15),
                                          if (!_expandedState[orderId]!)
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AllColors.lightPurple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Text(
                                                    order.createdBy
                                                            ?.firstName ??
                                                        'Unknown',
                                                    style: TextStyle(
                                                      color: AllColors
                                                          .mediumPurple,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12.5,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '₹ ${order.currencyTotalAmount?.toString() ?? '0'}',
                                                  style: TextStyle(
                                                    color: DarkMode.backgroundColor2(context),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (_expandedState[orderId]!) ...[
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'CREATED BY',
                                                  style: TextStyle(
                                                    color: DarkMode.backgroundColor2(context),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                Text(
                                                  'PENDING AMOUNT',
                                                  style: TextStyle(
                                                    color: DarkMode.backgroundColor2(context),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 1),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AllColors.lightPurple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Text(
                                                    order.createdBy
                                                            ?.firstName ??
                                                        'Unknown',
                                                    style: TextStyle(
                                                      color: AllColors
                                                          .mediumPurple,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12.5,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '₹${order.currencyDueAmount?.toString() ?? 'Unknown'}',
                                                  style: TextStyle(
                                                    color: AllColors.vividRed,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'ORDER ID',
                                                  style: TextStyle(
                                                    color: DarkMode.backgroundColor2(context),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                Text(
                                                  'PAID AMOUNT',
                                                  style: TextStyle(
                                                    color: DarkMode.backgroundColor2(context),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '#${order.orderSerialNumber?.toString() ?? 'Unknown'}',
                                                  style: TextStyle(
                                                    color: AllColors.grey,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  '₹${order.currencyTotalAmount?.toString() ?? '0'}',
                                                  style: TextStyle(
                                                    color: AllColors.darkGreen,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'SYNC WITH ZOHO',
                                                  style: TextStyle(
                                                    color: DarkMode.backgroundColor2(context),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                Text(
                                                  'ORDERED DATE',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: DarkMode.backgroundColor2(context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 27,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                    color: AllColors.lightBlue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 6),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.sync,
                                                          size: 13,
                                                          color: AllColors
                                                              .darkBlue,
                                                        ),
                                                        const SizedBox(
                                                            width: 3),
                                                        Text(
                                                          'Sync',
                                                          style: TextStyle(
                                                            color: AllColors
                                                                .darkBlue,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'May 31, 2024',
                                                  style: TextStyle(
                                                    color: AllColors.figmaGrey,
                                                    fontSize: 12.5,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            const Divider(thickness: 0.4),
                                            const SizedBox(height: 19),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 27,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AllColors.lightYellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      order.status != null
                                                          ? '${order.status![0].toUpperCase()}${order.status!.substring(1).toLowerCase()}'
                                                          : 'N/A',
                                                      style: TextStyle(
                                                        color: AllColors
                                                            .darkYellow,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '₹ ${order.currencyTotalAmount?.toString() ?? '0'}',
                                                  style: TextStyle(
                                                    color: DarkMode.backgroundColor2(context),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          rowChildren.add(Expanded(child: Container()));
                        }
                      }

                      rows.add(
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: rowChildren,
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            if (isFloatingButtonClicked)
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: AllColors.lighterGrey,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextField(
                                    controller: searchController,
                                    decoration: const InputDecoration(
                                      hintText: 'Search Order...',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      viewModel.orders.value = viewModel
                                          .orderListItems
                                          .where((order) {
                                        final customerName = order
                                                .customer?.firstName
                                                ?.toLowerCase() ??
                                            '';
                                        final salesPerson = order
                                                .salesPerson?.firstName
                                                ?.toLowerCase() ??
                                            '';
                                        return customerName.contains(
                                                value.toLowerCase()) ||
                                            salesPerson
                                                .contains(value.toLowerCase());
                                      }).toList();
                                    },
                                  ),
                                ),
                              ),
                            Column(children: rows),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
