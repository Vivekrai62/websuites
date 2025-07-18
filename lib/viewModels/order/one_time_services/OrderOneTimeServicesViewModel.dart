import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../Utils/utils.dart';
import '../../../data/models/requestModels/order/onetime_services/OrderOneTimeServiceReqModel.dart';
import 'package:websuites/data/models/responseModels/order/onetime_services/OrderOneTimeServiceResModel.dart';

class OrderOneTimeServicesViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<Items> orderOneTimeSer = <Items>[].obs; // Updated to use OrderItem

  Future<void> orderOneTimeServices({bool forceRefresh = false}) async {
    if (orderOneTimeSer.isNotEmpty && !forceRefresh) {
      return; // Skip if data exists and no force refresh
    }

    loading.value = true;
    if (forceRefresh) {
      orderOneTimeSer.clear(); // Clear list on force refresh
    }

    OrderOneTimeServiceReqModel request = OrderOneTimeServiceReqModel(
      dateRange: null,
      dateRangeTo: null,
      filterDays: null,
      filterDaysType: null,
      limit: 15,
      page: 1,
      search: '',
      statusType: null,
    );

    try {
      final response = await _api.orderOneTimeServices(request.toJson());
      if (kDebugMode) {
        print('API Response order one time: ${response.toJson()}');
      }

      if (response.items.isNotEmpty) {
        orderOneTimeSer.assignAll(response.items); // Corrected to assign the items list
        Utils.snackbarSuccess('Order One Time fetched');
      } else {
        orderOneTimeSer.clear();
        Utils.snackbarFailed('No order One Time found');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching order One Time: $error');
      }
      Utils.snackbarFailed('Error fetching order One Time: $error');
    } finally {
      loading.value = false;
    }
  }
}