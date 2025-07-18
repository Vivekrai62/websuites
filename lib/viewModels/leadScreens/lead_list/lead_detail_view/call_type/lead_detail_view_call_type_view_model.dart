import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadDetailViewCallType extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadDetailCallType(BuildContext context) async {
    loading.value = true;
    _api.leadDetailActivityCallType().then((value) {
      if(value.isNotEmpty){
        for (var responseData in value) {
          if (kDebugMode) {
            print("Lead Detail View call Type  ${responseData.name}");
          }
          Utils.snackbarSuccess('Lead Detail View call Type fetch');
        }
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Lead Detail Type data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }




}