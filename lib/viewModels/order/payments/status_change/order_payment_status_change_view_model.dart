import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/order/order_payment/status_change/order_payment_status_change_request_model.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';

class OrderPaymentStatusChangeViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> orderPaymentStatusChange (BuildContext context) async {
    loading.value = true;

    PaymentStatusChangeRequestModel requestModel= PaymentStatusChangeRequestModel(
      paymentId: "50a58054-80b4-4166-84f1-13ac45d96f44",
      remark: "No Longer Need",
      status: "approved",
    );
    _api.paymentStatusChange(requestModel.toJson()).then((response) {
      if (response.id!= null && response.id!.isNotEmpty) {
        print('Order Payments Status Change  ${response.status}');
        Utils.snackbarSuccess('order customer_list fetched');
        loading.value = false;
      }else{
        Utils.snackbarFailed('order customer_list not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }



}