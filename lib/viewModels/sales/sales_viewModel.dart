import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/sales/sales_list_request_model.dart';
import 'package:websuites/data/models/responseModels/sales/sales_response_model.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class SalesViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxBool initialLoad = true.obs; // Flag for initial load
  RxBool dataLoaded = false.obs; // New flag to track if data has been loaded
  RxList<Item> sales = <Item>[].obs;
  RxList<Item> filteredSales = <Item>[].obs; // For search results
  final Rx<SalesResponseModel> salesResponseModel = SalesResponseModel(
    items: [],
    meta: null,
  ).obs;

  // Observable for error state
  RxString error = ''.obs;

  // Pagination variables
  RxInt currentPage = 1.obs;
  final int itemsPerPage = 15;
  RxBool hasMoreData = true.obs;

  @override
  void onInit() {
    super.onInit();
    filteredSales.assignAll(sales); // Initialize filtered role
  }

  Future<void> salesApi(BuildContext context) async {
    try {
      if (currentPage.value == 1) {
        loading.value = true;
      }

      error.value = '';

      final requestModel = SalesListRequestModel(
        limit: itemsPerPage,
        page: currentPage.value,
      );

      final response = await _api.salesApi(requestModel.toJson());

      if (currentPage.value == 1) {
        salesResponseModel.value = response;
        sales.assignAll(response.items);
        filteredSales.assignAll(sales);
        dataLoaded.value = true; // Set dataLoaded to true after initial load
      } else {
        // Append new items to existing sales for pagination
        final updatedItems = [...salesResponseModel.value.items, ...response.items];
        salesResponseModel.value = SalesResponseModel(
          items: updatedItems,
          meta: response.meta,
        );
        sales.assignAll(updatedItems);
        filteredSales.assignAll(sales);
      }

      // Update pagination status
      hasMoreData.value = (response.meta?.currentPage ?? 0) < (response.meta?.totalPages ?? 0);

      // Show success message only on initial load
      if (initialLoad.value) {
        Utils.snackbarSuccess('Sales data fetched successfully');
        initialLoad.value = false;
      }

      // Log data in debug mode
      if (kDebugMode) {
        print('Sales data fetched: ${sales.length} items');
      }

    } catch (e, stackTrace) {
      error.value = e.toString();
      if (kDebugMode) {
        print('Sales API Error: $e');
        print('Stack trace: $stackTrace');
      }
      Utils.snackbarFailed('Failed to fetch sales data: ${e.toString()}');
    } finally {
      loading.value = false;
    }
  }
}
