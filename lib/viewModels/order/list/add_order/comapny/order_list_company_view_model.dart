import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/order/list/add_order/company/order_list_company_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class OrderListCompanyViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> orderListCompany (BuildContext context) async {
    loading.value = true;

    OrderCompanyRequestModel orderCompanyRequestModel=OrderCompanyRequestModel( customerId: "29c99755-1940-4332-8903-b2f596617f57",
      limit: 15,
      page: 1,
      range: null,
      search: "",);
    _api.orderCompany(orderCompanyRequestModel.toJson()).then((response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var data in response.items!) {
          print('Order List Company Response  ${data.companyName}');

        }
        Utils.snackbarSuccess('Order  List Company Response Order data fetch');
      }
      else{
        Utils.snackbarFailed('order List Company Response not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }


}