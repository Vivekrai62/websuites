import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/models/responseModels/leads/trashLeads/leadTypes/lead_types_response_model.dart';
import '../../../../../data/repositories/repositories.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/models/responseModels/leads/trashLeads/leadTypes/lead_types_response_model.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadTypeViewModel extends GetxController {
  final _api = Repositories();

  RxString selectedLeadTypeId = ''.obs;
  final TextEditingController searchController = TextEditingController();
  RxString searchQuery = ''.obs;
  RxList<LeadTypesResponseModel> filteredLeadTypesList = <LeadTypesResponseModel>[].obs;

  // Your existing properties
  RxBool loading = false.obs;
  RxList<LeadTypesResponseModel> leadTypesList = <LeadTypesResponseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeadTypes();
    // Set up search listener
    searchQuery.listen((_) => _filterLeadTypes());
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchLeadTypes() async {
    loading.value = true;
    try {
      final response = await _api.leadTypeApi();
      leadTypesList.assignAll(response);
      filteredLeadTypesList.assignAll(response); // Initialize filtered list
      print("Lead types fetched successfully");
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching lead types: $error');
      }
      print("Error fetching lead types");
    } finally {
      loading.value = false;
    }
  }

  void _filterLeadTypes() {
    if (searchQuery.value.isEmpty) {
      filteredLeadTypesList.assignAll(leadTypesList);
    } else {
      final filtered = leadTypesList.where((item) {
        final query = searchQuery.value.toLowerCase();
        final itemName = (item.name ?? '').toLowerCase();

        // Check main item name
        if (itemName.contains(query)) return true;

        // Check children names
        if (item.children != null) {
          return item.children!.any((child) =>
              (child.name ?? '').toLowerCase().contains(query)
          );
        }

        return false;
      }).toList();

      filteredLeadTypesList.assignAll(filtered);
    }
  }

  // Add this method for UI to call
  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  List<String> getLeadTypeNames() {
    return filteredLeadTypesList // Use filtered list
        .expand((leadType) => [
      if (leadType.name != null && leadType.name!.isNotEmpty) leadType.name!,
      ...?leadType.children?.map((child) => child.name ?? '').where((name) => name.isNotEmpty),
    ])
        .toList();
  }
}