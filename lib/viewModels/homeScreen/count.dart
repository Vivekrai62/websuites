import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/utils.dart';
import '../../data/repositories/repositories.dart';


class HomeScreenCountViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> DBCount(BuildContext context) async {
    loading.value = true;

    _api.dashboardCountApi().then((value) {
      if(value.customers!= null){
        Utils.snackbarSuccess('Id fetched');
        loading.value = false;

      }else{
        Utils.snackbarFailed('ID not fetched');

      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}