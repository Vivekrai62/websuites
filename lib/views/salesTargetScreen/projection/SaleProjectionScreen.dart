import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import '../../../data/models/requestModels/sales/projection/update/SalesUpdateProjectionReqModel.dart';
import '../../../data/models/responseModels/sales/projection/update/SalesUpdateProjectionListResponseModel.dart';
import '../../../data/repositories/repositories.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/container_Utils/ContainerUtils.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/sales/projection/SalesProjectionViewModel.dart';
import '../../../viewModels/sales/projection/update/SalesUpdateProjectionViewModel.dart';


class SaleProjectionScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const SaleProjectionScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<SaleProjectionScreen> createState() => _SaleProjectionScreenState();
}

class _SaleProjectionScreenState extends State<SaleProjectionScreen> {
  late final SalesProjectionViewModel controller;
  late final SalesUpdateProjectionViewModel updateController;
  TextEditingController searchController = TextEditingController();
  bool isFloatingButtonClicked = false;

  Future<void> _refreshCustomerList() async {
    controller.isLoading.value = true;
    await controller.fetchSalesProjections(context: context);
  }

  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<SalesProjectionViewModel>()) {
      final repositories = Get.put(Repositories());
      Get.put(SalesProjectionViewModel(repository: repositories));
    }
    if (!Get.isRegistered<SalesUpdateProjectionViewModel>()) {
      Get.put(SalesUpdateProjectionViewModel());
    }

    controller = Get.find<SalesProjectionViewModel>();
    updateController = Get.find<SalesUpdateProjectionViewModel>();

    controller.fetchSalesProjections();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Obx(() {
        if (controller.isLoading.value && controller.hasLoadedOnce.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.salesProjections.isEmpty) {
          return const Center(
            child: Text('No sales projections available'),
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
                      'Sales Projection',
                      style: TextStyle(
                        color: AllColors.blackColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 17.5,
                      ),
                    ),
                    const Spacer(),
                    const InkWell(
                      child: Icon(Icons.filter_list, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshCustomerList,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (controller.salesProjections.isEmpty) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: constraints.maxHeight,
                          child: const Center(
                            child: Text("No sales targets available"),
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
                    const double itemHeight = 188;
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
                                hintText: 'Search',
                                onSearch: (value) {
                                  // Trigger the search/filtering
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
                            itemCount: controller.salesProjections.length,
                            itemBuilder: (context, index) {
                              final projection =
                                  controller.salesProjections[index];
                              return GestureDetector(
                                onTap: () {
                                  // Add tap handling logic if needed
                                },
                                child: ContainerUtils(
                                  paddingBottom: 0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            projection.productCategory?.name ??
                                                'N/A',
                                            style: const TextStyle(
                                                fontFamily: FontFamily.sfPro,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          Image.asset('assets/icons/date.png',
                                              height: 12, width: 12),
                                          const SizedBox(width: 5),
                                          Text(
                                            formatDateWithDay(projection
                                                    .createdAt
                                                    .toString() ??
                                                'N/A'),
                                            style: TextStyle(
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: FontFamily.sfPro,
                                                color: AllColors.mediumPurple),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            'Product: ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: FontFamily.sfPro,
                                                color: AllColors.blackColor),
                                          ),
                                          Text(
                                            projection.product?.name ?? 'N/A',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: FontFamily.sfPro,
                                                color: AllColors.figmaGrey),
                                          ),
                                          const Spacer(),
                                          Text('₹${projection.amount}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: AllColors.vividRed)),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.auto_graph,
                                              color: AllColors.mediumPurple,
                                              size: 20),
                                          Text(
                                            ' ${formatDateWithDay(projection.projectionDate.toString() ?? 'N/A')}',
                                            style: TextStyle(
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: FontFamily.sfPro,
                                                color: AllColors.mediumPurple),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: AllColors.lightPurple,
                                            ),
                                            child: Text(
                                              '${projection.createdBy?.firstName ?? 'N/A'} ${projection.createdBy?.lastName}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AllColors.mediumPurple,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(thickness: 0.4),
                                      Row(
                                        children: [
                                          Image.asset(
                                            IconStrings.sales,
                                            height: 17,
                                            width: 17,
                                            color: AllColors.text__green,
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              '${projection.lead?.firstName ?? 'N/A'} ${projection.lead?.lastName ?? 'N/A'}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: FontFamily.sfPro,
                                                color: AllColors.figmaGrey,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              // Convert DateTime fields to strings before passing to dialog
                                              final formattedProjection = {
                                                'id': projection.id?.toString(),
                                                'amount': projection.amount,
                                                'isClosed': projection.isClosed,
                                                'status': projection.status,
                                                'projectionDate': projection
                                                            .projectionDate !=
                                                        null
                                                    ? (projection.projectionDate
                                                            is DateTime
                                                        ? DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(projection
                                                                .projectionDate!)
                                                        : projection
                                                            .projectionDate
                                                            .toString())
                                                    : null,
                                                'createdAt': projection
                                                            .createdAt !=
                                                        null
                                                    ? (projection.createdAt
                                                            is DateTime
                                                        ? DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(projection
                                                                .createdAt!)
                                                        : projection.createdAt
                                                            .toString())
                                                    : null,
                                                'updatedAt': projection
                                                            .updatedAt !=
                                                        null
                                                    ? (projection.updatedAt
                                                            is DateTime
                                                        ? DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(projection
                                                                .updatedAt!)
                                                        : projection.updatedAt
                                                            .toString())
                                                    : null,
                                                'productCategory':
                                                    projection.productCategory,
                                                'product': projection.product,
                                                'lead': projection.lead,
                                                'customer': projection.customer,
                                                'createdBy':
                                                    projection.createdBy,
                                              };
                                              _showDialog(
                                                  context, formattedProjection);
                                            },
                                            icon: Image.asset(
                                                'assets/icons/edit.png',
                                                height: 16,
                                                width: 16),
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

  void _showDialog(BuildContext context, dynamic projection) {
    TextEditingController dateController = TextEditingController();
    TextEditingController amountController =
        TextEditingController(text: projection['amount']?.toString());
    TextEditingController productController =
        TextEditingController(text: projection['product']?.name);
    TextEditingController categoryController =
        TextEditingController(text: projection['productCategory']?.name);

    if (projection['projectionDate'] != null) {
      try {
        DateTime parsedDate = DateTime.parse(projection['projectionDate']);
        dateController.text = DateFormat('dd-MM-yyyy').format(parsedDate);
      } catch (e) {
        dateController.text = projection['projectionDate'];
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Edit Sales Projection',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('Amount'),
                  const SizedBox(height: 5),
                  CreateNewLeadScreenCard2(
                    hintText: 'Enter Amount',
                    controller: amountController,
                  ),
                  const SizedBox(height: 10),
                  const Text('Product'),
                  const SizedBox(height: 5),
                  CreateNewLeadScreenCard2(
                    hintText: 'Enter Product',
                    controller: productController,
                  ),
                  const SizedBox(height: 10),
                  const Text('Product Category'),
                  const SizedBox(height: 5),
                  CreateNewLeadScreenCard2(
                    hintText: 'Enter Category',
                    controller: categoryController,
                  ),
                  const SizedBox(height: 10),
                  const Text('Select Date'),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () async {
                      DateTime initialDate = DateTime.now();
                      if (dateController.text.isNotEmpty) {
                        try {
                          List<String> dateParts =
                              dateController.text.split('-');
                          initialDate = DateTime(
                            int.parse(dateParts[2]), // Year
                            int.parse(dateParts[1]), // Month
                            int.parse(dateParts[0]), // Day
                          );
                        } catch (e) {
                          initialDate = DateTime.now();
                        }
                      }

                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: initialDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                                primary: AllColors.mediumPurple,
                                onPrimary: Colors.white,
                                surface: Colors.white,
                                onSurface: Colors.black,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (selectedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(selectedDate);
                        setState(() {
                          dateController.text = formattedDate;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: CreateNewLeadScreenCard2(
                        hintText: 'Select Date',
                        controller: dateController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: CustomButton(
                        width: 80,
                        height: 30,
                        borderRadius: 25,
                        onPressed: () async {
                          Get.back();
                          String formattedDate = '';
                          try {
                            List<String> dateParts =
                                dateController.text.split('-');
                            formattedDate =
                                '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}'; // yyyy-MM-dd
                          } catch (e) {
                            print('Error formatting date: $e');
                            return;
                          }

                          int? amount;
                          try {
                            amount = int.parse(amountController.text);
                          } catch (e) {
                            print('Error parsing amount: $e');
                            return;
                          }

                          final updatedProjection =
                              SalesUpdateProjectionListResponseModel(
                            id: projection['id']?.toString() ?? '',
                            amount: amount,
                            isClosed: projection['isClosed'],
                            status: projection['status'],
                            projectionDate: formattedDate,
                            createdAt:
                                projection['createdAt']?.toString() ?? '',
                            updatedAt:
                                projection['updatedAt']?.toString() ?? '',
                            productCategory: projection['productCategory'] !=
                                    null
                                ? ProductCategory(
                                    id: projection['productCategory'].id,
                                    name: projection['productCategory'].name,
                                  )
                                : null,
                            product: projection['product'] != null
                                ? Product(
                                    id: projection['product'].id,
                                    name: projection['product'].name,
                                  )
                                : null,
                            lead: projection['lead'] != null
                                ? Lead(
                                    id: projection['lead'].id,
                                    firstName: projection['lead'].firstName,
                                    lastName: projection['lead'].lastName,
                                  )
                                : null,
                            customer: projection['customer'] != null
                                ? Customer(
                                    id: projection['customer'].id,
                                    name: projection['customer'].name,
                                  )
                                : null,
                            createdBy: projection['createdBy'] != null
                                ? CreatedBy(
                                    id: projection['createdBy'].id,
                                    firstName:
                                        projection['createdBy'].firstName,
                                    lastName: projection['createdBy'].lastName,
                                  )
                                : null,
                          );

                          final viewModel =
                              Get.find<SalesUpdateProjectionViewModel>();
                          bool success = await viewModel.salesUpdateProjection(
                            projection['id'] ?? '',
                            formattedDate,
                            amount,
                          );

                          if (success) {
                            controller.fetchSalesProjections();
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Update',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
