import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/repositories/repositories.dart';
import '../../../../data/models/responseModels/leads/createNewLead/createNewModelPost/CreateNewModelbutton.dart';

class CreateNewLeadController extends GetxController {
  final api = Repositories();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<CreateNewModel> createnewList = RxList<CreateNewModel>();

  // Form fields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final organizationController = TextEditingController();
  // Add more controllers for other fields as needed

  Future<void> createNewLead(BuildContext context) async {
    isLoading.value = true;

    try {
      // Validate email and mobile
      if (!await isEmailUnique(emailController.text)) {
        errorMessage.value = 'Email already exists';
        isLoading.value = false;
        return;
      }

      if (!await isMobileUnique(mobileController.text)) {
        errorMessage.value = 'Mobile number already exists';
        isLoading.value = false;
        return;
      }

      // Create lead data
      final leadData = {
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'mobile': mobileController.text,
        'organization': organizationController.text,
        // Add more fields as needed
      };

      // Make POST request
      final response = await api.createLead(context);

      // // Handle response
      // if (response is List<CreateNewModel>) {
      //   createnewList.addAll(response);
      //   Get.snackbar('Success', 'New lead(s) created successfully');
      // } else if (response is CreateNewModel) {
      //   createnewList.add(response);
      //   Get.snackbar('Success', 'New lead created successfully');
      // } else {
      //   errorMessage.value = 'Failed to create new lead';
      // }
    } catch (e) {
      errorMessage.value = 'Error creating new lead: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> isEmailUnique(String email) async {
    // Implement API call to check email uniqueness
    // Return true if email is unique, false otherwise
    return true; // Placeholder
  }

  Future<bool> isMobileUnique(String mobile) async {
    // Implement API call to check mobile uniqueness
    // Return true if mobile is unique, false otherwise
    return true; // Placeholder
  }
}
