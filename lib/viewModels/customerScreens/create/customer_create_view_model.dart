import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/requestModels/customer/create/customer_create_req_model.dart';
import '../../../data/repositories/repositories.dart';
import '../../../utils/utils.dart';
import '../../../views/homeScreen/home_manager/HomeManagerScreen.dart';



// class CustomerCreateViewModel extends GetxController {
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   RxBool initialLoad = true.obs;
//   final formKey = GlobalKey<FormState>();
//
//   Future<void> createCustomer(CustomerCreateRequestModel model, BuildContext context) async {
//     try {
//       loading.value = true;
//
//       // Prepare form data
//       final formData = await model.toFormData();
//
//       // Call API with form data
//       final response = await _api.customersCreateApi(formData);
//       loading.value = false;
//
//       // Handle response
//       if (response['success'] == true || response['status'] == 'success') {
//         Utils.flushBarSuccessMessage(
//           response['message'] ?? 'Customer created successfully',
//           context,
//         );
//         // Navigate to HomeManagerScreen
//         Get.off(() => HomeManagerScreen());
//       } else {
//         throw Exception(response['message'] ?? 'Unknown error occurred');
//       }
//     } catch (e) {
//       loading.value = false;
//       final errorMessage = e.toString().replaceFirst('Exception: ', '');
//       Utils.snackbarFailed('Error: $errorMessage');
//       print('Customer creation error: $e');
//       rethrow;
//     }
//   }
// }

class CustomerCreateViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxBool initialLoad = true.obs;
  final formKey = GlobalKey<FormState>();

  Future<void> createCustomer(CustomerCreateRequestModel model, BuildContext context) async {
    try {
      loading.value = true;

      // Prepare form data
      final formData = await model.toFormData();

      // Call API with form data
      final response = await _api.customersCreateApi(formData);
      loading.value = false;

      // Handle response
      if (response['success'] == true || response['status'] == 'success') {
        Utils.flushBarSuccessMessage(
          response['message'] ?? 'Customer created successfully',
          context,
        );
        // Navigate to HomeManagerScreen
        Get.off(() => HomeManagerScreen());
      } else {
        // Throw an exception with status code if available
        throw Exception('API Error: ${response['message'] ?? 'Unknown error occurred'}, Status Code: ${response['statusCode'] ?? 'N/A'}');
      }
    } catch (e) {
      loading.value = false;
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      if (e is HttpException && e.message.contains('Status Code')) {
        // If the exception already contains the status code, use it
        errorMessage = e.message;
      } else {
        // Fallback error message with no status code
        errorMessage = 'Error: $errorMessage, Status Code: Unknown';
      }
      Utils.snackbarFailed(errorMessage);
      print('Customer creation error: $errorMessage');
      rethrow;
    }
  }
}