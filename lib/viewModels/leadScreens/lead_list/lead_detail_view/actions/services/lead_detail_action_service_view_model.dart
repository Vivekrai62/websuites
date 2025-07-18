import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/appUrls/app_urls.dart';
import '../../../../../../data/models/requestModels/lead/lead_list/details/actionCreate/leadType/LeadDetailLeadTypeCreateReqModel.dart';

import '../../../../../../data/models/requestModels/lead/lead_list/details/actionCreate/service/LeadDetailActionServiceReqModel.dart';
import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/actionCreate/leadType/LeadDetailLeadTypeCreateResModel.dart';
import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/actionCreate/service/LeadDetailActionServiceResModel.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../../utils/utils.dart';

class LeadDetailActionCreateService extends GetxController {
  final api = Repositories();
  RxBool loading = false.obs;

  Future<void> leadDetailActionCreateService(
      BuildContext context,
      String serviceId,
      Map<String, dynamic> requestData,
      ) async {
    loading.value = true;

    try {
      // Construct the request model
      final reqModel = LeadDetailActionServiceReqModel.fromJson(requestData);

      // Construct the dynamic URL
      String dynamicUrl = "${AppUrls.baseurl}${AppUrls.leadDetailActionService}/$serviceId";

      // Make the API call
      LeadDetailActionServiceResModel response = await api.leadDetailActionCreateService(
        reqModel.toJson(),
        dynamicUrl,
      );

      if (response.success == true) {
        Utils.snackbarSuccess('Lead Service assigned successfully');
      } else {
        Utils.snackbarFailed('Failed to assign Lead Service: ${response.message ?? "Unknown error"}');
      }
    } catch (error) {
      Utils.snackbarFailed('Error: $error');
    } finally {
      loading.value = false;
    }
  }
}