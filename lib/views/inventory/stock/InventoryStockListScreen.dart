import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/inventory/stock/inventory_stock_viewModel.dart';
import '../../../viewModels/saveToken/save_token.dart';

class InventoryStockListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const InventoryStockListScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<InventoryStockListScreen> createState() =>
      _InventoryStockListScreenState();
}

class _InventoryStockListScreenState extends State<InventoryStockListScreen> {
  SaveUserData userPreference = SaveUserData();
  final InventoryStockViewModel _viewModel = Get.put(InventoryStockViewModel());
  String? userName = '';
  String? userEmail = '';

  final RxSet<int> _expandedItems = RxSet<int>();

  @override
  void initState() {
    super.initState();
    // No need to call the API here; the ViewModel's onInit will handle it
  }

  void _toggleItemExpansion(int index) {
    if (_expandedItems.contains(index)) {
      _expandedItems.remove(index);
    } else {
      _expandedItems.add(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: DarkMode.backgroundColor(context),
      // drawer: CustomDrawer(
      //   userName: '$userName',
      //   phoneNumber: '$userEmail',
      //   version: '1.0.12',
      // ),
      body: Obx(() {
        return _viewModel.loading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  CustomAppBar(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 40, right: 15, left: 5),
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
                            'Inventory Stock',
                            style: TextStyle(
                              // backgroundColor: DarkMode.backgroundColor(context),
                              color: DarkMode.backgroundColor2(context),
                              fontWeight: FontWeight.w700,
                              fontSize: 17.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _refreshProjectList,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (_viewModel
                                  .inventoryStocks.value?.items?.isEmpty ??
                              true) {
                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height: constraints.maxHeight,
                                child: const Center(
                                  child: Text("No inventory stock available"),
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

                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: StaggeredGrid.count(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                children: List.generate(
                                  _viewModel.inventoryStocks.value?.items
                                          ?.length ??
                                      0,
                                  (index) {
                                    final item = _viewModel
                                        .inventoryStocks.value?.items?[index];
                                    return Obx(() {
                                      final bool isExpanded =
                                          _expandedItems.contains(index);

                                      return StaggeredGridTile.fit(
                                        crossAxisCellCount: 1,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: ContainerUtils(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 9,
                                                      child: Text(
                                                        item?.product?.name ??
                                                            '',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    GestureDetector(
                                                      onTap: () =>
                                                          _toggleItemExpansion(
                                                              index),
                                                      child: AnimatedRotation(
                                                        turns: isExpanded
                                                            ? 0.5
                                                            : 0.0,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        child: const Icon(
                                                            Icons
                                                                .arrow_drop_down_outlined,
                                                            size: 17),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 12,
                                                          vertical: 0),
                                                      decoration: BoxDecoration(
                                                        color: AllColors
                                                            .background_green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Text(
                                                        '₹${item?.product?.salePrice ?? '0'}',
                                                        style: TextStyle(
                                                          color: AllColors
                                                              .text__green,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    const Text(
                                                      'QUANTITY : ',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            FontFamily.sfPro,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${item?.quantity ?? '0'}',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            AllColors.figmaGrey,
                                                        fontFamily:
                                                            FontFamily.sfPro,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                if (isExpanded) ...[
                                                  const SizedBox(height: 8),
                                                  const Divider(
                                                      thickness: 0.5,
                                                      height: 40),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (item?.inventoryStocks
                                                              ?.isEmpty ??
                                                          true)
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          2),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AllColors
                                                                    .lightBlue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                              ),
                                                              child: Text(
                                                                'First Lot',
                                                                style:
                                                                    TextStyle(
                                                                  color: AllColors
                                                                      .darkBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .sfPro,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  'BATCH : ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    'N/A',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: AllColors
                                                                          .figmaGrey,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Text(
                                                                  'QUANTITY: ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '0',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: AllColors
                                                                        .figmaGrey,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  'Price ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    '0',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: AllColors
                                                                          .figmaGrey,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Text(
                                                                  'Expiry Date : ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'N/A',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: AllColors
                                                                        .figmaGrey,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  'Manufacturers: ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    'N/A',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: AllColors
                                                                          .figmaGrey,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      else
                                                        ...item!
                                                            .inventoryStocks!
                                                            .asMap()
                                                            .entries
                                                            .map((entry) {
                                                          int idx = entry.key;
                                                          var stock =
                                                              entry.value;
                                                          String lotLabel = idx ==
                                                                  0
                                                              ? 'First Lot'
                                                              : idx == 1
                                                                  ? 'Second Lot'
                                                                  : '${idx + 1}th Lot';

                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              if (idx > 0)
                                                                const SizedBox(
                                                                    height: 12),
                                                              Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AllColors
                                                                      .lightBlue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                                child: Text(
                                                                  lotLabel,
                                                                  style:
                                                                      TextStyle(
                                                                    color: AllColors
                                                                        .darkBlue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .sfPro,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    'BATCH : ',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      stock.batch ??
                                                                          'N/A',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: AllColors
                                                                            .figmaGrey,
                                                                        fontFamily:
                                                                            FontFamily.sfPro,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                    'QUANTITY: ',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${stock.quantity ?? '0'}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: AllColors
                                                                          .figmaGrey,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    'Price ',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      '${stock.price ?? '0'}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: AllColors
                                                                            .figmaGrey,
                                                                        fontFamily:
                                                                            FontFamily.sfPro,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                    'Expiry Date : ',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    stock.expiryDate !=
                                                                            null
                                                                        ? formatDateToDDMMYYYY(
                                                                            stock.expiryDate)
                                                                        : 'N/A',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: AllColors
                                                                          .figmaGrey,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    'Manufacturers: ',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .sfPro,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      stock.manufacturer
                                                                              ?.name ??
                                                                          'N/A',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: AllColors
                                                                            .figmaGrey,
                                                                        fontFamily:
                                                                            FontFamily.sfPro,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                    ],
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                ),
                              ),
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

  Future<void> _refreshProjectList() async {
    await _viewModel.inventoryStockApiFromService();
  }
}
