import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/models/responseModels/leads/setting/lead_source/status/lead_source_status_list_res_model.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../../utils/utils.dart';

class LeadSourceStatusListViewModel extends GetxController {
  final _api = Repositories();
  final RxBool loading = false.obs;
  final statusList = <LeadSourceStatusListResModel>[].obs; // Store status data

  // Check if controller is still mounted
  bool get isMounted => !isClosed;

  Future<void> fetchLeadSourceStatus(
      String sourceId, {
        bool forceRefresh = false,
        Function()? onSuccess,
        Function(String error)? onError,
      }) async {
    if (!isMounted) return;

    loading.value = true;
    try {
      final List<LeadSourceStatusListResModel> response = await _api.leadSourceListStatusApi(sourceId);

      if (!isMounted) return;

      statusList.assignAll(response);

      if (response.isEmpty) {
        // Utils.snackbarFailed('No status data available for sourceId: $sourceId');
      } else {
        onSuccess?.call();
        if (onSuccess == null && isMounted) {
          // Utils.snackbarSuccess('Lead source status fetched successfully');
        }
      }
    } catch (error) {
      if (onError != null && isMounted) {
        onError(error.toString());
      } else if (isMounted) {
        // Utils.snackbarFailed('Failed to fetch lead source status: $error');
        // debugPrint('Error in lead source status: $error');
      }
    } finally {
      if (isMounted) {
        loading.value = false;
      }
    }

  }

  @override
  void onClose() {
    super.onClose();
    // debugPrint('LeadSourceStatusListViewModel disposed');
  }
}