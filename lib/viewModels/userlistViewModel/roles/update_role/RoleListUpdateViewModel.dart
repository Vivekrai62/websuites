import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/responseModels/userList/list/update/RolesListUpdateResponseModel.dart';
import '../../../../data/repositories/repositories.dart';

class RoleListUpdateViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  RxList<RolesListUpdateResponseModel> roleData = <RolesListUpdateResponseModel>[].obs;
  RxList<RolesListUpdateResponseModel> filteredCategories = <RolesListUpdateResponseModel>[].obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    filteredCategories.bindStream(roleData.stream);
    searchController.addListener(_filterRoles);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> roleUpdateListApi(BuildContext context) async {
    loading.value = true;
    try {
      var value = await _api.roleUpdateListApi();
      if (value.isNotEmpty) {
        roleData.value = value;
        filteredCategories.value = value;
        Utils.snackbarSuccess('Role Update fetched');
      } else {
        Utils.snackbarFailed('Role Update not fetched');
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('Error: $error');
        print('Stack Trace: $stackTrace');
      }
      Utils.snackbarFailed('Something went wrong, please try again.');
    } finally {
      loading.value = false;
    }
  }

  void _filterRoles() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredCategories.value = roleData;
    } else {
      filteredCategories.value = roleData
          .where((role) => role.name?.toLowerCase().contains(query) ?? false)
          .toList();
    }
  }

  // Define the saveUpdatedPermissions method that takes roleId as a parameter
// In RoleListUpdateViewModel
  Future<void> saveUpdatedPermissions(String roleId, List<Map<String, dynamic>> updatedPermissions) async {
    loading.value = true;

    try {
      // Call the API to save the updated permissions
      var result = await _api.saveRolePermissions(roleId, updatedPermissions);  // Ensure the API handles roleId too.

      if (result) {
        Utils.snackbarSuccess('Permissions updated successfully');
      } else {
        Utils.snackbarFailed('Failed to update permissions');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error saving permissions: $error');
      }
      Utils.snackbarFailed('Something went wrong while saving permissions.');
    } finally {
      loading.value = false;
    }
  }

}

