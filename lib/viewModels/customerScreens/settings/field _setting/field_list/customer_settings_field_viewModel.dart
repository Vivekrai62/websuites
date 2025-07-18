import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../../utils/utils.dart';
class CustomerSettingsFieldListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> settingFieldList(BuildContext context) async {
    loading.value = true;
    _api.customerSettingFieldList().then((response) {
      if (response.isNotEmpty) {
        for (var responseData in response) {
          if (kDebugMode) {
            print("Customer Setting Field List type ${responseData.type}");
            print("Customer Setting Field List name ${responseData.name}");
          }
          Utils.snackbarSuccess('Customer Master Activity Purpose List fetch');
        }
        loading.value = false;
      }
      else{
        Utils.snackbarFailed('Customer Safe Area Product data  not found');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }



}