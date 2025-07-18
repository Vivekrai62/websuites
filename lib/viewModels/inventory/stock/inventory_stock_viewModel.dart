import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/inventory/stock/inventory_stock_response_model.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class InventoryStockViewModel extends GetxController {
  final Repositories _api = Repositories(); // API Service
  RxBool loading = false.obs;
  Rx<InventoryStocksResponseModel?> inventoryStocks =
      Rx<InventoryStocksResponseModel?>(null);
  RxString error = ''.obs; // To store error messages

  @override
  void onInit() {
    super.onInit();
    // Fetch data only if it hasn't been loaded yet
    if (inventoryStocks.value == null) {
      inventoryStockApiFromService();
    }
  }

  // Function to fetch inventory stock data
  Future<void> inventoryStockApiFromService() async {
    loading.value = true; // Set loading to true when the API call starts
    try {
      final value = await _api
          .inventoryStockApiFromService(); // Call the repository method to fetch inventory data

      if (value.items != null && value.items!.isNotEmpty) {
        // Check if the response is valid and contains items
        inventoryStocks.value =
            value; // Update the observable value with the fetched data
        // Utils.snackbarSuccess('Inventory stock fetched'); // Show success message (optional)
      } else {
        // Show failure message if no data is found
        // Utils.snackbarFailed('No inventory stock found');
      }
    } catch (e) {
      error.value = e
          .toString(); // Store the error message in the observable error variable
      if (kDebugMode) {
        print('Error fetching inventory stock: $e');
      }
      // Utils.snackbarFailed('An error occurred while fetching inventory stock'); // Show failure message
    } finally {
      loading.value = false; // Set loading to false when the API call finishes
    }
  }
}
