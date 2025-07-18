import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';
import '../../../data/models/requestModels/customer/customer_payment_reminder/customer_payment_reminder_list.dart';

class CustomerPaymentReminderListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> customerPaymentReminder(BuildContext context) async {
    loading.value = true;

    CustomerPaymentRequestModel customerPaymentRequestModel=CustomerPaymentRequestModel(
      customer: null,
      dateRange: null,
      dateRangeTo: "reminder_date",
      division: null,
      limit: 15,
      page: 1,
      reminderTo: null,
      reminderType: null,
      rowsPerPage: 15,
      status: null,
    );
    _api.customerPaymentReminderList(customerPaymentRequestModel.toJson()).then((response) {
      if (response.items != null && response.items!.isNotEmpty) {
        // Process each lead item
        for (var item in response.items!) {
          print('Customer Payments Reminder: ${item.id}');
          print('Customer: Payment Reminders First Name ${item.reminderTo?.firstName}');
          print('Customer: Payment Reminders First Name ${item.orders?.customer?.firstName}');
        }
        Utils.snackbarSuccess('Customer customer_list fetched successfully');
      }
      else{
        Utils.snackbarFailed('customer Payment not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}