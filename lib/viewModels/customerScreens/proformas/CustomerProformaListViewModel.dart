import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../../data/models/requestModels/customer/proformas/CustomerProformasReqModel.dart';
import '../../../data/models/responseModels/customers/proformas/CustomerProformasResModel.dart';
import '../../../data/models/responseModels/customers/proformas/view/proforma_view_res_model.dart';
import '../../../data/repositories/repositories.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class CustomerProformaListViewModel extends GetxController {
  final Repositories _api = Repositories();
  final RxBool loading = false.obs;
  final RxList<Items> customerProItems = <Items>[].obs;
  final RxList<Items> allCustomerProItems = <Items>[].obs;
  Map<String, dynamic> appliedFilters = {};

  @override
  void onInit() {
    super.onInit();
    fetchCustomerProformas();
  }

  void applyFilters(Map<String, dynamic> filters) {
    appliedFilters = filters;
    // print('Applied filters: $appliedFilters');
    fetchCustomerProformas(forceRefresh: true);
  }

  Future<void> fetchCustomerProformas({bool forceRefresh = false}) async {
    try {
      loading.value = true;
      if (forceRefresh) {
        customerProItems.clear();
        allCustomerProItems.clear();
      }

      final request = _createRequestModel();

      final CustomerProformasResModel response =
      await _api.customerProformasApi(request.toJson());

      if (response.items != null && response.items!.isNotEmpty) {
        customerProItems.assignAll(response.items!);
        allCustomerProItems.assignAll(response.items!);
      } else {
        customerProItems.clear();
        allCustomerProItems.clear();
        // debugPrint('No proforma items found in response');
      }

      // debugPrint('API Response items count: ${response.items?.length}');
    } catch (error) {
      customerProItems.clear();
      allCustomerProItems.clear();
      // debugPrint('Error fetching proforma role: $error');
    } finally {
      loading.value = false;
    }
  }

  CustomerProformasReqModel _createRequestModel() {
    return CustomerProformasReqModel(
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
      customerProItems.assignAll(allCustomerProItems);
    } else {
      final filteredItems = allCustomerProItems.where((item) {
        final name = item.name?.toLowerCase() ?? '';
        final email = item.email?.toLowerCase() ?? '';
        final performaNumber = item.performaNumber?.toString() ?? '';
        final lowerQuery = query.toLowerCase();
        return name.contains(lowerQuery) ||
            email.contains(lowerQuery) ||
            performaNumber.contains(lowerQuery);
      }).toList();
      customerProItems.assignAll(filteredItems);
    }
  }
}








