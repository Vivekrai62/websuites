import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../data/models/responseModels/projects/list/details/ProjectDetailsResponseModels.dart';
import '../../../data/repositories/repositories.dart';

class ProjectDetailViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Rx<ProjectDetailResponseModel?> projectDetail =
      Rx<ProjectDetailResponseModel?>(null);

  // Method to fetch project details
  Future<void> projectDetailView(BuildContext context, String projectId) async {
    if (projectDetail.value != null &&
        projectDetail.value!.project?.id == projectId) {
      return;
    }

    loading.value = true;

    try {
      // Fetch project details using the projectId
      final value = await _api
          .projectDetailView(projectId); // Pass the projectId to the API call
      projectDetail.value = value; // Store the fetched data

      // You can add additional logic here if needed
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching project details: ${error.toString()}");
      }
      // Optionally, you can show a message to the user
      // Get.snackbar("Error", "Failed to fetch project details");
    } finally {
      loading.value = false;
    }
  }

  // Method to refresh the project details
  Future<void> refreshList(BuildContext context, String projectId) async {
    await projectDetailView(context, projectId); // Re-fetch the project details
  }
}
