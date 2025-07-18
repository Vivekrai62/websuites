import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../data/repositories/repositories.dart';

class LeadDetailProposalViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadDetailProposalType(BuildContext context) async {
    loading.value = true;
    _api.leadDetailProposal().then((response) {
      if (response.isNotEmpty) {
        for (var responseData in response) {
          if (kDebugMode) {
            // print("Lead Detail proposal type ${responseData.subject}");
          }
          // Utils.snackbarSuccess('Lead Detail Proposal data fetch');
        }
        loading.value = false;
      } else {
        // Utils.snackbarFailed('Lead Detail data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
