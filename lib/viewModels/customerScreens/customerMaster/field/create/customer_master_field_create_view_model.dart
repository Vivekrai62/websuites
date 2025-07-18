import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/customer/master/activation_fields/create/customer_master_field_create_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerMasterFieldCreateViewModel extends  GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerMasterFieldCreate(BuildContext context) async {
    loading.value = true;
    CustomerMasterFieldCreateRequestModel requestModel=CustomerMasterFieldCreateRequestModel(
      answers: "",
      fieldLabel: "Tester",
      fieldName: "Tester",
      required: false,
      type: "text",
    );
    _api.customerMasterActivationFieldCreate(requestModel.toJson()).then((value) {
      if (value.id!.isNotEmpty) {
        if (kDebugMode) {
          print("Customer Activation  Field Create  ${value.id}");
          print("Customer Activation Field Create label ${value.fieldLabel}");
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