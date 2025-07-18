import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/leads/createNewLead/source/source_response_model.dart';
import '../../../../data/repositories/repositories.dart';

class SourceViewModel extends GetxController {
  List<SourceResponseModel> sourceList = []; // Change to hold SourceResponseModel
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> fetchLeadSources(BuildContext context) async {
    print("Api call");
    loading.value = true;
    try {
      List<SourceResponseModel> sources = await _api.createNewLeadSourceApi();
      sourceList = sources; // Assign the fetched sources to the customer_list
      // Utils.snackbarSuccess('Sources fetched successfully');
    } catch (e) {
      // Utils.snackbarFailed('Error fetching sources');
      // if (kDebugMode) {
      //   print(e.toString());
      // }
    } finally {
      loading.value = false;
    }
  }
}
