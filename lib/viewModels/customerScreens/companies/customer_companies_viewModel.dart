import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Utils/utils.dart';
import '../../../data/models/requestModels/customer/companies/customer_companies.dart';
import '../../../data/repositories/repositories.dart';
class CustomerCompaniesViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;


  Future<void> companyList(BuildContext context) async {
    loading.value = true;
    CustomerCompaniesRequestModel companiesRequestModel = CustomerCompaniesRequestModel(
      assignedTo: "",
      customerId: "",
      limit: 15,
      page: 1,
      range: null,
      search: "",
    );
    _api.customerCompaniesList(companiesRequestModel.toJson()).then((
        response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var item in response.items!) {
          print('Customer Company List : ${item.id}');
          print('Customer Company List Phone No: ${item.companyPhone}');
          print('Customer Company List  Name: ${item.customer?.firstName}');
        }
        Utils.snackbarSuccess('Customer customer_list fetched successfully');
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