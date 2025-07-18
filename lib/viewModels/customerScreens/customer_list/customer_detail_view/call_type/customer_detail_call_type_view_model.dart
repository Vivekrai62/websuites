import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerDetailCallTypeViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerDetailCallType(BuildContext context) async {
    loading.value = true;
    _api.customerDetailViewActivityCallType().then((value) {
      if(value.isNotEmpty){
        for (var responseData in value) {
          if (kDebugMode) {
            print("Customer Detail View call Type  ${responseData.name}");
          }
          Utils.snackbarSuccess('Customer Detail View call Type fetch');
        }
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Customer Type data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }



}