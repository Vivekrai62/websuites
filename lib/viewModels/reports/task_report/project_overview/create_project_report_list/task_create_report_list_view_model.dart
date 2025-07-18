import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import 'package:websuites/data/models/requestModels/report/task_report/project_overview/create_report_list/task_create_report_list_request_model.dart';
import '../../../../../data/models/requestModels/report/task_report/project_overview/create_report_list/task_create_report_list_request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class TaskCreateReportListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> taskCreateReportList(
    BuildContext context,
    String title,
    String description,
    DateTime? startDate,
    DateTime? endDate,
    String projectId,
    List<String> ccTo,
    Map<String, dynamic>? attachment,
  ) async {
    loading.value = true;

    try {
      // Validate required fields
      if (title.isEmpty || description.isEmpty) {
        Utils.snackbarFailed('Title and description are required');
        return;
      }

      // Validate required date fields
      if (startDate == null || endDate == null) {
        Utils.snackbarFailed('Start date and end date are required');
        return;
      }

      // Ensure start date is before end date
      if (startDate.isAfter(endDate)) {
        Utils.snackbarFailed('Start date must be before end date');
        return;
      }

      // Check if attachment is required and not provided
      if (attachment == null || attachment.isEmpty) {
        Utils.snackbarFailed('Attachment is required');
        return;
      }

      // Create the request model
      CreateReportListRequestModel requestModel =
          CreateReportListRequestModel.fromDateTime(
        title: title,
        description: description,
        startDate: startDate,
        endDate: endDate,
        project: projectId,
        ccTo: ccTo,
        attachment: attachment,
      );

      // Call the API to create the report
      final response = await _api.taskCreateReportList(requestModel.toJson());

      // Check if the response has valid data
      if (response.isNotEmpty) {
        // Assuming response is a list, get the first item
        final firstReport =
            response.first; // Adjust based on your API response structure
        if (firstReport.id != null && firstReport.id!.isNotEmpty) {
          Utils.snackbarSuccess('Project report created successfully');
          Get.back(); // Navigate back after successful creation
        } else {
          // Log the response for debugging
          print('API Response: ${response.toString()}');
          Utils.snackbarFailed(
              'Failed to create project report. Please try again.');
        }
      } else {
        // Log the response for debugging
        print('API Response: ${response.toString()}');
        Utils.snackbarFailed(
            'Failed to create project report. Please try again.');
      }
    } catch (error) {
      // Log the error for debugging
      print('Error: $error');
      Utils.snackbarFailed(
          'An error occurred while creating the report. Please check your input and try again.');
    } finally {
      loading.value = false;
    }
  }
}
