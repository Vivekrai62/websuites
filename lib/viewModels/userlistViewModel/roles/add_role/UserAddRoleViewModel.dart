import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/role/add_role/UserAddRoleRequestModel.dart';

import '../../../../data/models/responseModels/userList/list/add_role/UserAddRoleResponseModel.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../data/models/responseModels/userList/list/update/RolesListUpdateResponseModel.dart';

class UserAddRoleViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<UserAddRoleResponseModel> roles = <UserAddRoleResponseModel>[].obs;

  Future<void> addRole(
    BuildContext context,
    UserAddRoleRequestModel role,
  ) async {
    loading.value = true;
    try {
      // Create the request payload
      final Map<String, dynamic> payload = {
        'name': role.name,
        'description': role.description,
      };

      // The API call now returns UserAddRoleResponseModel directly
      final UserAddRoleResponseModel response =
          await _api.usersAddRoleApi(payload);

      roles.add(response);
      Utils.snackbarSuccess('Role added successfully');
    } catch (error) {
      if (kDebugMode) {
        print("Error: $error");
      }
      Utils.snackbarFailed('Failed to add role');
    } finally {
      loading.value = false;
    }
  }
}
