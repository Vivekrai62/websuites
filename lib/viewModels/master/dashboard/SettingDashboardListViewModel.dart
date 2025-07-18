import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/models/requestModels/master/dashboard/save_changes/SettingDashSaveChangesRequestModel.dart';
import '../../../../data/models/responseModels/master/dashboard/save_changes/SettingDashSaveChangesResponseModel.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
import '../../../data/models/responseModels/master/dashboard/SettingDashboardResponseModel.dart';

class SettingDashboardListViewModel extends GetxController {
  final _api = Repositories();

  var selectedDashboardName = Rx<String?>(null);
  var selectedDashboardId = Rx<String?>(null);
  RxBool loading = false.obs;
  RxList<SettingDashboardListResponseModel> masterDashboardItems =
      <SettingDashboardListResponseModel>[].obs;

  // Map to store charts for each division
  final Map<String, List<String>> divisionChartsMap = {};
  final Map<String, List<String>> originalChartsMap =
      {}; // Store original charts
  var selectedDashboardCharts = Rx<List<String>?>(null);

  // Map to store deletion states for each division
  final Map<String, List<bool>> divisionDeletionStates = {};

  // Define the allowed chart values
  static const List<String> allowedCharts = [
    'lead_cards',
    'lead_types_chart',
    'lead_reminders_chart',
    'lead_sources_chart',
    'customer_status_chart',
    'customer_reminders_chart',
    'payment_reminders_chart',
    'task_status_chart',
    'project_status_chart',
    'project_reminders_chart',
    'sales_chart',
    'transactions_chart',
    'effective_hours',
  ];

  // Fetch the master setting customer_list from the API
  Future<void> fetchMasterSettingList(BuildContext context) async {
    loading.value = true;
    try {
      final response = await _api.masterSettingListApi();

      if (response.isNotEmpty) {
        // Assign data to observable variables
        masterDashboardItems.value = response;
        selectedDashboardName.value = response.first.name ?? '';
        selectedDashboardId.value = response.first.id ?? '';

        // Initialize the divisionChartsMap, originalChartsMap, and deletion states for each dashboard
        for (var dashboard in masterDashboardItems) {
          divisionChartsMap[dashboard.name ?? ''] =
              List<String>.from(dashboard.charts ?? []);
          originalChartsMap[dashboard.name ?? ''] =
              List<String>.from(dashboard.charts ?? []);

          // Initialize deletion states for this division
          divisionDeletionStates[dashboard.name ?? ''] =
              List.filled(dashboard.charts.length ?? 0, false);
        }

        // Set the selected charts for the current division
        selectedDashboardCharts.value = List<String>.from(
            divisionChartsMap[selectedDashboardName.value ?? ''] ?? []);
        // Utils.snackbarSuccess('Dashboard customer_list fetched');
      } else {
        // If no data is coming from the API, initialize with all allowed charts
        selectedDashboardCharts.value = List<String>.from(allowedCharts);
        divisionChartsMap[selectedDashboardName.value ?? ''] =
            List<String>.from(allowedCharts);
        originalChartsMap[selectedDashboardName.value ?? ''] =
            List<String>.from(allowedCharts);
        divisionDeletionStates[selectedDashboardName.value ?? ''] =
            List.filled(allowedCharts.length, false);

        // Utils.snackbarFailed('No dashboards available');
      }
    } catch (error) {
      // if (kDebugMode) {
      //   print('Dashboard fetch error: $error');
      // }
      // Utils.snackbarFailed('Error fetching dashboard customer_list');
    } finally {
      loading.value = false;
    }
  }

  // Method to update selected dashboard
  void updateSelectedDashboard(String name) {
    selectedDashboardName.value = name;
    selectedDashboardId.value = masterDashboardItems
        .firstWhere((dashboard) => dashboard.name == name)
        .id;

    // Set the selected charts for the current division
    selectedDashboardCharts.value =
        List<String>.from(divisionChartsMap[name] ?? []);

    // Ensure deletion states are initialized for this division
    if (!divisionDeletionStates.containsKey(name)) {
      divisionDeletionStates[name] =
          List.filled(selectedDashboardCharts.value?.length ?? 0, false);
    }
  }

