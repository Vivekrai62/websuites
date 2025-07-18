import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/order/order_payment/update/order_payment_update_request_model.dart';
import '../../../../data/repositories/repositories.dart';
class OrderPaymentUpdateViewmodel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> orderPaymentUpdate (BuildContext context) async {
    loading.value = true;
    // final requestModel = OrderPaymentUpdateRequestModel(
    //     amount: 444.0 // Use a double to ensure proper number formatting
    // );
    OrderPaymentUpdateRequestModel orderPaymentUpdateRequestModel=OrderPaymentUpdateRequestModel(
        amount: 1300
    );
    var data=OrderPaymentUpdateRequestModel(amount: 444);

    print("Order Payment Update first  $data");
    var value=data.toJson();
    print("Order Payment Update $value");
    _api.orderPaymentUpdate(orderPaymentUpdateRequestModel.toJson()).then((response) {
      if (response.id!= null && response.id!.isNotEmpty) {
          print('Order Payments Update amount   ${response.amount}');
          print('Order Payments Update OrderNumber ${response.order?.orderNumber}');
          print('Order Payments Update Sale Price ${response.product?.salePrice}');
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