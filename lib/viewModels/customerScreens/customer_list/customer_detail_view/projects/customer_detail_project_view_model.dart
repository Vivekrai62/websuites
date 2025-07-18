import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../data/models/responseModels/customers/list/customer_detail_view/projects/customer_details_projects_res_model.dart';





class CustomerDetailProjectViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<CustomerDetailsProjectsResModel> customerProjects = <CustomerDetailsProjectsResModel>[].obs;
  RxString errorMessage = ''.obs;
  String? _lastCustomerId;

  Future<void> customerDetailsProject(BuildContext context, String customerId) async {
    if (_lastCustomerId == customerId && customerProjects.isNotEmpty) {
      return;
    }
    loading.value = true;
    errorMessage.value = '';
    try {
      final response = await _api.customerDetailsProject(customerId);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        customerProjects.value = response; // Updated line
        _lastCustomerId = customerId;
        loading.value = false;
      });

      if (response.isNotEmpty) {
        // print('hello ${response.first.id}');
      } else {
        // print('hello - response is empty');
      }
    } catch (error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        errorMessage.value = error.toString();
        loading.value = false;
      });
    }
  }


}