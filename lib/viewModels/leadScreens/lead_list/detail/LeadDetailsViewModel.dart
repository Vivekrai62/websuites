import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/models/responseModels/leads/list/details/LeadDetails.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadDetailsViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  Rx<LeadDetailsResponseModel?> leadDetails = Rx<LeadDetailsResponseModel?>(null);


  Future<void> fetchLeadDetails(BuildContext context, String leadId) async {
    loading.value = true;
    try {
      final LeadDetailsResponseModel value = await _api.leadDetailsApi(leadId);

      if (value != null) {
        leadDetails.value = value; // Assigning the fetched data
        // Utils.snackbarSuccess('Lead Detail Proposal data fetched');
      } else {
        // Utils.snackbarFailed('Lead Detail activity call not fetched');
      }
    } catch (error) {
      // Utils.snackbarFailed('Error fetching lead details');
      debugPrint(error.toString());
    } finally {
      loading.value = false;
    }
  }
  Future<void> updateLead({
    required String leadId,
    required String status,
    String? remark,
  }) async {
    loading.value = true;
    try {
      // Assuming your API repository has an updateLeadApi method
      final result = await _api.leadDetailsApi(leadId);

      if (result != null && result.leadStatus == true) {
        // Refresh lead details after update
        await fetchLeadDetails(Get.context!, leadId);

      } else {

      }
    } catch (error) {

      debugPrint(error.toString());
    } finally {
      loading.value = false;
    }
  }
}