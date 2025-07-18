import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/imageStrings/image_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/product/brand/product_brand_viewModel.dart';
import '../../../viewModels/product/gstList/product_gstList_viewModel.dart';
import '../../../viewModels/saveToken/save_token.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../viewModels/leadScreens/createNewLead/constant_controller/constant_controller.dart';
import '../../../viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import '../../../viewModels/leadScreens/lead_list/lead_assign/lead_assign.dart';
import '../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../../leadScreens/leadList/widgets/manat.dart';

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

class ProductGstListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const ProductGstListScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _ProductGstListScreenState createState() => _ProductGstListScreenState();
}

class _ProductGstListScreenState extends State<ProductGstListScreen> {
  final DivisionsViewModel divisionList = Get.put(DivisionsViewModel());
  final ConstantValueViewModel staticText = Get.put(ConstantValueViewModel());
  final SaveUserData preference = SaveUserData();
  final ProductGstListViewModel _viewModel = Get.put(ProductGstListViewModel());
  SaveUserData userPreference = SaveUserData();
  String? userName = '';
  String? userEmail = '';
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();
  bool isFloatingButtonClicked = false;
  final ListLeadAssignViewModel searchAssigned =
      Get.put(ListLeadAssignViewModel());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? nameError;
  String? descriptionError;
  bool showAttachmentError = false;

  Future<void> _refreshGstList() async {
    _viewModel.loading.value = true; // Show loading indicator
    await _viewModel.fetchProductGstList(); // Fetch new data
    _viewModel.loading.value = false; // Hide loading indicator
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_viewModel.productGstList.isEmpty) {
        _viewModel.fetchProductGstList();
        divisionList.fetchDivisions();
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
                      'Available GST rates',
                      style: TextStyle(
                        color: DarkMode.backgroundColor2(context),
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 18.5,
                      ),
                    ),
                    const Spacer(),
                    // GestureDetector(
                    //     // onTap: () => openProformasFilterBottomSheet(context),
                    //     child: Icon(Icons.filter_list)),
                    // SizedBox(width: 10,),

