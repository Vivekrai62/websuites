import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Utils/utils.dart';
import '../../../data/models/responseModels/userList/activity/UserActivitiesResponseModel.dart';
import '../../../data/repositories/repositories.dart';

class UserActivitiesModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<Items> userActivities = <Items>[].obs;

  // Method to get user activities with optional force refresh
  Future<void> getUserActivities(BuildContext context, {bool forceRefresh = false}) async {
    if (loading.value && !forceRefresh) return;

    loading.value = true;
    try {
      UserActivitiesResponseModel response = await _api.usersActivitiesApi();
      if (response.items != null && response.items!.isNotEmpty) {
        userActivities.value = response.items!;
        if (forceRefresh) {
          Utils.snackbarSuccess('Activities refreshed');
        }
      } else {
        Utils.snackbarFailed('No activities found');
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error: $error");
      }
      Utils.snackbarFailed('Failed to fetch activities');
    } finally {
      loading.value = false;
    }
  }

  // Keep the old method for backward compatibility
  Future<void> usersActivitiesApi() async {
    await getUserActivities(Get.context!);
  }
}
