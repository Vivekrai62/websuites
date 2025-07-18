import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/HRM/type/add/AddLeaveTypeRequestModel.dart';
import '../../../../../data/models/requestModels/HRM/type/update/UpdateLeaveTypeRequestModel.dart';
import '../../../../../data/models/responseModels/hrm/leave/type/add/AddLeaveTypeResponseModel.dart';

import '../../../../../data/models/responseModels/hrm/leave/type/update/UpdateLeaveTypeRsponseModel.dart';
import '../../../../../data/repositories/repositories.dart';

class UpdateLeaveTypeViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<UpdateLeaveTypeResponseModel> leaveUpdateType =
      <UpdateLeaveTypeResponseModel>[].obs;

  Future<void> updateLeaveTypeApi(
    BuildContext context,
    UpdateLeaveTypeRequestModel updateLeaveType,
  ) async {
    loading.value = true;
    try {
      // Extract the ID from the UpdateLeaveTypeRequestModel
      String? id = updateLeaveType.id; // This is now nullable

      // Check if id is null
      if (id == null) {
        Utils.snackbarFailed('Leave type ID cannot be null');
        return; // Exit early if id is null
      }

      // Debug print to check the ID
      print('Leave Type ID: $id');

      // Call the API with the ID and the JSON data
      final response =
          await _api.updateLeaveTypeApi(id, updateLeaveType.toJson());

      leaveUpdateType
          .add(response); // Add the new leave type to the customer_list
      Utils.snackbarSuccess('Leave type updated successfully');
    } catch (error) {
      if (kDebugMode) {
        print("Error: $error");
      }
      Utils.snackbarFailed('Failed to update leave type');
    } finally {
      loading.value = false;
    }
  }
}
