import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/requestModels/customer/crendentials/CustomerCredentialsReqModel.dart';
import '../../../data/models/responseModels/customers/crendentials/CustomerCredentialsResModel.dart';
import '../../../data/repositories/repositories.dart';

class CustomerCredentialListViewModel extends GetxController {
  final Repositories _api = Repositories();
  final RxBool loading = false.obs;
  final RxList<Item> customerCrendItems = <Item>[].obs;
  final RxList<Item> allcustomerCrendItems = <Item>[].obs;
  Map<String, dynamic> appliedFilters = {};

  @override
  void onInit() {
    super.onInit();
    fetchCustomerCredential();
  }

  void applyFilters(Map<String, dynamic> filters) {
    appliedFilters = filters;
    print('Applied filters: $appliedFilters');
    fetchCustomerCredential(forceRefresh: true);
  }

  Future<void> fetchCustomerCredential({bool forceRefresh = false}) async {
    try {
      loading.value = true;
      if (forceRefresh) {
        customerCrendItems.clear();
        allcustomerCrendItems.clear();
      }

      final request = _createRequestModel();

      final CustomerCredentialsResModel response =
          await _api.customerCredentialsApi(request.toJson());

      if (response.items.isNotEmpty) {
        customerCrendItems.assignAll(response.items);
        allcustomerCrendItems.assignAll(response.items);
      } else {
        customerCrendItems.clear();
        allcustomerCrendItems.clear();
        debugPrint('No credential items found in response');
      }

      debugPrint('API Response items count: ${response.items.length}');
    } catch (error) {
      customerCrendItems.clear();
      allcustomerCrendItems.clear();
      debugPrint('Error fetching credential role: $error');
    } finally {
      loading.value = false;
    }
  }

  CustomerCredentialsReqModel _createRequestModel() {
    return CustomerCredentialsReqModel(
      search: "",
      range: null,
      limit: 30,
      page: 1,
      assignedTo: "",
      customerId: appliedFilters['search_customer'] ?? "",
    );
  }

  // void searchProformas(String query) {
  //   if (query.isEmpty) {
  //     customerProItems.assignAll(allCustomerProItems);
  //   } else {
  //     final filteredItems = allCustomerProItems.where((item) {
  //       final name = item.name?.toLowerCase() ?? '';
  //       final email = item.email?.toLowerCase() ?? '';
  //       final performaNumber = item.performaNumber?.toString() ?? '';
  //       final lowerQuery = query.toLowerCase();
  //       return name.contains(lowerQuery) ||
  //           email.contains(lowerQuery) ||
  //           performaNumber.contains(lowerQuery);
  //     }).toList();
  //     customerProItems.assignAll(filteredItems);
  //   }
  // }
}
