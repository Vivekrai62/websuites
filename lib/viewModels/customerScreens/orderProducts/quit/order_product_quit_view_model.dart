import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/customer/order_product/quit/customer_order_product_service_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerOrderProductQuitViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerOrderProductQuit(BuildContext context) async {
    CustomerOrderProductQuitRequestModel customerOrderProductQuitRequestModel =
        CustomerOrderProductQuitRequestModel(reason: "Testing");
    loading.value = true;
    _api
        .customerOrderProductQuit(customerOrderProductQuitRequestModel.toJson())
        .then((value) {
      if (value.id.isNotEmpty) {
        if (kDebugMode) {
          print("Customer Order Product Quit  ${value.startBy.firstName}");
        }
        print("Customer Order Product Quit ${value.orderProduct.productType}");
        Utils.snackbarSuccess('Customer customer_list fetched successfully');
      } else {
        Utils.snackbarFailed('Customer order Products not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
