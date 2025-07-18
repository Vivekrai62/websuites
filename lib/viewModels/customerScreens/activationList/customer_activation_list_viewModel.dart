import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
import '../../../data/models/requestModels/activation/customer_activation_list_request_model.dart';
class CustomerActivationListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerActivationList (BuildContext context) async {
    CustomerActivationListRequestModel requestModel = CustomerActivationListRequestModel(
      dateRange: null,
      limit: 15,
      page: 1,
      sentBy: null,
      service: null,   // Optional: null value
    );

    loading.value = true;
    _api.customerActivationList(requestModel.toJson()).then((response) {
      if (response.items.isNotEmpty && response.items.isNotEmpty) {
        // Process each lead item
        for (var item in response.items) {
          print('Customer Activation Name : ${item.activationFor.name}');
          print('Customer Activation Create By Name${item.createdBy.name}');
        }
        Utils.snackbarSuccess('Customer Trash customer_list fetched successfully');
      }
   else{
        Utils.snackbarFailed('activationList Id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString()
        );
      }
    }
    );
  }
}