import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/repositories/repositories.dart';

import '../../../../../data/models/responseModels/customers/list/details/customer_details-services_res_model.dart';




class CustomerDetailsActivitiesServicesViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<CustomerDetailsActiServicesResModel> customerServices = <CustomerDetailsActiServicesResModel>[].obs;
  RxString errorMessage = ''.obs;
  String? _lastCustomerId;

  Future<void> customerDetailsActivitiesServices(BuildContext context, String customerId) async {
    if (_lastCustomerId == customerId && customerServices.isNotEmpty) {
      return;
    }
    loading.value = true;
    errorMessage.value = '';
    try {
      final response = await _api.customerDetailsActivitiesServices(customerId);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        customerServices.assignAll(response);
        _lastCustomerId = customerId;
        loading.value = false;
      });

      // Safe access to first element
      if (response.isNotEmpty) {
        // print('hello ${response.first.id}');
      } else {
        // print('hello - response is empty');
      }
    } catch (error) {
      // // Remove the problematic line that tries to access first element of empty list
      // print('hello error: $error');

      WidgetsBinding.instance.addPostFrameCallback((_) {
        errorMessage.value = error.toString();
        loading.value = false;
      });
    }
  }

  void clearActivities() {
    customerServices.clear();
    _lastCustomerId = null;
    errorMessage.value = '';
  }

  Future<void> refreshActivities(BuildContext context, String customerId) async {
    clearActivities();
    await customerDetailsActivitiesServices(context, customerId);
  }
}