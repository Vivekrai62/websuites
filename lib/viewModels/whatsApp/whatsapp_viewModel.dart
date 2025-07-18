import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class WhatsappViewModels extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> whatsapp (BuildContext context) async {
    loading.value = true;

    _api.whatsappApi().then((value) {

      if(value.items!= null){
        Utils.snackbarSuccess('whatsapp Id fetched');
        loading.value = false;

      }else{
        Utils.snackbarFailed('whatsapp Id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}