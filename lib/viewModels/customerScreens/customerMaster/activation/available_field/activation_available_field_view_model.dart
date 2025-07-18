import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/customer/master/activation_service/available_field/activation_available_field_request_model.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class ActivationAvailableFieldViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerActivationAvailableField(BuildContext context) async {
    loading.value = true;
    ActivationAvailableFieldRequestModel requestModel =
        ActivationAvailableFieldRequestModel(
      limit: 200,
      page: 1,
    );
    _api.customerMasterActivationAvailableField(requestModel.toJson())
        .then((response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var value in response.items!) {
          print("Activation available fields  Field Label ${value.fieldLabel}");
          print("Activation available field type ${value.type}");

        }
        Utils.snackbarSuccess('Customer Trash customer_list fetched successfully');
      } else {
        Utils.snackbarFailed('activity Purpose Id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
