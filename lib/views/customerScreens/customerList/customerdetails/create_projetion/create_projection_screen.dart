import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/data/models/responseModels/leads/list/lead_list.dart';
import 'package:websuites/resources/strings/strings.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/components/widgets/appBar/custom_appBar.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/viewModels/leadScreens/createNewLead/product_category/product_category_controller.dart';
import 'package:websuites/viewModels/leadScreens/lead_list/lead_detail_view/leadProductsViewModel/LeadProductsViewModel.dart';
import 'package:websuites/viewModels/leadScreens/lead_list/lead_detail_view/projection/create/ProjetionViewModel.dart';
import 'package:websuites/views/homeScreen/home_manager/HomeManagerScreen.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';


import '../../../../../resources/textStyles/responsive/test_responsive.dart';
import '../../../../../utils/dark_mode/dark_mode.dart';
import '../CustomerDetailsScreen.dart';

class CustomerCreateProjectionScreenController extends GetxController {
  final RxList<Map<String, dynamic>> fieldSets = <Map<String, dynamic>>[].obs;
  final RxBool autoValidate = false.obs;
  final RxList<Map<String, String?>> errors = <Map<String, String?>>[].obs;
  final ProjectionViewModel projectionViewModel = Get.put(ProjectionViewModel());

  @override
  void onInit() {
    super.onInit();
    resetForm(); // Clear previous data and add a new field set
  }

  @override
  void onClose() {
    for (var fieldSet in fieldSets) {
      (fieldSet['category'] as TextEditingController?)?.dispose();
      (fieldSet['product'] as TextEditingController?)?.dispose();
      (fieldSet['amount'] as TextEditingController?)?.dispose();
      (fieldSet['date'] as TextEditingController?)?.dispose();
    }
    super.onClose();
  }

  void addFieldSet() {
    fieldSets.add({
      'category': TextEditingController(),
      'categoryId': '',
      'product': TextEditingController(),
      'productId': '',
      'amount': TextEditingController(),
      'date': TextEditingController(),
    });
    errors.add({
      'category': null,
      'product': null,
      'amount': null,
      'date': null,
    });
  }

  void removeFieldSet(int index) {
    fieldSets.removeAt(index);
    errors.removeAt(index);
    fieldSets.refresh();
    errors.refresh();
  }

  void resetForm() {
    for (var fieldSet in fieldSets) {
      (fieldSet['category'] as TextEditingController?)?.dispose();
      (fieldSet['product'] as TextEditingController?)?.dispose();
      (fieldSet['amount'] as TextEditingController?)?.dispose();
      (fieldSet['date'] as TextEditingController?)?.dispose();
    }
    fieldSets.clear();
    errors.clear();
    addFieldSet();
    autoValidate.value = false;
    fieldSets.refresh();
    errors.refresh();
  }

  void navigateToCustomerDetails(String customerId) {
    resetForm();
    final homeController = Get.find<HomeManagerController>();
    homeController.lastScreen.value = CustomerDetailsScreen(
      customerId: customerId,
      customerData: homeController.selectedCustomerDetail.value,
      scaffoldKey: GlobalKey<ScaffoldState>(),
    );
    homeController.showOrderDetails.value = true;
    homeController.update();
    Get.back();
  }

  void createProjection(BuildContext context, String leadId, Item? orderItem, String customerId) async {
    // Validate fields before creating projection
    bool isValid = true;
    errors.clear();
    for (var fieldSet in fieldSets) {
      String? dateError;
      String formattedDate = fieldSet['date']!.text;

      // Validate date and ensure it is in ISO 8601 format
      if (fieldSet['date']!.text.isEmpty) {
        dateError = 'Date is required';
      } else {
        try {
          final date = DateTime.parse(fieldSet['date']!.text);
          formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date.toUtc());
          // Optionally, validate ISO 8601 format
          if (!RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$').hasMatch(formattedDate)) {
            dateError = 'Invalid date format';
          }
        } catch (e) {
          dateError = 'Invalid date format';
        }
      }

      errors.add({
        'category': fieldSet['category']!.text.isEmpty ? 'Category is required' : null,
        'product': fieldSet['product']!.text.isEmpty ? 'Product is required' : null,
        'amount': fieldSet['amount']!.text.isEmpty ? 'Amount is required' : null,
        'date': dateError,
      });

      if (errors.last.values.any((error) => error != null)) {
        isValid = false;
      }
    }
    autoValidate.value = true;
    errors.refresh();

