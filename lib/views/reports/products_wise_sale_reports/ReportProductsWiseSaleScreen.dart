import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import 'package:websuites/views/leadScreens/leadList/widgets/manat.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datafilter/SeletDateFilter.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/customerScreens/customer_list/customer_list_viewModel.dart';
import '../../../viewModels/leadScreens/createNewLead/constant_controller/constant_controller.dart';
import '../../../viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import '../../../viewModels/leadScreens/lead_list/lead_assign/lead_assign.dart';
import '../../../viewModels/reports/productWiseSale/ReportProductWiseSaleViewModel.dart';
import '../../leadScreens/leadList/leadlist_screen.dart';

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

class ReportProductsWiseSaleScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ReportProductsWiseSaleScreen({
    super.key,
    required this.scaffoldKey,
  });

  @override
  _ReportProductsWiseSaleScreenState createState() =>
      _ReportProductsWiseSaleScreenState();
}

class _ReportProductsWiseSaleScreenState
    extends State<ReportProductsWiseSaleScreen> {
  final ReportProductWiseSaleViewModel _viewModel =
      Get.put(ReportProductWiseSaleViewModel());
  final TextEditingController searchController = TextEditingController();
  bool isFloatingButtonClicked = false;

  final ListLeadAssignViewModel searchAssigned =
      Get.put(ListLeadAssignViewModel());
  final ConstantValueViewModel staticText = Get.put(ConstantValueViewModel());
  final DivisionsViewModel divisionList = Get.put(DivisionsViewModel());
  final CustomerListViewModel customerList = Get.put(CustomerListViewModel());

  Future<void> _refreshProductList() async {
    if (mounted) {
      // Clear UI state
      searchController.clear();
      setState(() {
        isFloatingButtonClicked = false;
      });

      // Reset filters and clear data
      _viewModel.resetRequestModel();
      filterStateController.clearSelections();
      _viewModel.productWiseSaleItems.clear(); // Clear data to show loading
      _viewModel.loading.value = true; // Force loading state

      // Reload data
      await _viewModel.reportProductWiseSale(context, forceRefresh: true);

      // Reset search state
      _viewModel.searchProducts('');
    }
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
      _viewModel.resetRequestModel();
      _viewModel.reportProductWiseSale(context);
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
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          setState(() {
            isFloatingButtonClicked = !isFloatingButtonClicked;
            if (!isFloatingButtonClicked) {
              searchController.clear();
              _viewModel.searchProducts('');
            }
          });
        },
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: DarkMode.backgroundColor(context),
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
                    'Product Wise Sales',
                    style: TextStyle(
                      color: DarkMode.backgroundColor2(context),
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 18.5,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => openProformasFilterBottomSheet(context),
                    child: const Icon(Icons.filter_list, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              debugPrint(
                  'Rendering with ${_viewModel.productWiseSaleItems.length} items');
              if (_viewModel.loading.value &&
                  _viewModel.productWiseSaleItems.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              final products = _viewModel.productWiseSaleItems.isNotEmpty
                  ? _viewModel.productWiseSaleItems[0].products ?? []
                  : [];

              if (products.isEmpty && !_viewModel.loading.value) {
                return const SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Center(child: Text("No products available")),
                );
              }

              return RefreshIndicator(
                onRefresh: _refreshProductList,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double screenWidth = constraints.maxWidth;
                    final int crossAxisCount = screenWidth < 600
                        ? 1
                        : screenWidth < 1200
                            ? 2
                            : 3;
                    const double itemHeight = 180;
                    final double itemWidth =
                        (screenWidth - (crossAxisCount - 1) * 16) /
                            crossAxisCount;
                    final double childAspectRatio = itemWidth / itemHeight;

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          if (isFloatingButtonClicked)
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, right: 15),
                              child: CreateNewLeadScreenCard2(
                                hintText: 'Search products...',
                                onSearch: (value) {
                                  _viewModel.searchProducts(value);
                                },
                                controller: searchController,
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
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final item = products[index];
                              return GestureDetector(
                                onTap: () {
                                  debugPrint(
                                      'View product details for ${item.productId}');
                                },
                                child: ContainerUtils(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.productName ??
                                                  'Unknown Product',
                                              style: const TextStyle(
                                                fontSize: 17.5,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: FontFamily.sfPro,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            'Amount: ₹ ${item.productSalePrice ?? 0}',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: AllColors.darkGreen,
                                              fontFamily: FontFamily.sfPro,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: AllColors.lightBlue,
                                            ),
                                            child: Text(
                                              item.productProductType != null &&
                                                      item.productProductType!
                                                          .isNotEmpty
                                                  ? item.productProductType![0]
                                                          .toUpperCase() +
                                                      item.productProductType!
                                                          .substring(1)
                                                  : 'Unknown Product',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AllColors.darkBlue,
                                                fontFamily: FontFamily.sfPro,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: AllColors.microPurple,
                                            ),
                                            child: Text(
                                              'Orders: ${item.orderCount ?? '0'}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AllColors.mediumPurple,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: FontFamily.sfPro,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Divider(thickness: 0.4),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Image.asset(ImageStrings.date,
                                              height: 13, width: 13),
                                          const SizedBox(width: 10),
                                          Text(
                                            item.productCreatedAt != null
                                                ? formatDate(
                                                    item.productCreatedAt)
                                                : 'Unknown Date',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AllColors.mediumPurple,
                                              fontFamily: FontFamily.sfPro,
                                              fontWeight: FontWeight.w400,
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
              );
            }),
          ),
        ],
      ),
    );
  }

  void openProformasFilterBottomSheet(BuildContext context) {
    final Map<String, Widget Function(BuildContext)> customBuilders = {};
    final constants = staticText.constantList.isNotEmpty
        ? staticText.constantList.first
        : null;
    FilterUtils.searchText.value = '';

    final TextEditingController createDateController = TextEditingController();

    final filterData = {
      'range': {
        'title': 'Range',
        'hintText': 'Select Date',
        'isSingleSelect': true,
        'widget': SelectDate(
          hintText: 'Select Date',
          filterIdentifier: 'range',
          controller: createDateController,
          onDateRangeSelected: (start, end) {
            if (start != null && end != null) {
              final formattedRange = {
                'start_date': start.toIso8601String().substring(0, 10),
                'end_date': end.toIso8601String().substring(0, 10),
              };
              createDateController.text = jsonEncode(formattedRange);
            } else {
              createDateController.text = '';
            }
          },
        ),
      },
      'search_customer': {
        'title': 'Search Customer',
        'hintText': 'Search',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          customerList.customers.map((lead) {
            return FilterOptionItem(
                label: lead.firstName ?? 'N/A', id: lead.id);
          }).toList(),
        ),
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
                    hintText: 'Search ${data['title']}',
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
                              ? AllColors.mediumPurple.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: Text(
                                  item.label,
                                  style: const TextStyle(
                                      fontSize: 14.5, color: Colors.black),
                                ),
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
                                          color: AllColors.mediumPurple),
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
        filterOptionss: [
          FilterOption(
            id: 'range',
            label: 'Range',
            hintText: 'Select Date',
            icon: Icons.calendar_today,
            isMultiSelect: false,
          ),
          FilterOption(
            id: 'search_customer',
            label: 'Search Customer',
            hintText: 'Search',
            icon: Icons.person,
            isMultiSelect: true,
          ),
        ],
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
              if (isSingleSelect) {
                final selectedItem = selected.first;
                switch (filterId) {
                  case 'search_customer':
                    selectedFilters['search_customer'] = selectedItem.id;
                    break;
                  default:
                    selectedFilters[filterId] =
                        selectedItem.id ?? selectedItem.label;
                }
              } else {
                selectedFilters[filterId] =
                    selected.map((item) => item.id ?? item.label).toList();
              }
            }
          });

          try {
            if (createDateController.text.isNotEmpty) {
              selectedFilters.addAll(jsonDecode(createDateController.text));
            }
          } catch (e) {
            print('Error parsing date range filters: $e');
          }

          print('Selected Filters: $selectedFilters');
          _viewModel.applyFilters(selectedFilters);
        },
      ),
    );
  }
}
