import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Utils/utils.dart';
import '../../../../../../data/models/requestModels/lead/setting/source/create/lead_source_create_req_model.dart';
import '../../../../../../data/models/responseModels/leads/setting/lead_source/create/lead_source_create_res_model.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../data/models/requestModels/lead/setting/dead/create/lead_dead_create_req_model.dart';
import '../../../../../data/models/responseModels/leads/setting/dead/create/lead_dead_create_res_model.dart';

class LeadDeadCreateViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;


  final TextEditingController nameController = TextEditingController();

  Future<void> leadDeadCreateApi(BuildContext context) async {
    if (nameController.text.trim().isEmpty) {
      Utils.snackbarFailed('Please enter a valid name');
      return;
    }

    loading.value = true;

    final request = LeadSettingDeadCreateReqModel(
      reason: nameController.text.trim(),
    );

    try {
      LeadSettingDeadCreateResModel response =
      await _api.leadDeadCreateApi(request.toJson());

      if (response.message != null && response.message!.isNotEmpty) {
        Utils.snackbarSuccess('Lead Dead created successfully');
      } else {
        Utils.snackbarFailed('Failed to create lead Dead');
      }
    } catch (e) {
      Utils.snackbarFailed('An error occurred while creating lead Dead');
      if (kDebugMode) print('Error in ViewModel: $e');
    } finally {
      loading.value = false;
    }
  }
}
