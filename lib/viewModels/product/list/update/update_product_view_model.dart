import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/product/update_product_request_model/update_product_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class UpdateProductViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> updateProductApi (BuildContext context) async {
    loading.value = true;
    UpdateProductRequestModel updateProductRequest = UpdateProductRequestModel(
      brand: "7203f798-2af0-46c8-819d-547970e07a79",
      description: "Working on Whsuites.",
      division: "c66d0806-c3a0-41e0-a595-abecba3cbd7e",
      downloadLink: "",
      duration: 0,
      gst: null,
      isTaxable: false,
      name: "Test Project",
      otherPrices: [
        {"currencyId": "9683948f-0161-4977-aa7c-2c45ff03b940", "sale_price": "600", "mrp": "3000"}
      ],
      packing: "trtykhrkjgbstkkmltrh",
      productCategory: ["0647c740-0c84-4599-9a49-cd3c88f901b9"],
      productType: "physical",
      projectActivationDisabled: false,
      quantity: 4,
      status: true,
    );
    _api.updateProduct(updateProductRequest.toJson()).then((value) {
      if(value.productType!=null && value.productType!.isNotEmpty){
        print("Update product id  ${value.productType}");
        print("Update product name ${value.name}");
        print("Update product division id ${value.division?.id}");
        print("Update product name ${value.productCategory?.name}");
        print("Update product Sale ${value.salePrice}");
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