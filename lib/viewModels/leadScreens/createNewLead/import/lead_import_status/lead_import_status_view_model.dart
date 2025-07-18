import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';
class LeadImportStatusViewModel extends GetxController {

  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> leadImportStatus(BuildContext context) async {
    loading.value = true;
    _api.leadImportStatus().then((value) {
      if (value.isNotEmpty) {
        for (var responseData in value) {
          if (kDebugMode) {
            print("Lead List Import Response${responseData.name}");
            print("Lead List Import Response${responseData.description}");
          }
          Utils.snackbarSuccess('Lead import Successful');
        }
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Lead import data  not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}



