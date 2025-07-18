import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/models/responseModels/leads/createNewLead/assignedLeadTo/assigned_lead_to_response_model.dart';
import '../../../../../data/repositories/repositories.dart';

class AssignedLeadToViewModel extends GetxController {
  final Repositories _api = Repositories();
  RxBool loading = false.obs;
  RxList<String> fullCategoriesRxList = <String>[].obs; // Full names with emails
  RxList<String> namesOnlyRxList = <String>[].obs; // Only first and last names
  RxString selectedLeadName = ''.obs;
  RxString selectedLeadId = ''.obs; // Initialize with an empty string

  Future<void> fetchAssignedLeads(BuildContext context) async {
    loading.value = true;
    fullCategoriesRxList.clear();
    namesOnlyRxList.clear();

    try {
      List<AssignedLeadToResponseModel> response = await _api.assignedLeadApi();
      if (response.isNotEmpty) {
        print("Lead IDs fetched");
        for (var item in response) {
          String firstName = item.first_name ?? '';
          String lastName = item.last_name ?? '';
          String email = item.email ?? '';

          // Add full name with email for internal use
          fullCategoriesRxList.add('$firstName $lastName\n$email');
          // Add only first and last name to namesOnlyRxList
          namesOnlyRxList.add('$firstName $lastName');
        }
      } else {
        print("No lead IDs found");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching leads: ${e.toString()}");
      }
    } finally {
      loading.value = false;
    }
  }
}