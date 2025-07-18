import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';

class SettingUserProfileController extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> settingUserProfile(BuildContext context) async {
    loading.value = true;
    _api.settingUserProfile().then((value) {
      // print("Lead Setting UserProfile  $value");
      if (value is List) {
        // print("Lead Setting UserProfile ${value.firstName}");
        // Utils.snackbarSuccess('Master divisions fetched');
      } else if (value.id.isNotEmpty) {
        // If value is a single object, handle accordingly
        if (kDebugMode) {
          // print("Lead Setting UserProfile ${value.firstName}");
        }
        // Utils.snackbarSuccess('Master divisions fetched');
      } else {
        // Utils.snackbarFailed('Master divisions not fetched');
      }
      loading.value = false;
    }).onError((error, stackTrace) {
      loading.value = false; // Reset loading on error
      if (kDebugMode) {
        print(error.toString());
      }
      // Utils.snackbarFailed('An error occurred');
    });
  }
}
