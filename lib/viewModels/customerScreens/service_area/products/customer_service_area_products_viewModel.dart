import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/customer/service_area/product/customer_service_area_product_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerServiceAreaProductsViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerSafeAreaProduct(BuildContext context) async {
    loading.value = true;
    CustomerServiceAreaProductRequestModel productRequestModel =
        CustomerServiceAreaProductRequestModel(
            completeDistrict: false,
            districtId: "8f9b70f4-c555-4bb4-843b-c478a1f8a387",
            divisionId: "2dc8cc03-a7ed-4763-80c9-b37c32d39c80",
            pincodeId: "c33a3304-054e-4c5f-a06c-71a9c59daba9");
    _api.safeAreaProduct(productRequestModel.toJson()).then((response) {
      if (response.isNotEmpty) { // Check if the customer_list is not empty
        // Iterate through the customer_list or handle each item individually
        for (var data in response) {
          if (data.id != null) {
            if (kDebugMode) {
              print("Customer safeArea Products ${data.productCategory}");
            }
            Utils.snackbarSuccess("Customer SafeArea product Fetch");
          } else {
            Utils.snackbarFailed('No data Found');
          }
        }
        loading.value = false;
      }
    else{
      Utils.snackbarFailed('Customer Safe Area Product data  not found');
    }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}
