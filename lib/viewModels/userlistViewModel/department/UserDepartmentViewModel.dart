import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../data/models/requestModels/userlist/department/update/UserDepartmentUpdateRequestModel.dart';

class UserDepartmentViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> updateUserDepartmentApi(
      BuildContext context,
      UserDepartmentUpdateRequestModel updatedDepartment,
      String? departmentId) async {
    loading.value = true;
    try {
      // Call the updated method with both parameters
      final response = await _api.updateUserDepartmentApi(
          updatedDepartment.toJson(), departmentId);
      if (response.id != null && response.id!.isNotEmpty) {
        print('User  department updated: ${response.id}');
        Utils.snackbarSuccess('Department updated successfully');
      } else {
        Utils.snackbarFailed('Failed to update department');
      }
    } catch (e) {
      print("Error updating department: $e");
      Utils.snackbarFailed('An error occurred while updating the department');
    } finally {
      loading.value = false;
    }
  }
}
