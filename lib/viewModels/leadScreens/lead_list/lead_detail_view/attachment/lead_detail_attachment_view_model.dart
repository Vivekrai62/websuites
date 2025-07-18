import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../data/repositories/repositories.dart';

class LeadDetailAttachmentViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadDetailAttachment(BuildContext context) async {
    loading.value = true;
    _api.leadDetailAttachment().then((value) {
      if (value.isNotEmpty) {
        for (var responseData in value) {
          if (kDebugMode) {
            // print("Lead Detail Attachment Type  ${responseData.type}");
            // print("Lead Detail  Attachment ${responseData.typeName}");
            // print("Lead Detail  Attachment First Name ${responseData.uploadedBy?.firstName}");
          }
          // Utils.snackbarSuccess('Lead Detail Proposal data fetch');
        }
        loading.value = false;
      } else {
        // Utils.snackbarFailed('Lead Detail activity call not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
