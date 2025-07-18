import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/models/requestModels/customer/customer_list/customer_detail_view/customer_assigned/customer_assigned_req_model.dart';
import '../../../../../data/repositories/repositories.dart';

class CustomerAssignedViewModel extends GetxController {
  final Repositories _api = Repositories();
  final RxBool isAssigning = false.obs;

  Future<bool> assignCustomersToLead({
    required String leadId,
    required List<String> assignedId,
  }) async {
    try {
      isAssigning.value = true;

      final requestModel = CustomerAssignedReqModel(customer: assignedId);
      final response = await _api.customerCreateAssigned(
        leadId: leadId,
        data: requestModel.toJson(),
      );

      if (response.success == true) {
        // Get.snackbar(
        //   'Success',
        //   response.data ?? 'Customers assigned successfully',
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        //   duration: const Duration(seconds: 2),
        // );
        return true;
      } else {
        // _showError(response.data ?? 'Failed to assign customers');
        return false;
      }
    } catch (e) {
      // debugPrint('Error assigning customers: $e');
      // _showError('Network error. Please try again.');
      return false;
    } finally {
      isAssigning.value = false;
    }
  }

  // void _showError(String message) {
  //   Get.snackbar(
  //     'Error',
  //     message,
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: Colors.red,
  //     colorText: Colors.white,
  //     duration: const Duration(seconds: 3),
  //   );
  // }
}