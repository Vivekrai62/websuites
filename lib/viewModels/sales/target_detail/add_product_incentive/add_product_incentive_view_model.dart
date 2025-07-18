import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/sales/target_detail/add_product_incentive/add_product_incentive_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class AddProductIncentiveViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> addProductIncentive (BuildContext context) async {
    loading.value = true;
    AddProductIncentiveRequestModel requestModel=AddProductIncentiveRequestModel(
      incentive: 1,
      incentiveType: "percentage",
      isSale: false,
      minimumSalePrice: 1,
      product: "3a309211-aabf-4e85-a7aa-62af8cf99b5b",
      targetIncentive: "06e5fbfe-936a-45a6-82e2-5adc59628692",

    );

    _api.addProductIncentive(requestModel.toJson()).then((response) {
      if(response.id!=null){
        if (kDebugMode) {
          print('Product incentive  Response targetIncentive ${response.incentive}');
          print('Product incentive Response targetIncentive ${response.taregtIncentive?.team?.mobile}');
        }
        print('IncentiveBreakDown Sale target ${response.taregtIncentive?.saleTarget}');
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