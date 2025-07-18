import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/master/proposals/master_proposals_resposne_model.dart';
import '../../../../data/repositories/repositories.dart';

class MasterProposalsViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Rx<List<MasterProposalsResponseModel>> proposals = Rx([]);

  Future<void> masterProposals(BuildContext context) async {
    loading.value = true;
    _api.masterProposal().then((value) {
      proposals.value = value;
      loading.value = false;
      if (value.isNotEmpty) {
        // Utils.snackbarSuccess('Master proposals fetched');
        print('Master proposals fetched');
      } else {
        // Utils.snackbarFailed('Master proposals not fetched');
        print('Master proposals not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
