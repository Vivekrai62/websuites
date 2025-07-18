import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/customer/customer_list/customer_detail_view/update_company/customer_detail_view_update_company_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerDetailUpdateCompanyViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerDetailViewUpdateCompany(BuildContext context) async {
    loading.value = true;
    CustomerRequestModel customerRequest = CustomerRequestModel(
      customer: "29c99755-1940-4332-8903-b2f596617f57",
      companyName: "Health Test",
      companyEmail: "lalit.webhopers@gmail.com",
      companyPhone: "9565668543210",
      countryCode: "91",
      contactPersonName: "Lalit Kumar",
      contactPersonNumber: "9876543210",
      gst: "07AAE887",
      website:"https://www.webhopers.com/",
      address:"Railway Colony",
      pincode:"b99b4b29-79e4-4805-b228-be78cdc5a7b5",
      state: "7046c56f-536f-4592-ba86-84c141fb83ff",
      city: "38c5d8e1-a310-4099-8d76-563c0644ec4f",
      country:"d5e52e1b-2353-4be5-ac4d-22f7124564a0",
      district:"40189bcc-0071-4137-841c-67accc7fab77",
    );
    _api.customerDetailViewUpdateCompany(customerRequest.toJson()).then((response) {
      if (response.id != null && response.id!.isNotEmpty) {
        // Process each lead item
          print('Customer Detail Update Company ${response.id}');
          print('Customer Detail  Update Company ${response.companyEmail}');
        Utils.snackbarSuccess('Customer Trash customer_list fetched successfully');
      }
      else{
        Utils.snackbarFailed('company Detail  not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }




}