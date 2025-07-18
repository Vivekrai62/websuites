import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../../Utils/utils.dart';
import '../../../../../../data/repositories/repositories.dart';
// Import the correct model file with a specific prefix
import 'package:websuites/data/models/requestModels/report/task_report/project_overview/task/ProjectOverViewTaskListRequestModel.dart'
    as models;
// import 'package:websuites/data/models/responseModels/reports/taskdetails/project_overview/task/ProjectOverViewTaskListResponseModel.dart';

import '../../../../../../views/reports/taskdetails/project_overview/task/ProjectOverViewTaskListResponseModel.dart';

class ProjectOverviewTaskListViewModel extends GetxController {
  final Repositories _api;

  ProjectOverviewTaskListViewModel(this._api);

  var isLoading = false.obs;
  var taskListResponse = Rx<ProjectOverViewTaskListResponseModel?>(null);
  var isDataLoaded = false;

  Future<void> fetchTaskList(
    BuildContext context, {
    String? projectId,
    models.DateRange? dateRange,
  }) async {
    if (isDataLoaded) return;

    isLoading.value = true;
    try {
      final requestModel = models.ProjectOverviewTaskRequestModel(
        limit: 15,
        dateRange: dateRange ??
            models.DateRange(
              from: DateTime.now()
                  .subtract(const Duration(days: 30))
                  .toIso8601String(),
              to: DateTime.now().toIso8601String(),
            ),
        page: 1,
        project: projectId ?? "4e71cae5-a4ba-403f-aaf6-35ebb5295baf",
      );

      // Using the correct model type from ProjectOverViewTaskListRequestModel.dart
      final response = await _api.ProjectOverViewTasksListApi(requestModel);
      taskListResponse.value = response;
      isDataLoaded = true;
      Utils.snackbarSuccess('Task Report fetched successfully');
    } catch (error) {
      Utils.snackbarFailed('Failed to fetch Task Report');
      if (kDebugMode) {
        print('Error fetching task list: ${error.toString()}');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void resetTaskList() {
    taskListResponse.value = null;
    isDataLoaded = false;
  }
}