                    CustomButton(
                        width: 70,
                        height: 22,
                        borderRadius: 54,
                        child: InkWell(
                          onTap: () {
                            _showDialog();
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
                onRefresh: _refreshGstList,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (_viewModel.productGstList.isEmpty) {
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
                    const double itemHeight = 154;
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
                      itemCount: _viewModel.productGstList.isNotEmpty
                          ? _viewModel.productGstList.length
                          : 1,
                      itemBuilder: (context, index) {
                        if (_viewModel.productGstList.isEmpty) {
                          return const Text("No products to display");
                        }

                        final productGst = _viewModel.productGstList[index];

                        return ContainerUtils(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Name and Status
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productGst.name ?? 'Unnamed Product',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 0),
                                    decoration: BoxDecoration(
                                      color: AllColors.background_green,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      productGst.status == 1
                                          ? 'Active'
                                          : 'Inactive',
                                      style: TextStyle(
                                        color: productGst.status == 1
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: FontFamily.sfPro,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Add some vertical spacing between rows
                              const SizedBox(height: 10),

                              // Date
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.date_range,
                                      color: AllColors.mediumPurple, size: 15),
                                  const SizedBox(width: 5),
                                  Text(
                                    formatDateToLongMonth(
                                        productGst.created_at ??
                                            'Unknown Date'),
                                    style: TextStyle(
                                      color: AllColors.mediumPurple,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              const Divider(thickness: 0.5, height: 30),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SGST
                                   Text(
                                    'SGST: ',
                                    style: TextStyle(
                                      color: DarkMode.backgroundColor2(context),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${productGst.sgst ?? '0'}%', // Data in grey, removed '$' symbol
                                    style: TextStyle(
                                      color:
                                          AllColors.figmaGrey, // Data in grey
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 12,
                                    ),
                                  ),

                                  const Spacer(),
                                  // CGST
                                   Text(
                                    'CGST: ',
                                    style: TextStyle(
                                      color: DarkMode.backgroundColor2(context),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${productGst.cgst ?? 0}',
                                    style: TextStyle(
                                      color: AllColors.figmaGrey,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 12,
                                    ),
                                  ),

                                  const Spacer(),
                                  // IGST
                                   Text(
                                    'IGST: ',
                                    style: TextStyle(
                                      color: DarkMode.backgroundColor2(context),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${productGst.igst ?? 0}',
                                    style: TextStyle(
                                      color: AllColors.figmaGrey,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 12,
                                    ),
                                  ),

                                  const Spacer(),
                                  Image.asset(
                                    ImageStrings.edit,
                                    height: 14,
                                    width: 14,
                                  ),
                                ],
                              ),

                              // Divider for better separation
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

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AllColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Add New Brand',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontFamily.sfPro,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Name ',
                                      style: TextStyle(fontSize: 14)),
                                  TextSpan(
                                    text: '* ',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            CommonTextField(
                              controller: _nameController,
                              hintText: 'Enter your name',
                              borderColor: AllColors.mediumPurple,
                              prefixIcon: Icon(Icons.person,
                                  color: AllColors.grey, size: 18),
                              hasError: nameError != null,
                              containerHeight: 40,
                              containerPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              textFieldPadding:
                                  const EdgeInsets.symmetric(vertical: 4),
                            ),
                            if (nameError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  nameError!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                            const SizedBox(height: 16),
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Division ',
                                      style: TextStyle(fontSize: 14)),
                                  TextSpan(
                                    text: '* ',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            CommonTextField(
                              controller: _nameController,
                              hintText: 'Select Division',
                              borderColor: AllColors.mediumPurple,
                              prefixIcon: Icon(Icons.person,
                                  color: AllColors.grey, size: 18),
                              hasError: nameError != null,
                              containerHeight: 40,
                              containerPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              textFieldPadding:
                                  const EdgeInsets.symmetric(vertical: 4),
                            ),
                            if (nameError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  nameError!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                            const SizedBox(height: 16),
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Description ',
                                      style: TextStyle(fontSize: 14)),
                                  TextSpan(
                                    text: '* ',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            CommonTextField(
                              controller: _descriptionController,
                              hintText: 'Description',
                              hasError: descriptionError != null,
                              prefixIcon: Icon(Icons.description,
                                  color: AllColors.grey, size: 18),
                              containerHeight: 40,
                              containerPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              textFieldPadding:
                                  const EdgeInsets.symmetric(vertical: 4),
                            ),
                            if (descriptionError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  descriptionError!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                            const SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    height: Get.height / 34,
                                    width: 100,
                                    child: Text('Save',
                                        style: TextStyle(
                                            color: AllColors.whiteColor,
                                            fontSize: 12)),
                                    onPressed: () {
                                      setState(() {
                                        nameError = null;
                                        descriptionError = null;
                                      });

                                      if (_nameController.text.isEmpty) {
                                        setState(() {
                                          nameError = 'Name is required';
                                        });
                                      }

                                      if (_descriptionController.text.isEmpty) {
                                        setState(() {
                                          descriptionError =
                                              'Description is required';
                                        });
                                      }

                                      if (nameError == null &&
                                          descriptionError == null) {
                                        // Handle saving the new brand logic here
                                        _resetForm();
                                        Get.back();
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 40),
                                  CustomButton(
                                    backgroundColor: AllColors.whiteColor,
                                    height: Get.height / 34,
                                    width: 100,
                                    child: Text('Reset',
                                        style: TextStyle(
                                            color: AllColors.blackColor,
                                            fontSize: 12)),
                                    onPressed: () {
                                      _resetForm();
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -10,
                      right: -10,
                      child: Container(
                        height: 28,
                        padding: const EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.close,
                              color: Colors.black, size: 14),
                          onPressed: () {
                            _resetForm();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _resetForm() {
    _nameController.clear();
    _descriptionController.clear();
    nameError = null;
    descriptionError = null;
    showAttachmentError = false;
  }
}
