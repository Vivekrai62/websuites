import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/data/repositories/repositories.dart';
import 'package:websuites/utils/utils.dart';
import 'package:websuites/data/models/requestModels/product/list/product_list_request_model.dart';
import 'package:websuites/data/models/responseModels/products/list/products_list_response_model.dart';
//
// class ProductListViewModel extends GetxController {
//   final api = Repositories();
//   RxBool loading = false.obs;
//   RxList<Item> products = <Item>[].obs; // Correctly defined as RxList<Item>
//   final RxList<Item> productsItems = <Item>[].obs;
//   final RxList<Item> allProductsItems = <Item>[].obs;
//   Map<String, dynamic> appliedFilters = {};
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     productList();
//   }
//
//   void applyFilters(Map<String, dynamic> filters) {
//     appliedFilters = filters;
//     print('Applied filters: $appliedFilters');
//     productList(forceRefresh: true);
//   }
//
//   Future<void> productList({bool forceRefresh = false} BuildContext context) async {
//     loading.value = true;
//
//     ProductListRequestModel requestModel = ProductListRequestModel(
//       brand: null,
//       division: null,
//       limit: 15,
//       page: 1,
//       productType: null,
//       search: "",
//       status: null,
//     );
//
//     try {
//       final response = await api.productList(requestModel.toJson());
//
//       // Ensure the response is of the correct type
//       if (response is ProductsListResponseModel) {
//         if (response.items.isNotEmpty) {
//           products.value = response.items; // Assign the customer_list of items directly
//           Utils.snackbarSuccess('Products customer_list fetched successfully');
//         } else {
//           Utils.snackbarFailed('No products found');
//         }
//       } else {
//         Utils.snackbarFailed('Invalid response format');
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print('Error fetching products: ${error.toString()}');
//       }
//       Utils.snackbarFailed('Error fetching products');
//     } finally {
//       loading.value = false;
//     }
//   }
// }

class ProductListViewModel extends GetxController {
  final Repositories _api = Repositories();
  RxList<Item> products = <Item>[].obs; // Correctly defined as RxList<Item>
  final RxBool loading = false.obs;
  final RxList<Item> productsItems = <Item>[].obs;
  final RxList<Item> allProductsItems = <Item>[].obs;
  Map<String, dynamic> appliedFilters = {};

  @override
  void onInit() {
    super.onInit();
    productList();
  }

  void applyFilters(Map<String, dynamic> filters) {
    appliedFilters = filters;
    print('Applied filters: $appliedFilters');
    productList(forceRefresh: true);
  }

  Future<void> productList({bool forceRefresh = false}) async {
    try {
      loading.value = true;
      if (forceRefresh) {
        products.clear(); // Clear existing products
      }

      final request = _createRequestModel();
      final ProductsListResponseModel response =
          await _api.productList(request.toJson());

      if (response.items.isNotEmpty) {
        products.assignAll(response.items); // Assign directly to products
        debugPrint('Products loaded: ${products.length}');
      } else {
        products.clear();
        debugPrint('No products found in response');
      }
    } catch (error) {
      products.clear();
      debugPrint('Error fetching product role: $error');
    } finally {
      loading.value = false;
    }
  }

  ProductListRequestModel _createRequestModel() {
    // Map status from true/false to "active"/"inactive"
    String? status;
    if (appliedFilters.containsKey('status')) {
      status = appliedFilters['status'] == true ? "active" : "inactive";
    }

    return ProductListRequestModel(
      brand: appliedFilters['brands' ?? ''],
      productType: null,
      status: status, // Use the mapped status value
      search: appliedFilters['search'] ?? '',
      division: appliedFilters['division'] ?? "",
      limit: 15,
      page: 1,
    );
  }

  void searchProformas(String query) {
    if (query.isEmpty) {
      productsItems.assignAll(allProductsItems);
    } else {
      final filteredItems = allProductsItems.where((item) {
        final name = item.name?.toLowerCase() ?? '';
        final email = item.name?.toLowerCase() ?? '';
        final performaNumber = item.name?.toString() ?? '';
        final lowerQuery = query.toLowerCase();
        return name.contains(lowerQuery) ||
            email.contains(lowerQuery) ||
            performaNumber.contains(lowerQuery);
      }).toList();
      productsItems.assignAll(filteredItems);
    }
  }
}
