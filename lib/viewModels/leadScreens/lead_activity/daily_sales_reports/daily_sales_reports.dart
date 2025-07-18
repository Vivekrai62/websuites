import 'package:get/get.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../data/models/requestModels/lead/activity/daily_sales_reports/daily_sales_reports.dart';
import '../../../../views/leadScreens/leadActivities/leadActivities/dailySalesReport/dailyreportcard/SalesPersonCard.dart';

class DailySalesReportsViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<SalesPerson> salesPeople = <SalesPerson>[].obs;

  // Fetch the daily sales reports
  Future<void> dailySalesReports() async {
    // Load data only if salesPeople is empty
    if (salesPeople.isNotEmpty) return;

    final dailySalesReportRequestModel = DailySalesReportRequestModel(
      dateRange: DateRanges(
        from: "2024-10-24 00:00:00.000",
        to: "2024-10-24 23:59:59.999",
      ),
      limit: 15,
      page: 1,
      userId: "",
    );

    loading.value = true;
    try {
      final response = await _api
          .dailySalesReportList(dailySalesReportRequestModel.toJson());

      if (response.items != null && response.items!.isNotEmpty) {
        salesPeople.clear();
        salesPeople.addAll(response.items!.map((item) => SalesPerson(
              name: item.name ?? item.mobile ?? 'Not Available',
              email: item.email ?? 'Not Available',
              answered: item.activities?.calls?.details?.answered?.count ?? 0,
              notAnswered:
                  item.activities?.calls?.details?.notAnswered?.count ?? 0,
              wrongNumber:
                  item.activities?.calls?.details?.wrongNumber?.count ?? 0,
              numberBusy:
                  item.activities?.calls?.details?.numberBusy?.count ?? 0,
              physicalMeeting: item.activities?.meetings?.count ?? 0,
              virtualMeeting: 0,
              total: (item.activities?.calls?.details?.answered?.count ?? 0) +
                  (item.activities?.calls?.details?.notAnswered?.count ?? 0) +
                  (item.activities?.calls?.details?.wrongNumber?.count ?? 0) +
                  (item.activities?.calls?.details?.numberBusy?.count ?? 0),
              totalMeeting: item.activities?.meetings?.count ?? 0,
            )));
        // Utils.snackbarSuccess('Lead Activity Daily Sale Reports successfully');
      } else {
        // Utils.snackbarFailed('No leads found');
      }
    } catch (e) {
      // Utils.snackbarFailed('Failed to fetch leads');
      print('Error: $e');
    } finally {
      loading.value = false;
    }
  }
}
