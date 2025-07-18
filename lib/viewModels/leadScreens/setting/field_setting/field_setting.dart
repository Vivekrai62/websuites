import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/responseModels/leads/setting/field_setting/field_setting.dart';
import '../../../../data/repositories/repositories.dart';

class LeadFieldSettingViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  RxBool isDataLoaded = false.obs; // New flag to track if data has been loaded
  RxList<FieldSettingResponseModel> leadFiledSettings = <FieldSettingResponseModel>[].obs;

  Future<void> fieldSettingList(BuildContext context) async {
    // Only show loading and make API call if data hasn't been loaded already
    if (isDataLoaded.value && leadFiledSettings.isNotEmpty) {
      return; // Skip loading if we already have data
    }

    loading.value = true;
    try {
      final value = await _api.fieldSettingListApi();

      if (value.isNotEmpty) {
        leadFiledSettings.assignAll(value);
        isDataLoaded.value = true; // Mark that data has been loaded
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading field settings: $e');
      }
    } finally {
      loading.value = false;
    }
  }

  // Method to force refresh the data if needed
  Future<void> refreshFieldSettings(BuildContext context) async {
    loading.value = true;
    try {
      final value = await _api.fieldSettingListApi();

      if (value.isNotEmpty) {
        leadFiledSettings.assignAll(value);
        isDataLoaded.value = true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error refreshing field settings: $e');
      }
    } finally {
      loading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // You could optionally preload data when the ViewModel is first initialized
    // if (Get.context != null) fieldSettingList(Get.context!);
  }
}