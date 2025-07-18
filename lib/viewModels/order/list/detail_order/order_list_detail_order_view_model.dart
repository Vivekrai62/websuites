import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';

class OrderListDetailOrderViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> orderDetailList (BuildContext context) async {
    loading.value = true;
    _api.orderDetailList().then((response) {
      if (response.id != null && response.id!.isNotEmpty) {

          if (kDebugMode) {
            print('Order Detail List  Response  ${response.orderNumber}');
          }
          if (kDebugMode) {
            print('Order Detail List  Response  ${response.orderProducts?[0].salePrice}');
          }
          print('Order Detail List  Response  ${response.orderNumber}');
          print('Order Detail List  Response  ${response.payments?[0].amount}');

          Utils.snackbarSuccess('Order  Detail List Fetching');
      }
      else{
        Utils.snackbarFailed('order Detail List not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }



}