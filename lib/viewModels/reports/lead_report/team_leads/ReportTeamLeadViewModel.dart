import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../data/models/requestModels/report/leadReport/team_leads/ReportTeamLeadReqModel.dart' as report;
import '../../../../data/models/responseModels/reports/leadReport/team_leads/TeamLeadResponseModel.dart';

class ReportTeamLeadViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<TeamLeadResponseModel> teamLeadDataList = <TeamLeadResponseModel>[].obs;

  // Using DateRange from report.TeamLeadReqModel
  report.TeamLeadReqModel leadUnique = report.TeamLeadReqModel(
    dateRange: report.DateRange(
      from: "2024-08-14 00:00:00.000",
      to: "2024-11-14 23:59:59.999",
    ),
  );

  // If you still need a single selected item, keep this; otherwise, remove it
  Rx<TeamLeadResponseModel> leadTeamLeadResponse = Rx(TeamLeadResponseModel(user: null, leadType: [], total: null));

  Future<void> leadTeamLead(BuildContext context) async {
    loading.value = true;
    try {
      // Assuming _api.leadTeamLead returns a List<dynamic> (JSON array)
      var response = await _api.leadTeamLead(leadUnique.toJson());

      // Parse the list response using the static method you added
      List<TeamLeadResponseModel> parsedList = TeamLeadResponseModel.fromJsonList(response);

      // Clear and update the RxList
      teamLeadDataList.clear();
      teamLeadDataList.addAll(parsedList);

      // If you want to set leadTeamLeadResponse to the first item (optional)
      if (parsedList.isNotEmpty) {
        leadTeamLeadResponse.value = parsedList.first;
      }

      print('Team Lead Data: ${teamLeadDataList.map((e) => e.toJson()).toList()}');
    } catch (error) {
      print('Error fetching team lead data: ${error.toString()}');
    } finally {
      loading.value = false;
    }
  }
}