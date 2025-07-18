import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/customer/setting/column_setting/column_setting_update/column_setting_update_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class ColumnSettingUpdateViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> columnSettingUpdate(BuildContext context) async {
    loading.value = true;

    RequestModel request = RequestModel(
      fieldId: "2c90bb28-2184-4700-b9b2-0fe4bba2f447",
      roleIds: ["7a835171-f613-4a90-ad2d-0aa65148477a"],
    );
    _api.customerSettingColumnUpdate(request.toJson()).then((response) {
      if (response!=null) {
       print("Customer Setting$response");
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


