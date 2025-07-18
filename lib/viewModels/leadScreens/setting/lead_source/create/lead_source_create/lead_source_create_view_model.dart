import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Utils/utils.dart';
import '../../../../../../data/models/requestModels/lead/setting/source/create/lead_source_create_req_model.dart';
import '../../../../../../data/models/responseModels/leads/setting/lead_source/create/lead_source_create_res_model.dart';
import '../../../../../../data/repositories/repositories.dart';

class LeadSourceCreateViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  // Controller to get input from TextField
  final TextEditingController nameController = TextEditingController();

  Future<void> leadSourceCreateApi(BuildContext context) async {
    if (nameController.text.trim().isEmpty) {
      Utils.snackbarFailed('Please enter a valid name');
      return;
    }

    loading.value = true;

    final request = LeadSettingSourceCreateReqModel(
      name: nameController.text.trim(),
    );

    try {
      LeadSourceCreateResModel response =
      await _api.leadSourceCreateApi(request.toJson());

      if (response.id != null && response.id!.isNotEmpty) {
        Utils.snackbarSuccess('Lead source created successfully');
      } else {
        Utils.snackbarFailed('Failed to create lead source');
      }
    } catch (e) {
      Utils.snackbarFailed('An error occurred while creating lead source');
      if (kDebugMode) print('Error in ViewModel: $e');
    } finally {
      loading.value = false;
    }
  }
}
