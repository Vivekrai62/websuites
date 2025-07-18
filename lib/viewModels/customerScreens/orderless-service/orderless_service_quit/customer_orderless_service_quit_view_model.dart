import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/customer/orderless_services/orderless_service_quit/customer_orderless_service_quit_request_model.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';
class CustomerOrderlessServiceQuitViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerOrderlessServiceQuit(BuildContext context) async {
    loading.value = true;
    CustomerOrderlessServiceQuitRequestModel customerOrderlessServiceQuitRequestModel=CustomerOrderlessServiceQuitRequestModel(reason:'testing',);
    _api.customerOrderlessServicesQuit(customerOrderlessServiceQuitRequestModel.toJson()).then((value) {
      if (value.id!= null && value.id!.isNotEmpty){
          if (kDebugMode) {
            print('Customer Orderless Services Quit: ${value.quitBy?.firstName}');
            print("Customer Orderless Services Quit Email ${value.quitBy?.email} ");
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