  // Remove a chart by its index
  void removeChart(int index) {
    if (selectedDashboardCharts.value != null &&
        index >= 0 &&
        index < selectedDashboardCharts.value!.length) {
      // Mark the item as deleted in the deletion states map
      if (divisionDeletionStates[selectedDashboardName.value ?? ''] != null) {
        divisionDeletionStates[selectedDashboardName.value ?? '']![index] =
            true;
      }

      // Refresh the selectedDashboardCharts customer_list to trigger a UI update
      selectedDashboardCharts.refresh();
    }
  }

  // Method to reset the selected charts to include all original charts
  void resetCharts() {
    String currentDivision = selectedDashboardName.value ?? '';

    // If no data is coming from the API, reset to all allowed charts
    if (originalChartsMap[currentDivision] == null ||
        originalChartsMap[currentDivision]!.isEmpty) {
      selectedDashboardCharts.value = List<String>.from(allowedCharts);
      divisionChartsMap[currentDivision] = List<String>.from(allowedCharts);
      originalChartsMap[currentDivision] = List<String>.from(allowedCharts);
      divisionDeletionStates[currentDivision] =
          List.filled(allowedCharts.length, false);
    } else {
      // Reset the charts to the original customer_list for the current division
      selectedDashboardCharts.value =
          List<String>.from(originalChartsMap[currentDivision] ?? []);

      // Reset the deletion states for this division
      if (divisionDeletionStates.containsKey(currentDivision)) {
        divisionDeletionStates[currentDivision] =
            List.filled(selectedDashboardCharts.value?.length ?? 0, false);
      }
    }

    // Utils.snackbarSuccess('Charts have been reset to the original state.');
  }

  Future<SettingDashSaveChangesMessageResponseModel?> saveCharts() async {
    try {
      loading.value = true;
      String currentDivision = selectedDashboardName.value ?? '';

      if (selectedDashboardCharts.value == null ||
          selectedDashboardCharts.value!.isEmpty ||
          selectedDashboardId.value == null ||
          selectedDashboardId.value!.isEmpty) {
        // Utils.snackbarFailed('Please select at least one chart to save.');
        return null;
      }

      // Filter out deleted charts
      List<String> nonDeletedCharts = [];
      List<bool>? deletionStates = divisionDeletionStates[currentDivision];

      if (deletionStates != null) {
        for (int i = 0; i < selectedDashboardCharts.value!.length; i++) {
          if (!deletionStates[i]) {
            nonDeletedCharts.add(selectedDashboardCharts.value![i]);
          }
        }
      } else {
        nonDeletedCharts = List.from(selectedDashboardCharts.value!);
      }

      // Filter valid charts
      List<String> validCharts = nonDeletedCharts
          .where((chart) => allowedCharts.contains(chart))
          .toList();

      if (validCharts.isEmpty) {
        // Utils.snackbarFailed('No valid charts selected.');
        return null;
      }

      SettingDashSaveChangesRequestModel requestModel =
          SettingDashSaveChangesRequestModel(
        roleId: selectedDashboardId.value!,
        charts: validCharts,
      );

      final response = await _api.settingSaveChangesApi(requestModel);

      if (response.message != null) {
        // Update the saved state for this specific division
        divisionChartsMap[currentDivision] = validCharts;

        // Optionally, you can update the masterDashboardItems if needed
        var updatedDashboard = masterDashboardItems.firstWhere(
          (dashboard) => dashboard.name == currentDivision,
          orElse: () => const SettingDashboardListResponseModel(),
        );

        // Create a new instance with updated charts
        var newDashboard = SettingDashboardListResponseModel(
          id: updatedDashboard.id,
          name: updatedDashboard.name,
          charts: validCharts, // Set the updated charts
        );

        // Replace the old dashboard with the new one
        int index = masterDashboardItems.indexOf(updatedDashboard);
        if (index != -1) {
          masterDashboardItems[index] = newDashboard;
        }

        // Utils.snackbarSuccess(response.message!);
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        // print('Error saving charts: $e');
      }
      // Utils.snackbarFailed('Failed to save charts: $e');
      return null;
    } finally {
      loading.value = false;
    }
  }
}
