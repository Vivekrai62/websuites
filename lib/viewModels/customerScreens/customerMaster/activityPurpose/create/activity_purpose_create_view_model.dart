import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/customer/master/activity_purpose_create/activity_purpose_create_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class ActivityPurposeCreateViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> activityPurposeCreate(BuildContext context) async {
    loading.value = true;
    ActivityPurposeCreateRequestModel createRequestModel=ActivityPurposeCreateRequestModel(
      name: "test_only",
      status: true,
      type: "Call",
    );

    _api.customerMasterActivityPurposeCreate(createRequestModel.toJson()).then((value) {
      if (value.id!.isNotEmpty) {
        if (kDebugMode) {
          print("Customer Activity Purpose Created id  ${value.id}");
          print("Customer Activity Purpose  Created type ${value.name}");
        }
        Utils.snackbarSuccess('Customer Company Credential List fetch');
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Customer Company Credential  not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}