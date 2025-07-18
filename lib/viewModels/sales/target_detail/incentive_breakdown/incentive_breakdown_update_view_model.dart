import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/sales/target_detail/incentive_breakdown/incentive_breakdown_update.dart';
import '../../../../data/repositories/repositories.dart';

class IncentiveBreakDownUpdateViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;


  Future<void> incentiveBreakDownUpdate (BuildContext context) async {
    loading.value = true;
    IncentiveBreakDownUpdateRequestModel requestModel=IncentiveBreakDownUpdateRequestModel(
      achievePercentage: 1,
      incentive: 1,
      incentiveType:"percentage",
      targetIncentiveMember:"0e6c88f7-7258-4322-9acd-39510152517b",
    );

    _api.incentiveBreakdown(requestModel.toJson()).then((response) {
      if(response.id!=null){
        if (kDebugMode) {
          print('IncentiveBreakDown Response targetIncentive ${response.achievePercentage}');
        }
        print('IncentiveBreakDown Sale target ${response.targetIncentiveMember?.targetIncentive?.saleTarget}');
        print('IncentiveBreakDown Response targetIncentive ${response.incentive}');



      }

      Utils.snackbarSuccess('Task Update fetched successfully');
        }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }



}