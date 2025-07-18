import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/requestModels/task/master/add_task_type/master_add_task_type_request_model.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';
class TaskMasterAddTaskTypeViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> addTaskType (BuildContext context) async {
    loading.value = true;
AddTaskTypeRequestModel requestModel=AddTaskTypeRequestModel(name:"Pharma Hoper");
    _api.addTaskType(requestModel.toJson()).then((value) {
      if(value.id!= null && value.id!.isNotEmpty){
          print("Response Task master Add Task Color${value.color}");
          print("Response Task master Add Task Name ${value.name}");
        Utils.snackbarSuccess('taskList fetched');
        loading.value = false;
      }else{
        Utils.snackbarFailed('taskList not fetched');
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error.toString()
        );
      }
    }
    );
  }


}