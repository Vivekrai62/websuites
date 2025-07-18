import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Utils/utils.dart';
import '../../data/models/responseModels/userList/list/UserListResponseModels.dart';
import '../../data/repositories/repositories.dart';

class UserListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<Item> userList = <Item>[].obs; // Observable role to hold users

  // Fetch user data
  Future<void> userListApi(
      {BuildContext? context, bool forceRefresh = false}) async {
    loading.value = true;
    if (userList.isEmpty || forceRefresh) {
      try {
        // Make the API request and get the response
        UsersListResponseModel response = await _api.userListApi();

        // Check if the items role in the response is not null or empty
        if (response.items.isNotEmpty) {
          userList.value =
              response.items; // Update the user role with non-null data
          // Utils.snackbarSuccess('Users fetched');
        } else {
          userList.clear(); // Clear userList if no items are found
          // Utils.snackbarFailed('No users found');
        }
      } catch (error) {
        if (kDebugMode) {
          // print("Error fetching users: $error"); // Log error for debugging purposes
        }
        // Utils.snackbarFailed('Failed to fetch users');
      } finally {
        loading.value =
            false; // Ensure loading is set to false after the operation completes
      }
    } else {
      loading.value =
          false; // Ensure loading is set to false if we're not fetching
    }
  }
}
