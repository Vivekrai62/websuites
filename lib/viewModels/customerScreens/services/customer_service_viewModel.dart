import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Utils/utils.dart';
import '../../../data/models/requestModels/customer/services/customer_services_area_request_model.dart';
import '../../../data/repositories/repositories.dart';
class CustomerServiceViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerServicesList(BuildContext context) async {
    loading.value = true;
    CustomerServicesRequestModel customerServicesRequestModel =
        CustomerServicesRequestModel(
      dateRange: null,
      dateRangeTo: null,
      filterDays: null,
      filterDaysType: null,
      limit: 15,
      page: 1,
      search: "",
      statusType: null,
    );
    _api.customerServices(customerServicesRequestModel.toJson())
        .then((response) {
      if (response.items.isNotEmpty) {
        for (var item in response.items) {
          print("Customer Service Remark:${item.orderProduct?.order?.remark}");
          print('Customer Services OrderNumber : ${item.startDate}');
          print("Customer Service End Date ${item.endDate}");
          print(
              'Customer Services OrderProduct total : ${item.orderProduct?.total}');
          print(
              'Customer Services OrderProduct  payment Mode: ${item.orderProduct?.paymentMode}');
          print(
              "Customer Service Company Email:${item.orderProduct?.order?.company?.companyEmail}");
          print("Customer Service Status:${item.orderProduct?.order?.status}");
        }
      } else {
        Utils.snackbarFailed('customer services List Id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
