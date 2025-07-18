import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/lead/lead_list/lead_detail_view/generate_proforma/lead_list_generate_proforma_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadDetailPerformaViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> leadDetailGenerateProforma(BuildContext context) async {
    loading.value = true;
    final request = LeadDetailGenerateProformaRequestModel(
      address: "testing",
      city: "f16e41be-14d7-4685-adaa-4ab1ab0c8fef",
      currencyId: "9683948f-0161-4977-aa7c-2c45ff03b940",
      division: "c66d0806-c3a0-41e0-a595-abecba3cbd7e",
      email: "healthcare.scazon@gmail.com",
      id: "ca661553-d140-4a22-8c09-e96a2b330adf",
      name: "Prakash",
      phone: 9999999999,
      products: [
        Product(
          total: 220000,
          gst: 0,
          quantity: 1,
          salePrice: 220000,
          paymentMode: null,
          paymentType: "onetime",
          isUpload: false,
          id: "3a309211-aabf-4e85-a7aa-62af8cf99b5b",
          tdsOption: "without_gst",
          tdsPercentage: "1",
          duration: 30,
          receivedAmount: 0,
          installments: 0,
          installmentDay: 1,
        ),
      ],
      remark: "testing",
      type: "lead",
    );

    _api.leadDetailGenerateProforma(request.toJson()).then((value) {
      if(value.id!.isNotEmpty){
          if (kDebugMode) {
            print("Lead Detail View name  ${value.name}");
            print("Lead Detail View city  ${value.city?.id}");
            print("Lead Detail View email  ${value.email}");

          }
          Utils.snackbarSuccess('Lead Detail View call Type fetch');
        loading.value = false;
      }
      else {
        Utils.snackbarFailed('Lead Detail Type data not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


}