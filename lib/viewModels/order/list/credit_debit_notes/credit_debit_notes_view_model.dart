import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/order/list/credit_debit_notes/order_credit_debit_notes_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class OrderCreditDebitNoteViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> orderCreditDebitNote (BuildContext context) async {
    loading.value = true;
    OrderCreditDebitNoteRequestModel orderCreditDebitNoteRequestModel=OrderCreditDebitNoteRequestModel(
      amount: 60.0,
      orderProduct: "d5175a3d-ba3c-4700-a626-8757bbd5c899",
      remark: "testing",
      type: "credit",
    );
    _api.orderCreditDebitNote(orderCreditDebitNoteRequestModel.toJson()).then((response) {
      if (response.id!=null && response.id!.isNotEmpty) {
        if (kDebugMode) {
          print('Order Credit Debit  Response Order Type  ${response.type}');
          print('Order Credit Debit  Response amount  ${response.amount}');
          print('Order Credit Debit  Response Customer First Name ${response.customer?.firstName}');
          print('Order Credit Debit  Response Customer Create By update At ${response.createdBy?.createdAt}');
        }
        Utils.snackbarSuccess('Order  Delete List Fetching');
      }
      else{
        Utils.snackbarFailed('order Delete List not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
















}