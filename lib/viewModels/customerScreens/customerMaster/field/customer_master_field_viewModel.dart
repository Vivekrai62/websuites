import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/requestModels/customer/master/activation_fields/customer_master_activation_field_request_model.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
class CustomerMasterActivationFieldViewModels extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerMasterFields (BuildContext context) async {
    loading.value = true;
    CustomerMasterActivationFieldRequestModel requestModel=CustomerMasterActivationFieldRequestModel(
      limit: 15,
      page: 1,
      search: '',
    );
    _api.customerMasterActivationField(requestModel.toJson()).then((response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var item in response.items!) {
          print('Customer Master Field name : ${item.field_name}');
          print('Customer Master Primary Created at ${item.created_at}');
        }
        Utils.snackbarSuccess('Customer Trash customer_list fetched successfully');
      }
    else{
        Utils.snackbarFailed('company credentials id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}
