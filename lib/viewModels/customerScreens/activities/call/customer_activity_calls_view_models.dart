import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../data/models/responseModels/customers/activities/call/customer_activities_calls_res_model.dart';

class CustomerActivitiesCallsViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<CustomerDetailsActivitiesCallResModel> customerCalls = <CustomerDetailsActivitiesCallResModel>[].obs;
  RxString errorMessage = ''.obs;
  String? _lastCustomerId;

  Future<void> customerDetailsActivitiesCall(BuildContext context, String customerId) async {
    if (_lastCustomerId == customerId && customerCalls.isNotEmpty) {
      return;
    }
    loading.value = true;
    errorMessage.value = '';
    try {
      final response = await _api.customerDetailsActivitiesCall(customerId);
      // Assuming response is a List<CustomerDetailsActivitiesCallResModel>
      customerCalls.value = response; // Assign the entire list
      _lastCustomerId = customerId;
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      loading.value = false;
    }
  }

  void clearActivities() {
    customerCalls.clear();
    _lastCustomerId = null;
    errorMessage.value = '';
  }

  Future<void> refreshActivities(BuildContext context, String customerId) async {
    clearActivities();
    await customerDetailsActivitiesCall(context, customerId);
  }
}