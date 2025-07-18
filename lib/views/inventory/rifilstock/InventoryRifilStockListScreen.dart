import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/container_Utils/ContainerUtils.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/inventory/refillStocks/inventory_refill_stocks_viewModel.dart';

class InventoryRifilStockListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const InventoryRifilStockListScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<InventoryRifilStockListScreen> createState() =>
      _InventoryRifilStockListScreenState();
}

class _InventoryRifilStockListScreenState
    extends State<InventoryRifilStockListScreen> {
  final InventoryRefillStocksViewModel _viewModel =
      Get.put(InventoryRefillStocksViewModel());

  @override
  void initState() {
    super.initState();
    // Fetch data only if it hasn’t been loaded yet (no forceRefresh)
    _viewModel.inventoryRefillApi(context);
  }

  Future<void> _refreshProjectList() async {
    // Force refresh when the user pulls to refresh
    await _viewModel.inventoryRefillApi(context, forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: DarkMode.backgroundColor(context),
      body: Obx(() {
        if (_viewModel.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_viewModel.inventoryItems.isEmpty) {
          return const Center(child: Text("No items available"));
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
                      'Inventory Stock Refill',
                      style: TextStyle(
                        color: AllColors.blackColor,
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
                    if (_viewModel.inventoryItems.isEmpty) {
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
                          children: _viewModel.inventoryItems.map((item) {
                            return StaggeredGridTile.fit(
                              crossAxisCellCount: 1,
                              child: GestureDetector(
                                onTap: () {},
                                child: ContainerUtils(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.manufacturer?.name ??
                                            'Manufacturer Name Not Available',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          fontFamily: FontFamily.sfPro,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Image.asset(ImageStrings.date,
                                              height: 13, width: 13),
                                          const SizedBox(width: 10),
                                          Text(
                                            formatDateWithTime(item.createdAt ??
                                                'Date Not Available'),
                                            style: TextStyle(
                                              fontFamily: FontFamily.sfPro,
                                              fontSize: 12,
                                              color: AllColors.mediumPurple,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: AllColors.mediumPurple,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Text(
                                              '₹${NumberFormat('#,##,##0.00', 'en_IN').format(item.inventoryTransactions?.first.price ?? 0)}',
                                              style: TextStyle(
                                                color: AllColors.whiteColor,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: FontFamily.sfPro,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'MANUFACTURERS',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          fontFamily: FontFamily.sfPro,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            item.manufacturer?.name ??
                                                'No Manufacturer',
                                            style: TextStyle(
                                              color: AllColors.darkBlue,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            item.manufacturer?.email ?? 'N/A',
                                            style: TextStyle(
                                              color: AllColors.figmaGrey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'PRODUCT',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          fontFamily: FontFamily.sfPro,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            item.inventoryTransactions?.first
                                                        .price !=
                                                    null
                                                ? '₹${NumberFormat('#,##,##0.00', 'en_IN').format(item.inventoryTransactions!.first.price)}'
                                                : 'N/A',
                                            style: TextStyle(
                                              color: AllColors.figmaGrey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                          const Spacer(),
                                          const Text(
                                            'Price: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                          Text(
                                            item.inventoryTransactions?.first
                                                        .price !=
                                                    null
                                                ? '₹${NumberFormat('#,##,##0.00', 'en_IN').format(item.inventoryTransactions!.first.price)}'
                                                : 'N/A',
                                            style: TextStyle(
                                              color: AllColors.figmaGrey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'CREATOR: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                          Text(
                                            '${item.createdBy?.firstName ?? ''} ${item.createdBy?.lastName ?? ''}',
                                            style: TextStyle(
                                              color: AllColors.figmaGrey,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                          const Spacer(),
                                          const Text(
                                            'BATCH: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                          Text(
                                            item.inventoryTransactions?.first
                                                    .batch ??
                                                'N/A',
                                            style: TextStyle(
                                              color: AllColors.figmaGrey,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Divider(thickness: 0.5, height: 30),
                                      Row(
                                        children: [
                                          const Text(
                                            'Quantity: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                          Text(
                                            item.inventoryTransactions?.first
                                                    .quantity
                                                    .toString() ??
                                                'N/A',
                                            style: TextStyle(
                                              color: AllColors.figmaGrey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: item.inventoryTransactions
                                                          ?.first.cr ==
                                                      true
                                                  ? AllColors.lightRed
                                                  : item.inventoryTransactions
                                                              ?.first.dr ==
                                                          true
                                                      ? AllColors
                                                          .background_green
                                                      : AllColors.lightRed,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Text(
                                              item.inventoryTransactions?.first
                                                          .cr ==
                                                      true
                                                  ? 'Debit'
                                                  : item.inventoryTransactions
                                                              ?.first.dr ==
                                                          true
                                                      ? 'Credit'
                                                      : 'N/A',
                                              style: TextStyle(
                                                color: item.inventoryTransactions
                                                            ?.first.dr ==
                                                        true
                                                    ? AllColors.text__green
                                                    : item.inventoryTransactions
                                                                ?.first.cr ==
                                                            true
                                                        ? AllColors.vividRed
                                                        : AllColors.greenJungle,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: FontFamily.sfPro,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
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
}
