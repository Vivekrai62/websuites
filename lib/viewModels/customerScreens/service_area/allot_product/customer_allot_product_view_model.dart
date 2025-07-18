import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/customer/service_area/allot_product/customer_allot_product_request_model.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';
class CustomerAllotProductViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> allotProduct(BuildContext context) async {
    loading.value = true;
   CustomerAllotProductRequestModel allotProductRequestModel=CustomerAllotProductRequestModel(
     customerId: 'be966547-da12-4af9-990d-3df8f844c6a7',
     companyId: '3e4bc2ff-6a39-4ad9-90c6-0776bdbbf966',
     districtId: 'c6ffeb4d-f36b-47c0-b557-5569c20ade08',
     completeDistrict: false,
     pincodeId: '3efe52d6-63a6-4f81-a506-b0a2c9a1032f',
     divisionId: 'f45f29ab-e1b9-47b7-b570-dfe76f8c76ed',
     completeDivision: false,
     productIds: [
       '2796493c-e25c-4bec-8935-91bc4434c7ee',
     ],
   );
    _api.serviceAreaAllotProduct(allotProductRequestModel.toJson()).then((
        response) {
      if (response.message!=null) {
        // Process each lead item
       print("Customer Service Allot Product Successful");
       print("Message Service Area ${response.message}");
        Utils.snackbarSuccess('Customer Service Allot customer_list ');
      }
      else {
        Utils.snackbarFailed('customer Service Area Allot product does not fetch');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}