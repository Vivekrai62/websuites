import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/order/list/search_customer/order_search_customer_request_model.dart';

import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';

class OrderListSearchCustomerViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> searchCustomerApi(BuildContext context) async {
    loading.value = true;

    OrderSearchCustomerRequestModel orderSearchCustomerRequestModel = OrderSearchCustomerRequestModel(limit: 15, search: "");

    _api.searchCustomer(orderSearchCustomerRequestModel.toJson()).then((response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var data in response.items!) {
          print('Order customer_list search Customer ${data.firstName}');
          print('Order customer_list search Customer ${data.lastName}');


        }
      }
     else {
        Utils.snackbarFailed('Order  Customer List not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
