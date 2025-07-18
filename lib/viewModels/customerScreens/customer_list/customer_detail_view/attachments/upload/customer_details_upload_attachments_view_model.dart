import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/models/requestModels/customer/details/attachments/customer_details_upload_attachments_req_model.dart';
import '../../../../../../data/models/responseModels/customers/list/customer_detail_view/attachements/upload/customer_details_upload_attachments_res_model.dart';
import '../../../../../../data/repositories/repositories.dart';

class CustomerDetailsAttachmentsUploadViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<CustomerDetailsAttachmentsUploadResModel> customerDetailsAttachments = <CustomerDetailsAttachmentsUploadResModel>[].obs;
  RxString errorMessage = ''.obs;
  String? _lastCustomerId;

  Future<List<CustomerDetailsAttachmentsUploadResModel>> uploadCustomerAttachment(
      BuildContext context,
      String customerId,
      CustomerDetailsAttachmentsUploadReqModel requestModel,
      Uint8List fileBytes,
      String fileName,
      ) async {
    loading.value = true;
    errorMessage.value = '';
    try {
      final response = await _api.uploadCustomerAttachment(
        customerId,
        requestModel,
        fileBytes,
        fileName,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        customerDetailsAttachments.addAll(response);
        _lastCustomerId = customerId;
        loading.value = false;
      });

      return response; // Return the API response
    } catch (error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        errorMessage.value = error.toString();
        loading.value = false;
      });
      rethrow; // Rethrow the error to allow the caller to handle it
    }
  }
}