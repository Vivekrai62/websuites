import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

import '../../../data/models/requestModels/report/task_report/start_stop/StartStopRequestModels.dart';
import '../../../data/models/responseModels/reports/task_report/task_report_response_model.dart';

import '../../../views/reports/taskdetails/TaskDetailsResponseModel.dart';
import '../../../views/reports/taskdetails/start_stop/StartStopResponseModels.dart';

class TaskReportsListViewModel extends GetxController {
  final _api = Repositories();
  final RxBool loading = false.obs;

  final Rx<TaskReportResponseModel> taskReportResponse =
      TaskReportResponseModel(
    items: [],
    meta: null,
    userKey: null,
  ).obs;
  final Rx<String?> error = Rx<String?>(null);
  final Rx<TaskDetailsResponseModel?> taskDetails =
      Rx<TaskDetailsResponseModel?>(null);
  final RxBool isStarted = false.obs;
  final RxBool dataLoaded = false.obs; // Flag to track if data has been loaded

  // Fetch task reports
  Future<void> fetchTaskReports(
      Map<String, dynamic> data, BuildContext context) async {
    if (dataLoaded.value) return; // If data is already loaded, do nothing

    error.value = null;
    loading.value = true;

    try {
      TaskReportResponseModel response = await _api.taskReportList(data);
      if (response.items.isNotEmpty) {
        taskReportResponse.value = response;
        dataLoaded.value = true; // Set dataLoaded to true
        Utils.snackbarSuccess('Task reports fetched successfully');
      } else {
        taskReportResponse.value = TaskReportResponseModel(
          items: [],
          meta: response.meta,
          userKey: response.userKey,
        );
        Utils.snackbarFailed('No task reports found');
      }
    } catch (e) {
      error.value = 'Error fetching task reports: ${e.toString()}';
      Utils.snackbarFailed(error.value!);
      taskReportResponse.value = TaskReportResponseModel(
        items: [],
        meta: null,
        userKey: null,
      );
    } finally {
      loading.value = false;
    }
  }

  // Fetch task details
  Future<TaskDetailsResponseModel?> fetchTaskDetails(String taskId) async {
    loading.value = true;
    try {
      final response = await _api.fetchTaskDetails(taskId);
      taskDetails.value = response;
      return response;
    } catch (e) {
      error.value = 'Error fetching task details: $e';
      Utils.snackbarFailed(error.value!);
      return null;
    } finally {
      loading.value = false;
    }
  }

  // Start a task
  Future<void> taskStartStop(String taskId) async {
    loading.value = true;
    try {
      StartStopRequestModels request =
          StartStopRequestModels(task: taskId, type: 'start');
      StartStopResponseModels response =
          await _api.taskStartStop(request.toJson());

      if (response.id != null) {
        isStarted.value = true;
        Utils.snackbarSuccess('Task started successfully');
      } else {
        Utils.snackbarFailed('Failed to start task');
      }
    } catch (e) {
      error.value = 'Error starting task: ${e.toString()}';
      Utils.snackbarFailed(error.value!);
    } finally {
      loading.value = false;
    }
  }

  // Stop a task
  Future<void> stopTask(String taskId) async {
    loading.value = true;
    try {
      StartStopRequestModels request =
          StartStopRequestModels(task: taskId, type: 'stop');
      StartStopResponseModels response =
          await _api.taskStartStop(request.toJson());

      if (response.id != null) {
        isStarted.value = false;
        Utils.snackbarSuccess('Task stopped successfully');
      } else {
        Utils.snackbarFailed('Failed to stop task');
      }
    } catch (e) {
      error.value = 'Error stopping task: ${e.toString()}';
      Utils.snackbarFailed(error.value!);
    } finally {
      loading.value = false;
    }
  }

  // Clear data
  void clearData() {
    taskReportResponse.value = TaskReportResponseModel(
      items: [],
      meta: null,
      userKey: null,
    );
    taskDetails.value = null;
    loading.value = false;
    error.value = null;
    dataLoaded.value = false; // Reset dataLoaded when clearing data
  }
}
