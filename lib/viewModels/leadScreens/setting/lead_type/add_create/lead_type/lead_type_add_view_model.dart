import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/requestModels/lead/setting/lead_type/lead_type/lead_type_add_request_model.dart';
import '../../../../../../data/models/requestModels/lead/setting/lead_type/sub_lead_type/create_add/lead_type_add_req_model.dart';
import '../../../../../../data/models/responseModels/leads/setting/lead_type/add_create/lead_type/lead_type_res_model.dart';
import '../../../../../../data/models/responseModels/leads/setting/lead_type/add_create/sub_type/lead_subtype_add_res_model.dart';
import '../../../../../../data/repositories/repositories.dart';



class LeadTypeAddViewModel extends GetxController {
  final Repositories _repository = Repositories();
  final RxBool isLoading = false.obs;

  Future<void> addLeadType(BuildContext context, AddLeadTypeReqModel requestModel) async {
    if (requestModel.name?.trim().isEmpty ?? true) {
      _showSnackBar(context, 'Please enter a lead type name', Colors.orange, Icons.warning_outlined);
      return;
    }

    isLoading.value = true;
    try {
      final requestData = requestModel.toJson();
      if (kDebugMode) {
        print("Lead Type Add Request Data: $requestData");
      }

      final response = await _repository.leadTypeAddApi(requestData);
      if (response.id != null) {
        _showSnackBar(context, 'Lead type "${requestModel.name}" added successfully!', Colors.green, Icons.check_circle_outline);
      } else {
        _showSnackBar(context, 'Failed to add lead type: No ID returned', Colors.red, Icons.error_outline);
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Lead Type Add ViewModel Error: $e");
        print("Stack Trace: $stackTrace");
      }
      _showSnackBar(context, 'Failed to add lead type: $e', Colors.red, Icons.error_outline);
    } finally {
      isLoading.value = false;
    }
  }

  void _showSnackBar(BuildContext context, String message, Color backgroundColor, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}