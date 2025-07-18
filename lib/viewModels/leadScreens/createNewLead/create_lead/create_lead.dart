import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/lead/create_lead/create_lead.dart';
import '../../../../data/repositories/repositories.dart';
class CreateLeadViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> createLead(BuildContext context) async {
    loading.value = true;
    CreateLeadRequestModel createLeadRequestModel = CreateLeadRequestModel(
      divisions: ["c66d0806-c3a0-41e0-a595-abecba3cbd7e"],
      firstName: "Sakshi_test112",
      gstin: "5",
      lastName: "Chaudhary",
      mobile: 9877383665,
      services: ["0647c740-0c84-4599-9a49-cd3c88f901b9"],
      source: "7628f58d-0c18-4144-ae57-5de6a04a5d70",
      email: "test76280@gmail.com",
      type: "702c2b2d-9c42-40da-8a78-49637cc455b2",
      websites: ["webhoper"],
    );

    _api.createLead(createLeadRequestModel).then((response) {
      // Successfully fetched the leads
      if (response.id != null && response.id!.isNotEmpty) {
        // Process each lead item
          // Print or handle each lead item here
          print(' Create Lead ID: ${response.firstName}');
          print('Create Lead Name: ${response.email}');
        Utils.snackbarSuccess(' Create Lead Successfully ');
      } else {
        Utils.snackbarFailed('No leads found');
      }
    }).onError((error, stackTrace) {
      // Handle any error here
      Utils.snackbarFailed('Failed to fetch leads');
      print('Error Create Lead Data: $error');
    });

  }





}