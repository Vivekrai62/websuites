import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/lead/lead_list/lead_detail_view/activity_call_create/lead_detail_activity_call_create_request_model.dart';

import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadDetailActivityCallCreateViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadDetailActivityCallCreate(BuildContext context) async {
    loading.value = true;

    CallCreateRequest callCreateRequest=  CallCreateRequest(
      activity: "call",
      subActivity: "cbf8eeae-414a-44df-8686-0921aa731869",
      remark: "Answered Remark",
      lat: 30.6430455,
      lng: 76.821743,
      reminder: DateTime.parse("2024-11-21T06:44:00.000Z"),
      reminderTo: "4ab12ff3-77c3-4bb0-a2da-d5b2600bf9b5",
      informedToCustomer: true,
      ccTo: ["18aae555-f46e-4bff-bc1d-6849dceb279f"],
    );
    _api.leadDetailActivityCallCreate(callCreateRequest.toJson()).then((value) {
      if(value.id!.isNotEmpty){
          if (kDebugMode) {
            print("Lead Detail View Activity Call Create activity ${value.activity}");
            print("Lead Detail View Activity Call Create lead id  ${value.lead?.id}");
            print("Lead Detail View Activity Call Create  ${value.subActivity?.name}");

          }
          Utils.snackbarSuccess('Lead Detail Activity call  fetch');
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Lead Detail activity call not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


}



