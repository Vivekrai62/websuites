import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/models/requestModels/master/master_customize/customize_lead_source/customize_lead_source.dart';
import '../../../../data/repositories/repositories.dart';

class MasterCustomizeLeadSourceViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> masterCustomizeLeadSource(BuildContext context) async {
    loading.value = true;
    CustomizeLeadSourceRequestModel requestModel =
        CustomizeLeadSourceRequestModel(modules: ["lead_source"]);
    // Convert the RequestModel to JSON
    Map<String, dynamic> requestData = requestModel.toJson();
    _api.masterCustomizeLeadSource(requestData).then((value) {
      print("Value $value");
      if (value.isNotEmpty) {
        // Check if the customer_list is not empty
        for (var responseData in value) {
          print("Customize Lead Source ${responseData.key}");
          if (responseData.id != null) {
            // Utils.snackbarSuccess('Master divisions fetched');
          } else {
            // Utils.snackbarFailed('One of the master divisions does not have an ID');
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
