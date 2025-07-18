import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';

class OrderSearchProductViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> orderSearchProduct(BuildContext context) async {
    loading.value = true;
    _api.searchProduct().then((response) {
      if (response.isNotEmpty) {
        for (var responseData in response) {
          if (kDebugMode) {
            print("Order Search Product List description ${responseData.description}");
            print("Order Search Product List  name ${responseData.name}");
          }
          Utils.snackbarSuccess('Order Search Product List List fetch');
        }
      } else {
        Utils.snackbarFailed('Order Search Product not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
