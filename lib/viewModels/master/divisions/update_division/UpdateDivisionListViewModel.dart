import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/master/divisions/update/UpdateDivisionListResponseModel.dart';
import '../../../../data/repositories/repositories.dart';

class UpdateDivisionListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Rx<List<UpdateDivisionListResponseModel>> division = Rx([]);

  Future<void> updateDivisionList(BuildContext context, String id) async {
    loading.value = true; // Start loading
    try {
      // Fetch the division customer_list using the provided id
      List<UpdateDivisionListResponseModel> value =
          await _api.updateDivisionList(id);
      division.value = value; // Update the division customer_list
      loading.value = false; // Stop loading

      if (value.isNotEmpty) {
        // Utils.snackbarSuccess('Master proposals fetched');
        // print('Master fetched');
      } else {
        // Utils.snackbarFailed('Master proposals not fetched');
        // print('Master proposals not fetched');
      }
    } catch (error) {
      loading.value = false; // Stop loading on error
      if (kDebugMode) {
        // print(error.toString());
      }
      // Utils.snackbarFailed('An error occurred: ${error.toString()}');
    }
  }
}
