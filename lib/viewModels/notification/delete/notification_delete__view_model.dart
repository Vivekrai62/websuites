import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/responseModels/notification/delete/notification_delete_res_model.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/lead/lead_list/details/status/LeadDetailsStatusReqModel.dart';
import '../../../../../data/repositories/repositories.dart';
import 'package:dio/dio.dart';

class NotificationDeleteViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxInt unreadCount = 0.obs;
  RxList<NotificationDeleteResModel> notifications =
      <NotificationDeleteResModel>[].obs;
  Future<void> deleteNotificationApi(String notificationId) async {
    try {
      // You may need to pass a payload, or just an empty map if not needed
      final response = await _api.notificationDeleteApi({}, notificationId);
      if (response.message?.isNotEmpty ?? false) {
        notifications.removeWhere((item) => item.message == notificationId);
        unreadCount.value =
            notifications.where((item) => item.message == 'Unread').length;
        print('Notification deleted successfully');
        Utils.snackbarSuccess('Notification deleted successfully');
      } else {
        Utils.snackbarFailed('Failed to delete notification');
        print('Notification not  deleted successfully');


      }
    } catch (e) {
      Utils.snackbarFailed('Error deleting notification');
      print('Notification not catch  deleted successfully');

    }
  }
}
