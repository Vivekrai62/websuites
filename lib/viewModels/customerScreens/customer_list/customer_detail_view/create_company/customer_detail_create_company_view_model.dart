import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/customer/customer_list/customer_detail_view/create_company/customer_detail_create_company_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerDetailCreateCompanyViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerDetailCreateCompany(BuildContext context) async {
    loading.value = true;
    CustomerViewCreateCompanyRequestModel companyRequestModel=CustomerViewCreateCompanyRequestModel(
      customer: "29c99755-1940-4332-8903-b2f596617f57",
      companyName: "testing Purpose",
      companyEmail: "sakshi@gmail.com",
      companyPhone: "987678873210",
      countryCode: "91",
      cCountryCode: "91",
      contactPersonName: "testing",
      contactPersonNumber: "9876543210",
      gst: "07AAEFE5388B1ZJ",
      website: "https://www.webhopers.com/",
      address: "Railway Colony",
      pincode: "b99b4b29-79e4-4805-b228-be78cdc5a7b5",
      state: "2ac87851-6207-4e99-aa27-ea1a0ad2f862",
      city: "38c5d8e1-a310-4099-8d76-563c0644ec4f",
      country: "d5e52e1b-2353-4be5-ac4d-22f7124564a0",
      parent: "undefined",
      district: "40189bcc-0071-4137-841c-67accc7fab77",
      stateCode: "undefined",
      logo: "undefined",
      addressType: "indian",
    );

    _api.customerDetailViewCreateCompany(companyRequestModel.toJson()).then((value) {
      if(value.isNotEmpty){
        for (var responseData in value) {
          if (kDebugMode) {
            print("Customer Detail View Create Company  company name ${responseData.companyName}");
            print("Customer Detail View Crete Company Company Email${responseData.companyEmail}");
          }
          Utils.snackbarSuccess('Lead Master type data fetched');
        }
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Customer Type data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }



}