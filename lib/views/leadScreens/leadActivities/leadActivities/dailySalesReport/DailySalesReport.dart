// DailySalesReportScreen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../viewModels/leadScreens/lead_activity/daily_sales_reports/daily_sales_reports.dart';
import 'dailyreportcard/SalesPersonCard.dart';

class DailySalesReportScreen extends StatelessWidget {
  const DailySalesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DailySalesReportsViewModel viewModel =
        Get.put(DailySalesReportsViewModel());

    // Call the API only if data hasn't been loaded yet
    if (viewModel.salesPeople.isEmpty) {
      viewModel.dailySalesReports();
    }

    return Obx(() {
      if (viewModel.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: () async {
          // Reload data manually on pull-to-refresh
          viewModel.salesPeople.clear(); // Clear data before refreshing
          await viewModel.dailySalesReports();
        },
        child: ListView.builder(
          itemCount: viewModel.salesPeople.length,
          itemBuilder: (context, index) {
            return SalesPersonCard(salesPerson: viewModel.salesPeople[index]);
          },
        ),
      );
    });
  }
}
