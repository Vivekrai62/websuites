import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../Utils/utils.dart';
import '../../../data/models/requestModels/customer/trash/customer_trash_request_model.dart';
class CustomerTrashViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerTrashList(BuildContext context) async {
    loading.value = true;
    CustomerTrashRequestModel requestModel = CustomerTrashRequestModel(
      limit: 15,
      page: 1,
      search: "",  // Empty search term as per your example
    );
    _api.customersTrashApi(requestModel.toJson())
        .then((response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var item in response.items!) {
          print('Customer Trash First : ${item.firstName}');
          print('Customer Trash Primary Email ${item.primaryEmail}');
        }
        Utils.snackbarSuccess('Customer Trash customer_list fetched successfully');
      }
      // else {
      Utils.snackbarFailed('customer Trash List Id not fetched');
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

}