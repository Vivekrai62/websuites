import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../../Utils/utils.dart';
import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/update_status/dead_reason/LeadDetailsDeadStatusReason.dart';
import '../../../../../../data/repositories/repositories.dart';

class LeadDetailsStatusDeadReason extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadDetailsDeadStatusReason> deadReasons = <LeadDetailsDeadStatusReason>[].obs;

  Future<List<String>> leadDetailDeadReasonApi(BuildContext context) async {
    loading.value = true;
    try {
      final value = await _api.leadDetailDeadReasonApi();
      if (value.isNotEmpty) {
        deadReasons.assignAll(value); // Store the fetched reasons
        for (var responseData in value) {
          if (kDebugMode) {
            print("Lead Detail Dead Reason Type: ${responseData.reason}");
          }
        }
        Utils.snackbarSuccess('Lead Detail Reason data fetched');
        loading.value = false;
        return deadReasons.map((reason) => reason.reason ?? '').toList();
      } else {
        Utils.snackbarFailed('Lead Detail Reason not fetched');
        loading.value = false;
        return [];
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("Error: $error");
        print("StackTrace: $stackTrace");
      }
      Utils.snackbarFailed('Failed to fetch Lead Detail Reason');
      loading.value = false;
      return [];
    }
  }
}