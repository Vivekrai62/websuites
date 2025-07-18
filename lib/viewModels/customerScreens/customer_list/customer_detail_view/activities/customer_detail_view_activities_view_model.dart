import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/customer/customer_list/customer_detail_view/customer_detail_view_activities_request_model.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';
class CustomerDetailViewActivitiesViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> customerDetailViewActivities(BuildContext context) async {
    loading.value = true;

    RequestModel request = RequestModel(
      activity: "all",
      customer: "c5f2b49c-e836-4a1f-8e84-61eb9cd3e9b0",
      limit: 110,
    );
    _api.customerDetailViewActivities(request.toJson()).then((response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var item in response.items!) {
          print('Customer Detail View Activities List : ${item.remark}');
          print('Customer Detail View Activities List createdBy ${item.createdBy?.firstName}');
          print('Customer Detail View Activities List subActivity ${item.subActivity?.name}');
        }
        Utils.snackbarSuccess('Customer Trash customer_list fetched successfully');
      }
      else{
        Utils.snackbarFailed('company credentials id not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }

}




