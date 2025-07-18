import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/requestModels/master/master_customize/master_customizeList.dart';
import '../../../../data/models/responseModels/master/customizeLabel/customize/customize_response_model.dart';
import '../../../../data/repositories/repositories.dart';

class MasterCustomizeListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  // List to store the fetched customize customer_list
  final RxList<MasterCustomizeResponseModel> _masterCustomizeList =
      <MasterCustomizeResponseModel>[].obs;

  // Getter to expose the customer_list
  List<MasterCustomizeResponseModel> get masterCustomizeListResult =>
      _masterCustomizeList;

  Future<void> masterCustomizeList(BuildContext context) async {
    loading.value = true;
    MasterCustomizeRequestModel requestModel =
        MasterCustomizeRequestModel(modules: ["customers"]);

    // Convert the RequestModel to JSON
    Map<String, dynamic> requestData = requestModel.toJson();

    _api.masterCustomizeList(requestData).then((value) {
      print("Value $value");
      if (value.isNotEmpty) {
        _masterCustomizeList.value =
            value; // Store the result in the observable customer_list

        // Check if all items have an ID
        bool allItemsHaveId =
            value.every((responseData) => responseData.id != null);

        // Show the snackbar based on the overall result
        if (allItemsHaveId) {
          // Utils.snackbarSuccess('Master divisions fetched');
          // print("Master divisions fetched");
        } else {
          // Utils.snackbarFailed('One or more master divisions do not have an ID');
        }
      } else {
        // Utils.snackbarFailed('Master divisions not fetched');
        // print("Master divisions not fetched");
      }
      loading.value = false;
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      // Utils.snackbarFailed('Error fetching master divisions');
      // print("Error fetching master divisions");
      loading.value = false;
    });
  }
}
