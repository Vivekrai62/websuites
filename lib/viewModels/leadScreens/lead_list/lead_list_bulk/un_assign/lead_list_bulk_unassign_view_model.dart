import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/lead/lead_list/lead_list_bulk/un_assign/lead_list_bulk_un_assign_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadListBulkUnassignViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadListBulkUnAssign(BuildContext context) async {
    LeadListBulkUnAssignRequestModel leadListBulkUnAssignRequestModel=LeadListBulkUnAssignRequestModel(
      lead: ["24c3a359-5b1a-47a1-912f-54eeac2dab12", "cf07bd8f-d035-4e4b-849f-7582ddd0e4bb"],
    );
    _api.leadListBulkUnAssign(leadListBulkUnAssignRequestModel.toJson()).then((response) {
      print("LeadList Bulk UnAssign Response $response");
      print('Lead customer_list Bulk UnAssign affected : ${response.data}');

      Utils.snackbarSuccess('Lead customer_list fetched successfully');
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


}