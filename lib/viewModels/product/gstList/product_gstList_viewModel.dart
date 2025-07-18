import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
import '../../../data/models/responseModels/products/gst_list/product_gstList_response_model.dart';

class ProductGstListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<ProductGstListResponseModel> productGstList =
      <ProductGstListResponseModel>[].obs; // Observable customer_list

  // This will hold the filtered customer_list based on the search query
  RxList<ProductGstListResponseModel> filteredProductGstList =
      <ProductGstListResponseModel>[].obs;

  Future<void> fetchProductGstList() async {
    loading.value = true;
    try {
      final value = await _api.fetchProductGstList();
      // print("API Response: $value"); // Log raw response
      if (value.isNotEmpty) {
        productGstList.value = value; // Update observable role
        filteredProductGstList.value = value; // Update filtered role
        // print("Updated productGstList with ${productGstList.length} items"); // Confirm update
        for (var data in value) {
          // print("Product GST List name: ${data.name}");
          // print("Product GST List id: ${data.id}");
          // print("Product GST List cgst: ${data.cgst}");
          // print("Product GST List status: ${data.status}");
        }
        // Utils.snackbarSuccess('Product GST List fetched');
      } else {
        // print("API returned empty role");
        // Utils.snackbarFailed('Product GST List is empty');
      }
    } catch (error) {
      // print("Error fetching product GST role: $error");
      // print("StackTrace: $stackTrace");
      // Utils.snackbarFailed('Error fetching product GST List: $error');
    } finally {
      loading.value = false; // Ensure loading is false even on error
    }
  }

  // Method to filter the product customer_list based on the search query
  void filterProductGstList(String query) {
    if (query.isEmpty) {
      filteredProductGstList.value =
          productGstList; // Reset to the full customer_list if the query is empty
    } else {
      filteredProductGstList.value = productGstList.where((product) {
        return product.name?.toLowerCase().contains(query.toLowerCase()) ??
            false;
      }).toList();
    }
  }
}
