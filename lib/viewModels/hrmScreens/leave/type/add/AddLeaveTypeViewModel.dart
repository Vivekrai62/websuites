import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/HRM/type/add/AddLeaveTypeRequestModel.dart';
import '../../../../../data/models/responseModels/hrm/leave/type/add/AddLeaveTypeResponseModel.dart';
import '../../../../../data/repositories/repositories.dart';

class AddLeaveTypeViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<AddLeaveTypeResponseModel> leaveAddType =
      <AddLeaveTypeResponseModel>[].obs;

  Future<void> addLeaveTypeApi(
    BuildContext context,
    AddLeaveTypeRequestModel addLeaveType,
  ) async {
    loading.value = true;
    try {
      final response = await _api.addLeaveTypeApi(addLeaveType.toJson());
      leaveAddType.add(response); // Add the new leave type to the customer_list
      Utils.snackbarSuccess('Leave type added successfully');
    } catch (error) {
      if (kDebugMode) {
        // print("Error: $error");
      }
      Utils.snackbarFailed('Failed to add leave type');
    } finally {
      loading.value = false;
    }
  }
}
