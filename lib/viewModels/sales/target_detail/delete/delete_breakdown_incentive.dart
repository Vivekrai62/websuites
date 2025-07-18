import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';

class DeleteBreakDownIncentiveViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void>deleteBreakDownIncentive (BuildContext context) async {
    loading.value = true;
    _api.deleteBreakDownIncentive().then((response) {
      if (response.raw!.isNotEmpty) {
        print('Delete BreakDown incentive ${response.raw}');
        Utils.snackbarSuccess('Task Update fetched successfully');
      }
      else{
        Utils.snackbarFailed('Task Update not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }



}



