import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerSourceViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerSourceList(BuildContext context) async {
    loading.value = true;
    _api.customerSourceApi().then((value) {
      // print("Customer Source api $value");
      if (value.isNotEmpty) {
        for (var responseData in value) {
          print("Customer Source Api ${responseData.name}");
          // Utils.snackbarSuccess(' data fetched');
        }
        loading.value = false;
      } else {
        // Utils.snackbarFailed('Customer Source api data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
