import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../../../Utils/utils.dart';
import '../../../../../../../data/models/requestModels/lead/setting/lead_type/sub_lead_type/update_lead/sub_tyep_update_req_model.dart';
import '../../../../../../../data/models/responseModels/leads/setting/lead_type/add_create/sub_type/update_lead/sub_tyep_update_res_model.dart';
import '../../../../../../../data/repositories/repositories.dart';

class LeadUpdateSubTypeViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<bool> updateSubLeaveTypeApi(
      String subtypeId, String name, String status, bool isReminderRequired) async {
    loading.value = true;
    try {
      LeadSubtypeUpdateReqModel request = LeadSubtypeUpdateReqModel(
        name: name,
        status: status,
        isReminderRequired: isReminderRequired,
      );

      LeadSubtypeUpdateResModel response =
      await _api.updateSubLeaveTypeApi(subtypeId, request.toJson());

      if (response.status != null && response.status!.isNotEmpty) {
        Utils.snackbarSuccess('Lead Sub Type updated successfully');
        return response.status == "true"; // Return the updated status as a boolean
      } else {
        Utils.snackbarFailed('Failed to update Lead Sub Type');
        return false; // Return false if the update failed
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      Utils.snackbarFailed('An error occurred while updating Lead Sub Type');
      return false; // Return false in case of an error
    } finally {
      loading.value = false;
    }
  }
}