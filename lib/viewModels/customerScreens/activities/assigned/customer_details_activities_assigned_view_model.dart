import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/repositories/repositories.dart';

import '../../../../data/models/responseModels/customers/activities/assigned/customer_details_activities_assigned_res_model.dart';



class CustomerDetailsActivitiesAssignedViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<CustomerDetailsActiAssignedResModel> customerAssigned = <CustomerDetailsActiAssignedResModel>[].obs;
  RxString errorMessage = ''.obs;
  String? _lastCustomerId;

  Future<void> customerDetailsActivitiesAssigned(BuildContext context, String customerId) async {
    if (_lastCustomerId == customerId && customerAssigned.isNotEmpty) {
      return;
    }
    loading.value = true;
    errorMessage.value = '';
    try {
      final response = await _api.customerDetailsActivitiesAssigned(customerId);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        customerAssigned.assignAll(response);
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
    customerAssigned.clear();
    _lastCustomerId = null;
    errorMessage.value = '';
  }

  Future<void> refreshActivities(BuildContext context, String customerId) async {
    clearActivities();
    await customerDetailsActivitiesAssigned(context, customerId);
  }
}