import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../data/models/responseModels/customers/list/customer_detail_view/list/customer_list_detail_view_list_response_model.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerListDetailViewListModel extends GetxController {
  final api = Repositories();
  final loading = false.obs;
  final errorMessage = ''.obs;

  Future<CustomerListDetailViewListResponseModel?> customerDetailViewList(
      BuildContext context, String customerId) async {
    loading(true);
    errorMessage('');
    try {
      // Validate customerId type
      if (customerId is! String) {
        print('Invalid customerId type: ${customerId.runtimeType}, value: $customerId');
        throw Exception('customerId must be a String');
      }
      print('Fetching customer details for ID: $customerId'); // Debug

      final value = await api.customersListCustomerDetailViewList(customerId);
      if (value != null && value.id != null && value.id!.isNotEmpty) {
        if (kDebugMode) {
          print("Customer List Detail address: ${value.primaryAddress}");
        }
        return value;
      } else {
        errorMessage('Customer data not found or incomplete');
        Get.snackbar(
          'Error',
          'Customer data not found or incomplete.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
        return null;
      }
    } catch (error) {
      errorMessage('Failed to fetch customer details: $error');
      if (kDebugMode) {
        print("Error fetching customer details: $error");
      }
      Get.snackbar(
        'Error',
        'Failed to load customer details. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return null;
    } finally {
      loading(false);
    }
  }
}