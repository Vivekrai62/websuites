import 'package:get/get.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../data/models/requestModels/lead/activity/lead_reports/lead_reports.dart';
import '../../../../views/leadScreens/leadActivities/leadActivities/leadReport/leadrepoertCard/LeadActivitiesReportCard.dart';

class LeadActivityLeadReportViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  // Use RxList to dynamically update the UI when data changes
  RxList<LeadActivitiesCard> leads = <LeadActivitiesCard>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeadReports(); // Fetch the data when the controller is initialized
  }

  // Fetch lead reports from the API
  Future<void> fetchLeadReports() async {
    loading.value = true;

    LeadReportsRequestModel leadReportsRequestModel = LeadReportsRequestModel(
      dateRange: DateRange(
        from: "2024-08-14 00:00:00.000",
        to: "2024-11-14 23:59:59.999",
      ),
      limit: 10,
      page: 2,
      userId: "",
    );

    _api
        .leadActivityLeadReports(leadReportsRequestModel.toJson())
        .then((response) {
      loading.value = false;

      if (response.items != null && response.items!.isNotEmpty) {
        // Clear existing leads and add new ones from the API response
        leads.clear();

        for (var item in response.items!) {
          // Map the response data to LeadActivitiesCard
          leads.add(LeadActivitiesCard(
            name: item.name ?? 'Not Available',
            email: item.email ?? 'Not Available',
            phoneNumber: item.mobile ?? 'Not Available',
            calls: item.activities?.calls?.count ?? 0,
            total: item.activities?.calls?.count ?? 0,
            notAnsweredCalls: item.activities?.calls?.details?.notAnswered ?? 0,
            meetings: item.activities?.meetings?.count ?? 0,
            totals: item.activities?.meetings?.count ?? 0,
            physicalMeetings: item.activities?.meetings?.details?.physical ?? 0,
          ));
        }

        // Utils.snackbarSuccess('Lead Reports List fetched successfully');
      } else {
        // Utils.snackbarFailed('No leads found');
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      // Utils.snackbarFailed('Failed to fetch leads');
      print('Error: $error');
    });
  }
}
