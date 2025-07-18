import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../data/models/requestModels/sales/projection/SalesProjectionsListRequestModel.dart';
import '../../../data/models/responseModels/sales/projection/SalesProjectionsListResponseModel.dart';
import '../../../utils/utils.dart';
import '../../../data/repositories/repositories.dart';

class SalesProjectionViewModel extends GetxController {
  final Repositories repository;

  SalesProjectionViewModel({required this.repository});

  final RxBool isLoading = false.obs;
  final RxBool hasLoadedOnce =
      false.obs; // New flag to track if data has loaded once
  final RxList<SalesProjectionsListResponseModel> salesProjections =
      RxList<SalesProjectionsListResponseModel>();

  Future<void> fetchSalesProjections({
    BuildContext? context,
    String? createdBy,
    String? status,
    String? dateRange,
    bool? isOpen,
    String? productCategory,
  }) async {
    try {
      // Only show loading if data hasn't been loaded before
      if (!hasLoadedOnce.value) {
        isLoading.value = true;
      }

      final request = SalesProjectionsListRequestModel(
        createdBy: createdBy,
        status: status,
        dateRange: dateRange,
        isOpen: isOpen,
        productCategory: productCategory,
      );
      final response = await repository.salesProjectionApi(request.toJson());
      if (kDebugMode) {
        // print("Parsed Sales Projections: $response");
      }
      salesProjections.value = response ?? [];
      if (salesProjections.isNotEmpty) {
        if (kDebugMode) {
          // print("Sales Projections Count: ${salesProjections.length}");
        }
      } else {
        if (kDebugMode) {
          // print("No Sales Projections Found");
        }
      }

      // Mark as loaded once data is fetched successfully
      hasLoadedOnce.value = true;
    } catch (error) {
      if (kDebugMode) {
        // print('SalesProjectionViewModel Error: $error');
      }
      if (context != null) {
        // Utils.snackbarFailed('Error fetching sales projections: $error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void clearProjection() {
    salesProjections.clear();
    hasLoadedOnce.value = false; // Reset if you want to reload on demand
  }
}
