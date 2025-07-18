import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../data/repositories/repositories.dart';
import 'package:websuites/data/models/requestModels/report/employeeReport/ReportEmployeeReportReqModel.dart';

import '../../../data/models/responseModels/reports/employeeReport/ReportEmployeeResModel.dart';

class ReportEmployeeViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<ReportEmployeeReportResModel> employeeDataList = <ReportEmployeeReportResModel>[].obs;

  ReportEmployeeReportReqModel reportEmployeeReq = ReportEmployeeReportReqModel(
    page: 1,
    limit: 15,
    dateRange: DateRange(
      from: "2025-04-09 00:00:00.000",
      to: "2025-04-09 23:59:59.999",
    ),
    isWithTeam: true,
    reportOn: null,
    userId: null,
  );

  Future<void> fetchEmployeeReports(BuildContext context) async {
    loading.value = true;
    try {
      ReportEmployeeReportResModel response = await _api.reportEmployee(reportEmployeeReq.toJson());
      employeeDataList.assignAll([response]); // Wrap in a list for consistency
    } catch (error) {
      print('Error fetching employee reports: $error');
      employeeDataList.clear();
    } finally {
      loading.value = false;
    }
  }
}
