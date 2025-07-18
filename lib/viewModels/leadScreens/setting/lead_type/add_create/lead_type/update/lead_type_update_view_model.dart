import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../../../Utils/utils.dart';
import '../../../../../../../data/models/requestModels/lead/setting/lead_type/lead_type/update/lead_type_update_req_model.dart';
import '../../../../../../../data/models/responseModels/leads/setting/lead_type/add_create/lead_type/update/lead_type_update_res_model.dart';
import '../../../../../../../data/repositories/repositories.dart';

class LeadUpdateTypeViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<bool> updateLeadTypeApi(
      String leadTypeId,
      String name,
      String status,
      bool isReminderRequired,
      bool removeFromTodo,
      bool removeFromList,
      ) async {
    loading.value = true;
    try {
      LeadTypeUpdateReqModel request = LeadTypeUpdateReqModel(
        name: name,
        status: status,
        isReminderRequired: isReminderRequired,
        // removeFromTodo: removeFromTodo,
        // removeFromList: removeFromList,
      );

      LeadTypeUpdateResModel response =
      await _api.updateLeadTypeApi(leadTypeId, request.toJson());

      if (response.status != null && response.status!.isNotEmpty) {
        Utils.snackbarSuccess('Lead Type updated successfully');
        return response.status == "true";
      } else {
        Utils.snackbarFailed('Failed to update Lead Type');
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      Utils.snackbarFailed('An error occurred while updating Lead Type');
      return false;
    } finally {
      loading.value = false;
    }
  }
}