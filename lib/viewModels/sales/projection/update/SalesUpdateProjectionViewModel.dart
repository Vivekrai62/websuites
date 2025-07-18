import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/sales/projection/update/SalesUpdateProjectionReqModel.dart';
import '../../../../data/models/responseModels/sales/projection/update/SalesUpdateProjectionResModel.dart';
import '../../../../data/repositories/repositories.dart';

class SalesUpdateProjectionViewModel extends GetxController {
  final api = Repositories();
  RxBool loading = false.obs;

  Future<bool> salesUpdateProjection(
      String userId, String projectionDate, int amount) async {
    loading.value = true;
    try {
      final requestModel = {
        'projection_date': projectionDate,
        'amount': amount, // Pass amount as an integer
      };

      final response = await api.salesUpdateProjection(
        userId,
        requestModel,
      );

      if (response.message.isNotEmpty) {
        // Utils.snackbarSuccess('Sales projection updated successfully');
        return response.message == "true";
      } else {
        // Utils.snackbarFailed('Failed to update sales projection');
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        // print('Error updating sales projection: $error');
      }
      // Utils.snackbarFailed('An error occurred while updating sales projection');
      return false;
    } finally {
      loading.value = false;
    }
  }
}
