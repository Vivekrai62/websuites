import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerSettingColumnListViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> settingColumnList(BuildContext context) async {
    loading.value = true;
    _api.customerSettingColumnList().then((response) {
      if (response.isNotEmpty) {
        for (var responseData in response) {
          if (kDebugMode) {
            print("Customer Setting Column List type ${responseData.type}");
            print("Customer Setting Column List name ${responseData.fieldName}");
            print("Customer Setting Column List name ${responseData.filter}");
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