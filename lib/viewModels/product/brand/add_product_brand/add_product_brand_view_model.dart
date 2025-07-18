import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/product/brand/add_product_brand/add_product_brand_request_model.dart';
import '../../../../data/repositories/repositories.dart';
class AddProductBrandViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> addProductBrand (BuildContext context) async {
    loading.value = true;

    AddProductBrandRequestModel requestModel= AddProductBrandRequestModel(
    description: "Add New brand item",
    divisionId: "c66d0806-c3a0-41e0-a595-abecba3cbd7e",
    name: "Testing Purpose",
    );

    _api.addProductBrand(requestModel.toJson()).then((value) {
      if(value.id!.isNotEmpty){
          print("Add Product Brand Response id ${value.id}");
          print("Add Product Brand Response name ${value.name}");
          print("Add Product Brand Response description ${value.description}");
          print("Add Product Brand Response division ${value.division?.name}");

        Utils.snackbarSuccess('product brand fetched');
        loading.value = false;
      }else {
        Utils.snackbarFailed('product brand not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }




}