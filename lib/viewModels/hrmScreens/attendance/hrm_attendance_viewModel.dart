import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class AttendanceViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> attendanceApi (BuildContext context) async {
    loading.value = true;

    _api.attendanceApi().then((value) {

      if(value.id!= null){
        Utils.snackbarSuccess('attendance Id fetched');
        loading.value = false;

      }else{
        Utils.snackbarFailed('attendance Id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode){
        print(error.toString()
        );
      }
    }
    );
  }
}