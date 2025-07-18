import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../data/repositories/repositories.dart';

class LeadSettingCustomFieldsViewmodel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> settingCustomFields(BuildContext context) async {
    loading.value = true;
    _api.settingCustomFields().then((value) {
      // print("Lead Setting CustomFields Value $value");
      if (value.isNotEmpty) {
        for (var responseData in value) {
          // print("Lead Settings CustomFields data ${responseData.fieldLabel}");
          // Utils.snackbarSuccess('Lead Setting CustomFields fetched');
        }
        loading.value = false;
      } else {
        // Utils.snackbarFailed('master divisions not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
