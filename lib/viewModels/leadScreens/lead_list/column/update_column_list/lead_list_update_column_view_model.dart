import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/lead/lead_list/column/lead_list_column_list_update_request_model.dart';
import '../../../../../data/models/responseModels/leads/list/column_list/edit/Lead_Column_Setting_Edit_Update_ResModel.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadListUpdateColumnViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> leadListColumnUpdate(
      BuildContext context, {
        required String fieldId,
        required List<String> roleIds,
      }) async {
    loading.value = true;

    final requestModel = ColumnUpdateRequestModel(
      fieldId: fieldId,
      roleIds: roleIds,
    );

    try {
      LeadColumnSettingEditUpdateResModel response =
      await _api.leadColumnSettingEditListApi(requestModel.toJson());

      if (response.message != null && response.message!.isNotEmpty) {
        if (kDebugMode) {
          print("Lead List Update Column List ${response.message}");
        }
        Utils.snackbarSuccess('Lead List Update Column List data fetched');
      } else {
        Utils.snackbarFailed('Lead List Update Column List is empty');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in leadListColumnUpdate: $e");
      }
      Utils.snackbarFailed('Something went wrong');
    } finally {
      loading.value = false;
    }
  }
}