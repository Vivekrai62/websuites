import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/repositories/repositories.dart';
import '../../../../data/models/requestModels/lead/activity/activity_list.dart';
import '../../../../data/models/responseModels/reports/leadReport/Activities/ReportActivitiesResModel.dart';

class ReportLeadActivityViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<ReportActivityResModel> activityDataList =
      <ReportActivityResModel>[].obs;

  // Define the leadActivity property
  LeadActivityRequestModel leadActivity = LeadActivityRequestModel(
      page: 1,
      limit: 15,
      dateRange: DateRange(
          from: "2025-04-09 00:00:00.000", to: "2025-04-09 23:59:59.999"));

  Rx<ReportActivityResModel> leadActivityResponse =
      Rx(ReportActivityResModel());

  Future<void> leadActivityList(BuildContext context) async {
    loading.value = true; // Start loading
    try {
      var response = await _api.leadActivityList(leadActivity.toJson());
      leadActivityResponse.value = response; // Store the response
      // Add the response to the list if it’s not already in the expected format
      activityDataList.clear(); // Clear previous data
      activityDataList.add(response); // Add the response to the list
      // print(' lead activities: ${leadActivity.toJson()}');
      // print('API Response: ${response.toJson()}');
    } catch (error) {
      // print('Error fetching lead activities: ${error.toString()}');
    } finally {
      loading.value = false; // Stop loading
    }
  }
}
