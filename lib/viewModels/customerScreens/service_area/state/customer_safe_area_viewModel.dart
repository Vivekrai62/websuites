import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/models/requestModels/customer/service_area/state/Customer_service_area_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerServiceAreaStateViewModels extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> safeAreaState(BuildContext context) async {
    loading.value = true;
    CustomerServiceAreaStateRequestModel customerSafeAreaRequestModel =
        CustomerServiceAreaStateRequestModel(
            divisionId: 'f45f29ab-e1b9-47b7-b570-dfe76f8c76ed');
    _api.safeAreaState(customerSafeAreaRequestModel.toJson()).then((value) {
      if (value.isNotEmpty) {
        // Check if the customer_list is not empty
        // Iterate through the customer_list or handle each item individually
        for (var response in value) {
          if (kDebugMode) {
            // print("Customer safeArea State   ${response.name}");
          }
          if (response.id != null) {
            // Utils.snackbarSuccess("Customer SafeArea City Fetch");
          } else {
            // Utils.snackbarFailed('One of the master divisions does not have an ID');
          }
        }
        loading.value = false;
      } else {
        // Utils.snackbarFailed('master divisions not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
