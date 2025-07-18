import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../data/models/requestModels/customer/service_area/pincodes/customer_service_area_pincode_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerServiceAreaPincodeViewmodel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerSafeAreaPincode(BuildContext context) async {
    loading.value = true;
    CustomerServiceAreaPincodeRequestModel pincodeRequestModel =
        CustomerServiceAreaPincodeRequestModel(
      districtId: "d86bbf28-1dea-441f-9992-a385697bcada",
      divisionId: "2dc8cc03-a7ed-4763-80c9-b37c32d39c80",
    );
    _api.safeAreaPincode(pincodeRequestModel.toJson()).then((value) {
      if (value.isNotEmpty) {
        // Check if the customer_list is not empty
        for (var response in value) {
          if (kDebugMode) {
            // print("Customer safeArea PinCodes ${response.code}");
          }
          if (response.id != null) {
            // Utils.snackbarSuccess("Customer SafeArea pincode Fetch");
          } else {
            // Utils.snackbarFailed('No data Found');
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
