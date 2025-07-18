import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/master/departments/master_departments_response_model.dart';
import '../../../../data/repositories/repositories.dart';

class MasterDepartmentsViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<MasterDepartmentsResponseModel> departments =
      <MasterDepartmentsResponseModel>[].obs; // Declare the customer_list

  Future<void> masterDepartments(BuildContext context,
      {bool forceRefresh = false}) async {
    if (departments.isNotEmpty && !forceRefresh) return;

    loading.value = true;
    try {
      final response = await _api.masterDepartment();
      if (response.isNotEmpty) {
        departments.value = response;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      loading.value = false;
    }
  }
}
