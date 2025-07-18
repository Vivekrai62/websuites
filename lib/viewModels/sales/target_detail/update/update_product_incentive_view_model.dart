import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/sales/target_detail/update/sale_update_product_incentive_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class UpdateProductIncentiveViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> updateProductIncentive (BuildContext context) async {
    loading.value = true;

    UpdateProductIncentiveRequestModel updateProductIncentiveRequestModel=UpdateProductIncentiveRequestModel(
      incentive: 3,
      incentiveType: "percentage",
      isSale: false,
      minimumSalePrice: 1,
      product: "3a309211-aabf-4e85-a7aa-62af8cf99b5b",
      targetIncentive: "06e5fbfe-936a-45a6-82e2-5adc59628692",
    );
    _api.updateProductIncentive(updateProductIncentiveRequestModel.toJson()).then((response) {
      if (response.id!.isNotEmpty) {
        print('update Product Incentive ${response.incentive}');
        if (kDebugMode) {
          print('Update Product Incentive ${response.incentiveType}');
        }
        print("Update Product Incentive Sale  ${response.isSale}");
        print('Update Product  Incentive ${response.minimumSalePrice}');
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