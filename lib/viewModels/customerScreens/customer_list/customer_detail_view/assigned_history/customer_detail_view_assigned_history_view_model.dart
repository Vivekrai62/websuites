import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';
class CustomerDetailAssignHistoryViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerDetailAssignHistory(BuildContext context) async {
    loading.value = true;
    _api.customerDetailViewAssignHistory().then((value) {
      if(value.isNotEmpty){
        for (var responseData in value) {
          if (kDebugMode) {
            print("Customer Detail View Assigned History username  ${responseData.user?.firstName}");
            print("Customer Detail View Assigned History Assign by ${responseData.assignedBy?.firstName}");
          }
          Utils.snackbarSuccess('Lead Master type data fetched');
        }
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Customer Type data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

}

