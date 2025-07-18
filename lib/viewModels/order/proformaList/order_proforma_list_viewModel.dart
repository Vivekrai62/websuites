import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class OrderProformaListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> orderProformaList (BuildContext context) async {
    loading.value = true;

    _api.orderProformaApi().then((value) {

      if(value.id!= null){
        Utils.snackbarSuccess('order proforma customer_list fetched');
        loading.value = false;

      }else{
        Utils.snackbarFailed('order proforma customer_list not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}