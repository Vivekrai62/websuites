import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../Data/response/status.dart';
import '../../data/models/responseModels/dashboard/db_lead_by_type_count_response_model.dart';
import '../../data/repositories/repositories.dart';

class HomeScreenLeadsByTypeCountViewModel extends GetxController {
  final _api = Repositories();
  // RxBool Loading = false.obs;
  final rxStatus = Status.loading.obs;
  final dbLeadTypeCountModel = DashboardLeadsByTypeCountResponseModel().obs;
  RxString error = ''.obs;

  void setLeadTypeCount(DashboardLeadsByTypeCountResponseModel value) =>
      dbLeadTypeCountModel.value = value;
  void setRxStatus(Status value) => rxStatus.value = value;
  void setError(String value) => error.value = value;

  Future<void> DBLeadsByTypeCount(context) async {
    setRxStatus(Status.loading);

    _api.dbLeadsTypeCountApi().then((value) {
      setLeadTypeCount(value);
      setRxStatus(Status.completed);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxStatus(Status.error);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
