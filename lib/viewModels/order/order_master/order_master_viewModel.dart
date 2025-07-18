import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class OrderMasterViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> orderMaster (BuildContext context) async {
    loading.value = true;

    _api.orderMasterApi().then((value) {

      if(value.id!= null){
        Utils.snackbarSuccess('order Master fetched');
        loading.value = false;

      }else{
        Utils.snackbarFailed('order Master not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}





