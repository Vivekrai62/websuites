import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../data/models/responseModels/customers/activities/meeting/customer_details_meeting_res_model.dart';
import '../../../../data/models/responseModels/customers/activities/reminder/customer_details_activities_reminder_res_model.dart';
import '../../../../views/customerScreens/customerList/customerdetails/activities/visit/customer_details_visit_only_res_model.dart';

class CustomerActivitiesReminderViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<CustomerDetailsActiReminderResModel> customerReminder = <CustomerDetailsActiReminderResModel>[].obs;
  RxString errorMessage = ''.obs;
  String? _lastCustomerId;

  Future<void> customerDetailsActivitiesReminder(BuildContext context, String customerId) async {
    if (_lastCustomerId == customerId && customerReminder.isNotEmpty) {
      return;
    }
    loading.value = true;
    errorMessage.value = '';
    try {
      final response = await _api.customerDetailsActivitiesReminder(customerId);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        customerReminder.assignAll(response);
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
    customerReminder.clear();
    _lastCustomerId = null;
    errorMessage.value = '';
  }

  Future<void> refreshActivities(BuildContext context, String customerId) async {
    clearActivities();
    await customerDetailsActivitiesReminder(context, customerId);
  }
}