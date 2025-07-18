import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../data/models/requestModels/userlist/status/UserListStatusRequestModel.dart';
import '../../../data/models/responseModels/userList/status/UserStatusResponseModel.dart';

class UserStatusViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<bool> userStatusUpdate(String userId, bool status) async {
    loading.value = true;
    try {
      UserListStatusRequestModel userStatusRequest = UserListStatusRequestModel(
        id: userId,
        statusBool: status, // Pass the boolean value
      );

      UserStatusResponseModel response =
          await _api.userStatusUpdate(userId, userStatusRequest.toJson());

      if (response.status != null && response.status!.isNotEmpty) {
        Utils.snackbarSuccess('User  status updated successfully');
        return response.status ==
            "true"; // Return the updated status as a boolean
      } else {
        Utils.snackbarFailed('Failed to update user status');
        return status; // Return the original status if the update failed
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      Utils.snackbarFailed('An error occurred while updating user status');
      return status; // Return the original status in case of an error
    } finally {
      loading.value = false;
    }
  }
}
