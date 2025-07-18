import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/customer/order_product/services/customer_order_product_service_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerOrderProductServiceViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerOrderProductService(BuildContext context) async {
    OrderProductServiceRequestModel orderProductServiceRequestModel=OrderProductServiceRequestModel(
      orderProduct: "84f121f0-d840-4db6-934a-634e3ed4ee90",
      startDate: "2024-11-06T00:00:00.000Z",
      remark: "Ok",
      endDate: "2025-06-11",
      reminderBeforeExpire: 5,
    );
    loading.value = true;
    _api.customerOrderProductService(orderProductServiceRequestModel.toJson()).then((value) {
      if (value.id.isNotEmpty) {
       print("Customer Order Product firstName ${value.startBy.firstName}");
       print("Customer Order Product OrderProduct type ${value.orderProduct.productType}");
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