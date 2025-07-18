import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/order/list/export/export_list_request_model.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';

class OrderExportViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> orderExportList(BuildContext context) async {
    loading.value = true;
    OrderExportRequestModel request = OrderExportRequestModel(
      createdBy: null,
      customer: null,
      dateRange: null,
      paymentType: null,
      product: null,
      productType: null,
    );
    _api.orderExport(request.toJson()).then((response) {
      if (response.message != null && response.message!.isNotEmpty) {
        print('Order Export  Response  ${response.status}');
        print('Order Export  Response  ${response.message}');
        Utils.snackbarSuccess('Order  Delete List Fetching');
      } else {
        Utils.snackbarFailed('order Delete List not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
