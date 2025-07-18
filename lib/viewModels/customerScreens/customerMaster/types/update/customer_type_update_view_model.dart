import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/customer/master/customer_type/update/customer_type_update_request_model.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerTypeUpdateViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerTypeUpdate(BuildContext context) async {
    CustomerTypeUpdateRequestModel responseModel =
        CustomerTypeUpdateRequestModel(name: "old customer", status: true);
    loading.value = true;
    _api.customerMasterCustomerTypeUpdate(responseModel.toJson()).then((value) {
      if (value.id!.isNotEmpty) {
        if (kDebugMode) {
          print("Customer Customer type Credential Update${value.id}");
          print("Customer Customer type Credential  Update ${value.name}");
        }
        Utils.snackbarSuccess('Customer Company Credential List fetch');
        loading.value = false;
      } else {
        Utils.snackbarFailed('Customer Company Credential  not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
