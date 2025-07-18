import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../viewModels/product/master/product_master_viewModel.dart';
import '../../../resources/iconStrings/icon_strings.dart';

class ProductMasterListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const ProductMasterListScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _ProductMasterListScreenState createState() =>
      _ProductMasterListScreenState();
}

class _ProductMasterListScreenState extends State<ProductMasterListScreen> {
  final ProductMasterViewModel _viewModel = Get.put(ProductMasterViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch data only if it hasn’t been loaded yet (no forceRefresh)
      _viewModel.masterProductList(context);
    });
  }

  Future<void> _refreshProductList() async {
    // Force refresh when the user pulls to refresh
    await _viewModel.masterProductList(context, forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          // Add search or filter functionality here if needed
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
                      'Product Master List',
                      style: TextStyle(
                        color: DarkMode.backgroundColor2(context),
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 18.5,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      width: 70,
                      height: 22,
                      borderRadius: 54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add,
                              color: AllColors.whiteColor, size: 18),
                          const SizedBox(width: 5),
                          const Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.sfPro,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        // Add product creation logic here
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshProductList,
                child: _viewModel.items.isEmpty
                    ? const Center(child: Text("No products available"))
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          if (_viewModel.items.isEmpty) {
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
                          const double itemHeight = 195;
                          final double childAspectRatio =
                              itemWidth / itemHeight;

                          return GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: childAspectRatio,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: _viewModel.items.isNotEmpty
                                ? _viewModel.items.length
                                : 1,
                            itemBuilder: (context, index) {
                              if (_viewModel.items.isEmpty) {
                                return const Text("No products to display");
                              }

                              final item = _viewModel.items[index];

                              return ContainerUtils(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.product?.name ??
                                                'Unnamed Product',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontFamily: FontFamily.sfPro,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: AllColors.background_green,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Text(
                                            item.product?.status == true
                                                ? 'Active'
                                                : 'Inactive',
                                            style: TextStyle(
                                              color: AllColors.text__green,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: FontFamily.sfPro,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 7),
                                    Row(
                                      children: [
                                        const Text('IS ON SALE? - ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: FontFamily.sfPro,
                                                fontWeight: FontWeight.w600)),
                                        Text(
                                          item.is_sale == true ? 'YES' : 'NO',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AllColors.figmaGrey,
                                            fontFamily: FontFamily.sfPro,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: item.incentive_type ==
                                                    'percentage'
                                                ? Colors.orange
                                                : AllColors.lighterPurple,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Text(
                                            item.incentive_type == 'percentage'
                                                ? 'Percentage'
                                                : 'Flat',
                                            style: TextStyle(
                                              color: item.incentive_type ==
                                                      'percentage'
                                                  ? Colors.white
                                                  : AllColors.mediumPurple,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: FontFamily.sfPro,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 7),
                                    Row(
                                      children: [
                                        Icon(Icons.date_range,
                                            color: AllColors.mediumPurple,
                                            size: 15),
                                        const SizedBox(width: 4),
                                        Text(
                                          formatDateWithTime(item.created_at ??
                                              'Unknown Date'),
                                          style: TextStyle(
                                            color: AllColors.mediumPurple,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: FontFamily.sfPro,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Spacer(),
                                        const Text('QUANTITY: ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: FontFamily.sfPro,
                                                fontWeight: FontWeight.w600)),
                                        Text(
                                          item.product?.quantity != null &&
                                                  item.product?.quantity != 0
                                              ? '${item.product?.quantity}'
                                              : 'N/A',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AllColors.figmaGrey,
                                            fontFamily: FontFamily.sfPro,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 7),
                                    Row(
                                      children: [
                                        const Text('INCENTIVE: ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: FontFamily.sfPro,
                                                fontWeight: FontWeight.w600)),
                                        Text(
                                          item.incentive != null
                                              ? '${item.incentive} %'
                                              : 'N/A',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AllColors.figmaGrey,
                                            fontFamily: FontFamily.sfPro,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Spacer(),
                                        const Text('MIN SALE PRICE: ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: FontFamily.sfPro,
                                                fontWeight: FontWeight.w600)),
                                        Text(
                                          item.minimum_sale_price != null
                                              ? '₹ ${item.minimum_sale_price}'
                                              : 'N/A',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AllColors.figmaGrey,
                                            fontFamily: FontFamily.sfPro,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(thickness: 0.5, height: 30),
                                    Row(
                                      children: [
                                        const Text(
                                          'DESCRIPTION: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: FontFamily.sfPro,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            item.product?.description ?? 'N/A',
                                            style: TextStyle(
                                              color: AllColors.figmaGrey,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: FontFamily.sfPro,
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        const Icon(Icons.edit, size: 16),
                                      ],
                                    ),
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
}
