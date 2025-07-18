import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadDetailTaskTypeViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadDetailTaskType(BuildContext context) async {
    loading.value = true;
    _api.leadDetailTaskType().then((response) {
      if(response.isNotEmpty){
        for (var responseData in response) {
          if (kDebugMode) {
            print("Lead Detail Task Type ${responseData.name}");
          }
          Utils.snackbarSuccess('Lead Detail task type data fetch');
        }
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Lead Detail  task type data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }



}