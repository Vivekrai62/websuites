import 'package:get/get.dart';
import 'package:websuites/data/network/network_api_services.dart';
import '../../../../data/models/responseModels/dashboard/main_dashboard/charts/projects-reminders-chart/ProjectReminderResModel.dart';
import '../../../../resources/appUrls/app_urls.dart';

class TaskStatusController extends GetxController {
  final NetworkApiServices _apiService = NetworkApiServices();
  final Rx<DbProjectReminderResModel?> reminderData =
      Rx<DbProjectReminderResModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProjectReminders();
  }

  Future<void> fetchProjectReminders() async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _apiService.postApiResponse(
        AppUrls.dashboardProjectReminder,
        {},
      );

      print('Raw API Response: $response'); // Debugging

      reminderData.value = DbProjectReminderResModel.fromJson(response);
      print(
          'Parsed Data: ${reminderData.value?.count}, ${reminderData.value?.data}');
    } catch (e) {
      print('Error: $e');
      error.value = 'Failed to fetch reminders: ${e.toString()}';
      reminderData.value = DbProjectReminderResModel(count: 0, data: []);
    } finally {
      isLoading.value = false;
    }
  }
}
