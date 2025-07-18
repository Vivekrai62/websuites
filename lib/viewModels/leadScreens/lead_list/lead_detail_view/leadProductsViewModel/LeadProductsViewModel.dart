import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/lead/lead_list/lead_detail_view/leadProducts/LeadPropductsReqModel.dart';
import '../../../../../data/models/responseModels/leads/list/details/lead_detail_view/leadPropducts/LeadProductsResModel.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadProductsViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadProductsRes> products = <LeadProductsRes>[].obs;
  RxString errorMessage = ''.obs; RxString selectedProduct = ''.obs;


  @override
  void onInit() {
    super.onInit();
    // Fetch products when the controller is initialized
    fetchLeadProducts(Get.context!);
  }

  Future<void> fetchLeadProducts(BuildContext context) async {
    loading.value = true;
    errorMessage.value = '';

    LeadProductsReqModel request = LeadProductsReqModel(
      page: 1,
      limit: 1500,
    );

    try {
      if (kDebugMode) {
        print("Fetching lead products with request: ${request.toJson()}");
      }
      LeadProductsRes response = await _api.leadProducts(request.toJson());

      if (kDebugMode) {
        print("API Response: ${response.toString()}");
        print("Items count: ${response.items.length}");
      }

      if (response.items.isNotEmpty) {
        products.assignAll([response]);
        if (kDebugMode) {
          print("Lead Products fetched: ${response.items.length} items");
          print("First item category ID: ${response.items.first.productCategory?.id}");
          print("Product names: ${response.items.map((item) => item.name).toList()}");
        }
      } else {
        products.clear();
        errorMessage.value = 'No lead products found';
        if (kDebugMode) {
          print("No lead products found in response");
        }
        Utils.snackbarFailed('No lead products found');
      }
    } catch (error) {
      errorMessage.value = 'Failed to fetch lead products: $error';
      if (kDebugMode) {
        print("Error fetching lead products: ${error.toString()}");
      }
      Utils.snackbarFailed('Failed to fetch lead products: $error');
    } finally {
      loading.value = false;
    }
  }

  List<String> getAllProductNames() {
    final names = products
        .expand((product) => product.items)
        .map((item) => item.name)
        .toList();
    if (kDebugMode) {
      print("All product names: $names");
    }
    return names;
  }

  List<String> getProductNamesByCategoryId(String categoryId) {
    if (categoryId.isEmpty) {
      if (kDebugMode) {
        print("CategoryId is empty, returning all product names");
      }
      return getAllProductNames();
    }

    // More detailed logging to help debug
    if (kDebugMode) {
      print("Filtering products for categoryId: $categoryId");
      print("Available products count: ${products.isNotEmpty ? products.first.items.length : 0}");

      // Debug to check if categories match
      if (products.isNotEmpty) {
        final categories = products.first.items
            .map((item) => '${item.productCategory?.id}:${item.productCategory?.name}')
            .toSet()
            .toList();
        print("Available categories in products: $categories");
      }
    }

    final filteredNames = products
        .expand((product) => product.items)
        .where((item) => item.productCategory?.id == categoryId)
        .map((item) => item.name)
        .toList();

    if (kDebugMode) {
      print("Found ${filteredNames.length} matching products for categoryId: $categoryId");
      print("Filtered product names: $filteredNames");
    }

    return filteredNames.isNotEmpty ? filteredNames : ['Not available'];
  }

  List<String> getProductNamesByCategoryName(String categoryName) {
    if (categoryName.isEmpty) {
      if (kDebugMode) {
        print("CategoryName is empty, returning all product names");
      }
      return getAllProductNames();
    }

    final filteredNames = products
        .expand((product) => product.items)
        .where((item) => item.productCategory?.name == categoryName)
        .map((item) => item.name)
        .toList();

    if (kDebugMode) {
      print("Filtering products for categoryName: $categoryName");
      print("Filtered product names: $filteredNames");
    }

    return filteredNames.isNotEmpty ? filteredNames : ['Not available'];
  }
}