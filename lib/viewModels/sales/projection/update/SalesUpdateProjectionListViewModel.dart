import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/sales/projection/update/SalesUpdateProjectionListResponseModel.dart';
import '../../../../data/repositories/repositories.dart';

class SalesUpdateProjectionListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<SalesUpdateProjectionListResponseModel> projectionUpdateGet =
      <SalesUpdateProjectionListResponseModel>[]
          .obs; // Declare the customer_list

  Future<void> salesProjectionUpdateApi(BuildContext context) async {
    loading.value = true;
    try {
      final response = await _api.salesProjectionUpdateApi();
      // print("Value $response");
      if (response.isNotEmpty) {
        projectionUpdateGet.value =
            response; // Update the departments customer_list
        // Utils.snackbarSuccess('Master divisions fetched');
        // print('Master divisions fetched');
      } else {
        // Utils.snackbarFailed('Master divisions not fetched');
        // print('Master divisions not fetched');
      }
    } catch (e) {
      // Utils.snackbarFailed('Error fetching master divisions: $e');
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      loading.value =
          false; // Ensure loading is false regardless of success or failure
    }
  }
}
