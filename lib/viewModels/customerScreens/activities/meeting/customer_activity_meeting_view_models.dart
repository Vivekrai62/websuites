import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../data/models/responseModels/customers/activities/meeting/customer_details_meeting_res_model.dart';

class CustomerActivitiesMeetingViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<CustomerDetailsActivitiesMeetingResModel> customerMeeting = <CustomerDetailsActivitiesMeetingResModel>[].obs;
  RxString errorMessage = ''.obs;
  String? _lastCustomerId;

  Future<void> customerDetailsActivitiesMeeting(BuildContext context, String customerId) async {
    if (_lastCustomerId == customerId && customerMeeting.isNotEmpty) {
      return;
    }
    loading.value = true;
    errorMessage.value = '';
    try {
      final response = await _api.customerDetailsActivitiesMeeting(customerId);
      // Update observables in a single frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        customerMeeting.assignAll(response); // Use assignAll to update the list
        _lastCustomerId = customerId;
        loading.value = false;
      });
    } catch (error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        errorMessage.value = error.toString();
        loading.value = false;
      });
    }
  }

  void clearActivities() {
    customerMeeting.clear();
    _lastCustomerId = null;
    errorMessage.value = '';
  }

  Future<void> refreshActivities(BuildContext context, String customerId) async {
    clearActivities();
    await customerDetailsActivitiesMeeting(context, customerId);
  }
}