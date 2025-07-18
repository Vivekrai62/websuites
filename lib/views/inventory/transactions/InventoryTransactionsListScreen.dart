import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart'; // GetX package
import 'package:intl/intl.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../../utils/container_Utils/ContainerUtils.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/inventory/transactions/inventory_transactions_viewModel.dart';
import '../../../viewModels/saveToken/save_token.dart';

class InventoryTransactionsListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const InventoryTransactionsListScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<InventoryTransactionsListScreen> createState() =>
      _InventoryTransactionsListScreenState();
}

class _InventoryTransactionsListScreenState
    extends State<InventoryTransactionsListScreen> {
  String? userName = '';
  String? userEmail = '';
  SaveUserData userPreference = SaveUserData();
  final InventoryTransactionsViewModel viewModel =
      Get.put(InventoryTransactionsViewModel());
  List<bool> _isExpanded = []; // Initialize as empty role

  @override
  void initState() {
    super.initState();
    // Call API and update _isExpanded when data is available
    viewModel.inventoryTransactionsApi(context).then((_) {
      setState(() {
        _isExpanded = List.generate(
          viewModel.inventoryTransactionsResponseModel.value.items?.length ?? 0,
          (_) => false,
        );
      });
    });
  }

  Future<void> _refreshProjectList() async {
    await viewModel.inventoryTransactionsApi(context);
    setState(() {
      _isExpanded = List.generate(
        viewModel.inventoryTransactionsResponseModel.value.items?.length ?? 0,
        (_) => false,
      );
    });
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
        if (viewModel.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Ensure _isExpanded matches the current items length
        if (_isExpanded.length !=
            (viewModel.inventoryTransactionsResponseModel.value.items?.length ??
                0)) {
          _isExpanded = List.generate(
            viewModel.inventoryTransactionsResponseModel.value.items?.length ??
                0,
            (_) => false,
          );
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
                      'Inventory Transaction',
                      style: TextStyle(
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
                    return Obx(() {
                      if (viewModel.inventoryTransactionsResponseModel.value
                              .items?.isEmpty ??
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
                              horizontal: 15, vertical: 15),
                          child: StaggeredGrid.count(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            children: List.generate(
                              viewModel.inventoryTransactionsResponseModel.value
                                      .items?.length ??
                                  0,
                              (index) {
                                final item = viewModel
                                    .inventoryTransactionsResponseModel
                                    .value
                                    .items?[index];

                                return StaggeredGridTile.fit(
                                  crossAxisCellCount: 1,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: ContainerUtils(
                                      paddingTop: 0,
                                      paddingBottom: 15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                item?.manufacturer?.name ??
                                                    'Manufacturer Name',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17.5,
                                                  fontFamily: FontFamily.sfPro,
                                                ),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                icon: Icon(
                                                  _isExpanded[index]
                                                      ? Icons
                                                          .arrow_drop_up_outlined
                                                      : Icons
                                                          .arrow_drop_down_outlined,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isExpanded[index] =
                                                        !_isExpanded[index];
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(ImageStrings.date,
                                                  height: 13, width: 13),
                                              const SizedBox(width: 10),
                                              Text(
                                                formatDateWithTime(
                                                    item?.createdAt ??
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 3),
                                                decoration: BoxDecoration(
                                                  color: AllColors.mediumPurple,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Text(
                                                  '₹${NumberFormat('#,##,##0.00', 'en_IN').format(item?.price)}',
                                                  style: TextStyle(
                                                    color: AllColors.whiteColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (_isExpanded[index]) ...[
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
                                                  item?.manufacturer?.name ??
                                                      'No Manufacturer',
                                                  style: TextStyle(
                                                    color: AllColors.darkBlue,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  item?.manufacturer?.email ??
                                                      'N/A',
                                                  style: TextStyle(
                                                    color: AllColors.figmaGrey,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              'PRODUCTS',
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
                                                  item?.product?.name ??
                                                      'No Product',
                                                  style: TextStyle(
                                                    color: AllColors.darkBlue,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Text(
                                                  '₹${NumberFormat('#,##,##0.00', 'en_IN').format(item?.price)}',
                                                  style: TextStyle(
                                                    color: AllColors.figmaGrey,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                  ),
                                                ),
                                                const Spacer(),
                                                const Text(
                                                  'Price : ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                  ),
                                                ),
                                                Text(
                                                  '₹${NumberFormat('#,##,##0.00', 'en_IN').format(item?.product?.mrp)}',
                                                  style: TextStyle(
                                                    color: AllColors.figmaGrey,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            const Divider(
                                                thickness: 0.5, height: 30),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Quantity : ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                  ),
                                                ),
                                                Text(
                                                  '${item?.quantity}',
                                                  style: TextStyle(
                                                    color: AllColors.figmaGrey,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: AllColors
                                                        .background_green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Text(
                                                    item?.cr == true
                                                        ? 'Credit'
                                                        : item?.dr == true
                                                            ? 'Debit'
                                                            : 'N/A',
                                                    style: TextStyle(
                                                      color:
                                                          AllColors.greenJungle,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    });
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
