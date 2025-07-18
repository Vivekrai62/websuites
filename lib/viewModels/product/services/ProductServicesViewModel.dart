import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../data/models/requestModels/product/services/ProductsServicesReqModel.dart';
import '../../../data/models/responseModels/products/services/ProductsServicesResModel.dart';

class ProductServicesViewModel extends GetxController {
  final Repositories _api = Repositories();
  RxList<Items> productsServices =
      <Items>[].obs; // Correctly defined as RxList<Item>
  final RxBool loading = false.obs;
  final RxList<Items> productsServicesItems = <Items>[].obs;
  final RxList<Items> allProductsServicesItems =
      <Items>[].obs; // This will hold all items for searching
  Map<String, dynamic> appliedFilters = {};

  @override
  void onInit() {
    super.onInit();
    fetchProductServices();
  }

  void applyFilters(Map<String, dynamic> filters) {
    appliedFilters = filters;
    print('Applied filters: $appliedFilters');
    fetchProductServices(forceRefresh: true);
  }

  Future<void> fetchProductServices({bool forceRefresh = false}) async {
    try {
      loading.value = true;
      if (forceRefresh) {
        productsServices.clear(); // Clear existing products
      }

      final request = _createRequestModel();
      final ProductsServicesResModel response =
          await _api.fetchProductServices(request.toJson());

      if (response.items != null && response.items!.isNotEmpty) {
        productsServices
            .assignAll(response.items!); // Assign directly to products
        allProductsServicesItems
            .assignAll(response.items!); // Populate all items for search
        debugPrint('Products Services loaded: ${productsServices.length}');
      } else {
        productsServices.clear();
        allProductsServicesItems.clear();
        debugPrint('No products found in response');
      }
    } catch (error) {
      productsServices.clear();
      allProductsServicesItems.clear();
      debugPrint('Error fetching product services role: $error');
    } finally {
      loading.value = false;
    }
  }

  ProductsServicesReqModel _createRequestModel() {
    // Correctly map status from true/false to "active"/"inactive" if needed
    return ProductsServicesReqModel(
      brand:
          appliedFilters['brands'] ?? '', // Correct usage of nullish coalescing
      search: appliedFilters['search'] ?? '',
      division: appliedFilters['division'] ?? "",
      limit: 15,
      page: 1,
    );
  }

  void searchProformas(String query) {
    if (query.isEmpty) {
      productsServicesItems
          .assignAll(allProductsServicesItems); // No filter, show all items
    } else {
      final filteredItems = allProductsServicesItems.where((item) {
        final name = item.name?.toLowerCase() ?? '';
        final description = item.description?.toLowerCase() ??
            ''; // Assuming you want to filter by description as well
        final lowerQuery = query.toLowerCase();
        return name.contains(lowerQuery) || description.contains(lowerQuery);
      }).toList();
      productsServicesItems.assignAll(filteredItems); // Update search results
    }
  }
}
