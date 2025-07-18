import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/lead/lead_list/details/status/LeadDetailsStatusReqModel.dart';
import '../../../../../data/repositories/repositories.dart';
import 'package:dio/dio.dart';

class LeadDetailUpdateStatusViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> leadDetailUpdateStatus(
      BuildContext context, {
        required String leadId,
        required LeadDetailsLeadTypeReqModel requestModel,
      }) async {
    loading.value = true;

    try {
      await _api
          .leadDetailUpdateStatus(requestModel.toJson(), leadId)
          .then((response) {
        if (response.message?.isNotEmpty ?? false) {
          if (kDebugMode) {
            print("Lead Detail Update Status Response ${response.message}");
          }
          Utils.snackbarSuccess('Lead status updated successfully');
          loading.value = false;
        } else {
          Utils.snackbarFailed('Failed to update lead status');
          loading.value = false;
        }
      });
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("Error: $error");
        print("StackTrace: $stackTrace");
      }
      String errorMessage = 'An error occurred while updating lead status';
      if (error is DioError && error.response?.data != null) {
        errorMessage = error.response?.data['message'] ?? errorMessage;
      }
      Utils.snackbarFailed(errorMessage);
      loading.value = false;
    }
  }
}