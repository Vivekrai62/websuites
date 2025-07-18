import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/models/responseModels/sales/sales_detail_target/sales_detail_target_response_model.dart';
import '../../../data/repositories/repositories.dart';

class TargetDetailViewModel extends GetxController {
  final _api = Repositories(); // Assuming you have a repository to fetch data
  RxBool loading = false.obs;
  RxBool dataLoaded = false.obs; // New flag to track if data has been loaded
  Rx<TargetDetailResponseModel> targetDetailResponse =
      TargetDetailResponseModel().obs;

  Future<void> targetDetail(BuildContext context) async {
    // Only fetch data if it hasn't been loaded yet
    if (dataLoaded.value) return;

    loading.value = true;
    try {
      final response = await _api.targetDetail(); // Fetch the target detail
      targetDetailResponse.value =
          response; // Set the response to the observable
      dataLoaded.value = true; // Set dataLoaded to true after initial load
    } catch (error) {
      // Handle error
      print("Error fetching target details: $error");
    } finally {
      loading.value = false; // Set loading to false after fetching
    }
  }
}
