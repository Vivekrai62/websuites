import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../resources/imageStrings/image_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datafilter/SeletDateFilter.dart';
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
import '../../../viewModels/product/brand/product_brand_viewModel.dart';
import '../../../viewModels/product/category/product_category_viewModel.dart';
import '../../../viewModels/product/list/product_list_viewModel.dart';
import '../../../viewModels/saveToken/save_token.dart';
import '../../customerScreens/customerList/customerdetails/CustomerDetailsScreen.dart';
import '../../homeScreen/home_manager/HomeManagerScreen.dart';
import '../../homeScreen/home_manager/dumy/practicescreen.dart';
import '../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../../leadScreens/leadList/leadlist_screen.dart';
import '../../leadScreens/leadList/widgets/manat.dart';
import 'package:websuites/data/models/responseModels/products/list/products_list_response_model.dart'
    as customer_model;

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

class ProductsListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const ProductsListScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final DivisionsViewModel divisionList = Get.put(DivisionsViewModel());
  final ConstantValueViewModel staticText = Get.put(ConstantValueViewModel());
  final SaveUserData preference = SaveUserData();
  final ProductListViewModel viewModel = Get.put(ProductListViewModel());
  final ProductBrandViewModel productBrand = Get.put(ProductBrandViewModel());
  TextEditingController searchController = TextEditingController();
  bool isFloatingButtonClicked = false;
  final ListLeadAssignViewModel searchAssigned =
      Get.put(ListLeadAssignViewModel());
  String userName = '';
  String userEmail = '';

  Future<void> _refreshProductList() async {
    viewModel.loading.value = true;
    await viewModel.productList();
    viewModel.loading.value = false;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.products.isEmpty) {
        viewModel.productList();
        divisionList.fetchDivisions();
        productBrand.productBrands();
      }
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
        if (viewModel.loading.value) {
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
                          if (widget.scaffoldKey.currentState != null) {
                            if (!widget
                                .scaffoldKey.currentState!.isDrawerOpen) {
                              widget.scaffoldKey.currentState!.openDrawer();
                            }
                          } else {
                            debugPrint("Scaffold key has no current state");
                          }
                        },
                      ),
                    if (isTablet) const SizedBox(width: 10),
                    Text(
                      'Products List',
                      style: TextStyle(
                        color: DarkMode.backgroundColor2(context),
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 18.5,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () => openProformasFilterBottomSheet(context),
                        child: const Icon(Icons.filter_list)),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                        width: 70,
                        height: 22,
                        borderRadius: 54,
                        child: InkWell(
                          onTap: () {
                            _showAddProductBottomSheet();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: AllColors.whiteColor,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Add',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.sfPro),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {})
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshProductList,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (viewModel.products.isEmpty) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: constraints.maxHeight,
                          child: const Center(
                            child: Text("No products available"),
                          ),
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
                    const double itemHeight = 210;
                    final double childAspectRatio = itemWidth / itemHeight;

                    return GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: childAspectRatio,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: viewModel.products.isNotEmpty
                          ? viewModel.products.length
                          : 1,
                      itemBuilder: (context, index) {
                        if (viewModel.products.isEmpty) {
                          return const Text("No products to display");
                        }

                        final product = viewModel.products[index];
                        return ContainerUtils(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.name ?? 'Unknown Product',
                                      style: const TextStyle(
                                        fontFamily: FontFamily.sfPro,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 22,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: product.status == true
                                          ? AllColors.background_green
                                          : AllColors
                                              .lightRed, // Green if true, Red if false
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          product.status == true
                                              ? 'Active'
                                              : 'Inactive', // Active if true, Inactive if false
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: product.status == true
                                                ? AllColors.text__green
                                                : AllColors
                                                    .vividRed, // White text color for both active and inactive
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    product.productCategory?.name ?? 'N/A',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: FontFamily.sfPro,
                                        fontWeight: FontWeight.w400,
                                        color: AllColors.figmaGrey),
                                  ),
                                  const Spacer(),
                                  Text(
                                    product.division?.name ?? 'N/A',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: FontFamily.sfPro,
                                        fontWeight: FontWeight.w400,
                                        color: AllColors.figmaGrey),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    ImageStrings.date,
                                    height: 14,
                                    width: 14,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    formatDateWithTime(
                                      product.updatedAt.toString() ?? 'N/A',
                                    ),
                                    style: TextStyle(
                                        color: AllColors.mediumPurple,
                                        fontFamily: FontFamily.sfPro,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Link : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        fontFamily: FontFamily.sfPro,
                                        color: AllColors.darkBlue),
                                  ),
                                  Icon(
                                    Icons.compare_arrows,
                                    size: 14,
                                    color: AllColors.darkBlue,
                                  )

                                  // Text('QUANTITY : ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,fontFamily: FontFamily.sfPro),),
                                  // Text(product.mrp.toString() ??'N/A',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14,fontFamily: FontFamily.sfPro),)
                                  //
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'MRP : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        fontFamily: FontFamily.sfPro),
                                  ),
                                  Text(
                                    '₹${product.mrp.toString() ?? 'N/A'}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontFamily:
                                          'SFPro', // Adjust if FontFamily.sfPro is a variable
                                      color: AllColors.figmaGrey,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Divider(
                                thickness: 0.4,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(product.division?.name ?? 'N/A')
                            ],
                          ),
                        );
                      },
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

  void openProformasFilterBottomSheet(BuildContext context) {
    final Map<String, Widget Function(BuildContext)> customBuilders = {};
    final constants = staticText.constantList.isNotEmpty
        ? staticText.constantList.first
        : null;
    FilterUtils.searchText.value = '';

    final TextEditingController createDateController = TextEditingController();

    final filterData = {
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
      'status': {
        'title': 'Service Status',
        'hintText': 'Search Status',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(label: "Active"),
          FilterOptionItem(label: "InActive"),
        ]),
      },
      'brands': {
        'title': 'Brands',
        'hintText': 'Brands',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          productBrand.productBrands.map((brands) {
            return FilterOptionItem(label: brands.name ?? 'N/A', id: brands.id);
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
            id: 'division',
            label: 'Division',
            hintText: 'Division',
            icon: Icons.business,
            isMultiSelect: true,
          ),
          FilterOption(
              id: 'status',
              label: 'Services Status',
              hintText: 'Search Status',
              icon: Icons.search,
              isMultiSelect: false),
          FilterOption(
            id: 'brands',
            label: 'Brands',
            hintText: 'Search Status', // Should this be 'Search Brands'?
            icon: Icons.search,
            isMultiSelect: false,
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
                  case 'division':
                    selectedFilters['division'] = selectedItem.id;
                    break;

                  case 'status':
                    // Map "Active" to true and "Inactive" to false
                    selectedFilters['status'] =
                        selectedItem.label == "Active" ? true : false;
                    break;

                  case ' brands': // Should be 'brands'
                    selectedFilters['brands'] = selectedItem.id;
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

          print('Selected Filters: $selectedFilters');
          Get.find<ProductListViewModel>().applyFilters(selectedFilters);
        },
      ),
    );
  }

  void _showAddProductBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Products',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.sfPro),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Name *'),
                CommonTextField(
                  containerPadding: const EdgeInsets.only(top: 5, bottom: 5),
                  hintText: 'Product Name',
                  allowCustomBorderInput: BorderRadius.circular(30),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('Products Type *'),
                CommonTextField(
                  containerPadding: const EdgeInsets.only(top: 5, bottom: 5),
                  hintText: 'Enter Title',
                  allowCustomBorderInput: BorderRadius.circular(30),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                          width: 70,
                          height: 22,
                          borderRadius: 54,
                          child: InkWell(
                            onTap: () {
                              // _showAddProductBottomSheet();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.sfPro),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {}),
                      const SizedBox(
                        width: 20,
                      ),
                      CustomButton(
                          backgroundColor: Colors.red,
                          width: 70,
                          height: 22,
                          borderRadius: 54,
                          child: InkWell(
                            onTap: () {
                              _showAddProductBottomSheet();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CANCEL',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.sfPro),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {}),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
