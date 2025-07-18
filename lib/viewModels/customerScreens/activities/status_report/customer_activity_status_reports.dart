import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/customer/customer_activity/status_reports/customer_activity_status_reports.dart';

import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerActivityStatusReportViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> statusReports(BuildContext context) async {
    loading.value = true;
   CustomerStatusReportsRequestModel customerStatusReportsRequestModel= CustomerStatusReportsRequestModel(
      assignedTo: null,
      customerStatus: null,
      isFilterUserWithTeam: true,
      limit: 15,
      noOrderForDays: null,
      noServiceForDays: null,
      page: 1,
      projectStatus: null,
      serviceRunning: null,
    );

    _api.customerActivityStatusReport(customerStatusReportsRequestModel.toJson())
        .then((response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var item in response.items!) {
          print('Customer Status reports Report  : ${item.id}');
          if (kDebugMode) {
            print('Customer Status reports FirstName : ${item.firstName}');
            print('Customer Status reports : ${item.lastName}');
          }
        }
        Utils.snackbarSuccess('Customer customer_list fetched successfully');
      } else {
        Utils.snackbarFailed('Customer Activity Report Status List');
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