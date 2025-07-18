import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../data/models/responseModels/inventory/request/inventory_request_response_model.dart'
    as inventoryRequest;

class InventoryRequestViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<inventoryRequest.Items> inventoryRequests =
      <inventoryRequest.Items>[].obs;

  Future<void> inventoryRequestApi(BuildContext context,
      {bool forceRefresh = false}) async {
    // Set loading to true at the start of the API call
    loading.value = true;

    // Check if the inventoryRequests role is empty or if a force refresh is requested
    if (inventoryRequests.isEmpty || forceRefresh) {
      try {
        final value = await _api.inventoryRequestApi();

        if (value.items != null && value.items!.isNotEmpty) {
          inventoryRequests.value = value.items!.cast<inventoryRequest.Items>();
          // Utils.snackbarSuccess('Inventory request fetched successfully');
        } else {
          // Utils.snackbarFailed('No inventory requests found');
        }
      } catch (error) {
        if (kDebugMode) {
          print(error.toString());
        }
        // Utils.snackbarFailed('Error fetching inventory requests: $error');
      } finally {
        loading.value = false; // Stop loading
      }
    } else {
      loading.value = false; // Stop loading if no API call was made
    }
  }
}
