import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../Utils/utils.dart';
import '../../../../../../data/models/requestModels/lead/setting/source/update/lead_source_update_req_model.dart';
import '../../../../../../data/repositories/repositories.dart';

class LeadSourceUpdateViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> leadSourceUpdateApi(BuildContext context, LeadSourceUpdateReqModel sourceRequest, String sourceId) async {
    loading.value = true;
    try {
      // Log the actual payload being sent to the API
      debugPrint('Sending API request with payload: ${sourceRequest.toJson()} and sourceId: $sourceId');
      debugPrint('Status being sent: ${sourceRequest.status}');

      final response = await _api.leadSourceUpdateApi(sourceRequest.toJson(), sourceId);
      loading.value = false;

      debugPrint('API response: id=${response.id}, name=${response.name}, status=${response.status}');

      if (response.id.isNotEmpty) {
        debugPrint('Source Updated: ID = ${response.id}, Name = ${response.name}, Status = ${response.status}');
        Utils.snackbarSuccess('Source updated successfully with status: ${response.status}');
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