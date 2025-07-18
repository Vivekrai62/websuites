import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/product/master/master_add_product_request_model.dart';
import '../../../Utils/utils.dart';
import '../../../data/repositories/repositories.dart';
class MasterAddProductViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> masterAddProduct(BuildContext context) async {
    loading.value = true;
    MasterAddProductRequestModel requestModel=MasterAddProductRequestModel(
      incentive: 10,
      incentiveType: "percentage",
      isSale: false,
      minimumSalePrice: 2,
      product: "c00f8501-9d9c-40f7-a3d6-a35e8e1744d8",
    );
    _api.masterAddProduct(requestModel.toJson()).then((value) {
      if(value.id!= null && value.id!.isNotEmpty){
        Utils.snackbarSuccess('product master fetched');
        loading.value = false;
      }else{
        Utils.snackbarFailed('product master not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }

}