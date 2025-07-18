import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
import '../../../data/models/requestModels/product/master/product_master_list_request_model.dart';
import '../../../data/models/responseModels/products/master/product_master_response_model.dart';

class ProductMasterViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<Items> items = <Items>[].obs; // Store fetched items
  RxList<Items> filteredItems = <Items>[].obs; // Store filtered items

  Future<void> masterProductList(BuildContext context,
      {bool forceRefresh = false}) async {
    // Only fetch data if the role is empty or a refresh is forced
    if (items.isEmpty || forceRefresh) {
      loading.value = true;
      ProductMasterListRequestModel requestModel =
          ProductMasterListRequestModel(
        limit: 15,
        page: 1,
        search: "",
      );

      try {
        final response = await _api.masterProductList(requestModel.toJson());
        if (response.items != null) {
          items.value = response.items!;
          filteredItems.value = items; // Initialize filtered items
        } else {
          Utils.snackbarFailed('No products found or invalid response');
        }
      } catch (error) {
        if (kDebugMode) print('Error fetching products: $error');
        Utils.snackbarFailed('Failed to load products');
      } finally {
        loading.value = false;
      }
    }
  }

  void filterMasterList(String query) {
    if (query.isEmpty) {
      filteredItems.value = items;
    } else {
      filteredItems.value = items
          .where((product) =>
              product.product?.name
                  ?.toLowerCase()
                  .contains(query.toLowerCase()) ??
              false)
          .toList();
    }
  }
}
