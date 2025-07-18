import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/leads/leadMasters/types/ReportTeamLeadHotColdResModel.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class LeadMasterTypesViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadMasterTypeResponseModel> hotColdDataList = <LeadMasterTypeResponseModel>[].obs;
  Rx<LeadMasterTypeResponseModel> hotColdLeadResponse = Rx(LeadMasterTypeResponseModel());

  Future<void> leadMasterType(BuildContext context) async {
    loading.value = true;
    try {
      List<LeadMasterTypeResponseModel> value = await _api.leadMasterType();
      if (value.isNotEmpty) {
        for (var responseData in value) {
          if (kDebugMode) {
            print("LEAD Master type data: ${responseData.name}");
          }
          Utils.snackbarSuccess('Lead Master type data fetched');
        }

        // Clear and update the RxList with the fetched data
        hotColdDataList.clear();
        hotColdDataList.addAll(value);

        // Set the first item to hotColdLeadResponse (optional)
        if (value.isNotEmpty) {
          hotColdLeadResponse.value = value.first;
        }
      } else {
        Utils.snackbarFailed('No Lead Master type data fetched');
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("Error fetching Lead Master type: $error");
        print(stackTrace);
      }
      Utils.snackbarFailed('Failed to fetch Lead Master type data');
    } finally {
      loading.value = false;
    }
  }
}