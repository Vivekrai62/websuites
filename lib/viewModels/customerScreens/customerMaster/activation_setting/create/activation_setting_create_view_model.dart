import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/customer/master/activation_setting/create/customer_master_activation_setting_create_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class ActivationSettingCreateViewmodel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> activationSettingCreate(BuildContext context) async {
    loading.value = true;
    CustomerMasterActivationSettingCreateRequestModel activationSettingUpdateRequestModel=CustomerMasterActivationSettingCreateRequestModel(
      ccUsers: ["4ab12ff3-77c3-4bb0-a2da-d5b2600bf9b5"],
      isSentCustomer: false,
      mailTo: "4ab12ff3-77c3-4bb0-a2da-d5b2600bf9b5",
      service: "b0443508-4160-402a-b34b-c367826b67ce",
    );
    _api.customerMasterActivationSettingCreate(activationSettingUpdateRequestModel.toJson()).then((value) {
      if (value.id!.isNotEmpty) {
        if (kDebugMode) {
          print("Activation Setting Created id ${value.id}");
          print("Activation Setting  Created Name ${value.mailTo?.id}");
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