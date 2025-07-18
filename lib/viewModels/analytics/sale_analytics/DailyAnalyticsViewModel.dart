import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../data/models/requestModels/analytics/sale_analytics/DailyAnalyticsRequestModel.dart';
import '../../../data/models/responseModels/analytics/sale_analytics/DailyAnalyticsResponseModel.dart';

class DailyAnalyticsViewModel extends GetxController {
  final Repositories api = Repositories();
  RxBool loading = false.obs;

  RxList<DailyAnalyticsResponseModel> analyticsData =
      RxList<DailyAnalyticsResponseModel>();

  Future<void> dailyAnalyticsListApi(BuildContext context) async {
    try {
      loading.value = true;

      DailyAnalyticsRequestModel dailyAnalyticsRequest =
          DailyAnalyticsRequestModel(
              month: null, year: null, date: "2024-12-02");

      final response =
          await api.dailyAnalyticsListApi(dailyAnalyticsRequest.toJson());

      if (response.isNotEmpty) {
        analyticsData.value = response;

        // Debug print
        if (kDebugMode) {
          // print("Daily Analytics Response: ${response.toString()}");
        }

        // Utils.snackbarSuccess('Analytics data fetched successfully');
      } else {
        // Utils.snackbarFailed('Failed to fetch analytics data');
      }
    } catch (error) {
      if (kDebugMode) {
        // print("Error: $error");
        // print("Stack Trace: $stackTrace");
      }
      // Utils.snackbarFailed('Error fetching analytics data: ${error.toString()}');
    } finally {
      loading.value = false;
    }
  }

  String? get name => analyticsData.isNotEmpty ? analyticsData[0].name : null;

  int? get approvedAmount =>
      analyticsData.isNotEmpty ? analyticsData[0].approvedAmount : null;

  int? get totalAmount =>
      analyticsData.isNotEmpty ? analyticsData[0].totalAmount : null;

  int? get totalOrders =>
      analyticsData.isNotEmpty ? analyticsData[0].totalOrders : null;
}
