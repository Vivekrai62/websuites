import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../data/models/requestModels/order/list/order_list_request_model.dart';
import '../../../data/models/responseModels/order/list/order_list_response_model.dart';

class OrderListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  final RxList<Item> orderListItems = <Item>[].obs;
  final RxList<Item> allOrderListItems = <Item>[].obs;
  RxList<Item> orders = <Item>[].obs;

  @override
  void onInit() {
    super.onInit();
    orderList();
  }

  Future<void> orderList({bool forceRefresh = false}) async {
    if (orders.isNotEmpty && !forceRefresh) {
      return; // Skip if data exists and no force refresh
    }

    loading.value = true;
    if (forceRefresh) {
      orderListItems.clear();
      allOrderListItems.clear();
      orders.clear(); // Clear all lists on force refresh
    }

    OrderListRequestModel orderRequest = OrderListRequestModel(
      btnLabel: "Submit",
      createdBy: null,
      customer: null,
      dateRange: null,
      fiscalYearLabel: null,
      isModalShow: false,
      isTaxable: "No",
      limit: 15,
      modalType: "Add",
      page: 1,
      paymentType: null,
      product: null,
      productType: null,
      search: "",
      source: null,
      status: null,
    );

    try {
      var response = await _api.orderList(orderRequest.toJson());
      if (kDebugMode) {
        print('API Response order role: ${response.toJson()}');
      }

      if (response.items.isNotEmpty) {
        orders.assignAll(response.items);
        orderListItems.assignAll(response.items!);
        allOrderListItems.assignAll(response.items!);
        // Utils.snackbarSuccess('Order role fetched successfully');
      } else {
        orders.clear();
        orderListItems.clear();
        allOrderListItems.clear();
        // Utils.snackbarFailed('No orders found');
      }
    } catch (error) {
      orders.clear();
      orderListItems.clear();
      allOrderListItems.clear();
      if (kDebugMode) {
        // print('Error fetching order role: ${error.toString()}');
      }
      // Utils.snackbarFailed('An error occurred while fetching the order role: $error');
    } finally {
      loading.value = false;
    }
  }
}
