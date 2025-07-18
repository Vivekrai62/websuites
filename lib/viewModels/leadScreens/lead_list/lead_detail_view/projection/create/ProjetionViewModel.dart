import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../../data/models/requestModels/lead/lead_list/lead_detail_view/projection/create/LeadProjectionCreateReqModel.dart';
import '../../../../../../data/models/responseModels/leads/list/details/lead_detail_view/projection/create/LeadProjectionCreateResModel.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../../utils/utils.dart';

class ProjectionViewModel extends GetxController {
  final api = Repositories();
  RxBool loading = false.obs;
  RxList<LeadProjectionCreateResModel> items = <LeadProjectionCreateResModel>[].obs;
  RxString errorMessage = ''.obs;

  Future<void> projectionCreate(BuildContext context, String leadId, List<Map<String, dynamic>> projectionData) async {
    loading.value = true;
    errorMessage.value = '';

    try {
      // Construct the projection product list
      List<ProjectionProduct> projectionProducts = projectionData.map((data) {
        return ProjectionProduct(
          productCategory: data['categoryId'] ?? '',
          product: data['productId'] ?? '', // Added missing product field
          amount: double.tryParse(data['amount']?.toString() ?? '0') ?? 0.0,
          projectionDate: data['date'] ?? '',
        );
      }).toList();

      // Log data for debugging
      if (kDebugMode) {
        print('Sending projection data: $projectionProducts');
      }

      // Construct the request payload
      final projectionCreateReqModel = LeadProjectionCreateReqModel(
        id: leadId,
        type: 'lead',
        projectionProduct: projectionProducts,
      );

      final response = await api.projectionCreate(projectionCreateReqModel, leadId);

      if (response != null) {
        items.add(response);
        if (kDebugMode) {
          print('Lead Projection Created: ${response.toJson()}');
        }
        Utils.snackbarSuccess('Projection created successfully');
      } else {
        errorMessage.value = 'No response received from the server';
        Utils.snackbarFailed('Failed to create projection: No response');
      }
    } catch (error) {
      errorMessage.value = 'Failed to create projection: $error';
      if (kDebugMode) {
        print('Error creating projection: $error');
      }
      Utils.snackbarFailed('Failed to create projection: $error');
    } finally {
      loading.value = false;
    }
  }
}