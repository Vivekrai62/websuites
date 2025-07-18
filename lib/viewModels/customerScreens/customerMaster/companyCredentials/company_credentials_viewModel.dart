import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
class CompanyCredentialsViewModels extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> companyCredentialsType(BuildContext context) async {
    loading.value = true;
    _api.customerMasterCompanyCredential().then((value) {
      if (value.isNotEmpty) {
        for (var responseData in value) {
          if (kDebugMode) {
            print("Customer Company Credential name ${responseData.name}");
            print("Customer Company Credential  ${responseData.createdAt}");
          }
          Utils.snackbarSuccess('Customer Company Credential List fetch');
        }
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