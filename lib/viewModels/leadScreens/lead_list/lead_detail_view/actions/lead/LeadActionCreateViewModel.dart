import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/models/requestModels/lead/lead_list/details/actionCreate/LeadActionCreateReqModel.dart';
import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/actionCreate/LeadActionCreateResModel.dart';
import '../../../../../../data/repositories/repositories.dart';

class LeadActionCreateViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;


  RxList<LeadActionCreateResModel> leadResponseList = <LeadActionCreateResModel>[].obs;


  RxList<LeadActionCreateResModel> filteredLeadResponseList = <LeadActionCreateResModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    filteredLeadResponseList.assignAll(leadResponseList);
  }

  Future<void> leadDetailActionLead(BuildContext context) async {
    loading.value = true;
    LeadActionCreateReqModel requestModel = LeadActionCreateReqModel(json: {});

    try {
      final List<LeadActionCreateResModel> response = await _api.leadDetailActionLead(requestModel.toJson());
      loading.value = false;

      if (response.isNotEmpty && response.first.id != null && response.first.id!.isNotEmpty) {
        // Store all responses in leadResponseList
        leadResponseList.assignAll(response);
        // Initialize filtered list with all leads
        filteredLeadResponseList.assignAll(response);
        // print('Lead Detail Action Lead Activity: ${response.map((e) => e.id).toList()}');
        // Utils.snackbarSuccess('Lead customer_list fetched successfully');
      } else {
        // Utils.snackbarFailed('Lead Detail Action Service data not fetched');
      }
    } catch (error) {
      loading.value = false;
      if (kDebugMode) {
        // print(error.toString());
      }
      // Utils.snackbarFailed('An error occurred while fetching lead data');
    }
  }


  void filterLeads(String query) {
    if (query.isEmpty) {
      filteredLeadResponseList.assignAll(leadResponseList);
    } else {
      filteredLeadResponseList.assignAll(leadResponseList.where((lead) {
        final fullName = '${lead.firstName} ${lead.lastName}'.trim();
        return fullName.toLowerCase().contains(query.toLowerCase());
      }).toList());
    }
  }
}