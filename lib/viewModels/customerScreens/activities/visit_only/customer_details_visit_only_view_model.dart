import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../data/models/responseModels/customers/activities/meeting/customer_details_meeting_res_model.dart';
import '../../../../views/customerScreens/customerList/customerdetails/activities/visit/customer_details_visit_only_res_model.dart';

class CustomerActivitiesVisitOnlyViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<LeadDetailsActiVisitOnlyResModel> customerVisit = <LeadDetailsActiVisitOnlyResModel>[].obs;
  RxString errorMessage = ''.obs;
  String? _lastCustomerId;

  Future<void> customerDetailsActivitiesVisitOnly(BuildContext context, String customerId) async {
    if (_lastCustomerId == customerId && customerVisit.isNotEmpty) {
      return;
    }
    loading.value = true;
    errorMessage.value = '';
    try {
      final response = await _api.customerDetailsActivitiesVisitOnly(customerId);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        customerVisit.assignAll(response); // Use assignAll to update the list
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
    customerVisit.clear();
    _lastCustomerId = null;
    errorMessage.value = '';
  }

  Future<void> refreshActivities(BuildContext context, String customerId) async {
    clearActivities();
    await customerDetailsActivitiesVisitOnly(context, customerId);
  }
}