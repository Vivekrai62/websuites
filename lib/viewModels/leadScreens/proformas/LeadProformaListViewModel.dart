import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/requestModels/lead/proformas/LeadProformasReqModel.dart';
import '../../../data/models/responseModels/leads/proformas/LeadProformasResModel.dart';
import '../../../data/repositories/repositories.dart';

class LeadProformaListViewModel extends GetxController {
  final Repositories _api = Repositories();
  final RxBool loading = false.obs;
  final RxList<Items> leadProItems = <Items>[].obs;
  final RxList<Items> allLeadProItems = <Items>[].obs;
  Map<String, dynamic> appliedFilters = {};

  @override
  void onInit() {
    super.onInit();
    fetchLeadProformas();
  }

  void applyFilters(Map<String, dynamic> filters) {
    appliedFilters = filters;
    print('Applied filters: $appliedFilters');
    fetchLeadProformas(forceRefresh: true);
  }

  Future<void> fetchLeadProformas({bool forceRefresh = false}) async {
    try {
      loading.value = true;
      if (forceRefresh) {
        leadProItems.clear();
        allLeadProItems.clear();
      }

      final request = _createRequestModel();

      final LeadProformasResModel response =
      await _api.leadProformasApi(request.toJson());

      if (response.items != null && response.items!.isNotEmpty) {
        leadProItems.assignAll(response.items!);
        allLeadProItems.assignAll(response.items!);
      } else {
        leadProItems.clear();
        allLeadProItems.clear();
        debugPrint('No proforma items found in response');
      }

      debugPrint('API Response items count: ${response.items?.length}');
    } catch (error) {
      leadProItems.clear();
      allLeadProItems.clear();
      debugPrint('Error fetching proforma role: $error');
    } finally {
      loading.value = false;
    }
  }

  LeadProformasReqModel _createRequestModel() {
    return LeadProformasReqModel(
      search: appliedFilters['search'] ?? '',
      isWithTeam: appliedFilters['lead_assigned'] == 'withteam' ? true : false,
      division: appliedFilters['division'] ?? "",
      limit: 10,
      page: 1,
      dateRange: appliedFilters['range'] != null
          ? appliedFilters['range'] as Map<String, dynamic>?
          : null,
      createdBy: appliedFilters['created_by'] as String?,
    );
  }

  void searchProformas(String query) {
    if (query.isEmpty) {
      leadProItems.assignAll(allLeadProItems);
    } else {
      final filteredItems = allLeadProItems.where((item) {
        final name = item.name?.toLowerCase() ?? '';
        final email = item.email?.toLowerCase() ?? '';
        final performaNumber = item.performaNumber?.toString() ?? '';
        final lowerQuery = query.toLowerCase();
        return name.contains(lowerQuery) ||
            email.contains(lowerQuery) ||
            performaNumber.contains(lowerQuery);
      }).toList();
      leadProItems.assignAll(filteredItems);
    }
  }
}