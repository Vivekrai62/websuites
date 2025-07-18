import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/models/requestModels/customer/service_area/city/safe_area_city_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class CustomerServiceAreaCityViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerSafeAreaCity(BuildContext context) async {
    loading.value = true;
    ServiceAreaCityRequestModel safeAreaCityRequestModel =
        ServiceAreaCityRequestModel(
            divisionId: "2dc8cc03-a7ed-4763-80c9-b37c32d39c80",
            stateId: "406d3dab-1230-4555-8c96-771efae4e50a");
    _api.safeAreaCity(safeAreaCityRequestModel.toJson()).then((value) {
      if (value.isNotEmpty) {
        for (var response in value) {
          if (kDebugMode) {
            // print("Customer safeArea city   ${response.name}");
          }
          if (response.id != null) {
            // Utils.snackbarSuccess("Customer SafeArea City Fetch");
          } else {
            // Utils.snackbarFailed('No city found');
          }
        }
        loading.value = false;
      } else {
        // Utils.snackbarFailed('master divisions not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
