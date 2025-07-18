import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../../Utils/utils.dart';
import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/activities/meeting/LeadDetailsActiMeetingResModel.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../Utils/utils.dart';



class LeadDetailsActiMeetingViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadDetailsActiMeetingResModel> leadActivitiesMeeting = <LeadDetailsActiMeetingResModel>[].obs;

  Future<void> leadDetailsActivitiesMeeting(BuildContext context, String leadId) async {
    if (loading.value) return; // Prevent concurrent API calls
    loading.value = true;
    try {
      final value = await _api.leadDetailsActivitiesMeeting(leadId);
      if (value.isNotEmpty) {
        leadActivitiesMeeting.assignAll(value); // Use assignAll for smoother updates
        Utils.snackbarSuccess('Lead detail Reminder data fetched');
      } else {
        leadActivitiesMeeting.clear();
        Utils.snackbarFailed('No lead detail Reminder activities found');
      }
    } catch (error) {
      Utils.snackbarFailed('Failed to fetch Reminder lead detail activities: $error');
    } finally {
      loading.value = false;
    }
  }
}