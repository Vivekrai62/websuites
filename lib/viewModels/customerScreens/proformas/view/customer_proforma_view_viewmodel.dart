import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:websuites/data/models/requestModels/customer/proformas/CustomerProformasReqModel.dart';
import 'package:websuites/data/models/responseModels/customers/proformas/CustomerProformasResModel.dart';
import 'package:websuites/data/models/responseModels/customers/proformas/view/proforma_view_res_model.dart';
import 'package:websuites/data/repositories/repositories.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class InvoiceViewModel extends GetxController {
  final Repositories _api;
  final RxBool loading = false.obs;
  final RxList<Items> customerProItems = <Items>[].obs;
  final RxList<Items> allCustomerProItems = <Items>[].obs;
  final Rx<CustomerPerformaPdfResModel?> invoice = Rx<CustomerPerformaPdfResModel?>(null);
  final Rx<File?> pdfFile = Rx<File?>(null);
  final RxString error = ''.obs;
  Map<String, dynamic> appliedFilters = {};

  InvoiceViewModel(this._api);

  @override
  void onInit() {
    super.onInit();
    fetchCustomerProformas();
  }

  void applyFilters(Map<String, dynamic> filters) {
    appliedFilters = filters;
    fetchCustomerProformas(forceRefresh: true);
  }

  Future<void> fetchCustomerProformas({bool forceRefresh = false}) async {
    try {
      loading.value = true;
      if (forceRefresh) {
        customerProItems.clear();
        allCustomerProItems.clear();
      }

      final request = _createRequestModel();
      final CustomerProformasResModel response = await _api.customerProformasApi(request.toJson());

      if (response.items != null && response.items!.isNotEmpty) {
        customerProItems.assignAll(response.items!);
        allCustomerProItems.assignAll(response.items!);
      } else {
        customerProItems.clear();
        allCustomerProItems.clear();
      }
    } catch (e) {
      customerProItems.clear();
      allCustomerProItems.clear();
      error.value = e.toString();
      Get.snackbar('Error', 'Failed to load proformas: $e');
    } finally {
      loading.value = false;
    }
  }

  CustomerProformasReqModel _createRequestModel() {
    return CustomerProformasReqModel(
      search: appliedFilters['search'] ?? '',
      isWithTeam: appliedFilters['lead_assigned'] == 'withteam' ? true : false,
      division: appliedFilters['division'] ?? "",
      limit: 10,
      page: 1,
      dateRange: appliedFilters['range'] != null
          ? appliedFilters['range'] as Map<String, dynamic>?
          : null,
      createdBy: appliedFilters['created_by'] as String?,
    );
  }

  void searchProformas(String query) {
    if (query.isEmpty) {
      customerProItems.assignAll(allCustomerProItems);
    } else {
      final filteredItems = allCustomerProItems.where((item) {
        final name = item.name?.toLowerCase() ?? '';
        final email = item.email?.toLowerCase() ?? '';
        final performaNumber = item.performaNumber?.toString() ?? '';
        final lowerQuery = query.toLowerCase();
        return name.contains(lowerQuery) ||
            email.contains(lowerQuery) ||
            performaNumber.contains(lowerQuery);
      }).toList();
      customerProItems.assignAll(filteredItems);
    }
  }

  Future<void> fetchInvoicePdf(String invoiceId) async {
    loading.value = true;
    error.value = '';
    pdfFile.value = null;
    invoice.value = null;

    try {
      debugPrint('Fetching PDF for invoiceId: $invoiceId');
      final response = await _api.fetchInvoicePdf(invoiceId);
      debugPrint('PDF API response: ${response.toJson()}');
      invoice.value = response;

      if (response.file != null) {
        debugPrint('Using PDF file from response');
        pdfFile.value = response.file;
      } else if (response.pdfData != null && response.pdfData!.isNotEmpty) {
        debugPrint('Saving PDF from Base64');
        pdfFile.value = await _api.savePdfFromBase64(
          response.pdfData!,
          'invoice_$invoiceId.pdf',
        );
      } else if (response.pdfUrl != null && response.pdfUrl!.isNotEmpty) {
        debugPrint('Downloading PDF from URL: ${response.pdfUrl}');
        pdfFile.value = await _api.downloadPdfFromUrl(
          response.pdfUrl!,
          'invoice_$invoiceId.pdf',
        );
      } else {
        throw Exception('No valid PDF data, URL, or file provided in response');
      }
    } catch (e) {
      error.value = e.toString();
      debugPrint('Error fetching PDF: $e');
      Get.snackbar('Error', 'Failed to load invoice PDF: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> downloadPdf() async {
    if (pdfFile.value == null) {
      Get.snackbar('Error', 'No PDF available to download');
      return;
    }

    try {
      if (await Permission.storage.request().isGranted) {
        final dir = await getDownloadsDirectory();
        final newFile = await pdfFile.value!.copy(
          '${dir!.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf',
        );
        Get.snackbar('Success', 'PDF downloaded to: ${newFile.path}');
      } else {
        Get.snackbar('Error', 'Storage permission denied');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to download PDF: $e');
    }
  }
}