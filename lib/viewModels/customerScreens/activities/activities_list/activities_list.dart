import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../../Utils/utils.dart';
import '../../../../../../data/models/responseModels/customers/activities/activities_list/activities_list.dart';
import '../../../../../../data/repositories/repositories.dart';

class CustomerActivitiesListViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<CustomerActivityListResponseModel> customerActivities = <CustomerActivityListResponseModel>[].obs;
  RxString errorMessage = ''.obs;
  String? _lastCustomerId;

  Future<void> customerDetailsActivitiesAll(BuildContext context, String customerId) async {
    if (_lastCustomerId == customerId && customerActivities.isNotEmpty) {
      return;
    }loading.value = true;
    errorMessage.value = '';
    try {

      final response = await _api.customerDetailsActivitiesAll(customerId);
      customerActivities.value = response;
      _lastCustomerId = customerId;
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      loading.value = false;
    }
  }


  void clearActivities() {
    customerActivities.clear();
    _lastCustomerId = null;
    errorMessage.value = '';


  }

  Future<void> refreshActivities(BuildContext context, String customerId) async {
    clearActivities();
    await customerDetailsActivitiesAll(context, customerId);
  }
}