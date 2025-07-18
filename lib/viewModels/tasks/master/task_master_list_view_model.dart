import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
import '../../../data/models/responseModels/tasks/master/task_master_list/task_master_response_model.dart';

class TaskMasterListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<TaskMasterResponseModel> taskMaster = <TaskMasterResponseModel>[].obs;

  Future<void> tasksMasterApi(BuildContext context) async {
    // Check if data already exists, if yes, skip loading
    if (taskMaster.isNotEmpty) {
      return; // Data already loaded, no need to fetch again
    }

    loading.value = true;

    try {
      final value = await _api.tasksMasterApi();
      if (value.isNotEmpty) {
        taskMaster.assignAll(value);
        // Utils.snackbarSuccess('Task Master data fetched');
      } else {
        // Utils.snackbarFailed('No Task Master data found');
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      Utils.snackbarFailed('Error fetching Task Master: $error');
    } finally {
      loading.value = false;
    }
  }

  Future<void> loadNextPage(BuildContext context) async {
    // Implement pagination logic here if needed
  }

  Future<void> refreshList(BuildContext context) async {
    taskMaster.clear(); // Clear existing data
    await tasksMasterApi(context); // Fetch fresh data
  }
}
