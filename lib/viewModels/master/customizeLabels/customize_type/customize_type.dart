import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';

class MasterCustomizeTypeController extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> masterCustomizeList(BuildContext context) async {
    loading.value = true;

    _api.masterCustomizeType().then((value) {
      // Create an instance of RequestModel
      if (kDebugMode) {
        print("Value $value");
      }
      if (value.isNotEmpty) {
        // Check if the customer_list is not empty
        for (var responseData in value) {
          if (kDebugMode) {
            // print("Master CustomizeType ${responseData.displayName}");
          }
          if (responseData.displayName != null) {
            // Utils.snackbarSuccess('Master CustomizeType fetched');
          } else {
            // Utils.snackbarFailed('One of the master divisions does not have an ID');
          }
        }
        loading.value = false;
      } else {
        // Utils.snackbarFailed('master divisions not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
