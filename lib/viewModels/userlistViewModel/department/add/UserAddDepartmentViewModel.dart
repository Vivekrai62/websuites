import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/userlist/department/add/UserDepartmentAddRequestModel.dart';
import '../../../../data/models/responseModels/userList/add/UserDepartmentAddResponsetModel.dart';
import '../../../../data/repositories/repositories.dart';

class UserAddDepartmentViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<UserDepartmentAddResponseModel> userAddDepartment =
      <UserDepartmentAddResponseModel>[].obs;

  Future<void> usersAddDepartmentApi(
    BuildContext context,
    UserDepartmentAddRequestModel addDepartment,
  ) async {
    loading.value = true;
    try {
      // Send data to API to create a department
      final response = await _api.usersAddDepartmentApi(addDepartment.toJson());

      userAddDepartment
          .add(response); // Add the new department to the customer_list
      Utils.snackbarSuccess('Department added successfully');
    } catch (error) {
      if (kDebugMode) {
        print("Error: $error");
      }
      Utils.snackbarFailed('Failed to add department');
    } finally {
      loading.value = false;
    }
  }
}
