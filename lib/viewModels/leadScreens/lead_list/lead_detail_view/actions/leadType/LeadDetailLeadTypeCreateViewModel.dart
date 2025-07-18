import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/appUrls/app_urls.dart';
import '../../../../../../data/models/requestModels/lead/lead_list/details/actionCreate/leadType/LeadDetailLeadTypeCreateReqModel.dart';

import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/actionCreate/leadType/LeadDetailLeadTypeCreateResModel.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../../utils/utils.dart';

class LeadDetailLeadTypeCreateViewModel extends GetxController {
  final api = Repositories();
  RxBool loading = false.obs;

  Future<void> leadTypeToSalesUpdate(
      BuildContext context,
      String leadId,
      Map<String, dynamic> requestData,
      ) async {
    loading.value = true;

    try {
      // Construct the request model
      final reqModel = LeadDetailLeadTypeCreateReqModel.fromJson(requestData);

      // Construct the dynamic URL
      String dynamicUrl = "${AppUrls.baseurl}${AppUrls.leadDetailsLeadTypeEndpoint}/$leadId";

      // Make the API call
      LeadDetailLeadTypeCreateResModel response = await api.leadTypeToSalesUpdate(
        reqModel.toJson(),
        dynamicUrl,
      );

      if (response.success == true) {
        Utils.snackbarSuccess('Lead Type assigned successfully');
      } else {
        Utils.snackbarFailed('Failed to assign Lead Type: ${response.message ?? "Unknown error"}');
      }
    } catch (error) {
      Utils.snackbarFailed('Error: $error');
    } finally {
      loading.value = false;
    }
  }
}