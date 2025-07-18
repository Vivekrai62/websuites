import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../data/models/responseModels/products/category/product_category_response_model.dart';

class ProductCategoryViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<ProductCategoryResponseModel> categories =
      <ProductCategoryResponseModel>[].obs;
  RxList<ProductCategoryResponseModel> filteredCategories =
      <ProductCategoryResponseModel>[].obs;

  bool isDataLoaded = false;

  @override
  void onInit() {
    super.onInit();
    filteredCategories.value = categories;
  }

  Future<void> productCategory(BuildContext context,
      {bool forceRefresh = false}) async {
    if (!forceRefresh && isDataLoaded)
      return; // Skip if not refreshing and data is loaded

    loading.value = true;
    try {
      final response = await _api.productCategoryApi();
      categories.clear();
      categories.addAll(response);
      filteredCategories.value = categories;
      if (forceRefresh) {
        isDataLoaded = true; // Only set after a successful refresh
      } else {
        isDataLoaded = true; // Initial load
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    } finally {
      loading.value = false;
    }
  }

  void searchCategories(String query) {
    if (query.isEmpty) {
      filteredCategories.value = categories;
    } else {
      filteredCategories.value = categories
          .where((category) =>
              category.name?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    }
  }
}
