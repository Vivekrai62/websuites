import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/container_Utils/ContainerUtils.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/inventory/vendors/inventory_vendors_viewModel.dart';

class InventoryVendorsListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const InventoryVendorsListScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<InventoryVendorsListScreen> createState() =>
      _InventoryVendorsListScreenState();
}

class _InventoryVendorsListScreenState
    extends State<InventoryVendorsListScreen> {
  final InventoryVendorsViewModel _viewModel =
      Get.put(InventoryVendorsViewModel());

  @override
  void initState() {
    super.initState();
    // Fetch data only if it hasn’t been loaded yet (no forceRefresh)
    _viewModel.inventoryVendorsApi(context);
  }

  Future<void> _refreshProjectList() async {
    // Force refresh when the user pulls to refresh
    await _viewModel.inventoryVendorsApi(context, forceRefresh: true);
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

        if (_viewModel.vendorItems.isEmpty) {
          return const Center(child: Text('No vendors found.'));
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
                      'Inventory Vendors',
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
                          children: _viewModel.vendorItems.map((vendor) {
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
                                        children: [
                                          Expanded(
                                            child: Text(
                                              vendor.name ?? 'No Name',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17.5,
                                                fontFamily: FontFamily.sfPro,
                                              ),
                                            ),
                                          ),
                                          Image.asset(ImageStrings.edit,
                                              height: 14, width: 14),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: [
                                            Image.asset(ImageStrings.call,
                                                height: 13, width: 13),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                vendor.mobile != null
                                                    ? '+91-${vendor.mobile}'
                                                    : 'No Phone Number',
                                                style: TextStyle(
                                                  color: AllColors.figmaGrey,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  fontFamily: FontFamily.sfPro,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Image.asset(
                                              ImageStrings.email,
                                              height: 13,
                                              width: 13,
                                              color: AllColors.vividBlue,
                                            ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              child: Text(
                                                vendor.email ?? 'No Email',
                                                style: TextStyle(
                                                  color: AllColors.vividBlue,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  fontFamily: FontFamily.sfPro,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Image.asset(
                                            ImageStrings.date,
                                            height: 12,
                                            width: 12,
                                            color: AllColors.mediumPurple,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            formatDateWithTime(
                                                vendor.createdAt ?? 'No Date'),
                                            style: TextStyle(
                                              fontFamily: FontFamily.sfPro,
                                              fontSize: 12,
                                              color: AllColors.mediumPurple,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Divider(thickness: 0.4),
                                      const SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            ImageStrings.location,
                                            height: 15,
                                            width: 15,
                                            color: AllColors.figmaGrey,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                vendor.address ?? 'No Address',
                                                style: TextStyle(
                                                  color: AllColors.figmaGrey,
                                                  fontFamily: FontFamily.sfPro,
                                                  fontSize: 12,
                                                ),
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
