import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/customer/customer_order_product/order_product_list/customer_order_product_request_model.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
class CustomerOrderProductsListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerOrderProducts(BuildContext context) async {
    loading.value = true;
CustomerOrderProductRequestModel customerOrderProductRequestModel=CustomerOrderProductRequestModel(
  btnLabel: "Submit",
  createdBy: null,
  customer: null,
  dateRange: null,
  fiscalYearLabel: null,
  isModalShow: false,
  isTaxable: "No",
  limit: 15,
  modalType: "Add",
  page: 1,
  paymentType: null,
  product: null,
  productType: null,
  search: "",
  status: null,
);

    _api.customerOrderProduct(customerOrderProductRequestModel.toJson()).then((value) {
      if (value.items != null && value.items!.isNotEmpty) {
        for (var item in value.items!) {
          if (kDebugMode) {
            print('Customer Order Product id: ${item.id}');
          }
          if (kDebugMode) {
            print('Customer Order Product Company name ${item.order?.company?.companyName}');
          }
          print('Customer Order order Number ${item.order?.orderNumber}');
        }
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
