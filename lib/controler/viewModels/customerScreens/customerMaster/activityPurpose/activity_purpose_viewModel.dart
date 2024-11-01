import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerActivityPurposeViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerActivityPurpose (BuildContext context) async {
    loading.value = true;

    _api.customerActivityPurposeApi().then((value) {

      if(value.id!= null){
        Utils.snackbarSuccess('activity Purpose Id fetched');
        loading.value = false;

      }else{
        Utils.snackbarFailed('activity Purpose Id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}