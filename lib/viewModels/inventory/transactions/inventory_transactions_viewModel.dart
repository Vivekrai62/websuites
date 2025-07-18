import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';

import '../../../data/models/responseModels/inventory/transactions/inventory_transactions_response_model.dart';

class InventoryTransactionsViewModel extends GetxController {
  final Repositories _api = Repositories(); // Use the repository instance

  RxBool loading = false.obs;
  Rx<InventoryTransactionsResponseModel> inventoryTransactionsResponseModel =
      InventoryTransactionsResponseModel().obs; // Reactive model

  Future<void> inventoryTransactionsApi(BuildContext context,
      {bool forceRefresh = false}) async {
    if (inventoryTransactionsResponseModel.value.items == null ||
        inventoryTransactionsResponseModel.value.items!.isEmpty ||
        forceRefresh) {
      loading.value = true;

      try {
        // Fetch data from the API
        final response = await _api.inventoryTransactionsApi();
        inventoryTransactionsResponseModel.value =
            response; // Update the reactive model with the fetched data

        if (response.items != null && response.items!.isNotEmpty) {
          // Utils.snackbarSuccess('Inventory stock fetched');
        } else {
          // Utils.snackbarFailed('No inventory stock found');
        }
      } catch (error) {
        if (kDebugMode) {
          // print('Error fetching inventory transactions: $error');
        }
        // Utils.snackbarFailed('Failed to fetch data');
      } finally {
        loading.value = false; // Stop loading
      }
    }
  }
}
