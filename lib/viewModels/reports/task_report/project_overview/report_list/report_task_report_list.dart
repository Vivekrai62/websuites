import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';

import '../../../../../data/models/responseModels/reports/task_report/project_overview/report_list/task_report_list_response_model.dart';

import '../../../../../data/repositories/repositories.dart';

class TaskReportListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<TaskReportListResponseModel> reports =
      <TaskReportListResponseModel>[].obs;

  // Getter for loading
  bool get isLoading => loading.value;

  Future<void> fetchTaskProjectReportList(BuildContext context) async {
    loading.value = true;
    // Define data as Map<String, dynamic>
    Map<String, dynamic> data = {};
    try {
      var response = await _api.taskProjectReportList(data);
      if (response.isNotEmpty) {
        reports.value = response; // Store the fetched reports
        Utils.snackbarSuccess('Lead Detail Proposal data fetched');
      } else {
        Utils.snackbarFailed('Project Overview not fetched');
      }
    } catch (error) {
      Utils.snackbarFailed('Error fetching reports: $error');
    } finally {
      loading.value = false;
    }
  }
}
