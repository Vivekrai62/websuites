import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../data/models/requestModels/order/order_payment/order_payment_request_model.dart';
import '../../../data/models/responseModels/order/payments/order_payments_response_model.dart';

class OrderPaymentsViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<Items> orderPayments = <Items>[].obs;

  Future<void> orderPayment({bool forceRefresh = false}) async {
    if (orderPayments.isNotEmpty && !forceRefresh) {
      return; // Skip if data exists and no force refresh
    }

    loading.value = true;
    if (forceRefresh) {
      orderPayments.clear(); // Ensure role is cleared on force refresh
    }

    OrderPaymentRequestModel request = OrderPaymentRequestModel(
      chequeDateRange: null,
      createdBy: null,
      customerId: null,
      dateRange: null,
      divisionId: null,
      limit: 15,
      page: 1,
      paymentDateRange: null,
      paymentMode: null,
      paymentType: null,
      product: null,
      search: "",
      status: null,
    );

    try {
      final response = await _api.orderPaymentList(request.toJson());
      if (kDebugMode) {
        // print('API Response order payment role: ${response.toJson()}');
      }

      if (response.items != null && response.items!.isNotEmpty) {
        orderPayments
            .assignAll(response.items!); // Use assignAll for reactive update
        // Utils.snackbarSuccess('Order payments fetched');
      } else {
        orderPayments.clear();
        // Utils.snackbarFailed('No order payments found');
      }
    } catch (error) {
      if (kDebugMode) {
        // print('Error fetching order payment: $error');
      }
      // Utils.snackbarFailed('Error fetching order payments: $error');
    } finally {
      loading.value = false;
    }
  }
}
