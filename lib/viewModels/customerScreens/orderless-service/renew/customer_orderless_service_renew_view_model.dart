import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/customer/orderless_services/orderless_service_renew/customer_orderless_service_renew_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerOrderlessServiceRenewViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerOrderlessServiceRenew(BuildContext context) async {
    loading.value = true;
    CustomerOrderlessServiceRenewRequestModel
        orderlessServiceRenewRequestModel =
        CustomerOrderlessServiceRenewRequestModel(
       startDate: "2026-02-09",
      remark: "remark here",
      endDate: "2026-08-20",
      reminderBeforeExpire: 5,
    );
    _api.customerOrderlessServicesRenew(
            orderlessServiceRenewRequestModel.toJson())
        .then((value) {
      if (value.id!.isNotEmpty) {
        if (kDebugMode) {
          print('Customer Orderless Services Renew ${value.company?.id}');
          print('Customer Orderless Services Renew${value.remark}');
        }
        Utils.snackbarSuccess('Customer Orderless Services successfully');
      } else {
        Utils.snackbarFailed('Customer order Products not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
