import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
import '../../../data/models/requestModels/project/list/project_list_request_model.dart';
import '../../../data/models/responseModels/projects/list/projects_list_response_model.dart';

class ProjectListViewModel extends GetxController {
  final _api = Repositories();

  // Observable states
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxList<Item> projectList = <Item>[].obs; // Changed from ProjectItem to Item

  Rx<Meta?> meta = Rx<Meta?>(null);
  RxString errorMessage = ''.obs;

  static const int itemsPerPage = 15;

  // Initialize with default filters
  final _defaultFilters = ProjectListRequest(
    page: 1,
    limit: itemsPerPage,
    range: null,
    customer: null,
    billingType: null,
    subActivity: null,
    tags: [],
    divisionId: null,
    isFilterMemberWithTeam: true,
    member: null,
    sort: Sort(q: null, sortBy: "ASC"),
    status: null,
  );

  // Fetch initial project customer_list
  Future<void> fetchProjectList(BuildContext context) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _api.projectList(_defaultFilters.toJson());

      if (kDebugMode) {
        print("API Response: $response");
      }

      if (response.items.isNotEmpty ?? false) {
        projectList.assignAll(response.items);
      } else {
        projectList.clear();
        meta.value = null;
        Utils.snackbarFailed('No projects available');
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error details: $error");
      }
      _handleError('Failed to fetch projects', error);
    } finally {
      isLoading.value = false;
    }
  }

  // Load next page of projects
  Future<void> loadNextPage(BuildContext context) async {
    if (isLoadingMore.value || !_canLoadMore()) return;

    try {
      isLoadingMore.value = true;
      errorMessage.value = '';

      final nextPage = (meta.value?.currentPage ?? 0) + 1;
      final nextPageRequest = ProjectListRequest(
        page: nextPage,
        limit: itemsPerPage,
        range: _defaultFilters.range,
        customer: _defaultFilters.customer,
        billingType: _defaultFilters.billingType,
        subActivity: _defaultFilters.subActivity,
        tags: _defaultFilters.tags,
        divisionId: _defaultFilters.divisionId,
        isFilterMemberWithTeam: _defaultFilters.isFilterMemberWithTeam,
        member: _defaultFilters.member,
        sort: _defaultFilters.sort,
        status: _defaultFilters.status,
      );

      final response = await _api.projectList(nextPageRequest.toJson());

      if (response.items.isNotEmpty ?? false) {
        projectList.addAll(response.items); // Use addAll to append the items
      }

      meta.value = response.meta;
    } catch (error) {
      _handleError('Failed to load more projects', error);
    } finally {
      isLoadingMore.value = false;
    }
  }

  // Refresh project customer_list
  Future<void> refreshList(BuildContext context) async {
    projectList.clear();
    meta.value = null;
    errorMessage.value = '';
    await fetchProjectList(context);
  }

  // Helper methods
  bool _canLoadMore() {
    if (meta.value == null) return false;
    return (meta.value?.currentPage ?? 0) < (meta.value?.totalPages ?? 0);
  }

  void _handleError(String message, dynamic error) {
    errorMessage.value = message;
    if (kDebugMode) {
      print('$message: ${error.toString()}');
    }
    Utils.snackbarFailed(message);
  }

  // Getters
  bool get hasMore => _canLoadMore();
}
