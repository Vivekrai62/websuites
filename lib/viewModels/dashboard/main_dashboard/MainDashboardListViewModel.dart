import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../data/models/requestModels/dashboardScreen/main_dashboard_screen/customer-reminders-chart/DashCusRemReqModel.dart';
import '../../../data/models/requestModels/dashboardScreen/main_dashboard_screen/get-user-effectivetime/DbTaskPerformanceReqModel.dart';
import '../../../data/models/requestModels/dashboardScreen/main_dashboard_screen/lead-reminders-chart/MainDashLeadRemindReqModel.dart';
import '../../../data/models/requestModels/dashboardScreen/main_dashboard_screen/lead_type/MainLeadTypeReqModel.dart';
import '../../../data/models/requestModels/dashboardScreen/main_dashboard_screen/leads-by-source-count/MainDashLeadSourceReqModel.dart';
import '../../../data/models/requestModels/dashboardScreen/main_dashboard_screen/payments-reminders-chart/DbPaymentReminderReqModel.dart';
import '../../../data/models/requestModels/dashboardScreen/main_dashboard_screen/project_reminder/ProjectReminderReqModel.dart';
import '../../../data/models/requestModels/dashboardScreen/main_dashboard_screen/project_status/ProjectStatusReqModel.dart';
import '../../../data/models/requestModels/dashboardScreen/main_dashboard_screen/sales_charts/SalesChartReqModel.dart';
import '../../../data/models/requestModels/dashboardScreen/main_dashboard_screen/task-status-chart/DashTaskStatusReqModel.dart';
import '../../../data/models/requestModels/dashboardScreen/main_dashboard_screen/transactions-chart/DbTransactionReqModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/List/MainDashboardChartsList.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/customer-reminders-chart/DashCusRemResModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/customer-status-chart/MainDashCustomerStatusResModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/get-user-effectivetime/DbTaskPerformanceResModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/lead-cards/MainDashLeadCardListRespoModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/lead-reminders-chart/MainDashLeadRemindResModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/lead_type/MainLeadTypeResModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/leads-by-source-count/MainDashLeadSourceResModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/payments-reminders-chart/DbPaymentReminderResModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/project_status/ProjectStatusResModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/projects-reminders-chart/ProjectReminderResModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/sales_charts/SalesChartResModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/task-status-chart/DashTaskStatusResModel.dart';
import '../../../data/models/responseModels/dashboard/main_dashboard/charts/transactions-chart/DbTransactionResModel.dart';
import '../../../utils/utils.dart';
import '../../../data/repositories/repositories.dart';
import '../../../resources/appUrls/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDashboardListViewModel extends GetxController {

  final RxString userName = ''.obs;
  final RxString mobile = ''.obs;
  final Repositories _api = Repositories();

  final RxBool isTeamFilter = true.obs;
  final RxString selectedDashboardName = ''.obs;
  final RxString selectedDashboardId = ''.obs;
  final RxBool loading = false.obs;
  final RxList<MainDashLeadSourceResModel> leadSources =
      <MainDashLeadSourceResModel>[].obs;
  final RxList<MainDashLeadCardListRespoModel> leadCards =
      <MainDashLeadCardListRespoModel>[].obs;
  final RxList<MainDashLeadRemindResModel> leadReminder =
      <MainDashLeadRemindResModel>[].obs;
  final RxList<MainDashCustomerStatusResModel> leadCustomer =
      <MainDashCustomerStatusResModel>[].obs;
  final RxList<DashCusRemResModel> leadCustomerReminder =
      <DashCusRemResModel>[].obs;
  final RxList<DashTaskStatusResModelDart> taskStatus =
      <DashTaskStatusResModelDart>[].obs;
  final Rx<DbProjecStatusResModel?> projectStatusData =
  Rx<DbProjecStatusResModel?>(null);
  final RxList<DbPaymentReminderResModel> paymentReminder =
      <DbPaymentReminderResModel>[].obs;
  final RxList<DbProjectReminderResModel> projectReminder =
      <DbProjectReminderResModel>[].obs;
  final RxList<SalesChartResModel> salesChart = <SalesChartResModel>[].obs;
  final RxList<DbTransactionResModel> transactionChart =
      <DbTransactionResModel>[].obs;
  final RxList<DbTaskPerformanceResModel> taskPerformance =
      <DbTaskPerformanceResModel>[].obs;
  final RxList<DbLeadTypeResModel> leadType = <DbLeadTypeResModel>[].obs;

  String? get currentUserId => selectedUserId.value;
  dynamic get currentDivision => selectedDivision.value;
  bool get currentTeamFilter => isTeamFilter.value;
  DateRanges? get currentDateRange => selectedDateRange.value;

  final Rx<MainDashboardChartsListResponseModel?> mainDashboardItem =
  Rx<MainDashboardChartsListResponseModel?>(null);
  final RxList<String> selectedDashboardCharts = <String>[].obs;
  final Rx<DateRanges?> selectedDateRange = Rx<DateRanges?>(null);
  final Rx<String?> selectedUserId = Rx<String?>(null);
  final Rx<dynamic> selectedDivision = Rx<dynamic>(null);

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  Future<void> fetchUserProfileData() async {
    userName.value = 'Loading...';
    mobile.value = '';
    try {
      final response = await _api.MainDashBoardListApi();
      userName.value = response.firstName ?? 'Unknown';
      mobile.value = response.mobile ?? ''; // Replace with correct field if different
    } catch (error) {
      _handleError(error, 'Failed to fetch user data');
      userName.value = 'Error';
      mobile.value = '';
    }
  }


  Future<void> _initializeData() async {
    ever(selectedDashboardCharts, (_) => update());
    await fetchDashboardData();
    await fetchLeadSourcesWithDynamicDate();
    await fetchLeadCards();
    await fetchLeadReminder();
    await fetchLeadCustomer();
    await fetchLeadCusReminder();
    await fetchTaskStatus();
    await fetchProjectStatus();
    await fetchPaymentReminder();
    await fetchProjectReminder();
    await fetchSalesChart();
    await fetchTransactionChart();
    await fetchTaskPerformance();
    await fetchLeadType();

    ever(selectedDashboardCharts, (_) => update());
    await fetchUserProfileData(); // Add fetchUserData to initialization



  }

  Map<String, dynamic> getFilterParams() {
    return {
      'filterUserId': currentUserId,
      'division': currentDivision,
      'isFilterUserWithTeam': currentTeamFilter,
      'dateRange': currentDateRange ?? _getDefaultDateRange(),
    };
  }

  Future<void> fetchLeadSourcesWithDynamicDate() async {
    final params = getFilterParams();
    final requestModel = MainDashLeadSourceReqModel(
      dateRange: params['dateRange'],
      division: params['division'],
      filterUserId: params['filterUserId'],
      isFilterUserWithTeam: params['isFilterUserWithTeam'],
    );

    await fetchLeadSources(requestModel);
  }

  Future<void> fetchLeadType() async {
    final params = getFilterParams();

    final DateTime toDate = DateTime.now();
    final DateTime fromDate = toDate.subtract(const Duration(days: 29));
    final requestModel = DbLeadTypeReqModel(
      dateRange: DateRangeLeadType(from: fromDate, to: toDate),
      division: params['division'],
      filterUserId: params['filterUserId'],
      isFilterUserWithTeam: params['isFilterUserWithTeam'],
      // division: selectedDivision.value,
      // filterUserId: selectedUserId.value,
      // isFilterUserWithTeam: isTeamFilter.value,
    );

    try {
      loading(true);
      final response = await _api.dbLeadTypeApi(requestModel);
      print("lead type chart: $response");

      if (response is List) {
        leadType.clear();
        leadType.addAll(
            response.map((item) => DbLeadTypeResModel.fromJson(item)).toList());
      } else {
        print('Unexpected response format: $response');
        throw Exception('Invalid response format');
      }
    } catch (error) {
      _handleError(error, 'Failed to fetch lead type');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchLeadSources(MainDashLeadSourceReqModel requestModel) async {
    try {
      loading(true);
      final response = await _api.dbLeadsSourceApi(requestModel);
      if (response is List) {
        leadSources.assignAll(response
            .map((item) => MainDashLeadSourceResModel.fromJson(item))
            .toList());
      }
    } catch (error) {
      _handleError(error, 'Failed to fetch lead sources');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchLeadCards() async {
    final requestModel = MainDashLeadSourceReqModel(
      dateRange: selectedDateRange.value,
      division: selectedDivision.value,
      filterUserId: selectedUserId.value,
      isFilterUserWithTeam: isTeamFilter.value,
    );

    try {
      loading(true);
      final response = await _api.dbLeadCardApi(requestModel);

      if (response is Map<String, dynamic>) {
        final leadCard = MainDashLeadCardListRespoModel.fromJson(response);
        leadCards.clear();
        leadCards.add(leadCard);
      }
    } catch (error) {
      _handleError(error, 'Failed to fetch lead cards');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchLeadReminder() async {
    final requestModel = MainDashLeadRemindReqModel(
      dateRange: DateRng(from: '', to: ''),
      division: selectedDivision.value,
      filterUserId: selectedUserId.value ?? '',
      isFilterUserWithTeam: isTeamFilter.value,
    );

    try {
      loading(true);
      final response = await _api.dbLeadReminderApi(requestModel);

      if (response is Map<String, dynamic>) {
        final leadRemin = MainDashLeadRemindResModel.fromJson(response);
        leadReminder.clear();
        leadReminder.add(leadRemin);
      }
    } catch (error) {
      _handleError(error, 'Failed to fetch lead reminder');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchLeadCusReminder() async {
    final requestModel = DashCusRemReqModel(
      division: selectedDivision.value,
      filterUserId: selectedUserId.value,
      isFilterUserWithTeam: isTeamFilter.value,
    );

    try {
      loading(true);
      final response = await _api.dbCustomerReminderApi(requestModel);

      if (response is List) {
        leadCustomerReminder.assignAll(
            response.map((item) => DashCusRemResModel.fromJson(item)).toList());
      } else if (response is Map<String, dynamic>) {
        final leadCusReminder = DashCusRemResModel.fromJson(response);
        leadCustomerReminder.clear();
        leadCustomerReminder.add(leadCusReminder);
        // Utils.snackbarSuccess('Customer Lead Reminder fetched');
        // print(leadCustomerReminder);
        // print("Customer Lead Reminder fetched");
      }
    } catch (error) {
      _handleError(error, 'Failed to fetch lead customer reminders');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchProjectStatus() async {
    final DateTime toDate = DateTime.now();
    final DateTime fromDate = toDate.subtract(const Duration(days: 29));
    final requestModel = DbProjecStatusReqModel(
      filterUserId: selectedUserId.value,
      division: selectedDivision.value,
      isFilterUserWithTeam: isTeamFilter.value,
      dateRange: DateProjectStatus(from: fromDate, to: toDate),
    );

    try {
      loading(true);
      final response = await _api.dbProjectStatusApi(requestModel);
      // print("Project Status Response: $response");

      if (response is Map<String, dynamic>) {
        final projectStatus = DbProjecStatusResModel.fromJson(response);
        projectStatusData.value = projectStatus;
      } else {
        // print('Unexpected response format: $response');
        throw Exception('Invalid response format');
      }
    } catch (error) {
      _handleError(error, 'Failed to fetch project status');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchLeadCustomer() async {
    final requestModel = MainDashCustomerStatusReqModel(
      dateRange: DateRange(
          from: '2025-01-04 00:00:00.000', to: '2025-02-05 23:59:59.999'),
      division: selectedDivision.value,
      filterUserId: selectedUserId.value ?? 'Not avaialable',
      isFilterUserWithTeam: isTeamFilter.value,
    );

    try {
      loading(true);
      final response = await _api.dbCustomerApi(requestModel);

      if (response is Map<String, dynamic>) {
        final leadCustm = MainDashCustomerStatusResModel.fromJson(response);
        leadCustomer.clear();
        leadCustomer.add(leadCustm);
      }
    } catch (error) {
      _handleError(error, 'Failed to fetch lead customer status');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchTaskStatus() async {
    final requestModel = DashTaskStatusReqModel(
      dateRange: DateRangeTaskStatus(from: '', to: ''),
      division: selectedDivision.value,
      filterUserId: selectedUserId.value ?? 'Not avaialable ji Bikku ji',
      isFilterUserWithTeam: isTeamFilter.value,
    );

    try {
      loading(true);
      final response = await _api.dbTaskStatusApi(requestModel);

      if (response is Map<String, dynamic>) {
        // print("Raw Task Status Response: $response");
        final taskStat = DashTaskStatusResModelDart.fromJson(response);
        taskStatus.clear();
        taskStatus.add(taskStat);
        // print("Updated Task Status: ${taskStatus.length}");
      }
    } catch (error) {
      // print("Task Status Error: $error");
      _handleError(error, 'Failed to fetch task status');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchPaymentReminder() async {
    final requestModel = DbPaymentReminderReqModel(
      filterUserId: selectedUserId.value,
      division: selectedDivision.value,
      isFilterUserWithTeam: isTeamFilter.value,
    );

    try {
      loading(true);
      final response = await _api.dbPaymentReminderApi(requestModel);
      // print("payment reminder: $response");

      if (response is Map<String, dynamic>) {
        final paymentReminderData =
        DbPaymentReminderResModel.fromJson(response);
        paymentReminder.clear();
        paymentReminder.add(paymentReminderData);
      } else {
        // print('Unexpected response format: $response');
        throw Exception('Invalid response format');
      }
    } catch (error) {
      _handleError(error, 'Failed to fetch payment reminder');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchProjectReminder() async {
    final requestModel = ProjectReminderReqModel(
      filterUserId: selectedUserId.value,
      division: selectedDivision.value,
      isFilterUserWithTeam: isTeamFilter.value,
    );

    try {
      loading(true);
      final response = await _api.dbProjectReminderApi(requestModel);
      // print("Project reminder: $response");

      if (response is Map<String, dynamic>) {
        final projectReminderData =
        DbProjectReminderResModel.fromJson(response);
        projectReminder.clear();
        projectReminder.add(projectReminderData);
      } else {
        // print('Unexpected response format: $response');
        throw Exception('Invalid response format');
      }
    } catch (error) {
      _handleError(error, 'Failed to fetch project reminder');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchSalesChart() async {
    final DateTime toDate = DateTime.now();
    final DateTime fromDate = toDate.subtract(const Duration(days: 29));
    final requestModel = SalesChartReqModel(
      dateRange: DateRangeSalesChart(from: fromDate, to: toDate),
      filterUserId: selectedUserId.value,
      division: selectedDivision.value,
      isFilterUserWithTeam: isTeamFilter.value,
    );

    try {
      loading(true);
      final response = await _api.dbSalesChartApi(requestModel);
      // print("sales chart: $response");

      if (response is Map<String, dynamic>) {
        final salesCharts = SalesChartResModel.fromJson(response);
        salesChart.clear();
        salesChart.add(salesCharts);
      } else {
        // print('Unexpected response format: $response');
        throw Exception('Invalid response format');
      }
    } catch (error) {
      _handleError(error, 'Failed to fetch sales chart');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchTransactionChart() async {
    final requestModel = DbTransactionReqModel(
      filterUserId: selectedUserId.value,
      division: selectedDivision.value,
      isFilterUserWithTeam: isTeamFilter.value,
    );

    try {
      loading(true);
      final response = await _api.dbTransactionChartApi(requestModel);
      // print("transaction chart: $response");

      if (response is Map<String, dynamic>) {
        final transactionChartsData = DbTransactionResModel.fromJson(response);
        transactionChart.clear();
        transactionChart.add(transactionChartsData);
      } else {
        // print('Unexpected response format: $response');
        throw Exception('Invalid response format');
      }
    } catch (error) {
      _handleError(error, 'Failed to fetch transaction chart');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchTaskPerformance() async {
    final DateTime toDate = DateTime.now();
    final requestModel = DbTaskPerformanceReqModel(
      date: toDate,
      filterUserId: selectedUserId.value,
      isFilterUserWithTeam: isTeamFilter.value,
    );

    try {
      loading(true);
      final response = await _api.dbTaskPerformanceApi(requestModel);
      // print("task performance chart: $response");

      if (response is Map<String, dynamic>) {
        final taskPerformanceData =
        DbTaskPerformanceResModel.fromJson(response);
        taskPerformance.clear();
        taskPerformance.add(taskPerformanceData);
      } else {
        // print('Unexpected response format: $response');
        throw Exception('Invalid response format');
      }
    } catch (error) {
      _handleError(error, 'Failed to fetch task performance');
    } finally {
      loading(false);
    }
  }

  Future<void> fetchDashboardData() async {
    // print("🚀 fetchDashboardData called");
    if (loading.value) {
      // print("⚠️ Already loading, returning early");
      return;
    }

    try {
      loading(true);
      // print("🔍 Starting fetchDashboardData...");
      // print("🔍 API URL: ${AppUrls.dashboard}");

      // Check if user is authenticated
      final sp = await SharedPreferences.getInstance();
      String? token = sp.getString('accessToken');
      // print("🔍 Authentication Token: ${token != null ? "Present" : "Missing"}");

      if (token == null) {
        // print("❌ No authentication token found");
        _handleError("No authentication token", "User not authenticated");
        return;
      }

      // print("🔍 About to call MainDashBoardListApi...");
      final response = await _api.MainDashBoardListApi();
      // print("✅ API Response received: $response");
      // print("✅ Response type: ${response.runtimeType}");

      mainDashboardItem.value = response;

      // Debug response structure
      // print("🔍 Response structure analysis:");
      // print("🔍 - Role list length: ${response.roleList.length}");
      if (response.roleList.isNotEmpty) {
        // print("🔍 - First role name: ${response.roleList[0].name}");
        // print(
        //     "🔍 - First role dashboards length: ${response.roleList[0].dashboards.length}");
        // print("🔍 - First role dashboards: ${response.roleList[0].dashboards}");
      }
      // print("🔍 - Charts length: ${response.charts.length}");
      // print("🔍 - Charts content: ${response.charts}");

      // Check if user has dashboards configured in role_list
      if (response.roleList.isNotEmpty &&
          response.roleList[0].dashboards.isNotEmpty) {
        // print("✅ Using dashboards from role_list");
        // print("✅ User info - First Name: ${response.firstName}");
        // print("✅ User info - Email: ${response.email}");
        // print("✅ Role list length: ${response.roleList.length}");
        // print("✅ Dashboards length: ${response.roleList[0].dashboards.length}");

        final dashboard = response.roleList[0].dashboards[0];
        selectedDashboardCharts.value = dashboard.charts;
        selectedDashboardName.value = dashboard.name ?? '';
        selectedDashboardId.value = dashboard.id ?? '';

        // print("✅ Selected dashboard name: ${selectedDashboardName.value}");
        // print("✅ Selected dashboard charts: ${selectedDashboardCharts.value}");
      } else if (response.charts.isNotEmpty) {
        // Fallback: Use the charts array directly from the user response
        // print("✅ Using charts from user response directly (fallback)");
        // print("✅ User info - First Name: ${response.firstName}");
        // print("✅ User info - Email: ${response.email}");
        // print("✅ Charts length: ${response.charts.length}");

        selectedDashboardCharts.value = response.charts;
        selectedDashboardName.value = 'Default Dashboard';
        selectedDashboardId.value = response.id ?? '';

        // print("✅ Selected dashboard name: ${selectedDashboardName.value}");
        // print("✅ Selected dashboard charts: ${selectedDashboardCharts.value}");
      } else {
        // print("⚠️ No role list, dashboards, or charts found in response");
        // print("⚠️ Role list length: ${response.roleList.length}");
        if (response.roleList.isNotEmpty) {
          // print(
          //     "⚠️ First role dashboards length: ${response.roleList[0].dashboards.length}");
        }
        // print("⚠️ Charts length: ${response.charts.length}");

        // Set default charts if nothing is available
        selectedDashboardCharts.value = [
          "lead_cards",
          "lead_types_chart",
          "lead_reminders_chart",
          "lead_sources_chart",
          "customer_status_chart",
          "customer_reminders_chart",
          "payment_reminders_chart",
          "task_status_chart",
          "project_status_chart",
          "project_reminders_chart",
          "sales_chart",
          "transactions_chart",
          "effective_hours"
        ];
        selectedDashboardName.value = 'Default Dashboard';
        selectedDashboardId.value = response.id ?? '';

        // print("✅ Using default charts as fallback");
        // print("✅ Selected dashboard charts: ${selectedDashboardCharts.value}");
      }
    } catch (error) {
      // print("❌ Error in fetchDashboardData: $error");
      // print("❌ Error type: ${error.runtimeType}");
      // _handleError(error, 'Failed to fetch dashboard data');
    } finally {
      loading(false);
      // print("🏁 fetchDashboardData completed");
    }
  }

  void _handleError(dynamic error, String message) {
    if (kDebugMode) {
      // print('Error: $error');
    }
    Utils.snackbarFailed(message);
  }

  void applyFilters({
    String? userId,
    dynamic division,
    bool? isTeam,
    DateRanges? dateRange,
  }) {
    if (userId != null) selectedUserId.value = userId;
    if (division != null) selectedDivision.value = division;
    if (isTeam != null) isTeamFilter.value = isTeam;
    if (dateRange != null) selectedDateRange.value = dateRange;

    // Refresh all data with current filter values
    refreshAllData();
    // selectedUserId.value = userId;
    // selectedDivision.value = division;
    // isTeamFilter.value = isTeam ?? false;
    // selectedDateRange.value = dateRange;

    // fetchDashboardData();
    // fetchLeadSourcesWithDynamicDate();
    // fetchLeadCards();
    // fetchLeadReminder();
    // fetchLeadCustomer();
    // fetchLeadCusReminder();
    // fetchTaskStatus();
    // fetchProjectStatus();
    // fetchPaymentReminder();
    // fetchProjectReminder();
    // fetchSalesChart();
    // fetchTransactionChart();
    // fetchTaskPerformance();
    // fetchLeadType();
  }

  Future<void> refreshAllData() async {
    loading(true);
    try {
      await Future.wait([
        fetchDashboardData(),
        fetchLeadSourcesWithDynamicDate(),
        fetchLeadCards(),
        fetchLeadReminder(),
        fetchLeadCustomer(),
        fetchLeadCusReminder(),
        fetchTaskStatus(),
        fetchProjectStatus(),
        fetchPaymentReminder(),
        fetchProjectReminder(),
        fetchSalesChart(),
        fetchTransactionChart(),
        fetchTaskPerformance(),
        fetchLeadType(),
      ]);
    } finally {
      loading(false);
    }
  }

  void resetFilters() {
    selectedUserId.value = null;
    selectedDivision.value = null;
    isTeamFilter.value = true;
    selectedDateRange.value = null;

    refreshAllData();
  }

  DateRanges _getDefaultDateRange() {
    final DateTime now = DateTime.now();
    return DateRanges(
      from: now.subtract(const Duration(days: 30)),
      to: now,
    );
  }
}
