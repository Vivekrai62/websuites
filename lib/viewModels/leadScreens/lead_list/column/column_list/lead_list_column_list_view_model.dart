import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/models/responseModels/leads/list/column_list/lead_list_column_list_response_model.dart';
import '../../../../../data/repositories/repositories.dart';

class LeadListColumnListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadListColumnListResponseModel> leadColumns =
      <LeadListColumnListResponseModel>[].obs;

  Future<void> leadListColumnList(BuildContext context) async {
    loading.value = true;
    try {
      final List<LeadListColumnListResponseModel> value =
          await _api.leadListColumnList();

      if (value.isNotEmpty) {
        leadColumns
            .assignAll(value); // Directly assigning without parsing again
        // Utils.snackbarSuccess('Lead Detail Proposal data fetched');
      } else {
        // Utils.snackbarFailed('Lead Detail activity call not fetched');
      }
    } catch (error) {
      // Utils.snackbarFailed('Error fetching lead columns');
      // print(error.toString());
    } finally {
      loading.value = false;
    }
  }
}
