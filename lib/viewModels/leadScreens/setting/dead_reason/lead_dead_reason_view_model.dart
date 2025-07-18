import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/leads/setting/dead_reasons/lead_setting_dead_reason_res_model.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class LeadDeadReasonViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  // Add a reactive list to store the fetched data
  RxList<LeadSettingDeadReasonList> leadDeadReasons = <LeadSettingDeadReasonList>[].obs;

  Future<void> leadDeadReasonListApi(BuildContext context) async {
    loading.value = true;
    try {
      final value = await _api.leadDeadReasonListApi();
      print("Lead dead reason api $value");
      if (value.isNotEmpty) {
        // Update the reactive list with fetched data
        leadDeadReasons.assignAll(value);
        for (var responseData in value) {
          print("lead dead reasons ${responseData.id}");
          Utils.snackbarSuccess('Lead dead reasons fetched');
        }
      } else {
        Utils.snackbarFailed('No lead dead reasons fetched');
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      Utils.snackbarFailed('Failed to fetch lead dead reasons');
    } finally {
      loading.value = false;
    }
  }
}