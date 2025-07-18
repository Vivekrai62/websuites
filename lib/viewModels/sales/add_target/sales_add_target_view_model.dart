import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Utils/utils.dart';
import '../../../data/models/requestModels/sales/sales_target/sales_add_target_request_model.dart';
import '../../../data/repositories/repositories.dart';
class SalesAddTargetViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> salesAddTarget (BuildContext context) async {
    loading.value = true;
    SalesAddTargetRequestModel request = SalesAddTargetRequestModel(
      name: "test",
      startDate: "2024-12-17T18:30:00.000Z",
      endDate: "2024-12-25T18:30:00.000Z",
      saleTarget: 10,
      teamHead: "18aae555-f46e-4bff-bc1d-6849dceb279f",
    );
    _api.saleAddTarget(request.toJson()).then((response) {
      if (response.id !=null && response.id!.isNotEmpty) {
        print('Sales Add Target  saleTarget Response  ${response.saleTarget}');
        print('Sales Add Target team firstName Response  ${response.team?.firstName}');
        print('Sales Add Target team  Response ${response.teamHead?.firstName}');
        print('Sales Add Target  Response ${response.teamHead?.firstName}');
        print('Sales Add Target  role  ${response.createdBy!.roleList?[0].name}');
        Utils.snackbarSuccess('Task Update fetched successfully');
      }

      else{
        Utils.snackbarFailed('Task Update not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }


}