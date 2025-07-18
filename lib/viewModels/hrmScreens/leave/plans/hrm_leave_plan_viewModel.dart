import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../../utils/utils.dart';
import '../../../../data/models/responseModels/hrm/leave/plans/HrmLeavePlanResponseModel.dart';

class LeavePlanViewModel extends GetxController {
  final Repositories _api = Repositories();
  RxBool loading = false.obs;
  RxList<HrmLeavePlanResponseModel> leaveTypeList = <HrmLeavePlanResponseModel>[].obs;

  Future<void> leavePlanApi(BuildContext context) async {
    loading.value = true;
    try {
      leaveTypeList.value = await _api.leavePlanApi();
      if (leaveTypeList.isNotEmpty) {
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