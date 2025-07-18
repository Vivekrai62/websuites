import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../data/models/responseModels/customers/list/details/customer_details-services_res_model.dart';
import '../../../../../data/models/responseModels/customers/list/details/payments/customer_details_payment_res_model.dart';




class CustomerDetailPaymentViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<CustomerDetailsPaymentResModel> customerPayments = <CustomerDetailsPaymentResModel>[].obs;
  RxString errorMessage = ''.obs;
  String? _lastCustomerId;

  Future<void> customerDetailsPayments(BuildContext context, String customerId) async {
    if (_lastCustomerId == customerId && customerPayments.isNotEmpty) {
      return;
    }
    loading.value = true;
    errorMessage.value = '';
    try {
      final response = await _api.customerDetailsPayments(customerId);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        customerPayments.value = response; // Updated line
        _lastCustomerId = customerId;
        loading.value = false;
      });

      if (response.isNotEmpty) {
        // print('hello ${response.first.id}');
      } else {
        // print('hello - response is empty');
      }
    } catch (error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        errorMessage.value = error.toString();
        loading.value = false;
      });
    }
  }


}