import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../../data/models/responseModels/notification/notification_res_model.dart';

class NotificationViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<Items> notifications = <Items>[].obs;
  RxInt unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    notificationListApi();
  }

  Future<void> notificationListApi() async {
    loading.value = true;
    try {
      final response = await _api.notificationListApi();
      if (response.items.isNotEmpty) {
        notifications.value = response.items;
        unreadCount.value = response.meta.unreadCount;
        // print(  'Notification Screen list fetched: ${response.items.length} notifications');
        // print('Unread count: ${response.meta.unreadCount}');
      } else {
        // print('No notifications found');
        notifications.clear();
        unreadCount.value = 0;
      }
    } catch (error) {
      // if (kDebugMode) {
      //   print('Error fetching notifications: $error');
      // }
      // Utils.snackbarFailed('Failed to fetch notifications');
    } finally {
      loading.value = false;
    }
  }

  // Method to mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      // TODO: Implement mark as read API call
      // print('Marking notification $notificationId as read');
      // Update local state
      final index =
          notifications.indexWhere((item) => item.id == notificationId);
      if (index != -1) {
        final updatedItem = Items(
          id: notifications[index].id,
          message: notifications[index].message,
          status: 'Read',
          link: notifications[index].link,
          data: notifications[index].data,
          createdAt: notifications[index].createdAt,
          updatedAt: notifications[index].updatedAt,
          deletedAt: notifications[index].deletedAt,
          title: notifications[index].title,
        );
        notifications[index] = updatedItem;
        unreadCount.value = (unreadCount.value - 1).clamp(0, unreadCount.value);
      }
    } catch (error) {
      if (kDebugMode) {
        // print('Error marking notification as read: $error');
      }
    }
  }

  // Method to delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      // TODO: Implement delete notification API call
      // print('Deleting notification $notificationId');
      // Remove from local list
      notifications.removeWhere((item) => item.id == notificationId);
    } catch (error) {
      // if (kDebugMode) {
      //   print('Error deleting notification: $error');
      // }
    }
  }

  // Helper method to format date
  String formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          return '${difference.inMinutes} minutes ago';
        } else {
          return '${difference.inHours} hours ago';
        }
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return '${date.day} ${_getMonthName(date.month)}, ${date.year}';
      }
    } catch (e) {
      return dateString;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  // Helper method to get notification icon color
  Color getNotificationColor(String? color) {
    switch (color?.toLowerCase()) {
      case 'success':
        return const Color(0xFF4CAF50);
      case 'info':
        return const Color(0xFF2196F3);
      case 'warning':
        return const Color(0xFFFF9800);
      case 'error':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  // Helper method to get notification background color
  Color getNotificationBackgroundColor(String? color) {
    switch (color?.toLowerCase()) {
      case 'success':
        return const Color(0xFFE8F5E8);
      case 'info':
        return const Color(0xFFE3F2FD);
      case 'warning':
        return const Color(0xFFFFF3E0);
      case 'error':
        return const Color(0xFFFFEBEE);
      default:
        return const Color(0xFFF5F5F5);
    }
  }
}
