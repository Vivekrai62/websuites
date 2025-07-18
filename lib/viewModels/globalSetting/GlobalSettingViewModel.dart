import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../data/models/responseModels/globalSetting/GlobalSettingResModel.dart';

class GlobalSettingViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Rx<GlobalSettingResModel?> globalSetting = Rx<GlobalSettingResModel?>(null);

  Future<void> fetchGlobalSettings(BuildContext context) async {
    loading.value = true;
    try {
      final value = await _api.globalSetting();
      globalSetting.value = value; // Store the fetched setting
      if (value != null) {
        if (kDebugMode) {
          print("Global Setting Country Code: ${value.countryCode}");
        }
        Utils.snackbarSuccess('Global settings fetched successfully');
      } else {
        Utils.snackbarFailed('No global settings fetched');
      }

      loading.value = false;
    } catch (error, stackTrace) {
      loading.value = false;
      if (kDebugMode) {
        print("Error: $error");
        print("StackTrace: $stackTrace");
      }
      Utils.snackbarFailed('Failed to fetch global settings');
    }
  }
}