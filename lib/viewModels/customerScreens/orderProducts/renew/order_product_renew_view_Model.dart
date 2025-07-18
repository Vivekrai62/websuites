import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/customer/order_product/renew/customer_order_product_renew_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerOrderProductRenewViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerOrderProductRenew(BuildContext context) async {
    CustomerOrderProductRenewRequestModel customerOrderProductRenewRequestModel=CustomerOrderProductRenewRequestModel(
      serviceId: "a48a7b87-5be3-43a4-b2f4-6a2bbaf0b1a0",
      startDate: "2024-11-14T00:00:00.000Z",
      remark: "Renew",
      endDate: "2024-11-30",
      reminderBeforeExpire: 5,
    );
    loading.value = true;
    _api.customerOrderProductRenew(customerOrderProductRenewRequestModel.toJson()).then((value) {
      if (value.id!.isNotEmpty) {
        print("Customer Order Product Renew endDAte  ${value.endDate}");
        print("Customer Order Product renew  Start ${value.startBy?.firstName}");
        Utils.snackbarSuccess('Customer customer_list fetched successfully');
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



