import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import 'package:websuites/data/models/responseModels/inventory/refillStocks/inventory_refill_stocks_response_model.dart';

class InventoryRefillStocksViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<Items> inventoryItems =
      <Items>[].obs; // Observable role to store items

  // Fetch inventory refill data
  Future<void> inventoryRefillApi(BuildContext context,
      {bool forceRefresh = false}) async {
    // Only fetch data if the role is empty or a refresh is forced
    if (inventoryItems.isEmpty || forceRefresh) {
      loading.value = true;

      _api.inventoryRefillStocksApi().then((value) {
        if (value.items != null) {
          inventoryItems.value =
              value.items!; // Set the items in observable role
          // Utils.snackbarSuccess('Inventory Refill fetched');
          loading.value = false;
        } else {
          // Utils.snackbarFailed('Inventory Refill not fetched');
          loading.value = false;
        }
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print(error.toString());
        }
        loading.value = false;
      });
    }
  }
}
