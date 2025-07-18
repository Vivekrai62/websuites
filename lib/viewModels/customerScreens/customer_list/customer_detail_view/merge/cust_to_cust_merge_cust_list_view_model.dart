import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/responseModels/customers/list/customer_detail_view/merge/cust_to_cust_merge_cust_list_res_model.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../../data/models/requestModels/customer/customer_list/customer_detail_view/merge/cus_to_cus_merge_req_model.dart';
import '../../../../../data/models/responseModels/customers/list/customer_detail_view/merge/after_merge/cus_to_cus_merge_res_model.dart';

class CustToCustMergCustViewModel extends GetxController {
  final Repositories _api = Repositories();

  // Observables for state management
  RxBool loading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<CustToCustMergCustListResponseModel> custToCustMergeList =
      <CustToCustMergCustListResponseModel>[].obs;

  // Debounce timer for search queries
  Timer? _debounceTimer;

  Future<void> fetchCustToCustMergeList(
    String id, {
    String searchQuery = '',
    int skip = 0,
  }) async {
    // Validate input
    if (id.isEmpty) {
      // if (kDebugMode) {
      //   print('Error: ID parameter is empty');
      // }
      // errorMessage.value = 'Invalid ID parameter';
      // Utils.snackbarFailed('Invalid ID parameter');
      return;
    }

    try {
      loading.value = true;
      errorMessage.value = '';

      // if (kDebugMode) {
      //   print('Fetching customer merge list for ID: $id, Search Query: $searchQuery, Skip: $skip');
      // }

      // Debounce the API call
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
        try {
          final response = await _api.CustToCustMergCustListApi(
            id: id,
            searchQuery: searchQuery,
            skip: skip,
          );

          // if (kDebugMode) {
          //   print("Customer to Customer Merge List Response: $response");
          //   print("Response length: ${response.length}");
          // }

          // Clear existing data first
          custToCustMergeList.clear();

          // Assign new data
          custToCustMergeList.assignAll(response);

          if (response.isNotEmpty) {
            // if (kDebugMode) {
            //   print('Successfully fetched ${response.length} customer records');
            // }
            // Utils.snackbarSuccess('Customer merge list fetched successfully (${response.length} records)');
          } else {
            // if (kDebugMode) {
            //   // print('No customer merge list data found for ID: $id, Search Query: $searchQuery');
            // }
            // Utils.snackbarFailed('No customer merge list data found');
          }
        } catch (e) {
          // if (kDebugMode) {
          //   print('Error fetching customer merge list: $e');
          //   print('Stack trace: ${StackTrace.current}');
          // }

          // Clear data on error
          custToCustMergeList.clear();

          // Set error message
          String errorMsg = _getErrorMessage(e);
          errorMessage.value = errorMsg;

          // Utils.snackbarFailed('Failed to fetch customer merge list: $errorMsg');
        } finally {
          loading.value = false;
        }
      });
    } catch (e) {
      // if (kDebugMode) {
      //   print('Error setting up debounce for customer merge list: $e');
      // }
      loading.value = false;
    }
  }

  // Helper method to extract meaningful error messages
  String _getErrorMessage(dynamic error) {
    if (error == null) return 'Unknown error occurred';

    String errorString = error.toString();

    // Extract meaningful error messages
    if (errorString.contains('SocketException')) {
      return 'Network connection error';
    } else if (errorString.contains('TimeoutException')) {
      return 'Request timeout';
    } else if (errorString.contains('FormatException')) {
      return 'Invalid data format received';
    } else if (errorString.contains('Invalid API response format')) {
      return 'Server returned invalid response format';
    } else if (errorString.contains('Failed to parse response data')) {
      return 'Unable to process server response';
    } else {
      // Return the original error but limit length
      return errorString.length > 100
          ? '${errorString.substring(0, 100)}...'
          : errorString;
    }
  }

  // Method to refresh data
  Future<void> refreshData(String id,
      {String searchQuery = '', int skip = 0}) async {
    await fetchCustToCustMergeList(id, searchQuery: searchQuery, skip: skip);
  }

  // Method to clear data
  void clearData() {
    custToCustMergeList.clear();
    errorMessage.value = '';
    _debounceTimer?.cancel();
  }

  // Customer to Customer Merge (PUT)
  Future<Map<String, dynamic>?> customerToCustomerMerge(
      CustomerToCustomerMergeReqModel reqModel) async {
    loading.value = true;
    errorMessage.value = '';
    try {
      final res = await _api.customerToCustomerMerge(reqModel);
      // Optionally show a success snackbar here
      return res;
    } catch (e) {
      errorMessage.value = _getErrorMessage(e);
      // Optionally show a failure snackbar here
      return null;
    } finally {
      loading.value = false;
    }
  }

  @override
  void onClose() {
    // Clean up resources
    clearData();
    super.onClose();
  }
}
