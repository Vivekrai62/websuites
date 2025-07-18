import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import '../../../../../data/models/responseModels/leads/list/lead_list.dart';
import '../../../../../utils/appColors/app_colors.dart';
import '../../../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../resources/strings/strings.dart';
import '../../../../viewModels/leadScreens/createNewLead/product_category/product_category_controller.dart';
import '../../../../viewModels/leadScreens/lead_list/lead_detail_view/leadProductsViewModel/LeadProductsViewModel.dart';
import '../../../homeScreen/home_manager/HomeManagerScreen.dart';
import '../../createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../../leadList/lead_deatils/LeadDetails.dart';
import 'package:intl/intl.dart';
import '../../../../viewModels/leadScreens/lead_list/lead_detail_view/projection/create/ProjetionViewModel.dart';



// class LeadDetailsAddProjectionController extends GetxController {
//   final RxList<Map<String, dynamic>> fieldSets = <Map<String, dynamic>>[].obs;
//   final RxBool autoValidate = false.obs;
//   final RxList<Map<String, String?>> errors = <Map<String, String?>>[].obs;
//   final ProjectionViewModel projectionViewModel = Get.put(ProjectionViewModel());
//
//   @override
//   void onInit() {
//     super.onInit();
//     resetForm(); // Clear previous data and add a new field set
//   }
//
//   @override
//   void onClose() {
//     for (var fieldSet in fieldSets) {
//       (fieldSet['category'] as TextEditingController?)?.dispose();
//       (fieldSet['product'] as TextEditingController?)?.dispose();
//       (fieldSet['amount'] as TextEditingController?)?.dispose();
//       (fieldSet['date'] as TextEditingController?)?.dispose();
//     }
//     super.onClose();
//   }
//
//   void addFieldSet() {
//     fieldSets.add({
//       'category': TextEditingController(),
//       'categoryId': '',
//       'product': TextEditingController(),
//       'productId': '',
//       'amount': TextEditingController(),
//       'date': TextEditingController(),
//     });
//     errors.add({
//       'category': null,
//       'product': null,
//       'amount': null,
//       'date': null,
//     });
//   }
//
//   void removeFieldSet(int index) {
//     fieldSets.removeAt(index);
//     errors.removeAt(index);
//     fieldSets.refresh();
//     errors.refresh();
//   }
//
//   void resetForm() {
//     // Dispose existing controllers
//     for (var fieldSet in fieldSets) {
//       (fieldSet['category'] as TextEditingController?)?.dispose();
//       (fieldSet['product'] as TextEditingController?)?.dispose();
//       (fieldSet['amount'] as TextEditingController?)?.dispose();
//       (fieldSet['date'] as TextEditingController?)?.dispose();
//     }
//     // Clear fieldSets and errors
//     fieldSets.clear();
//     errors.clear();
//     // Add a single empty field set
//     addFieldSet();
//     autoValidate.value = false;
//     fieldSets.refresh();
//     errors.refresh();
//   }
//
//   bool validateForm() {
//     bool isValid = true;
//
//     for (int i = 0; i < fieldSets.length; i++) {
//       errors[i]['category'] = fieldSets[i]['category']!.text.isEmpty ? 'Product category is required' : null;
//       errors[i]['product'] = fieldSets[i]['product']!.text.isEmpty ? 'Product is required' : null;
//       errors[i]['amount'] = fieldSets[i]['amount']!.text.isEmpty ? 'Amount is required' : null;
//       errors[i]['date'] = fieldSets[i]['date']!.text.isEmpty ? 'Projection date is required' : null;
//
//       if (errors[i].values.any((error) => error != null)) {
//         isValid = false;
//       }
//     }
//
//     return isValid;
//   }
//
//   void showValidation() {
//     autoValidate.value = true;
//   }
//
//   void navigateToLeadDetails(Item? orderItem) {
//     resetForm(); // Clear form data before navigating
//     final homeController = Get.find<HomeManagerController>();
//     homeController.lastScreen.value = LeadDetailsScreen(
//       orderItem: orderItem,
//       scaffoldKey: homeController.scaffoldKey,
//     );
//     homeController.update();
//   }
//
//   void createProjection(BuildContext context, String leadId, Item? orderItem) async {
//     showValidation();
//     if (validateForm()) {
//       print('Form is valid, proceeding with creating projection');
//
//       // Collect data from fieldSets and format date
//       List<Map<String, dynamic>> projectionData = fieldSets.map((fieldSet) {
//         // Format date to ISO 8601
//         String formattedDate = fieldSet['date']!.text;
//         try {
//           final date = DateTime.parse(fieldSet['date']!.text);
//           formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date.toUtc());
//         } catch (e) {
//           print('Error parsing date: $e');
//         }
//
//         return {
//           'category': fieldSet['category']!.text,
//           'categoryId': fieldSet['categoryId'],
//           'product': fieldSet['product']!.text,
//           'productId': fieldSet['productId'],
//           'amount': fieldSet['amount']!.text,
//           'date': formattedDate,
//         };
//       }).toList();
//
//       // Call the ViewModel's projectionCreate method
//       await projectionViewModel.projectionCreate(context, leadId, projectionData);
//
//       // If successful, navigate back to LeadDetailsScreen
//       if (projectionViewModel.errorMessage.value.isEmpty) {
//         navigateToLeadDetails(orderItem);
//       }
//     }
//   }
// }
class LeadDetailsAddProjectionController extends GetxController {
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
    // Dispose existing controllers
    for (var fieldSet in fieldSets) {
      (fieldSet['category'] as TextEditingController?)?.dispose();
      (fieldSet['product'] as TextEditingController?)?.dispose();
      (fieldSet['amount'] as TextEditingController?)?.dispose();
      (fieldSet['date'] as TextEditingController?)?.dispose();
    }
    // Clear fieldSets and errors
    fieldSets.clear();
    errors.clear();
    // Add a single empty field set
    addFieldSet();
    autoValidate.value = false;
    fieldSets.refresh();
    errors.refresh();
  }

  void navigateToLeadDetails(Item? orderItem) {
    resetForm(); // Clear form data before navigating
    final homeController = Get.find<HomeManagerController>();
    homeController.lastScreen.value = LeadDetailsScreen(
      orderItem: orderItem,
      scaffoldKey: homeController.scaffoldKey,
    );
    homeController.update();
  }

  void createProjection(BuildContext context, String leadId, Item? orderItem) async {
    // Removed validation check since we don't want validation anymore

    // Collect data from fieldSets and format date
    List<Map<String, dynamic>> projectionData = fieldSets.map((fieldSet) {
      // Format date to ISO 8601
      String formattedDate = fieldSet['date']!.text;
      try {
        if (fieldSet['date']!.text.isNotEmpty) {
          final date = DateTime.parse(fieldSet['date']!.text);
          formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date.toUtc());
        }
      } catch (e) {
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

    // Call the ViewModel's projectionCreate method
    await projectionViewModel.projectionCreate(context, leadId, projectionData);

    // If successful, navigate back to LeadDetailsScreen
    if (projectionViewModel.errorMessage.value.isEmpty) {
      navigateToLeadDetails(orderItem);
    }
  }
}






class LeadDetailsAddProjectionScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Item? orderItem;

  const LeadDetailsAddProjectionScreen({
    Key? key,
    required this.scaffoldKey,
    this.orderItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productCategoryController = Get.put(ProductCategoryController());
    final leadProductsViewModel = Get.put(LeadProductsViewModel());
    final controller = Get.put(LeadDetailsAddProjectionController());
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
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
              child: Row(
                children: [
                  if (!isTablet)
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black, size: 25),
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => controller.navigateToLeadDetails(orderItem),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.back),
                        const SizedBox(width: 8),
                        Text(
                          "Back",
                          style: TextStyle(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.sfPro,
                            fontSize: 17.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Add Projection",
                    style: TextStyle(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 17.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child:
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          Strings.productsCat,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                            fontFamily: FontFamily.sfPro,
                          ),
                        ),
                        const Spacer(),
                        OutlinedButton.icon(
                          onPressed: () => controller.addFieldSet(),
                          icon: Icon(Icons.add, color: AllColors.greenJungle),
                          label: Text(
                            "Add",
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
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87,
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
                                // Reset product and amount
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
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: Strings.product,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
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
                          const SizedBox(height: 8),
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
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: Strings.amount,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
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
                          const SizedBox(height: 8),
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
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: Strings.projectionDate,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
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
                          const SizedBox(height: 8),
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
                            onPress: () => controller.createProjection(context, orderItem?.id ?? '', orderItem),
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
                            onPress: () => controller.navigateToLeadDetails(orderItem),
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