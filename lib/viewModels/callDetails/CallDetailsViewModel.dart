import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../data/models/responseModels/callDetails/CallDetailsResModel.dart';
import '../../data/models/responseModels/globalSetting/GlobalSettingResModel.dart';

class CallDetailsViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Rx<CallDetailsResModel?> globalSetting = Rx<CallDetailsResModel?>(null);

  Future<void> callDetails(BuildContext context) async {
    loading.value = true;
    try {
      final value = await _api.callDetails();
      globalSetting.value = value; // Store the fetched setting
      if (value != null) {
        // if (kDebugMode) {
        //   print("vivek Call Details: ${value.status}");
        // }
        // Utils.snackbarSuccess('vivek Call Details');
      } else {
        // Utils.snackbarFailed('vivek Call Details');
      }

      loading.value = false;
    } catch (error, stackTrace) {
      loading.value = false;
      if (kDebugMode) {
        // print("vivek Error: $error");
        // print("vivek StackTrace: $stackTrace");
      }
      // Utils.snackbarFailed('vivek Failed to fetch Call Details');
    }
  }
}