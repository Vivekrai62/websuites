import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/customer/customer_activity/reports/customer_activity_reports.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerActivityReportsViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerActivityReportList(BuildContext context) async {
    loading.value = true;
    CustomerActivityReportsRequestModel customerActivityReportsRequestModel=  CustomerActivityReportsRequestModel(
      from: DateTime.parse("2024-10-28 00:00:00.000"),
      to: DateTime.parse("2024-10-28 23:59:59.999"),
      limit: 15,
      page: 1,
      user: null,
    );
    _api.customerActivityReports(customerActivityReportsRequestModel.toJson())
        .then((response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var item in response.items!) {
          print('Customer Daily Report ID: ${item.id}');
          print('Customer Daily Report  : ${item.name}');
        }
        Utils.snackbarSuccess('Customer customer_list fetched successfully');
      } else {
        Utils.snackbarFailed('No leads found');
      }
    }).onError((error, stackTrace) {
      // Handle any error here
      Utils.snackbarFailed('Failed to fetch leads');
      if (kDebugMode) {
        print(error);
      }
    });
  }
}