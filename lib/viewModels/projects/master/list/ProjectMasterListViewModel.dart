import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/projects/master/ProjectMasterListResModel.dart';
import '../../../../data/repositories/repositories.dart';

class ProjectMasterListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<ProjectMasterListResponseModel> projectsMaster =
      <ProjectMasterListResponseModel>[].obs;
  RxString error = ''.obs; // Store error messages
  RxBool isDataInitialized = false.obs; // Track if data has been loaded

  Future<void> projectMaster(BuildContext context,
      {bool forceRefresh = false}) async {
    // Always clear data on force refresh to ensure fresh data
    if (forceRefresh) {
      projectsMaster.clear();
      isDataInitialized.value = false;
    }

    // Fetch data if not initialized or forced to refresh
    if (!isDataInitialized.value) {
      loading.value = true;
      error.value = ''; // Clear previous errors

      try {
        final value = await _api.projectMaster();

        if (value.isNotEmpty) {
          projectsMaster.assignAll(value);
          isDataInitialized.value = true; // Mark as initialized
        } else {
          projectsMaster.clear();
          error.value = 'No projects found';
        }
      } catch (e) {
        error.value = e.toString();
        if (kDebugMode) {
          print('Error fetching projects: $e');
        }
      } finally {
        loading.value = false;
      }
    }
  }

  // Method to manually clear the data when needed
  void clearData() {
    projectsMaster.clear();
    isDataInitialized.value = false;
    error.value = '';
  }
}
