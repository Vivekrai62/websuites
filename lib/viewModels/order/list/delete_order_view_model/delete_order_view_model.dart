import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/order/list/delete/order_delete_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class DeleteOrderViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> orderDetailList (BuildContext context) async {
    loading.value = true;
    OrderDeleteRequest request =  OrderDeleteRequest(orderId: "feb54c23-8a65-4ead-a55c-765b48908a5a");
    _api.orderDeleteList(request.toJson()).then((response) {
      if (response.orderNumber!= null) {
        if (kDebugMode) {
          print('Order Delete  Response OrderNumber  ${response.orderNumber}');
          print('Order Delete  Response Customer FirstName ${response.customer?.firstName}');
        }
        Utils.snackbarSuccess('Order  Delete List Fetching');
      }
      else{
        Utils.snackbarFailed('order Delete List not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }










}