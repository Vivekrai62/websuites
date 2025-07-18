import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
import 'package:websuites/data/models/responseModels/inventory/vendors/inventory_vendors_response_model.dart';

class InventoryVendorsViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<Items> vendorItems = <Items>[].obs;

  Future<void> inventoryVendorsApi(BuildContext context,
      {bool forceRefresh = false}) async {
    // Only fetch data if the role is empty or a refresh is forced
    if (vendorItems.isEmpty || forceRefresh) {
      loading.value = true;

      try {
        final response = await _api.inventoryVendorsApi();
        if (response.items != null) {
          vendorItems.assignAll(response.items!);
          // Utils.snackbarSuccess('Inventory Vendors fetched successfully');
        } else {
          // Utils.snackbarFailed('Failed to fetch Inventory Vendors');
        }
      } catch (e) {
        // Utils.snackbarFailed('Error fetching vendors: ${e.toString()}');
        if (kDebugMode) {
          // print('Error in inventoryVendorsApi: $e');
        }
      } finally {
        loading.value = false;
      }
    }
  }
}
