import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../../utils/utils.dart';
import '../../../../data/models/responseModels/hrm/leave/type/hrm_leave_type_response_model.dart';

class LeaveTypeViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<HrmLeaveTypeResponseModel> leaveDataList = <HrmLeaveTypeResponseModel>[].obs;

  Future<void> leaveApi(BuildContext context) async {
    loading.value = true;

    try {
      leaveDataList.value = await _api.leaveApi();
      if (leaveDataList.isNotEmpty) {
        Utils.snackbarSuccess('Leave Data fetched');
      } else {
        Utils.snackbarFailed('No Leave Data found');
      }
    } catch (error) {
      Utils.snackbarFailed('Error fetching leave data');
      if (kDebugMode) {
        print(error.toString());
      }
    } finally {
      loading.value = false;
    }
  }
}


