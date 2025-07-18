import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../../Utils/utils.dart';
import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/activities/assigned/LeadDetailsActiAssignedResModel.dart';
import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/activities/meeting/LeadDetailsActiMeetingResModel.dart';
import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/activities/notes/LeadDetailsActiNotesResModel.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../Utils/utils.dart';



class LeadDetailsActiNotesViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadDetailsActiNotesResModel> leadActivitiesNotes = <LeadDetailsActiNotesResModel>[].obs;

  Future<void> leadDetailsActivitiesNotes(BuildContext context, String leadId) async {
    if (loading.value) return; // Prevent concurrent API calls
    loading.value = true;
    try {
      final value = await _api.leadDetailsActivitiesNotes(leadId);
      if (value.isNotEmpty) {
        leadActivitiesNotes.assignAll(value); // Use assignAll for smoother updates
        Utils.snackbarSuccess('Lead detail Reminder data fetched');
      } else {
        leadActivitiesNotes.clear();
        Utils.snackbarFailed('No lead detail Reminder activities found');
      }
    } catch (error) {
      Utils.snackbarFailed('Failed to fetch Reminder lead detail activities: $error');
    } finally {
      loading.value = false;
    }
  }
}