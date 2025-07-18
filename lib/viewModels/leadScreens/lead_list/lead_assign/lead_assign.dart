import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/models/requestModels/lead/lead_list/filter/LeadUserFilterReqModel.dart';
import '../../../../data/models/responseModels/leads/list/lead_assign/lead_assign.dart';
import '../../../../data/repositories/repositories.dart';

class ListLeadAssignViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadAssignResponseModel> leadAssignList =
      <LeadAssignResponseModel>[].obs; // Observable role

  LeadUserFilterReqModel requestModel = LeadUserFilterReqModel(
    search: "",
    userId: null,
  );

  Future<void> leadListLeadAssign(BuildContext context) async {
    loading.value = true;
    try {
      final value = await _api.leadListLeadAssign(requestModel.toJson());
      if (value.isNotEmpty) {
        leadAssignList.assignAll(value); // Update the observable role
        for (var responseData in value) {
          if (kDebugMode) {
            print(
                "Lead Assign Data: ${responseData.firstName} (ID: ${responseData.id})");
          }
        }
      } else {
        if (kDebugMode) {
          print("No data fetched for Lead Assign");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching lead assign data: $error");
      }
    } finally {
      loading.value = false;
    }
  }

  // Method to ensure role is accessible
  RxList<LeadAssignResponseModel> getLeadAssignList() {
    return leadAssignList;
  }
}
