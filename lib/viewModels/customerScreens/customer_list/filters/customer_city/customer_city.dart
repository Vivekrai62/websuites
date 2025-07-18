import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../data/models/requestModels/customer/customer_city/customer_city.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerCityViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  CitySearchRequestModel requestModel = CitySearchRequestModel(search: '');
  Future<void> customerCity(BuildContext context) async {
    loading.value = true;
    _api.filterCityApi(requestModel.toJson()).then((value) {
      if (kDebugMode) {
        print("Customer city api ${value.items?.first.name ?? ""}");
      }
      if (value.items != null) {
        if (kDebugMode) {
          var data = value.items;
          print("Customer city Api value ${data?.first.name ?? ""}");
        }
        loading.value = false;
        // Utils.snackbarSuccess(' data fetched');
      } else {
        // Utils.snackbarFailed('Customer Division api data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
