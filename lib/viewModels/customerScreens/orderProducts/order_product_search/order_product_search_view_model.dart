import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerOrderProductSearchViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> orderProductSearch(BuildContext context) async {
    loading.value = true;
    _api.customerOrderProductSearch().then((value) {
      if (value.isNotEmpty) {
        for (var responseData in value) {
          if (kDebugMode) {
            print("Customer Order Product Search ${responseData.description}");
          }
          Utils.snackbarSuccess('Customer search assign');
        }
        loading.value = false;
      }
      else{
        Utils.snackbarFailed('customer customer_list Assign Id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}