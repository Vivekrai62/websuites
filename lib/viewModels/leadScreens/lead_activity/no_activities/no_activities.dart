import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../data/models/requestModels/lead/activity/no_activities/no_activities.dart';
import '../../../../data/models/responseModels/leads/lead_activity/no_activities/no_activities.dart';

class LeadActivityNoActivityViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadActivityItem> items = <LeadActivityItem>[].obs;

  Future<void> fetchNoActivities(BuildContext context) async {
    // Don't show loading if we already have items
    if (items.isEmpty) {
      loading.value = true;
    }

    final noActivitiesRequestModel = NoActivitiesRequestModel(
      activities: [],
      assignedTo: "",
      days: null,
      isFilterUserWithTeam: true,
      limit: 5,
      page: 1,
    );

    try {
      final response =
          await _api.leadNoActivities(noActivitiesRequestModel.toJson());

      if (response.items != null && response.items!.isNotEmpty) {
        items.value = response.items!;
        // Only show success message on refresh
        if (loading.value == false) {
          // Utils.snackbarSuccess('Activities refreshed successfully');
        }
      } else {
        items.clear();
        // Utils.snackbarFailed('No activities found');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
      // Utils.snackbarFailed('Failed to fetch activities: ${error.toString()}');
    } finally {
      loading.value = false;
    }
  }
}
