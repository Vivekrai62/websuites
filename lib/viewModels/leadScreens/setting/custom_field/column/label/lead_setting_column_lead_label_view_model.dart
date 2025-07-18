import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../../data/models/responseModels/leads/setting/custom_field/lead_label/lead_setting_column_lead_label_res_model.dart';
import '../../../../../../data/repositories/repositories.dart';

class LeadSettingColumnLeadLabelViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadSettingCustomLeadLabel> labels = <LeadSettingCustomLeadLabel>[].obs;

  Future<void> leadSettingColumnLabel() async {
    try {
      loading.value = true;
      final List<LeadSettingCustomLeadLabel> labels = await _api.columnSettingLeadLabel();

      if (kDebugMode) {
        print("Lead Setting UserProfile: Fetched ${labels.length} labels");
        if (labels.isNotEmpty) {
          print("First label ID: ${labels.first.id}, Label: ${labels.first.fieldLabel}");
        }
      }

      if (labels.isNotEmpty) {
        // Utils.snackbarSuccess('Lead column labels fetched successfully');
      } else {
        // Utils.snackbarFailed('No lead column labels found');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching lead column labels: $e");
      }
      // Utils.snackbarFailed('Failed to fetch lead column labels: $e');
    } finally {
      loading.value = false;
    }
  }
}