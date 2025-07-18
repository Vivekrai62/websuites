import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/appUrls/app_urls.dart';
import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/actionCreate/leadAssignedToSales/LeadAssignedToSalesResModel.dart';
import '../../../../../../data/repositories/repositories.dart';



class LeadAssignedToSalesViewModel extends GetxController {
  final api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadAssignedToSalesResModel> leadAssignedToSalesList = <LeadAssignedToSalesResModel>[].obs;
  Rx<LeadAssignedToSalesResModel> leadActivityResponse = Rx(LeadAssignedToSalesResModel());

  Future<void> assignLeadToSales(BuildContext context, String salesId, String leadId) async {
    loading.value = true;


    final requestData = {
      "leads": [leadId],
    };

    try {

      String dynamicUrl = "${AppUrls.baseurl}${AppUrls.leadAssignedEndpoint}/$salesId";

      var response = await api.leadAssignedToSales(requestData, dynamicUrl);

      if (response.success == true) {
        leadActivityResponse.value = response;
        leadAssignedToSalesList.clear();
        leadAssignedToSalesList.add(response);

        // Utils.snackbarSuccess('Lead assigned successfully');
      } else {
        // Utils.snackbarFailed('Failed to assign lead: ${response.success ?? "Unknown error"}');
      }
    } catch (error) {
      // Utils.snackbarFailed('Error: $error');
    } finally {
      loading.value = false;
    }
  }
}