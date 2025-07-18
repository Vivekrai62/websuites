import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';
class LeadDetailCurrencyViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadDetailCurrency(BuildContext context) async {
    loading.value = true;
    _api.leadDetailCurrency().then((value) {
      if(value.isNotEmpty){
        for (var responseData in value) {
          if (kDebugMode) {
            print("Lead Detail Currency Type  ${responseData.name}");
            print("Lead Detail Currency Type  ${responseData.code}");
          }
          Utils.snackbarSuccess('Lead Detail Currency data fetch');
        }
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Lead Detail Currency  not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }





}