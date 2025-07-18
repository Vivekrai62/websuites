import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/requestModels/lead/setting/lead_type/sub_lead_type/create_add/lead_type_add_req_model.dart';
import '../../../../../../data/models/responseModels/leads/setting/lead_type/add_create/sub_type/lead_subtype_add_res_model.dart';
import '../../../../../../data/repositories/repositories.dart';



class LeadSubTypeAddViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> leadSubTypeAddApi(BuildContext context, LeadSubTypeAddReqModel requestModel) async {
    loading.value = true;

    try {
      Map<String, dynamic> requestData = requestModel.toJson();
      if (kDebugMode) {
        print("Lead Type Add Request Data: $requestData");
      }
      LeadSubTypeAddResModel response = await _api.leadSubTypeAddApi(requestData);

      if (kDebugMode) {
        print("Lead Type Add Response: ${response.toJson()}");
      }

      if (response.id != null) {
        loading.value = false;
        // Success handled in the UI
      } else {
        loading.value = false;
        if (kDebugMode) {
          print("Lead Type Add Error: No ID returned in response");
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add subtype: No ID returned'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e, stackTrace) {
      loading.value = false;
      if (kDebugMode) {
        print("Lead Type Add ViewModel Error: $e");
        print("Stack Trace: $stackTrace");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add subtype: $e'),
          backgroundColor: Colors.red,
        ),
      );
      rethrow; // Optional: rethrow if you want to handle it further up
    }
  }
}