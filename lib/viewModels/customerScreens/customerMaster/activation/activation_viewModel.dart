import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';


class CustomerMasterActivationViewModels extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerActivationServices (BuildContext context) async {
    loading.value = true;
    _api.customerMasterActivationServices().then((value) {
      if (value.isNotEmpty) {
        for (var responseData in value) {
          if (kDebugMode) {
            print("Customer Master Activation Service  name ${responseData.name}");
            print("Customer Master Activation Service  Create ${responseData.createdAt}");
          }
          Utils.snackbarSuccess('Customer Master Activity Purpose List fetch');
        }
        loading.value = false;
      }
    else{
        Utils.snackbarFailed('customer activities Id not fetched');
      }
    }).onError((error, stackTrace){
      if (kDebugMode){
        print(error.toString());
      }
    }
    );
  }
}
