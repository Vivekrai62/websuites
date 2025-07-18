import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/repositories/repositories.dart';
import '../../../data/models/requestModels/report/products_wise_sale_reports/recurringServices/ReportRecurringServicesReqModel.dart';
import '../../../data/models/responseModels/reports/recurringServices/ReportRecurrigServicesResModel.dart';

class ReportRecurringServicesViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<ReportRecurringServicesResModel> reportRecurringServiceItems =
      <ReportRecurringServicesResModel>[].obs;

  ReportRecurringServicesReqModel reportRecurringServicesReqModel =
      ReportRecurringServicesReqModel(
    dateRange: null,
    expiredDaysAgo: null,
    statusType: null,
    expiringInDays: null,
    range: null,
    search: null,
    limit: 15,
    page: 1,
  );

  void resetRequestModel() {
    reportRecurringServicesReqModel = ReportRecurringServicesReqModel(
      dateRange: null,
      expiredDaysAgo: null,
      statusType: null,
      expiringInDays: null,
      range: null,
      search: null,
      limit: 15,
      page: 1,
    );
  }

  Future<void> fetchReportRecurringServices(BuildContext context,
      {bool forceRefresh = false}) async {
    loading.value = true;
    if (forceRefresh) {
      reportRecurringServiceItems.clear(); // Clear data for refresh
    }
    print(
        'Fetching recurring services with request: ${reportRecurringServicesReqModel.toJson()}');
    try {
      ReportRecurringServicesResModel response = await _api
          .reportRecurringServices(reportRecurringServicesReqModel.toJson());
      print('API response received with success: ${response.success}');
      reportRecurringServiceItems.clear();
      reportRecurringServiceItems.add(response);
    } catch (error) {
      print('Error fetching recurring services reports: $error');
      reportRecurringServiceItems.clear();
    } finally {
      loading.value = false;
      print(
          'RecurringServiceItems updated with ${reportRecurringServiceItems.length} items');
    }
  }

  void applyFilters(Map<String, dynamic> filters) {
    resetRequestModel();
    if (filters.containsKey('date_range')) {
      reportRecurringServicesReqModel.dateRange = filters['date_range'];
    }
    if (filters.containsKey('search')) {
      reportRecurringServicesReqModel.search = filters['search'];
    }
    if (filters.containsKey('status_type')) {
      reportRecurringServicesReqModel.statusType = filters['status_type'];
    }
    if (filters.containsKey('expiring_in_days')) {
      reportRecurringServicesReqModel.expiringInDays =
          filters['expiring_in_days'];
    }
    if (filters.containsKey('expired_days_ago')) {
      reportRecurringServicesReqModel.expiredDaysAgo =
          filters['expired_days_ago'];
    }
    fetchReportRecurringServices(Get.context!, forceRefresh: true);
  }

  void searchServices(String query) {
    resetRequestModel();
    reportRecurringServicesReqModel.search = query.isNotEmpty ? query : null;
    fetchReportRecurringServices(Get.context!, forceRefresh: true);
  }
}
