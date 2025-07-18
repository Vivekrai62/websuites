import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../viewModels/inventory/request/inventory_request_viewModel.dart';
import 'package:intl/intl.dart';
import '../../../viewModels/saveToken/save_token.dart';

class InventoryRequestListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const InventoryRequestListScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<InventoryRequestListScreen> createState() =>
      _InventoryRequestListScreenState();
}

class _InventoryRequestListScreenState
    extends State<InventoryRequestListScreen> {
  SaveUserData userPreference = SaveUserData();
  String? userName = '';
  String? userEmail = '';
  final InventoryRequestViewModel _viewModel =
      Get.put(InventoryRequestViewModel());
  final Map<String, bool> _expandedItems = {};

  @override
  void initState() {
    super.initState();
    _viewModel.inventoryRequestApi(context);
  }

  Future<void> _refreshProjectList() async {
    await _viewModel.inventoryRequestApi(context);
  }

  String formatDate(String? date) {
    if (date == null) return 'N/A';
    try {
      final DateTime dateTime = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(dateTime);
    } catch (e) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: DarkMode.backgroundColor(context),
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
                            'Inventory Request',
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
                          if (_viewModel.inventoryRequests.isEmpty) {
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
                                children:
                                    _viewModel.inventoryRequests.map((item) {
                                  final manufacturer = item.manufacturer;
                                  final firstProduct = item
                                              .inventoryRequestProducts
                                              ?.isNotEmpty ==
                                          true
                                      ? item.inventoryRequestProducts![0]
                                      : null;

                                  final itemKey =
                                      item.id ?? item.hashCode.toString();
                                  final isExpanded =
                                      _expandedItems[itemKey] ?? false;

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
                                                  manufacturer?.name ?? 'N/A',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 17.5,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                  icon: Icon(
                                                    isExpanded
                                                        ? Icons
                                                            .arrow_drop_up_outlined
                                                        : Icons
                                                            .arrow_drop_down_outlined,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _expandedItems[itemKey] =
                                                          !isExpanded;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  ImageStrings.date,
                                                  height: 14,
                                                  width: 14,
                                                ),
                                                Text(
                                                  '  ${formatDate(item.createdAt)}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                    fontSize: 12,
                                                    color:
                                                        AllColors.mediumPurple,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: AllColors.lightBlue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Text(
                                                    '${item.createdBy?.firstName ?? ''} ${item.createdBy?.lastName ?? ''}',
                                                    style: TextStyle(
                                                      color: AllColors.darkBlue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (isExpanded) ...[
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
                                                    manufacturer?.name ?? 'N/A',
                                                    style: TextStyle(
                                                      color: AllColors.darkBlue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Icon(
                                                    Icons.email_outlined,
                                                    color: AllColors.figmaGrey,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    manufacturer?.email ??
                                                        'N/A',
                                                    style: TextStyle(
                                                      color:
                                                          AllColors.figmaGrey,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                  Expanded(
                                                    child: Text(
                                                      firstProduct
                                                              ?.product?.name ??
                                                          'N/A',
                                                      style: TextStyle(
                                                        color:
                                                            AllColors.darkBlue,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            FontFamily.sfPro,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Quantity : ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${firstProduct?.quantity ?? 'N/A'}',
                                                    style: TextStyle(
                                                      color:
                                                          AllColors.figmaGrey,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  const Text(
                                                    'Price : ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                    ),
                                                  ),
                                                  Text(
                                                    '₹${firstProduct?.price ?? 'N/A'}',
                                                    style: TextStyle(
                                                      color:
                                                          AllColors.figmaGrey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Requested : ',
                                                    style: TextStyle(
                                                      color:
                                                          AllColors.greenJungle,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text(
                                                    formatDate(
                                                        item.requestDate),
                                                    style: TextStyle(
                                                      color:
                                                          AllColors.figmaGrey,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    'Deadline : ',
                                                    style: TextStyle(
                                                      color: AllColors.vividRed,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                    ),
                                                  ),
                                                  Text(
                                                    formatDate(
                                                        item.deadlineDate),
                                                    style: TextStyle(
                                                      color:
                                                          AllColors.figmaGrey,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          FontFamily.sfPro,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                  thickness: 0.5, height: 40),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 3),
                                                    decoration: BoxDecoration(
                                                      color: AllColors
                                                          .background_green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: Text(
                                                      item.status ?? 'N/A',
                                                      style: TextStyle(
                                                        color: AllColors
                                                            .greenJungle,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            FontFamily.sfPro,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 3),
                                                    decoration: BoxDecoration(
                                                      color: AllColors
                                                          .mediumPurple,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: Text(
                                                      'Update',
                                                      style: TextStyle(
                                                        color: AllColors
                                                            .whiteColor,
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
