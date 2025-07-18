import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/customer/orderless_services/orderless_service_create/customer_orderless_service_create_request_model.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';
class CustomerOrderlessServicesCreateViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerOrderlessServiceCreate(BuildContext context) async {
    loading.value = true;
    CustomerOrderlessServiceCreateRequestModel
        orderlessServiceCreateRequestModel =
        CustomerOrderlessServiceCreateRequestModel(
      startDate: "2024-11-01",
      endDate: "2025-11-30",
      productId: "3a309211-aabf-4e85-a7aa-62af8cf99b5b",
      reminderBeforeExpire: 7,
      companyId: "ec755b40-5853-4baf-9251-7a32a55b960d",
      remark: "Testing",
    );
    _api.customerOrderlessServicesCreate(
            orderlessServiceCreateRequestModel.toJson())
        .then((value) {
      if (value.id!.isNotEmpty ) {
          if (kDebugMode) {
            print('Customer Orderless Services update ${value.company?.id}');
            print('Customer Orderless Services update  Remark${value.remark}');
          }
          if (kDebugMode) {
            print('Customer Orderless Services Created Start date ${value.startDate}');
          }
        Utils.snackbarSuccess('Customer Orderless Services successfully');
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
