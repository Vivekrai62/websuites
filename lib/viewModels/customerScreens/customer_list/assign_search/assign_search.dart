import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/customer/customer_search_assign/customer_search_assign.dart';
import '../../../../data/repositories/repositories.dart';

class ListAssignSearchViewModels extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;

  CustomerSearchAssignRequestModel requestModel = CustomerSearchAssignRequestModel(
    data: "", // Passing empty data
    userId: null, // Passing null userId (or you can pass a specific userId here)
  );
  Future<void> leadListLeadAssign(BuildContext context) async {
    loading.value = true;
    _api.leadListLeadAssign(requestModel.toJson()).then((value) {
      if (value.isNotEmpty) {
        for (var responseData in value) {
          print("Customer search assign ${responseData.firstName}");
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