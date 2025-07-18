import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/responseModels/leads/trashLeads/deleteList/delete_list_response_model.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/trash/delete_list/delete_list.dart';
import '../../../../data/repositories/repositories.dart';

class TrashDeleteListViewModel extends GetxController {
  final Repositories api = Repositories();
  final RxBool loading = false.obs;
  final RxList<Item> leadsTrashList = <Item>[].obs;
  final RxList<Item> allLeadsTrashList = <Item>[].obs; // Add backup list for search
  final Rx<Meta?> meta = Rx<Meta?>(null);
  final RxBool isLoadingMore = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchTerm = ''.obs;

  // Store applied filters (if needed for future filter functionality)
  Map<String, dynamic> appliedFilters = {};

  // Filtered leads based on search term
  List<Item> get filteredLeads {
    if (searchTerm.value.isEmpty) {
      return leadsTrashList.toList();
    }
    return leadsTrashList.where((item) {
      final fullName = "${item.firstName ?? ''} ${item.lastName ?? ''}".toLowerCase().trim();
      final organization = (item.organization ?? '').toLowerCase();
      final mobile = (item.mobileWithCountryCode ?? '').toLowerCase();
      final searchLower = searchTerm.value.toLowerCase();
      return fullName.contains(searchLower) ||
          organization.contains(searchLower) ||
          mobile.contains(searchLower);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchTrashDeleteList();
  }

  /// Fetches the list of deleted leads from the server.
  Future<void> fetchTrashDeleteList({
    bool forceRefresh = false,
    int page = 1,
    int limit = 50,
    String? search,
  }) async {
    try {
      // Set loading state
      if (page == 1) {
        loading.value = true;
        hasError.value = false;
        errorMessage.value = '';
      } else {
        isLoadingMore.value = true;
      }

      // If force refresh, clear existing data
      if (forceRefresh) {
        leadsTrashList.clear();
        allLeadsTrashList.clear();
      }

      // Create request model
      final requestModel = LeadTrashListResModel(
        page: page,
        limit: limit,
        search: search,
        reminderRange: null,
        range: null,
        dateRange: null,
        deleteDateRange: null,
        unhandle: null,
      );

      // Fetch data from API
      final DeleteListResponseModel response = await api.leadTrashList(requestModel.toJson());

      debugPrint('Response Trash Delete List: ${response.toJson()}');

      // Process response
      if (response.items != null && response.items!.isNotEmpty) {
        if (page == 1) {
          leadsTrashList.assignAll(response.items!);
          allLeadsTrashList.assignAll(response.items!);
        } else {
          leadsTrashList.addAll(response.items!);
          allLeadsTrashList.addAll(response.items!);
        }
        meta.value = response.meta;
        hasError.value = false;
        errorMessage.value = '';
      } else {
        debugPrint('No items found in response');
        if (page == 1) {
          leadsTrashList.clear();
          allLeadsTrashList.clear();
        }
      }
    } catch (error) {
      // Clear lists on error (similar to CustomerCredentialScreen)
      if (page == 1) {
        leadsTrashList.clear();
        allLeadsTrashList.clear();
      }
      hasError.value = true;
      errorMessage.value = error.toString();
      debugPrint('Error fetching trash leads: $error');
      Utils.snackbarFailed('Failed to fetch leads: ${error.toString()}');
    } finally {
      if (page == 1) {
        loading.value = false;
      } else {
        isLoadingMore.value = false;
      }
    }
  }

  /// Refreshes the trash delete list by fetching the first page.
  Future<void> refresh() async {
    // Reset search and filters on refresh (like CustomerCredentialScreen)
    searchTerm.value = '';
    await fetchTrashDeleteList(forceRefresh: true, page: 1);
  }

  /// Loads more leads if available.
  Future<void> loadMoreLeads() async {
    if (isLoadingMore.value || loading.value) return;

    final currentPage = meta.value?.currentPage ?? 0;
    final totalPages = meta.value?.totalPages ?? 0;

    if (currentPage < totalPages) {
      await fetchTrashDeleteList(
        page: currentPage + 1,
        limit: meta.value?.itemsPerPage ?? 50,
        search: searchTerm.value.isNotEmpty ? searchTerm.value : null,
      );
    }
  }

  /// Checks if more leads can be loaded.
  bool get canLoadMore {
    if (meta.value == null) return false;
    return (meta.value!.currentPage ?? 0) < (meta.value!.totalPages ?? 0);
  }

  /// Searches for leads based on the provided search term.
  void searchLeads(String? search) {
    if (search == null || search.isEmpty) {
      searchTerm.value = '';
      // Reset to show all items
      return;
    }

    searchTerm.value = search;
    // For search, we don't make a new API call, just filter existing data
    // If you want to search on server side, uncomment the line below:
    // fetchTrashDeleteList(search: searchTerm.value, page: 1);
  }

  /// Apply filters (placeholder for future filter functionality)
  void applyFilters(Map<String, dynamic> filters) {
    appliedFilters = filters;
    debugPrint('Applied filters: $appliedFilters');
    fetchTrashDeleteList(forceRefresh: true);
  }

  /// Forces a refresh of the trash leads list.
  Future<void> forceRefresh() async {
    await refresh();
  }
}