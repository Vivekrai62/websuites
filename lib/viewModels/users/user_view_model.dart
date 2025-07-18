import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class UserViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> userApi (BuildContext context) async {
    loading.value = true;

    _api.usersApi().then((value) {

      if(value.items!= null){
        Utils.snackbarSuccess('users item fetched');
        loading.value = false;

      }else{
        Utils.snackbarFailed('users items not fetched');
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error.toString()
        );
      }
    }
    );
  }
}