import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../data/models/responseModels/products/brand/product_brand_response_model.dart';

class ProductBrandViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<ProductBrandResponseModel> productBrands =
      <ProductBrandResponseModel>[].obs;
  RxList<ProductBrandResponseModel> filteredCategories =
      <ProductBrandResponseModel>[].obs;

  Future<void> fetchProductBrands(BuildContext context) async {
    loading.value = true;
    try {
      final value = await _api.productBrand();
      if (value.isNotEmpty) {
        productBrands.value = value; // This should trigger Obx to rebuild
        filteredCategories.value = value;
        // Utils.snackbarSuccess('Product brands fetched');
      } else {
        // Utils.snackbarFailed('No product brands found');
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      // Utils.snackbarFailed('Error fetching product brands');
    } finally {
      loading.value = false;
    }
  }

  void searchCategories(String query) {
    if (query.isEmpty) {
      filteredCategories.value = productBrands; // Show all if query is empty
    } else {
      filteredCategories.value = productBrands.where((category) {
        return category.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
}
