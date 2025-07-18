import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';

import '../../../../data/models/requestModels/report/task_report/task_update/task_update_request_model.dart';

import '../../../../data/repositories/repositories.dart';

class ReportTaskUpdateViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  TaskUpdateRequestModel taskUpdateRequest = TaskUpdateRequestModel(
    assignedTo: "92e8ddb2-8682-46b6-b409-b15585489f29",
    deadline: "2024-12-23",
    description: "<p>1.implement Task Screen api.<br>2. Implement Report screen Api.</p>",
    estimatedMinutes: "30",
    priority: "medium",
    project: "65189f4c-843e-41e6-953c-6dabcd21f4a0",
    startDate: "2024-12-05",
    status: "b9e67ecd-66f7-444f-9574-03d49d8caf20",
    subject: "Whsuites Crm",
    taskType: "e8022c50-6935-425c-ba31-35b460adfda2",
  );

  Future<void> reportTaskUpdate (BuildContext context) async {
    loading.value = true;
    _api.taskUpdate(taskUpdateRequest.toJson()).then((response) {
      if (response.id !=null && response.id!.isNotEmpty) {
        // Process each lead item
          print('Task Update  response description  ${response.description}');
          print('Task Update  response estimatedMinutes ${response.estimatedMinutes}');
          print('Task Update  response project Name ${response.project?.projectName}');
          print('Task Update  response status name ${response.status?.name}');
        Utils.snackbarSuccess('Task Update fetched successfully');
      }
      else{
        Utils.snackbarFailed('Task Update not fetched');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }











}