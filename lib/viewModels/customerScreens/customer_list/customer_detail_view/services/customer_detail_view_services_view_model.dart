import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerDetailViewServicesViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerDetailViewServices(BuildContext context) async {
    loading.value = true;
    _api.customerDetailViewServices().then((value) {

      if(value.isNotEmpty){
        for (var responseData in value) {
          if (kDebugMode) {
            print("Customer Detail View Services name  ${responseData.service}");
            print("Customer Detail View Services id ${responseData.id}");
          }
          Utils.snackbarSuccess('Lead Master type data fetched');
        }
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Customer Type data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

}



