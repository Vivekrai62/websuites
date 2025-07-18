import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/product/add_product/add_product_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class AddProductViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> addProductApi(BuildContext context) async {
    loading.value = true;
    AddProductRequestModel productRequest = AddProductRequestModel(
      brand: "7203f798-2af0-46c8-819d-547970e07a79",
      description: "Working on This Project.",
      division: "c66d0806-c3a0-41e0-a595-abecba3cbd7e",
      downloadLink: "",
      duration: 0,
      gst: null,
      isTaxable: false,
      name: "Sales",
      otherPrices: [], // Replace with actual otherPrices if available
      packing: "reotoprpjnjtgrltrtgrrthy",
      productCategory: ["309cc464-01a9-4fd3-a400-093fd62cf954"],
      productType: "physical",
      projectActivationDisabled: false,
      quantity: 1,
      status: true,
    );
    _api.addProduct(productRequest.toJson()).then((value) {
      if (value.productType != null && value.productType!.isNotEmpty) {
        print("Add product id  ${value.productType}");
        print("Add product name ${value.name}");
        print("Add product division id ${value.division?.id}");
        print("Add product name ${value.productCategory?.name}");
        print("Add product Sale ${value.salePrice}");
        Utils.snackbarSuccess('product brand fetched');
        loading.value = false;
      } else {
        Utils.snackbarFailed('product brand not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
