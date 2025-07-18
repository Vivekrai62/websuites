// ViewModel for managing proposals data
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/master/proposals/master_proposals_resposne_model.dart';
import '../../../../data/repositories/repositories.dart';

class MasterProposalsViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Rx<List<MasterProposalsResponseModel>> proposals = Rx([]);

  // Fetch master proposals from API
  Future<void> masterProposals(BuildContext context) async {
    loading.value = true;
    try {
      final value = await _api.masterProposal();
      proposals.value = value;
      loading.value = false;
      if (value.isNotEmpty) {
        print('Master proposals fetched');
      } else {
        print('Master proposals not fetched');
      }
    } catch (error) {
      loading.value = false;
      if (kDebugMode) {
        print('Error fetching proposals: $error');
      }
    }
  }
}
