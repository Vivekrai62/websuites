// lead_list_view_model.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../data/models/requestModels/lead/lead_list/lead_list.dart';
import '../../../data/models/responseModels/leads/list/lead_list.dart';

class LeadListViewModel extends GetxController {
  final Repositories api = Repositories();
  Map<String, dynamic> appliedFilters = {};

  void applyFilters(Map<String, dynamic> filters) {
    appliedFilters = filters;
    print('Applied filters: $appliedFilters');
    final requestModel = _createRequestModel();
    print('Request Data to be sent: ${requestModel.toJson()}');
    fetchLeadList(forceRefresh: true);
  }

  // Observable states
  final RxBool loading = false.obs;
  final RxList<Item> leadItems = <Item>[].obs;
  final RxList<Item> originalLeadItems = <Item>[].obs; // Store original items

  final RxBool showOrderDetails = false.obs;
  final RxBool isInitialized = false.obs;
  Item? selectedItem;

  // Pagination control
  static const int pageSize = 20;
  int currentPage = 2;
  bool hasMoreData = true;

  // Meta information
  Meta? currentMeta;

  // Error handling
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (!isInitialized.value) {
      fetchLeadList();
    }
  }

  void toggleOrderDetails() {
    showOrderDetails.value = !showOrderDetails.value;
  }

  String formatCreatedAt(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'No Date';
    try {
      final DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('EEE dd, MMMM yyyy \'at\' hh:mm a').format(dateTime);
    } catch (e) {
      debugPrint('Error formatting date: $e');
      return 'Invalid Date';
    }
  }

  LeadListRequestModel _createRequestModel({int? page}) {
    return LeadListRequestModel(
      paginationType: "old",
      page: page ?? currentPage,
      search: appliedFilters['search'] ?? '',
      notificationId: "",
      reminderRange: appliedFilters['reminder_range'],
      assignedType: appliedFilters['assigned_type'],
      assignedRange: appliedFilters['assigned_range'],
      city: appliedFilters['city'] ?? '',
      country: appliedFilters['country'],
      customFields: CustomFields(json: {}),
      division: appliedFilters['division'] ?? "",
      isOpen: false,
      isForeignLead: appliedFilters['is_foreign_lead'] ?? false,
      lastActivityRange: appliedFilters['lastActivityRange'],
      leadAssigned: appliedFilters['lead_assigned'].toString().isNotEmpty
          ? appliedFilters['lead_assigned']
          : null,
      leadAssignedToTeam: appliedFilters['leadAssignedToTeam'] ?? true,
      leadDeadReason: "",
      limit: pageSize,
      noCampaign: appliedFilters['no_campaign'] ?? false,
      productCategory: appliedFilters['productCategory'] ?? "",
      queryType: appliedFilters['query_type'] ?? "",
      range: appliedFilters['range'],
      reminderType: appliedFilters['reminder_type'],
      repeatType: appliedFilters['repeatType'],
      serviceType: appliedFilters['service_type'] ?? [],
      sortBy: appliedFilters['order_by'] ?? "create_date",
      sortDir: appliedFilters['order_by_list'] ?? "DESC",
      source: appliedFilters['source'] ?? "",
      state: appliedFilters['state'],
      status: appliedFilters['lead_status'] != null &&
              appliedFilters['lead_status'].toString().isNotEmpty
          ? appliedFilters['lead_status'].toString().toLowerCase()
          : null,
      subTypes: appliedFilters['sub_types'] ?? [],
      toDoList: null,
      todoLeads: appliedFilters['to_do_leads'],
      type: appliedFilters['type'] ?? "",
      unhandle: appliedFilters['unhandle'] ?? "",
    );
  }

  Future<void> fetchLeadList({bool forceRefresh = false}) async {
    if (isInitialized.value && !forceRefresh) {
      return;
    }

    try {
      loading.value = true;
      errorMessage.value = '';
      currentPage = 1;
      hasMoreData = true;

      if (forceRefresh) {
        leadItems.clear();
      }

      final response = await _fetchPage();
      _updateWithResponse(response);
      isInitialized.value = true;
    } catch (e) {
      _handleError(e);
    } finally {
      loading.value = false;
    }
  }

  Future<void> refreshLeadList() async {
    return fetchLeadList(forceRefresh: true);
  }

  Future<void> loadMore() async {
    if (!hasMoreData || loading.value) return;

    try {
      loading.value = true;
      errorMessage.value = '';
      currentPage++;

      final response = await _fetchPage();
      if (response.items.isNotEmpty) {
        _updateWithResponse(response);
      } else {
        hasMoreData = false;
        currentPage--;
      }
    } catch (e) {
      currentPage--;
      _handleError(e);
    } finally {
      loading.value = false;
    }
  }

  Future<LeadListResponseModel> _fetchPage() async {
    try {
      final requestModel = _createRequestModel();
      print("Request Payload: ${jsonEncode(requestModel.toJson())}");
      final response = await api.leadList(requestModel.toJson());
      return response;
    } catch (e) {
      debugPrint('Error fetching page: $e');
      throw Exception('Failed to fetch leads: $e');
    }
  }

  void _updateWithResponse(LeadListResponseModel response) {
    leadItems.assignAll(response.items);
    originalLeadItems.assignAll(response.items); // Store the original items

    currentMeta = response.meta;

    if (currentMeta != null) {
      hasMoreData = currentPage < (currentMeta!.totalPages ?? 0);
    } else {
      hasMoreData = response.items.length >= pageSize;
    }
  }

  void _handleError(dynamic error) {
    debugPrint('Error in LeadListViewModel: $error');
    errorMessage.value = 'Failed to fetch leads. Please try again.';
    loading.value = false;
  }

  void filterLeads(String query) {
    if (query.isEmpty) {
      // Reset to the original customer_list
      leadItems.assignAll(originalLeadItems);
    } else {
      // Filter the leadItems based on the query
      leadItems.assignAll(originalLeadItems.where((item) {
        return item.organization?.toLowerCase().contains(query.toLowerCase()) ??
            false ||
                "${item.firstName} ${item.lastName}"
                    .toLowerCase()
                    .contains(query.toLowerCase());
      }).toList());
    }
  }

  // Getters for meta information
  int get totalItems => currentMeta?.totalItems ?? 0;

  int get totalPages => currentMeta?.totalPages ?? 0;

  int get currentPageItems => currentMeta?.itemCount ?? 0;

  bool get canLoadMore => hasMoreData && !loading.value;
}
