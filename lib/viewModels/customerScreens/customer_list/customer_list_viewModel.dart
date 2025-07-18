import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/repositories.dart';
import '../../../utils/utils.dart';
import '../../../data/models/requestModels/customer/customer_list/customer_list.dart';
import '../../../data/models/responseModels/customers/list/customers_list_response_model.dart';

class CustomerListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxBool initialLoad = true.obs;
  RxList<Item> customers = <Item>[].obs;
  RxList<Item> filteredCustomers = <Item>[].obs;

  // ADD: New observable for paginated display data
  RxList<Item> displayedCustomers = <Item>[].obs;

  Map<String, dynamic> appliedFilters = {};

  // Pagination state
  RxInt currentPage = 1.obs;
  RxInt itemsPerPage = 15.obs;
  RxInt totalItems = 0.obs;
  RxInt totalPages = 1.obs;
  List<int> itemsPerPageOptions = [2, 5, 10, 15, 20, 50];

  @override
  void onInit() {
    super.onInit();
    filteredCustomers.assignAll(customers);
    _updateDisplayedCustomers(); // Initialize displayed customers
  }


  // ADD: Method to update displayed customers based on pagination
  void _updateDisplayedCustomers() {
    if (filteredCustomers.isEmpty) {
      displayedCustomers.clear();
      // print('_updateDisplayedCustomers: No filtered customers, clearing displayedCustomers');
      return;
    }

    int startIndex = (currentPage.value - 1) * itemsPerPage.value;
    int endIndex = startIndex + itemsPerPage.value;

    // Ensure we don't go beyond available data
    if (startIndex >= filteredCustomers.length) {
      displayedCustomers.clear();
      // print('_updateDisplayedCustomers: Start index out of bounds, clearing displayedCustomers');
      return;
    }

    if (endIndex > filteredCustomers.length) {
      endIndex = filteredCustomers.length;
    }

    displayedCustomers.assignAll(filteredCustomers.sublist(startIndex, endIndex));
    //
    // print('_updateDisplayedCustomers:');
    // print('- StartIndex: $startIndex, EndIndex: $endIndex');
    // print('- FilteredCustomers length: ${filteredCustomers.length}');
    // print('- DisplayedCustomers length: ${displayedCustomers.length}');
  }

  void applyFilters(Map<String, dynamic> filters) {
    appliedFilters = filters;
    currentPage.value = 1; // Reset to first page on filter change
    customersListApi(Get.context!, filters: appliedFilters, forceRefresh: true);
  }

  Future<void> customersListApi(BuildContext context,
      {Map<String, dynamic>? filters, bool forceRefresh = false}) async {
    if (initialLoad.value || forceRefresh) {
      loading.value = true;
    }

    final customerRequestModel = CustomerRequestModel(
      assignedRange: appliedFilters['assigned_range'],
      productCategory: filters?['product_category']?.toString(),
      assignedTo: filters?['lead_assigned']?.toString(),
      city: filters?['city']?.toString() ?? '',
      customFields: filters?['customFields'] ?? {},
      customerAssignedToTeam: filters?['customerAssignedToTeam'] ?? false,
      typeId: filters?['customer_type']?.toString() ?? '',
      division: filters?['division']?.toString() ?? '',
      source: filters?['source']?.toString(),
      limit: itemsPerPage.value,
      page: currentPage.value,
      paginationType: 'old',
      projectStatus: filters?['project_status']?.toString(),
      range: filters?['range'] != null
          ? Range.fromJson(filters!['range'] as Map<String, dynamic>)
          : null,
      reminderRange: filters?['reminder_range'] != null
          ? Range.fromJson(filters!['reminder_range'] as Map<String, dynamic>)
          : null,
      reminderType: filters?['reminder_type']?.toString() ?? '',
      search: filters?['search']?.toString() ?? '',
      serviceStatus: filters?['service_status']?.toString(),
      status: filters?['status'] as String? ?? '',
    );

    try {
      final response = await _api.customersListApi(customerRequestModel.toJson());
      if (response.items.isNotEmpty) {
        customers.assignAll(response.items);
        filteredCustomers.assignAll(response.items);
        totalItems.value = response.meta?.totalItems ?? response.items.length;
        totalPages.value = response.meta?.totalPages ?? 1;
        itemsPerPage.value = response.meta?.itemsPerPage ?? itemsPerPage.value;

        // UPDATE: Refresh displayed customers after API call
        _updateDisplayedCustomers();

        if (forceRefresh) {
          // Utils.snackbarSuccess('Customer list refreshed successfully');
        }
      } else {
        customers.clear();
        filteredCustomers.clear();
        displayedCustomers.clear(); // Also clear displayed customers
        totalItems.value = 0;
        totalPages.value = 1;
        // Utils.snackbarFailed('No customers found');
      }
    } catch (error) {
      // if (kDebugMode) {
      //   print('Error fetching customer list: $error');
      // }
      // Utils.snackbarFailed('Failed to fetch customer list: $error');
    } finally {
      loading.value = false;
      initialLoad.value = false;
    }
  }

  void filterCustomers(String query) {
    if (query.isEmpty) {
      filteredCustomers.assignAll(customers);
    } else {
      filteredCustomers.assignAll(customers.where((customer) {
        final fullName = '${customer.firstName} ${customer.lastName}'.toLowerCase();
        final companyName = customer.companies.isNotEmpty
            ? customer.companies.first.companyName.toLowerCase() ?? ''
            : '';
        final email = customer.primaryEmail?.toLowerCase() ?? '';
        final contact = customer.primaryContact?.toLowerCase() ?? '';
        return fullName.contains(query.toLowerCase()) ||
            companyName.contains(query.toLowerCase()) ||
            email.contains(query.toLowerCase()) ||
            contact.contains(query.toLowerCase());
      }).toList());
    }


    totalItems.value = filteredCustomers.length;
    totalPages.value = totalItems.value == 0 ? 1 : (totalItems.value / itemsPerPage.value).ceil();
    currentPage.value = 1; // Reset to first page after filtering
    _updateDisplayedCustomers(); // Update displayed customers
  }

  void setPage(int page) {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      _updateDisplayedCustomers(); // Update displayed customers immediately
      // print('setPage: currentPage=${currentPage.value}, displayedCustomers=${displayedCustomers.length}');
    }
  }

  void setItemsPerPage(int items) {
    itemsPerPage.value = items;
    currentPage.value = 1; // Reset to first page when changing items per page
    totalPages.value = totalItems.value == 0 ? 1 : (totalItems.value / itemsPerPage.value).ceil();
    _updateDisplayedCustomers(); // Update displayed customers immediately
    // print('setItemsPerPage: itemsPerPage=${itemsPerPage.value}, totalPages=${totalPages.value}, displayedCustomers=${displayedCustomers.length}');
  }


}