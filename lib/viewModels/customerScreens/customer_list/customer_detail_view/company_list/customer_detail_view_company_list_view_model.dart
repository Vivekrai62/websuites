import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerDetailViewCompanyListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerDetailCompanyList(BuildContext context) async {
    loading.value = true;
    var data = {};
    _api.customerDetailViewCompanyList(data).then((value) {
      if (value.isNotEmpty) {
        for (var responseData in value) {
          if (kDebugMode) {
            print(
                "Customer Detail View Company List name  ${responseData.companyName}");
            print(
                "Customer Detail View Company List companyEmail ${responseData.companyEmail}");
          }
          Utils.snackbarSuccess('Lead Master type data fetched');
        }
        loading.value = false;
      } else {
        Utils.snackbarFailed('Customer Type data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
