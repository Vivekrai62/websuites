import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadListDetailViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;


  Future<void> leadDetailView(BuildContext context) async {
    loading.value = true;
    _api.leadDetailViewList().then((response) {
      if (response.id!.isNotEmpty) {
        print('lead Detail View Lead data: ${response.firstName}');
        print('Lead Detail View Lead data: ${response.contact?.mobile}');

        Utils.snackbarSuccess('Lead Detail View Lead data fetch');
      }
      else {
        Utils.snackbarFailed('Lead Detail data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


}