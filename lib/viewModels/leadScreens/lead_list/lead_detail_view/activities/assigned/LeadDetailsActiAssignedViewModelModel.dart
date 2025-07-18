import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../../Utils/utils.dart';
import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/activities/assigned/LeadDetailsActiAssignedResModel.dart';
import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/activities/meeting/LeadDetailsActiMeetingResModel.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../Utils/utils.dart';



class LeadDetailsActiAssignedViewModelModel extends GetxController {

  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadDetailsActiAssignedResModel> leadActivitiesAssigned = <LeadDetailsActiAssignedResModel>[].obs;

  Future<void> leadDetailsActivitiesAssigned(BuildContext context, String leadId) async {
    if (loading.value) return;
    loading.value = true;
    try {
      final value = await _api.leadDetailsActivitiesAssigned(leadId);
      if (value.isNotEmpty) {
        leadActivitiesAssigned.assignAll(value);
        Utils.snackbarSuccess('Lead detail Reminder data fetched');
      } else {
        leadActivitiesAssigned.clear();
        Utils.snackbarFailed('No lead detail Reminder activities found');
      }
    } catch (error) {
      Utils.snackbarFailed('Failed to fetch Reminder lead detail activities: $error');
    } finally {
      loading.value = false;
    }
  }


}