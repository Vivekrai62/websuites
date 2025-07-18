import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../data/models/responseModels/leads/setting/roles/roles.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class LeadSettingRolesViewmodel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<SettingRolesResponseModel> roles = <SettingRolesResponseModel>[].obs;

  Future<void> settingRoles(BuildContext context) async {
    loading.value = true;
    try {
      final value = await _api.settingRoleApi();
      if (value.isNotEmpty) {
        roles.assignAll(value); // Store roles in RxList
        for (var responseData in value) {
          // print("Lead Settings Roles data ${responseData.name}");
          // Utils.snackbarSuccess('Lead Setting Roles fetched');
        }
      // } else {
      //   Utils.snackbarFailed('No Data fetched');
      }
    } catch (error) {
      if (kDebugMode) {
        // print(error.toString());
      }
      // Utils.snackbarFailed('Failed to fetch roles');
    } finally {
      loading.value = false;
    }
  }
}