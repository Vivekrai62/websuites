import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/customer/customer_activity/no_activity/customer_activity_no_activities.dart';
import '../../../../data/models/requestModels/dashboardScreen/db_latest_task.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerActivityNoActivitiesViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<Items> leadList = <Items>[].obs; // To hold the customer_list of leads
  Future<void> customerNoActivityList(BuildContext context) async {
    loading.value = true;

    CustomerNoActivityRequestModel customerNoActivityRequestModel = CustomerNoActivityRequestModel(
      activities: [],
      assignedTo: null,
      isFilterUserWithTeam: true,
      limit: 15,
      page: 1,
    );
    _api.customerNoActivitiesList(customerNoActivityRequestModel.toJson()).then((response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var item in response.items!) {
          print('Customer No Activity ID: ${item.id}');
          print('Customer No Activity  Name: ${item.firstName}');
        }
        Utils.snackbarSuccess('Customer customer_list fetched successfully');
      } else {
        Utils.snackbarFailed('No leads found');
      }
    }).onError((error, stackTrace) {
      // Handle any error here
      Utils.snackbarFailed('Failed to fetch leads');
      print( error);
    });

  }



}