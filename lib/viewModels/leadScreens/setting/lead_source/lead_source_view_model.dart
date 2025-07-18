import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/leads/setting/lead_source/lead_source_list_res_model.dart';
import '../../../../data/models/responseModels/leads/setting/lead_source/status/lead_source_status_list_res_model.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class LeadSourceListViewModel extends GetxController {
  final _api = Repositories();
  final loading = false.obs;
  final sourceList = <LeadSourceListResModel>[].obs;
  final selectedSourceId = ''.obs; // Track selected source ID
  final statusList = <LeadSourceStatusListResModel>[].obs; // Store status data

  Future<void> fetchLeadSourceList(BuildContext context) async {
    try {
      loading.value = true;
      final value = await _api.leadSourceListApi();

      if (value.isNotEmpty) {
        sourceList.assignAll(value);
        // Utils.snackbarSuccess('Source data fetched successfully');
      } else {
        // Utils.snackbarFailed('No source data available');
      }
    } catch (e) {
      if (kDebugMode) {
        // print('Error fetching lead sources: $e');
      }
      // Utils.snackbarFailed('Failed to fetch source data: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> fetchLeadSourceStatus(String sourceId) async {
    try {
      loading.value = true;
      selectedSourceId.value = sourceId; // Update selected source ID
      final value = await _api.leadSourceListStatusApi(sourceId);

      if (value.isNotEmpty) {
        statusList.assignAll(value);
        // Utils.snackbarSuccess('Status data fetched successfully');
      } else {
        // Utils.snackbarFailed('No status data available');
      }
    } catch (e) {
      if (kDebugMode) {
        // print('Error fetching lead source status: $e');
      }
      // Utils.snackbarFailed('Failed to fetch status data: $e');
    } finally {
      loading.value = false;
    }
  }
}