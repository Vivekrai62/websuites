import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import '../../../resources/appUrls/app_urls.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/product/category/product_category_viewModel.dart';
import 'package:file_picker/file_picker.dart';

import '../../../viewModels/saveToken/save_token.dart';
import '../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class CategoryListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const CategoryListScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  bool showAttachmentError = false;
  Map<String, dynamic>? attachment;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _parentCategoryController =
      TextEditingController();
  String? nameError;
  String? descriptionError;

  final ProductCategoryViewModel _viewModel =
      Get.put(ProductCategoryViewModel());
  SaveUserData userPreference = SaveUserData();

  String? userName = '';
  String? userEmail = '';

  @override
  void initState() {
    super.initState();
    _fetchCategories(); // Initial fetch
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _parentCategoryController.dispose();
    super.dispose();
  }

  // Method to fetch categories
  Future<void> _fetchCategories({bool forceRefresh = false}) async {
    await _viewModel.productCategory(context, forceRefresh: forceRefresh);
  }

  void _resetForm() {
    _nameController.clear();
    _descriptionController.clear();
    _parentCategoryController.clear();
    setState(() {
      attachment = null;
      showAttachmentError = false;
    });
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
                              'Add New Product Category',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontFamily.sfPro,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Name Field
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
                              hasError: nameError != null, // Pass error state

                              containerHeight: 40,
                              containerPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              textFieldPadding:
                                  const EdgeInsets.symmetric(vertical: 4),
                            ),
                            if (nameError !=
                                null) // Show error message if exists
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  nameError!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                            const SizedBox(height: 16),

// Description Field
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
                              hasError: nameError != null, // Pass error state

                              prefixIcon: Icon(Icons.description,
                                  color: AllColors.grey, size: 18),
                              containerHeight: 40,
                              containerPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              textFieldPadding:
                                  const EdgeInsets.symmetric(vertical: 4),
                            ),
                            if (descriptionError !=
                                null) // Show error message if exists
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  descriptionError!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                            const SizedBox(height: 16),
                            // Parent Categories Field
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Parent Categories ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            CommonTextField(
                              controller: _parentCategoryController,
                              hintText: 'Parent Categories',
                              containerHeight: 40,
                              prefixIcon: Icon(Icons.category_sharp,
                                  color: AllColors.grey, size: 18),
                              containerPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              textFieldPadding:
                                  const EdgeInsets.symmetric(vertical: 4),
                            ),
                            const SizedBox(height: 16),

                            // File Upload Section
                            const Row(
                              children: [
                                Icon(Icons.upload, size: 14),
                                SizedBox(width: 4),
                                Text('Upload', style: TextStyle(fontSize: 14)),
                                Text('*',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red)),
                                Text(' ( Ideal Size of icon is 50*26 )',
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                CustomButton(
                                  height: Get.height / 34,
                                  width: 100,
                                  backgroundColor: AllColors.greyGoogleForm,
                                  child: Text('Choose files',
                                      style: TextStyle(
                                          color: AllColors.blackColor,
                                          fontSize: 12)),
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles();
                                    if (result != null) {
                                      setState(() {
                                        attachment = {
                                          'file': result.files.single.path,
                                          'name': result.files.single.name,
                                        };
                                        showAttachmentError = false;
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      attachment != null
                                          ? attachment!['name']
                                          : 'No file chosen',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            if (showAttachmentError)
                              const Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text(
                                  'File is required',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),

                            // Buttons
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
                                        nameError =
                                            null; // Reset error messages
                                        descriptionError = null;
                                      });

                                      // Validate Name
                                      if (_nameController.text.isEmpty) {
                                        setState(() {
                                          nameError = 'Name is required';
                                        });
                                      }

                                      // Validate Description
                                      if (_descriptionController.text.isEmpty) {
                                        setState(() {
                                          descriptionError =
                                              'Description is required';
                                        });
                                      }

                                      // Check if there are any errors
                                      if (nameError == null &&
                                          descriptionError == null) {
                                        if (attachment == null) {
                                          setState(() {
                                            showAttachmentError = true;
                                          });
                                          return;
                                        }

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

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor:  DarkMode.backgroundColor(context),
      // drawer: CustomDrawer(
      //   userName: '$userName',
      //   phoneNumber: '$userEmail',
      //   version: '1.0.12',
      // ),
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
                      'Category',
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
                      child: InkWell(
                        onTap: () {
                          _showDialog();
                        },
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
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _fetchCategories(
                    forceRefresh: true), // Force refresh on pull
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (_viewModel.categories.isEmpty) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: constraints.maxHeight,
                          child: const Center(
                            child: Text("No categories found"),
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
                    const double itemHeight = 93;
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
                      itemCount: _viewModel.filteredCategories.isNotEmpty
                          ? _viewModel.filteredCategories.length
                          : 1,
                      itemBuilder: (context, index) {
                        if (_viewModel.filteredCategories.isEmpty) {
                          return const Text("No products to display");
                        }

                        final category = _viewModel.filteredCategories[index];

                        return ContainerUtils(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.name ?? 'Unnamed Category',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  Image.asset(ImageStrings.edit,
                                      height: 16, width: 16),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(ImageStrings.date,
                                      height: 12, width: 12),
                                  const SizedBox(width: 8),
                                  Text(
                                    formatDateWithTime(
                                        category.createdAt ?? 'Unknown Date'),
                                    style: TextStyle(
                                      color: AllColors.mediumPurple,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text('Image Pending'),
                                  // Image.network(
                                  //   category.image != null && category.image!.isNotEmpty
                                  //       ? 'https://dev.whsuites.com/api/public/product_category/${category.image}'
                                  //       : 'https://placehold.co/50x26',
                                  //   height: 26,
                                  //   width: 50,
                                  //   fit: BoxFit.contain,
                                  //   errorBuilder: (context, error, stackTrace) {
                                  //     print('Image load error: $error');
                                  //     print(
                                  //         'Attempted URL: https://dev.whsuites.com/public/product_category/${category.image}');
                                  //     return Image.asset(
                                  //       'assets/images/placeholder.png',
                                  //       height: 26,
                                  //       width: 50,
                                  //       fit: BoxFit.contain,
                                  //     );
                                  //   },
                                  //   loadingBuilder: (context, child, loadingProgress) {
                                  //     if (loadingProgress == null) return child;
                                  //     return SizedBox(
                                  //       height: 26,
                                  //       width: 50,
                                  //       child: Center(
                                  //         child: CircularProgressIndicator(
                                  //           value: loadingProgress.expectedTotalBytes != null
                                  //               ? loadingProgress.cumulativeBytesLoaded /
                                  //               (loadingProgress.expectedTotalBytes ?? 1)
                                  //               : null,
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
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
