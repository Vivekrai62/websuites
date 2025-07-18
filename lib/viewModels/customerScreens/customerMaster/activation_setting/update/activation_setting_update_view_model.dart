import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/customer/master/activation_setting/update/customer_master_activation_setting_update_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class ActivationSettingUpdateViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> activationSettingUpdate(BuildContext context) async {
    loading.value = true;
    ActivationSettingUpdateRequestModel requestModel = ActivationSettingUpdateRequestModel(
      ccUsers: ["61986b57-37f2-4353-920e-dfb4ff25aac7"],
      isSentCustomer: false, // Pass boolean value here
      mailTo: "18aae555-f46e-4bff-bc1d-6849dceb279f",
      service: "1b8b5712-942e-4a32-b4f4-cbe46cab49cf",
    );

    _api.customerMasterActivationSettingUpdate(requestModel.toJson()).then((value) {
      if (value.id!.isNotEmpty) {
        if (kDebugMode) {
          print("Activation Setting Update id ${value.id}");
          print("Activation Setting  Update Name ${value.mailTo?.id}");
        }
        Utils.snackbarSuccess('Customer Company Credential List fetch');
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Customer Company Credential  not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }


}