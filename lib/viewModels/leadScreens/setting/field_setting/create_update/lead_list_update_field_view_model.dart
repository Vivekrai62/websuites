import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/lead/setting/field_create_update/lead_field_create_update_req_model.dart';
import '../../../../../data/models/responseModels/leads/setting/field_setting/create_update/lead_column_setting_edit_update_res_model.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadListUpdateFieldViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> leadListFieldUpdate(
      BuildContext context, {
        required String fieldId,
        required List<String> roleIds,
      }) async {
    loading.value = true;

    final requestModel = FieldUpdateRequestModel(
      fieldId: fieldId,
      roleIds: roleIds,
    );

    try {
      LeadFieldSettingEditUpdateResModel response =
      await _api.leadFieldSettingEditListApi(requestModel.toJson());

      if (response.message != null && response.message!.isNotEmpty) {
        if (kDebugMode) {
          print("Lead List Update field List ${response.message}");
        }
        Utils.snackbarSuccess('Lead List Update field List data fetched');
      } else {
        Utils.snackbarFailed('Lead List Update field List is empty');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in field: $e");
      }
      Utils.snackbarFailed('Something went wrong');
    } finally {
      loading.value = false;
    }
  }
}