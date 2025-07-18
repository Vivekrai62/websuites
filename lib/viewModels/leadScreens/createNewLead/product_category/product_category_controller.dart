import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/responseModels/leads/createNewLead/product_category/product_category.dart';
import '../../lead_list/lead_detail_view/leadProductsViewModel/LeadProductsViewModel.dart';

class ProductCategoryController extends GetxController {
  final Repositories repository = Repositories();
  final RxList<LeadProductCategoryList> leadProductCategories = <LeadProductCategoryList>[].obs;
  final RxList<LeadProductCategoryList> filterProCategory = <LeadProductCategoryList>[].obs;
  final RxString errorMessage = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<String> selectedCategories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch categories when the controller is initialized
    createLeadProductCategory(Get.context!);
  }

  Future<void> createLeadProductCategory(BuildContext context) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final categories = await repository.createLeadProductCategory();
      leadProductCategories.assignAll(categories);

      if (kDebugMode) {
        print("Fetched ${categories.length} product categories");
        categories.forEach((category) {
          print('Category ID: ${category.id}, Name: ${category.name}');
        });
      }

      if (categories.isEmpty) {
        errorMessage.value = 'No product categories found';
        Utils.snackbarFailed('No product categories found');
      }
    } catch (e) {
      errorMessage.value = 'Failed to load lead product categories: $e';
      if (kDebugMode) {
        print("Error in createLeadProductCategory: $e");
      }
      Utils.snackbarFailed('Failed to load lead product categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateSelectedCategories(List<String> selected) {
    selectedCategories.assignAll(selected);
    if (kDebugMode) {
      print('Updated selected categories: $selected');
    }

    // Trigger product filtering in LeadProductsViewModel
    if (selected.isNotEmpty) {
      final leadProductsViewModel = Get.find<LeadProductsViewModel>();
      final filteredProducts = leadProductsViewModel.getProductNamesByCategoryId(selected.first);
      if (kDebugMode) {
        print("Filtered products for category ${selected.first}: $filteredProducts");
      }
    }
  }

  void filterProductsCategory(String query) {
    if (query.isEmpty) {
      filterProCategory.assignAll(filterProCategory);
    } else {
      filterProCategory.assignAll(leadProductCategories.where((catPro) {
        final fullName = '${catPro.name} ${catPro.name}'.trim();
        return fullName.toLowerCase().contains(query.toLowerCase());
      }).toList());
    }
  }

}