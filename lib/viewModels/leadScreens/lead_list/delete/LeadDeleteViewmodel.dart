import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/models/responseModels/leads/list/delete/LeadDeleteResponseModel.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../Utils/utils.dart';

class LeadDeleteViewmodel extends GetxController {
  final _api = Repositories();
  final RxBool loading = false.obs;
  final Rx<LeadDeleteResponseModel?> leadDelete = Rx<LeadDeleteResponseModel?>(null);

  // Track if the controller is still mounted
  bool get isMounted => !isClosed;

  // Method with callback for better context handling
  Future<void> leadDeleteApi(
      String leadId, {
        Function()? onSuccess,
        Function(String error)? onError,
      }) async {
    if (!isMounted) return;

    loading.value = true;
    try {
      final LeadDeleteResponseModel response = await _api.leadDeleteApi(leadId);

      // Check if controller is still mounted before updating state
      if (!isMounted) return;

      leadDelete.value = response;

      // Call success callback if provided
      onSuccess?.call();

      // Fallback to snackbar if no callback provided
      if (onSuccess == null && isMounted) {
        Utils.snackbarSuccess('Lead deleted successfully');
      }
    } catch (error) {
      // Call error callback if provided
      if (onError != null && isMounted) {
        onError(error.toString());
      } else if (isMounted) {
        // Fallback to snackbar if no callback provided
        Utils.snackbarFailed('Failed to delete lead: $error');
        debugPrint('Error in leadDeleteApi: $error');
      }
    } finally {
      // Only update loading state if controller is still mounted
      if (isMounted) {
        loading.value = false;
      }
    }
  }

  // Method for widget usage with proper context handling
  Future<void> leadDeleteWithContext(
      String leadId,
      BuildContext context,
      ) async {
    if (!isMounted) return;

    loading.value = true;
    try {
      final LeadDeleteResponseModel response = await _api.leadDeleteApi(leadId);

      // Check if controller is still mounted before updating state
      if (!isMounted) return;

      leadDelete.value = response;

      // Check if context is still mounted before showing message
      if (context.mounted) {
        Utils.flushBarSuccessMessage('Lead deleted successfully', context);
      }
    } catch (error) {
      // Check if context is still mounted before showing error
      if (context.mounted) {
        Utils.flushBarErrorMessage('Failed to delete lead: $error', context);
        debugPrint('Error in leadDeleteApi: $error');
      }
    } finally {
      // Only update loading state if controller is still mounted
      if (isMounted) {
        loading.value = false;
      }
    }
  }

  @override
  void onClose() {
    // Clean up resources when the controller is disposed
    super.onClose();
    debugPrint('LeadDeleteViewmodel disposed');
  }
}