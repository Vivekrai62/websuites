import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/product/gst_list/add_gst_request_model.dart';
import '../../../../data/repositories/repositories.dart';
class AddGstViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> addGstApi(BuildContext context) async {
    AddGstRequestModel requestModel = AddGstRequestModel(
      cgst: 10,
      igst: 2,
      name: "Test Project",
      sgst: 25,
      status: 1,
    );

    loading.value = true;
    _api.addGstApi(requestModel.toJson()).then((value) {
      if(value.id!.isNotEmpty){
          print("Add gst List name ${value.name}");
          print("Add gst List id ${value.id}");
          print("Add gst List cgst ${value.cgst}");
          print("Add gst List status ${value.status}");
          Utils.snackbarSuccess('product GstList fetched');
          loading.value = false;

      }else {
        Utils.snackbarFailed('product GstList not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }






}