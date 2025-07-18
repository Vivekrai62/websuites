import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/customer/master/company_credential/company_credential_create/company_credential_request_model.dart';
import '../../../../../data/repositories/repositories.dart';
class CompanyCredentialCreateViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> companyCredentialCreate(BuildContext context) async {
    loading.value = true;

    CompanyCredentialCreateRequestModel requestModel=CompanyCredentialCreateRequestModel(name: "test");
    _api.customerMasterCompanyCredentialCreate(requestModel.toJson()).then((value) {
      if (value.id!.isNotEmpty) {
          if (kDebugMode) {
            print("Customer Company Credential Created id ${value.id}");
            print("Customer Company Credential  Created Name ${value.name}");
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