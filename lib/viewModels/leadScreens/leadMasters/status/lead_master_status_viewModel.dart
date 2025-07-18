import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class LeadMasterStatusViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> leadMasterStatus (BuildContext context) async {
    loading.value = true;

    _api.leadMastersStatusApi().then((value) {

      if(value.id!= null){
        Utils.snackbarSuccess('type Id fetched');
        loading.value = false;

      }else{
        Utils.snackbarFailed('type Id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode){
        print(error.toString());
      }
    }
    );
  }
}