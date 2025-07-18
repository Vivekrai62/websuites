import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/lead/lead_list/lead_list_bulk/delete/lead_list_bulk_delete_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadlistBulkDeleteViewmodel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadListBulkDelete(BuildContext context) async {
    LeadListBulkDeleteRequestModel listBulkDeleteRequestModel=LeadListBulkDeleteRequestModel(
      lead: [
        "74af0c9f-c196-49a3-a12b-f7ee878682a7",
        "3df8122f-056e-470f-acc0-02326145fda0"
      ],
      remark: "No Longer need",
    );
    _api.leadListBulkDelete(listBulkDeleteRequestModel.toJson()).then((response) {
      print("LeadListBulkDelete $response");
        print('Lead customer_list Bulk delete generate maps: ${response.generatedMaps}');
        print('Lead customer_list Bulk delete affected : ${response.affected}');

      Utils.snackbarSuccess('Lead customer_list fetched successfully');
        }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


}