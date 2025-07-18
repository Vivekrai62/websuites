import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadDetailTaskStatusViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadDetailTaskStatusType(BuildContext context) async {
    loading.value = true;
    _api.leadDetailTaskStatus().then((response) {
      if(response.isNotEmpty){
        for (var responseData in response) {
          if (kDebugMode) {
            print("Lead Detail Task Status ${responseData.name}");
          }
          Utils.snackbarSuccess('Lead Detail task status data fetch');
        }
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Lead Detail  task status data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }



}


