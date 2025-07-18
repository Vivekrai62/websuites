import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/repositories/repositories.dart';

import '../../../../data/models/responseModels/customers/activities/notes/customer_details_notes_res_model.dart';


class CustomerActivitiesNotesViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<CustomerDetailsActiNotesResModel> customerNotes = <CustomerDetailsActiNotesResModel>[].obs;
  RxString errorMessage = ''.obs;
  String? _lastCustomerId;

  Future<void> customerDetailsActivitiesNotes(BuildContext context, String customerId) async {
    if (_lastCustomerId == customerId && customerNotes.isNotEmpty) {
      return;
    }
    loading.value = true;
    errorMessage.value = '';
    try {
      final response = await _api.customerDetailsActivitiesNotes(customerId);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        customerNotes.assignAll(response);
        _lastCustomerId = customerId;
        loading.value = false;
      });

      // Safe access to first element
      if (response.isNotEmpty) {
        print('hello ${response.first.id}');
      } else {
        print('hello - response is empty');
      }
    } catch (error) {
      // Remove the problematic line that tries to access first element of empty list
      print('hello error: $error');

      WidgetsBinding.instance.addPostFrameCallback((_) {
        errorMessage.value = error.toString();
        loading.value = false;
      });
    }
  }

  void clearActivities() {
    customerNotes.clear();
    _lastCustomerId = null;
    errorMessage.value = '';
  }

  Future<void> refreshActivities(BuildContext context, String customerId) async {
    clearActivities();
    await customerDetailsActivitiesNotes(context, customerId);
  }
}