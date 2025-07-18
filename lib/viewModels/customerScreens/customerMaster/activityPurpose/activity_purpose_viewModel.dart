import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
class CustomerMasterActivityPurposeViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerMasterActivityPurpose(BuildContext context) async {
    loading.value = true;
    _api.customerMasterActivityPurpose().then((value) {
      if (value.isNotEmpty) {
        for (var responseData in value) {
          if (kDebugMode) {
            print("Customer Master Activity Purpose type ${responseData.type}");
            print("Customer Master Activity Purpose name ${responseData.name}");
          }
          Utils.snackbarSuccess('Customer Master Activity Purpose List fetch');
        }
        loading.value = false;
      } else {
        Utils.snackbarFailed('activity Purpose Id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
