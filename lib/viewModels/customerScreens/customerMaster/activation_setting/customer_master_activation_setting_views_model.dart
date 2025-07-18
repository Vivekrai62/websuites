import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/customer/master/activation_setting/customer_master_activation_setting_request_model.dart';
import '../../../../data/repositories/repositories.dart';
class CustomerMasterActivationSettingViewModels extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerMasterActivationSetting(BuildContext context) async {
    loading.value = true;
    CustomerMasterActivationSettingRequestModel requestModel=CustomerMasterActivationSettingRequestModel(
        limit: 15,
        page: 1
    );
    _api.customerMasterActivationSetting(requestModel.toJson()).then((response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var data in response.items!) {
            print('Customer Master Activation Setting  CC Users: ${data.ccUsers?.first.firstName}');
          print('Customer Master Activation Setting sentCustomer ${data.isSentCustomer}');
            print('Customer Master Activation Setting email ${data.mailTo?.email}');
        }
        Utils.snackbarSuccess('Customer Trash customer_list fetched successfully');
      }
     else {
        Utils.snackbarFailed('activity Purpose Id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }



}