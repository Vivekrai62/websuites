import 'package:get/get.dart';

class DateTimeController extends GetxController {
  Rx<DateTime> dateTime = DateTime.now().obs;

  @override
  void onInit() {
    // Update date time every minute
    updateDateTime();
    super.onInit();
  }

  void updateDateTime() {
    // Update DateTime every minute
    ever(DateTime.now() as RxInterface<Object?>, (_) {
      dateTime(DateTime.now());
    });
  }
}
