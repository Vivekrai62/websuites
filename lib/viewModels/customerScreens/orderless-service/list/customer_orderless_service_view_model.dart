import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/customer/orderless_services/orderless_service_list/customer_orderless_service_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerOrderlessServicesViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerOrderlessServiceList(BuildContext context) async {
    loading.value = true;
    CustomerOrderlessServiceRequestModel customerOrderlessServiceRequestModel =
        CustomerOrderlessServiceRequestModel(
      dateRange: null,
      statusType: null,
      limit: 15,
      dateRangeTo: null,
      search: "",
      filterDays: null,
      filterDaysType: null,
      page: 1,
    );
    _api.customerOrderlessServicesList(customerOrderlessServiceRequestModel.toJson()).then((value) {
      if (value.items != null && value.items!.isNotEmpty) {
        for (var item in value.items!) {
          if (kDebugMode) {
            print('Customer Orderless Services: ${item.id}');
          }
          if (kDebugMode) {
            print('Customer Orderless Services Start Date ${item.startDate}');
            print('Customer Orderless Services ${item.endDate}');
            print(
                'Customer Orderless Services${item.company?.customer?.firstName}');
          }
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
