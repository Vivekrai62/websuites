import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../data/models/responseModels/customers/list/filter/customer_division.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerDivisionViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<CustomerDivisionResponseModel> divisionList =
      <CustomerDivisionResponseModel>[].obs; // <-- Add this

  Future<void> customerListDivision() async {
    loading.value = true;
    _api.customerDivision().then((value) {
      if (kDebugMode) {
        // print("Customer Division api $value");
      }
      if (value.isNotEmpty) {
        divisionList.assignAll(value); // <-- Assign the fetched data
        loading.value = false;
      } else {
        // Utils.snackbarFailed('Customer Division api data not fetched');
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      loading.value = false;
    });
  }
}
