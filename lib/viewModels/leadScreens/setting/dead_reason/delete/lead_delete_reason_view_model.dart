import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';
import '../lead_dead_reason_view_model.dart';

class LeadDeleteReasonViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> deleteLeadDeadReasonApi(BuildContext context, String sourceId) async {
    loading.value = true;
    try {
      final response = await _api.deleteLeadDeadReasonApi(sourceId);
      if (response.message?.isNotEmpty ?? false) {
        if (kDebugMode) {
          print('Delete dead reason: ${response.message}');
        }
        Utils.snackbarSuccess('Lead dead reason deleted successfully');
        // Optionally, refresh the list after deletion
        Get.find<LeadDeadReasonViewModel>().leadDeadReasonListApi(context);
      } else {
        Utils.snackbarFailed('Failed to delete lead dead reason');
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('Error: $error');
      }
      Utils.snackbarFailed('Failed to delete lead dead reason');
    } finally {
      loading.value = false;
    }
  }
}