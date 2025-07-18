import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/lead/lead_list/details/activities/LeadDetailsActivitiesAllResModel.dart';
import '../../../../../data/models/responseModels/leads/list/details/lead_detail_view/activities/reminder/LeadDetailsActiReminderResModel.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadDetailsActiReminderViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadDetailsActiReminderResModel> leadActivitiesReminder = <LeadDetailsActiReminderResModel>[].obs;

  Future<void> leadDetailsActivitiesReminder(BuildContext context, String leadId) async {
    if (loading.value) return; // Prevent concurrent API calls
    loading.value = true;
    try {
      final value = await _api.leadDetailsActivitiesReminder(leadId);
      if (value.isNotEmpty) {
        leadActivitiesReminder.assignAll(value); // Use assignAll for smoother updates
        Utils.snackbarSuccess('Lead detail Reminder data fetched');
      } else {
        leadActivitiesReminder.clear();
        Utils.snackbarFailed('No lead detail Reminder activities found');
      }
    } catch (error) {
      Utils.snackbarFailed('Failed to fetch Reminder lead detail activities: $error');
    } finally {
      loading.value = false;
    }
  }
}