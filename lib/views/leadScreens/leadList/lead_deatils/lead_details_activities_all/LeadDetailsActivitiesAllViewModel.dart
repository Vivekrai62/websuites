import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/responseModels/leads/lead_activity/lead_activity_list/lead_activity_list.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadDetailsActivitiesAllViewModel extends GetxController {
  final _api = Repositories();
  final loading = false.obs;
  final leadDetailsList = <LeadDetailsActivitiesAllResModel>[].obs;

  Future<void> leadDetailsActivitiesAll(BuildContext context, String leadId) async {
    if (loading.value) return;

    loading.value = true;
    try {
      final activities = await _api.leadDetailsActivitiesAll(leadId);
      leadDetailsList.assignAll(activities);
      // print("Fetched ${activities.length} activities for leadId: $leadId");
    } catch (e) {
      // Utils.snackbarFailed('Error fetching lead activities: $e');
    } finally {
      loading.value = false;
    }
  }
}
