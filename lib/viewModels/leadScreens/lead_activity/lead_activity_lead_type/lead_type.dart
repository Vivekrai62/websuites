import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';


class LeadActivityLeadTypeViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadType(BuildContext context) async {
    loading.value = true;
    _api.leadActivityLeadType().then((value) {
      print(" Activity Lead Type Value $value");
      if (value.isNotEmpty) {
        for (var responseData in value) {
          print("Activity Lead type data ${responseData.name}");
          Utils.snackbarSuccess('Lead Activity Lead Type fetched');
        }
        loading.value = false;
      } else {
        Utils.snackbarFailed('No Data fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }






}