import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../viewModels/leadScreens/lead_activity/lead_reports/lead_reports.dart';

import 'leadrepoertCard/LeadActivitiesReportCard.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadReportScreen extends StatelessWidget {
  final LeadActivityLeadReportViewModel leadactivitiesreport;
  const LeadReportScreen({super.key, required this.leadactivitiesreport});

  // Use the controller to fetch lead reports
  // final LeadActivityLeadReportViewModel controller = Get.put(LeadActivityLeadReportViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Show loading indicator while fetching data
      if (leadactivitiesreport.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Check if there are any leads available
      if (leadactivitiesreport.leads.isEmpty) {
        return const Center(child: Text("No leads found"));
      }

      // Display the fetched leads in a list
      return ListView.builder(
        itemCount: leadactivitiesreport.leads.length,
        itemBuilder: (context, index) {
          return LeadActivityCard(lead: leadactivitiesreport.leads[index]);
        },
      );
    });
  }
}
