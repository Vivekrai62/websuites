import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/models/requestModels/master/dashboard/save_changes/SettingDashSaveChangesRequestModel.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class SettingDashSaveChangesViewModel extends GetxController {
  RxList<String> selectedDashboardCharts = <String>[].obs; // List of selected charts
  final _loading = false.obs; // Loading state
  final _error = ''.obs; // Error state
  final Repositories _repository = Repositories(); // Repository for API calls


  bool get loading => _loading.value;
  String get error => _error.value;

  static const List<String> allowedCharts = [
    "lead_cards",
    "lead_types_chart",
    "lead_reminders_chart",
    "lead_sources_chart",
    "customer_status_chart",
    "customer_reminders_chart",
    "payment_reminders_chart",
    "task_status_chart",
    "project_status_chart",
    "project_reminders_chart",
    "sales_chart",
    "transactions_chart",
    "effective_hours"
  ];

  // Method to remove a chart from the selected customer_list
  void removeChart(int index) {
    if (index >= 0 && index < selectedDashboardCharts.length) {
      selectedDashboardCharts.removeAt(index);
      selectedDashboardCharts.refresh();
    }
  }

  // Save the selected charts to the API
  Future<bool> saveChanges(String roleId) async {
    try {
      _loading.value = true;
      _error.value = '';

      if (selectedDashboardCharts.isEmpty) {
        Utils.snackbarFailed('Please select at least one chart to save.');
        return false;
      }

      // Filter the selected charts to only include allowed charts
      List<String> validCharts = selectedDashboardCharts
          .where((chart) => allowedCharts.contains(chart))
          .toList();

      if (validCharts.isEmpty) {
        Utils.snackbarFailed('No valid charts selected.');
        return false;
      }

      // Create the request model with the valid charts customer_list
      final requestModel = SettingDashSaveChangesRequestModel(
        roleId: roleId,
        charts: validCharts, // Pass the customer_list of valid charts directly
      );

      // Log the request model (for debugging)
      if (kDebugMode) {
        print('Request Model: ${requestModel.toJson()}');
      }

      // Call the API to save the changes
      final response = await _repository.settingSaveChangesApi(requestModel);

      // Check the response and show success or error message
      if (response.message != null) {
        Utils.snackbarSuccess(response.message!);
        return true;
      } else {
        _error.value = 'Unexpected response';
        return false;
      }
    } catch (e) {
      print("Error saving changes: $e");
      _error.value = e.toString();
      return false;
    } finally {
      _loading.value = false;
    }
  }
}