import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/customer/master/customer_type/create/customer_type_create_request_model.dart';
import '../../../../../data/repositories/repositories.dart';
class CustomerTypeCreateViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerTypeCreate(BuildContext context) async {
    loading.value = true;

    CustomerTypeCreateRequestModel requestModel=CustomerTypeCreateRequestModel(name: "test", status: true);
    _api.customerMasterCustomerTypeCreate(requestModel.toJson()).then((value) {
      if (value.id!.isNotEmpty) {
        if (kDebugMode) {
          print("Customer Customer Type Created  ${value.id}");
          print("Customer   Created type ${value.name}");
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