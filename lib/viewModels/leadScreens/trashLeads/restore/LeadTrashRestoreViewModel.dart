import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/models/responseModels/leads/list/delete/LeadDeleteResponseModel.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/responseModels/leads/trashLeads/delete_permanent/TrashLeadPermanentResModel.dart';
import '../../../../data/models/responseModels/leads/trashLeads/restore/LeadTrashRestoreResModel.dart';

class LeadTrashRestoreViewModel extends GetxController {
  final _api = Repositories();
  final RxBool loading = false.obs;
  final Rx<LeadTrashRestoreResModel?> leadTrashDeletePermanent = Rx<LeadTrashRestoreResModel?>(null);

  // Check if controller is still mounted
  bool get isMounted => !isClosed;

  Future<void> leadTrashRestoreApi(
        String leadId, {
        bool forceRefresh = false,
        Function()? onSuccess,
        Function(String error)? onError,
      }) async {
    if (!isMounted) return;

    loading.value = true;
    try {
      final LeadTrashRestoreResModel response = await _api.leadTrashRestoreApi(leadId);

      if (!isMounted) return;

      leadTrashDeletePermanent.value = response;

      onSuccess?.call();

      // Show fallback snackbar only if no callback is used
      if (onSuccess == null && isMounted) {
        Utils.snackbarSuccess('Lead restore successfully');
      }
    } catch (error) {
      if (onError != null && isMounted) {
        onError(error.toString());
      } else if (isMounted) {
        Utils.snackbarFailed('Failed to restore lead: $error');
        debugPrint('Error in lead trash restore: $error');
      }
    } finally {
      if (isMounted) {
        loading.value = false;
      }
    }
  }

  /// API call to delete a lead with context (for widget feedback)
  Future<void> leadRestoreWithContext(
      String leadId,
      BuildContext context,
      ) async {
    if (!isMounted) return;

    loading.value = true;
    try {
      final LeadTrashRestoreResModel response = await _api.leadTrashRestoreApi(leadId);

      if (!isMounted) return;

      leadTrashDeletePermanent.value = response;

      if (context.mounted) {
        Utils.flushBarSuccessMessage('Lead deleted successfully', context);
      }
    } catch (error) {
      if (context.mounted) {
        Utils.flushBarErrorMessage('Failed to delete lead: $error', context);
        debugPrint('Error in leadTrashDeletePermApi: $error');
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
    debugPrint('LeadTrashRestoreResModel disposed');
  }
}
