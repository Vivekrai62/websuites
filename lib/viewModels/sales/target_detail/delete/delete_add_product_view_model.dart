import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';
class DeleteProductViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void>deleteProduct(BuildContext context) async {
    loading.value = true;
    _api.deleteProduct().then((response) {
      if (response.raw!.isNotEmpty) {
        print('Delete Product  ${response.raw}');
        Utils.snackbarSuccess('Delete Product fetched successfully');
      }
      else{
        Utils.snackbarFailed('Delete Product  not fetching');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }


}