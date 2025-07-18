import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/repositories.dart';
import '../../../data/models/responseModels/leads/setting/setting.dart';

class LeadSettingListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadSettingResponseModel> leadSettings = <LeadSettingResponseModel>[].obs;

  // Track if data has been loaded already
  RxBool _hasLoadedData = false.obs;

  Future<void> leadColumnSettingList(BuildContext context) async {
    // Only show loading and make API call if data hasn't been loaded yet
    if (_hasLoadedData.value && leadSettings.isNotEmpty) {
      return; // Data already loaded, no need to fetch again
    }

    loading.value = true;
    try {
      final value = await _api.leadColumnSettingListApi();
      if (value.isNotEmpty) {
        // Check the type of data in value
        if (value is List<LeadSettingResponseModel>) {
          // If already parsed into LeadSettingResponseModel
          leadSettings.value = value;
        } else if (value is List<Map<String, dynamic>>) {
          // If raw JSON, parse using fromJsonList
          leadSettings.value = LeadSettingResponseModel.fromJsonList(value);
        } else {
          // Handle unexpected type
          if (kDebugMode) {
            print('Unexpected API response type: ${value.runtimeType}');
          }
          // Utils.snackbarFailed('Invalid data format');
        }

        // Mark data as loaded
        _hasLoadedData.value = true;
        loading.value = false;
      } else {
        // Handle empty response
        loading.value = false;
        // Utils.snackbarFailed('No lead settings fetched');
      }
    } catch (error, stackTrace) {
      loading.value = false;
      if (kDebugMode) {
        // print('Error: $error');
        // print('StackTrace: $stackTrace');
      }
      // Utils.snackbarFailed('Failed to fetch lead settings');
    }
  }

  // Add method to force refresh when needed
  void refreshData(BuildContext context) {
    _hasLoadedData.value = false;
    leadColumnSettingList(context);
  }

  // Clear data when no longer needed (optional)
  void clearData() {
    _hasLoadedData.value = false;
    leadSettings.clear();
  }
}