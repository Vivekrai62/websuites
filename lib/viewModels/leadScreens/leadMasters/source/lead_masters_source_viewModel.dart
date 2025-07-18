import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
class LeadMastersSourceViewmodel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadMasterSource(BuildContext context) async {
    loading.value = true;
    _api.leadMasterSource().then((value) {
      print("Lead Master Source api $value");
      if (value.isNotEmpty) {
        for (var responseData in value) {
          print("Source data ${responseData.name}");
          Utils.snackbarSuccess('source data fetched');
        }
        loading.value = false;
      } else {
        Utils.snackbarFailed('source data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}