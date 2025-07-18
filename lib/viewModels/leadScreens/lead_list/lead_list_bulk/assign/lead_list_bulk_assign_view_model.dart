import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/lead/lead_list/lead_list_bulk/assign/lead_list_bulk_assign_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadListBulkAssignViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadListBulkAssign(BuildContext context) async {
    LeadListBulkAssignRequestModel leadListBulkAssignRequestModel=LeadListBulkAssignRequestModel(
      lead: ["24c3a359-5b1a-47a1-912f-54eeac2dab12", "cf07bd8f-d035-4e4b-849f-7582ddd0e4bb"],
    );
    _api.leadListBulkAssign(leadListBulkAssignRequestModel.toJson()).then((response) {
      print("LeadListBulkDelete $response");
      print('Lead customer_list Bulk Assign data: ${response.data}');


      Utils.snackbarSuccess('Lead customer_list fetched successfully');
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

}