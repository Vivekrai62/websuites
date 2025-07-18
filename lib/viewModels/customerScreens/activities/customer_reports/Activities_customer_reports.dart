import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/customer/customer_activity/customer_reports/customer_activity_customer_reports.dart';
import '../../../../data/repositories/repositories.dart';

class ActivitiesCustomerReports extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerReportsList(BuildContext context) async {
    CustomerReportRequestModel  customerReportRequestModel = CustomerReportRequestModel(
      customer: null,
      dateRange: DateRange(
        from: "2024-10-29 00:00:00.000",
        to: "2024-10-29 23:59:59.999",
      ),
      limit: 15,
      page: 1,

    );
    loading.value = true;
    _api.customerReports(customerReportRequestModel.toJson()).then((response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var item in response.items!) {
          if (kDebugMode) {
            print('Customer Reports  ID: ${item.id}');
          }
          if (kDebugMode) {
            print('Customer Reports  Name: ${item.name}');
          }
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



