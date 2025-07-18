import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';

class CampaignListViewModels extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> campaignList(BuildContext context) async {
    loading.value = true;

    // _api.customersActivationListApi().then((value) {
    //
    //   if(value.items!= null){
    //     Utils.snackbarSuccess('activationList Id fetched');
    //     loading.value = false;
    //
    //   }else{
    //     Utils.snackbarFailed('activationList Id not fetched');
    //   }
    // }).onError((error, stackTrace) {
    //   if (kDebugMode) {
    //     print(error.toString()
    //     );
    //   }
    // }
    // );
  }
}
