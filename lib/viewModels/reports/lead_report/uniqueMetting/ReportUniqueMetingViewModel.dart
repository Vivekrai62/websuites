import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/repositories/repositories.dart';
import '../../../../data/models/requestModels/report/leadReport/uniqueMetting/ReportUniqueReqModel.dart';
import '../../../../data/models/responseModels/reports/leadReport/uniqueMetting/ReportUniqueResModel.dart';

class ReportUniqueMetingViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<ReportUniqueResModel> uniqueDataList = <ReportUniqueResModel>[].obs;

  // Define the leadActivity property
  ReportUniqueReqModel leadUnique = ReportUniqueReqModel(
    dateRange: null,
    limit: 15,
    page: 1,
    assignedTo: null,
    isFilterUserWithTeam: false,
  );

  Rx<ReportUniqueResModel> leadUniqueResponse = Rx(ReportUniqueResModel());

  Future<void> leadUniqueMeetingList(BuildContext context) async {
    loading.value = true; // Start loading
    try {
      var response = await _api.leadUniqueMeetingList(leadUnique.toJson());
      leadUniqueResponse.value = response; // Store the response
      // Add the response to the list if it’s not already in the expected format
      uniqueDataList.clear(); // Clear previous data
      uniqueDataList.add(response); // Add the response to the list
      print(' lead   unique: ${uniqueDataList.toJson()}');
      // print('API Response: ${response.toJson()}');
    } catch (error) {
      print('Error  fetching lead unique: ${error.toString()}');
    } finally {
      loading.value = false; // Stop loading
    }
  }
}
