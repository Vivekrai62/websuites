import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../data/models/requestModels/report/products_wise_sale_reports/ReportProductWiseReqModel.dart';
import '../../../data/models/responseModels/reports/products_wise_sale_reports/ReportProductWiseResModel.dart';

class ReportProductWiseSaleViewModel extends GetxController {
  final _api = Repositories();

  RxBool loading = false.obs;
  RxList<ReportProductWiseResModel> productWiseSaleItems = <ReportProductWiseResModel>[].obs;

  ReportProductWiseReqModel reportProductWiseReqModel = ReportProductWiseReqModel(
    dateRange: null,
    division: null,
    userId: null,
    isFilterUserWithTeam: true,
    products: [],
    limit: 15,
    page: 1,
  );

  void resetRequestModel() {
    reportProductWiseReqModel = ReportProductWiseReqModel(
      dateRange: null,
      division: null,
      userId: null,
      isFilterUserWithTeam: true,
      products: [],
      limit: 15,
      page: 1,
    );
  }

  Future<void> reportProductWiseSale(BuildContext context, {bool forceRefresh = false}) async {
    loading.value = true;
    if (forceRefresh) {
      productWiseSaleItems.clear(); // Clear data for refresh
    }
    print('Fetching product wise sale with request: ${reportProductWiseReqModel.toJson()}');
    try {
      ReportProductWiseResModel response = await _api.reportProductWiseSale(reportProductWiseReqModel.toJson());
      print('API response received with ${response.products?.length ?? 0} products');
      productWiseSaleItems.clear();
      productWiseSaleItems.add(response);
    } catch (error) {
      print('Error fetching product wise sale reports: $error');
      productWiseSaleItems.clear();
    } finally {
      loading.value = false;
      print('ProductWiseSaleItems updated with ${productWiseSaleItems.length} items');
    }
  }

  void applyFilters(Map<String, dynamic> filters) {
    resetRequestModel();
    // if (filters.containsKey('start_date') && filters.containsKey('end_date')) {
    //   reportProductWiseReqModel.dateRange = {
    //     'start_date': filters['start_date'],
    //     'end_date': filters['end_date'],
    //   };
    // }
    if (filters.containsKey('search_customer')) {
      reportProductWiseReqModel.userId = filters['search_customer'];
    }
    reportProductWiseSale(Get.context!, forceRefresh: true);
  }

  void searchProducts(String query) {
    resetRequestModel();
    if (query.isEmpty) {
      reportProductWiseSale(Get.context!, forceRefresh: true);
    } else {
      reportProductWiseReqModel.products = [query];
      reportProductWiseSale(Get.context!, forceRefresh: true);
    }
  }
}