    if (!isValid) {
      return;
    }

    List<Map<String, dynamic>> projectionData = fieldSets.asMap().entries.map((entry) {
      final fieldSet = entry.value;
      String formattedDate = fieldSet['date']!.text;

      // Format date to ISO 8601
      try {
        final date = DateTime.parse(fieldSet['date']!.text);
        formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date.toUtc());
      } catch (e) {
        // This should not happen since validation passed, but keep as a safeguard
        print('Error parsing date: $e');
      }

      return {
        'category': fieldSet['category']!.text,
        'categoryId': fieldSet['categoryId'],
        'product': fieldSet['product']!.text,
        'productId': fieldSet['productId'],
        'amount': fieldSet['amount']!.text,
        'date': formattedDate,
      };
    }).toList();

    await projectionViewModel.projectionCreate(context, customerId, projectionData);

    if (projectionViewModel.errorMessage.value.isEmpty) {
      navigateToCustomerDetails(customerId);
    }
  }
}

class CustomerCreateProjectionScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Item? orderItem;
  final String customerId; // Added customerId to ensure proper navigation

  const CustomerCreateProjectionScreen({
    Key? key,
    required this.scaffoldKey,
    this.orderItem,
    required this.customerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productCategoryController = Get.put(ProductCategoryController());
    final leadProductsViewModel = Get.put(LeadProductsViewModel());
    final controller = Get.put(CustomerCreateProjectionScreenController());
    final homeController = Get.find<HomeManagerController>();
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    // Initialize data fetching
    productCategoryController.createLeadProductCategory(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      productCategoryController.createLeadProductCategory(context);
      leadProductsViewModel.fetchLeadProducts(context);
    });

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CustomAppBar(
            child: Row(
              children: [

                GestureDetector(
                  onTap: (){
                    controller.navigateToCustomerDetails(customerId);


      },
                  child:
                  Row(
                    children: [
                      Icon(CupertinoIcons.back,
                        color: DarkMode.backgroundColor2(context),),
                      const SizedBox(width: 8),
                      ResponsiveText.getAppBarTextSize(context, Strings.back),
                    ],
                  ),
                ),

                Spacer(),
                ResponsiveText.getAppBarTextSize(context, Strings.projection),


              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ResponsiveText.getTitle(context, Strings.productsCat,fontSize: 16,fontWeight: FontWeight.w600),

                        const Spacer(),
                        OutlinedButton.icon(
                          onPressed: () => controller.addFieldSet(),
                          icon: Icon(Icons.add, color: AllColors.greenJungle),
                          label: Text(
                            Strings.add2,
                            style: TextStyle(
                              color: AllColors.greenJungle,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AllColors.greenJungle),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...controller.fieldSets.asMap().entries.map((entry) {
                      final index = entry.key;
                      final fieldSet = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index > 0)
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: Strings.productsCat,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: DarkMode.editColor(context),
                                          fontFamily: FontFamily.sfPro,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                          fontFamily: FontFamily.sfPro,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                CircleAvatar(
                                  backgroundColor: AllColors.lightRed,
                                  child: IconButton(
                                    onPressed: () => controller.removeFieldSet(index),
                                    icon: Icon(Icons.close, color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 8),
                          CommonTextField(
                            validator: null,
                            hintText: "Select Category",
                            controller: fieldSet['category']!,
                            isEditable: true,
                            categories: productCategoryController.leadProductCategories
                                .map((category) => category.name ?? '')
                                .toList(),
                            onCategoryChanged: (selectedCategoryName) {
                              final selectedCategory = productCategoryController.leadProductCategories.firstWhereOrNull(
                                    (cat) => cat.name == selectedCategoryName,
                              );
                              if (selectedCategory != null) {
                                productCategoryController.updateSelectedCategories([selectedCategory.id ?? '']);
                                fieldSet['category']!.text = selectedCategory.name ?? '';
                                fieldSet['categoryId'] = selectedCategory.id ?? '';
                                leadProductsViewModel.selectedProduct.value = '';
                                fieldSet['product']!.clear();
                                fieldSet['productId'] = '';
                                fieldSet['amount']!.clear();
                                controller.fieldSets.refresh();
                              }
                            },
                          ),
                          if (controller.autoValidate.value && controller.errors[index]['category'] != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0, left: 12.0),
                              child: Text(
                                controller.errors[index]['category']!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                            ),
                          const SizedBox(height: 15),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: Strings.product,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: DarkMode.editColor(context),
                                    fontFamily: FontFamily.sfPro,
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                   color: Colors.red,
                                    fontFamily: FontFamily.sfPro,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Obx(() {
                            final selectedCategoryId = productCategoryController.selectedCategories.isNotEmpty
                                ? productCategoryController.selectedCategories.first
                                : '';
                            final productNames = leadProductsViewModel.getProductNamesByCategoryId(selectedCategoryId);

                            return CommonTextField(
                              hintText: "Select Product",
                              controller: fieldSet['product']!,
                              isEditable: true,
                              categories: productNames,
                              onCategoryChanged: (selectedProductName) {
                                leadProductsViewModel.selectedProduct.value = selectedProductName;
                                fieldSet['product']!.text = selectedProductName;

                                if (selectedProductName.isNotEmpty && leadProductsViewModel.products.isNotEmpty) {
                                  final matchingProduct = leadProductsViewModel.products.first.items.firstWhereOrNull(
                                        (item) => item.productCategory?.id == selectedCategoryId && item.name == selectedProductName,
                                  );

                                  if (matchingProduct != null) {
                                    fieldSet['productId'] = matchingProduct.id ?? '';
                                    fieldSet['amount']!.text = matchingProduct.mrp.toString();
                                    controller.fieldSets.refresh();
                                  }
                                }
                              },
                            );
                          }),
                          if (controller.autoValidate.value && controller.errors[index]['product'] != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0, left: 12.0),
                              child: Text(
                                controller.errors[index]['product']!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                            ),
                          const SizedBox(height: 15),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: Strings.amount,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: DarkMode.editColor(context),
                                    fontFamily: FontFamily.sfPro,
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontFamily: FontFamily.sfPro,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          CommonTextField(
                            controller: fieldSet['amount']!,
                            hintText: "Enter Amount",
                            validator: null,
                            onChanged: (text) {
                              if (controller.errors[index]['amount'] != null) {
                                controller.errors[index]['amount'] = null;
                                controller.errors.refresh();
                              }
                            },
                          ),
                          if (controller.autoValidate.value && controller.errors[index]['amount'] != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0, left: 12.0),
                              child: Text(
                                controller.errors[index]['amount']!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                            ),
                          const SizedBox(height: 15),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: Strings.projectionDate,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: DarkMode.editColor(context),
                                    fontFamily: FontFamily.sfPro,
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontFamily: FontFamily.sfPro,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          CommonTextField(
                            controller: fieldSet['date']!,
                            hintText: "Select Date",
                            prefixIcon: Icon(Icons.date_range_sharp, color: Colors.grey[300], size: 22),
                            isDateField: true,
                            validator: null,
                            onChanged: (text) {
                              if (controller.errors[index]['date'] != null) {
                                controller.errors[index]['date'] = null;
                                controller.errors.refresh();
                              }
                            },
                          ),
                          if (controller.autoValidate.value && controller.errors[index]['date'] != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0, left: 12.0),
                              child: Text(
                                controller.errors[index]['date']!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }).toList(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: CommonButton(
                            height: 36,
                            width: 90,
                            borderRadius: 30,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            title: 'Create',
                            onPress: () => controller.createProjection(
                              context,
                              orderItem?.id ?? '',
                              orderItem,
                              customerId,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: CommonButton(
                            height: 36,
                            color: Colors.grey[300],
                            width: 90,
                            borderRadius: 30,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            title: 'Close',
                            onPress: () => controller.navigateToCustomerDetails(customerId),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}