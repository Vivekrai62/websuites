import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../Utils/utils.dart';
import '../../../../../../data/models/requestModels/lead/setting/source/update/lead_source_update_req_model.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../data/models/requestModels/lead/setting/dead/create/lead_dead_create_req_model.dart';
import '../../../../../data/models/requestModels/lead/setting/dead/update/lead_dead_update_req_model.dart';

class LeadDeadUpdateViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> leadDeadUpdateApi(BuildContext context, LeadSettingDeadUpdateReqModel deadRequest, String deadId) async {
    loading.value = true;
    try {
      // Log the actual payload being sent to the API
      debugPrint('Sending API request with payload: ${deadRequest.toJson()} and sourceId: $deadId');
      debugPrint('Status being sent: ${deadRequest.reason}');

      final response = await _api.leadDeadUpdateApi(deadRequest.toJson(), deadId);
      loading.value = false;

      debugPrint('API response: id=${response..message}, name=${response.message}, status=${response.message}');

      if (response.message!=null) {
        debugPrint('Dead Updated: ID = ${response.message}, Name = ${response.message}, Status = ${response.message}');
        Utils.snackbarSuccess('Dead updated successfully with status: ${response.message}');
      } else {
        debugPrint('API response invalid: $response');
        Utils.snackbarFailed('Failed to update source: Invalid response');
      }
    } catch (e, stackTrace) {
      loading.value = false;
      debugPrint('Error updating lead source: $e');
      debugPrint('Stack trace: $stackTrace');
      Utils.snackbarFailed('Error updating source: $e');
    }
  }
}