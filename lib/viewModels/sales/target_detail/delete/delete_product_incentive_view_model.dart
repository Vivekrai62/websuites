import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';
class DeleteProductIncentiveViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void>deleteProductIncentive (BuildContext context) async {
    loading.value = true;
    _api.deleteProductIncentive().then((response) {
      if (response.raw!.isNotEmpty) {
        if (kDebugMode) {
          print('Delete Product Incentive incentive ${response.raw}');
        }
        Utils.snackbarSuccess('Task Update fetched successfully');
      }
      else{
        Utils.snackbarFailed('Delete BreakDown not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }

}