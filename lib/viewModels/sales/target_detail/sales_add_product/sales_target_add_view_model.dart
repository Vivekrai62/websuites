import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/sales/target_detail/sales_add_product_request_model/sales_add_product_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class SalesAddProductViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> saleAddProduct (BuildContext context) async {
    loading.value = true;
    SalesAddProductRequestModel salesAddProductRequestModel=SalesAddProductRequestModel(
      product: "3a309211-aabf-4e85-a7aa-62af8cf99b5b",
      quantity: 4,
      targetIncentive: "06e5fbfe-936a-45a6-82e2-5adc59628692",
    );

    _api.salesAddProduct(salesAddProductRequestModel.toJson()).then((response) {
      if (response.id!.isNotEmpty) {
        print('Sales Target Add targetIncentive ${response.targetIncentive?.saleTarget}');
        print('Sales Target Add Response team Mobile ${response.targetIncentive?.team?.mobile}');
        print('Sales Target Add Response team RoleList ${response.targetIncentive?.team?.roleList?[0].name}');
        if (kDebugMode) {
          print('Sales Target Add Response Mrp ${response.product?.mrp}');
        }

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