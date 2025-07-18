import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/customer/service_area/select_company/service_area_select_company_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class ServiceAreaSelectCompanyViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> selectCompany(BuildContext context) async {
    loading.value = true;
    ServiceAreaSelectCompanyRequestModel selectCompanyRequestModel = ServiceAreaSelectCompanyRequestModel(
      limit: 15,
      page: 1,
      customerId: "be966547-da12-4af9-990d-3df8f844c6a7",
    );

    _api.serviceAreaSelectCompany(selectCompanyRequestModel.toJson()).then((
        response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var item in response.items!) {
          print('Customer Service Select: ${item.id}');
          print('Customer Service Select Company : ${item.companyName}');
          print('Customer Service Select Company Email : ${item.companyEmail}');


        }
        Utils.snackbarSuccess('Customer Service select company customer_list ');
      }
      else {
        Utils.snackbarFailed('customer Companies  List Id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}