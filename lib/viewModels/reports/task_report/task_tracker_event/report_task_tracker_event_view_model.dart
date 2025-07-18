import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';

import '../../../../data/models/requestModels/report/task_report/task_tracker_event/report_task_tracker_event_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class TaskTrackerEventViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> taskTrackerEvent(BuildContext context) async {
    loading.value = true;


    TaskTrackerEventRequestModel taskTrackerEventRequestModel=TaskTrackerEventRequestModel(task: '98a676ad-23b2-4f3b-8f26-33906250c10a',type:'end' );
    _api.taskTrackerEvent(taskTrackerEventRequestModel.toJson()).then((response) {
      if (response.id!.isNotEmpty) {
        print('Task Tracker id ${response.id}');
        print('Task Tracker action ${response.action}');
        print('Task Tracker dateTime ${response.dateTime}');

        Utils.snackbarSuccess('Task Report fetched successfully');
      }
      else{
        Utils.snackbarFailed('Task Report not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }








}