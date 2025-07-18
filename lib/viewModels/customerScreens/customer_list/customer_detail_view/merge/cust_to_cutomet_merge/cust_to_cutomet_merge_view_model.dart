import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../../data/models/requestModels/customer/customer_list/customer_detail_view/merge/cus_to_cus_merge_req_model.dart';
import '../../../../../../data/models/responseModels/customers/list/customer_detail_view/merge/after_merge/cus_to_cus_merge_res_model.dart';
import '../../../../../../data/models/responseModels/customers/list/customer_detail_view/merge/cust_to_cust_merge_cust_list_res_model.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../Utils/utils.dart';


class CustToCustMergCustViewModel extends GetxController {
  final Repositories _api = Repositories();

  // Observables for state management
  RxBool loading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<CustomerToCustomerMergeResModel> custToCustMergeList = <CustomerToCustomerMergeResModel>[].obs;

  // Debounce timer for search queries
  Timer? _debounceTimer;






  // Method to clear data
  void clearData() {
    custToCustMergeList.clear();
    errorMessage.value = '';
    _debounceTimer?.cancel();
  }

  Future<Map<String, dynamic>?> customerToCustomerMerge(CustomerToCustomerMergeReqModel reqModel) async {
    loading.value = true;
    errorMessage.value = '';

    try {
      final result = await _api.customerToCustomerMerge(reqModel);
      loading.value = false;

      // Enhanced success handling
      if (result != null && result['statusCode'] != null) {
        final statusCode = result['statusCode'];

        // Handle different success scenarios
        if (statusCode >= 200 && statusCode < 300) {
          if (kDebugMode) {
            print('✅ Customer merge successful: Status $statusCode');
            print('📊 Response data: ${result['model']?.toJson()}');
          }
          return result;
        } else {
          // Handle non-success status codes
          final errorMsg = result['model']?.message ?? 'Merge failed with status $statusCode';
          errorMessage.value = errorMsg;
          if (kDebugMode) {
            print('❌ Merge failed: $errorMsg');
          }
          return null;
        }
      }

      return result;
    } catch (e) {
      loading.value = false;
      final errorMsg = _getErrorMessage(e);
      errorMessage.value = errorMsg;

      // Enhanced error logging
      if (kDebugMode) {
        print('❌ Customer merge error: $errorMsg');
        print('🔍 Full error details: $e');
        print('📝 Request model: ${reqModel.toJson()}');
      }

      return null;
    }
  }

// Enhanced error message method
  String _getErrorMessage(dynamic error) {
    if (error == null) return 'Unknown error occurred';

    String errorString = error.toString();

    // Handle specific API errors
    if (errorString.contains('401')) {
      return 'Session expired. Please login again.';
    } else if (errorString.contains('403')) {
      return 'You don\'t have permission to merge customers.';
    } else if (errorString.contains('404')) {
      return 'Customer not found or has been deleted.';
    } else if (errorString.contains('422')) {
      return 'Invalid data provided. Please check your inputs.';
    } else if (errorString.contains('500')) {
      return 'Server error. Please try again later.';
    } else if (errorString.contains('NoSuchMethodError')) {
      return 'Invalid API response format: Unexpected data structure';
    } else if (errorString.contains('SocketException')) {
      return 'Network connection error. Please check your internet.';
    } else if (errorString.contains('TimeoutException')) {
      return 'Request timeout. Please try again.';
    } else if (errorString.contains('FormatException')) {
      return 'Invalid data format received from server.';
    } else {
      return errorString.length > 100
          ? '${errorString.substring(0, 100)}...'
          : errorString;
    }
  }

  @override
  void onClose() {
    // Clean up resources
    clearData();
    super.onClose();
  }
}