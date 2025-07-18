import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/responseModels/reports/task_report/project_overview/project_overview_list/task_report_project_overview_response_model.dart';
import '../../../../../data/repositories/repositories.dart';

class ProjectOverViewListViewModel extends GetxController {
  final _api = Repositories();
  final RxBool _loading = false.obs;
  final Rx<ProjectOverViewResponseModel?> _projectOverViewResponse = Rx(null);

  // Getter for loading
  bool get isLoading => _loading.value;

  // Getter for projectOverViewResponse
  ProjectOverViewResponseModel? get projectOverViewResponse =>
      _projectOverViewResponse.value;

  // Fetch project overview report
  Future<void> taskReportProjectOverview(
      BuildContext context, String listId) async {
    _loading.value = true; // Start loading

    try {
      // Call the API with the listId
      final response = await _api.taskProjectOverview(listId);

      // Store the response
      _projectOverViewResponse.value = response;

      // Check if the response has valid data
      if (response.project?.id != null && response.project!.id!.isNotEmpty) {
        // Process each lead item
        print('Task Project OverView id ${response.project?.id}');
        print('Task Project OverView status  ${response.project?.status}');
        print(
            'Task Project OverView member first name: ${response.project!.members?[0].firstName}');
        print(
            'Task Project OverView status task: ${response.tasks?.standard?.first.statusColor}');

        // Show success message
        Utils.snackbarSuccess('Project Overview fetched successfully');
      } else {
        Utils.snackbarFailed('Project Overview not fetched');
      }
    } catch (error) {
      // Handle errors gracefully
      if (kDebugMode) {
        print("Error fetching project overview: $error");
      }
      Utils.snackbarFailed('Failed to fetch project overview');
    } finally {
      _loading.value = false; // Stop loading
    }
  }
}
