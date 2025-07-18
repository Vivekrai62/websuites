
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/task/list/new_board/task_list_new_board_request_model.dart';
import '../../../../data/repositories/repositories.dart';
class TaskListNewBoardViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> taskListNewBoard(BuildContext context) async {
    loading.value = true;
    NewBoardRequestModel requestModel=NewBoardRequestModel(
      color: "#E27300",
      name: "In Progress",
    );
    _api.taskListNewBoard(requestModel.toJson()).then((value) {
      if(value.id!.isNotEmpty){
          print("Response Task List New Board Name  ${value.name}");
          print("Response Task List New Board color ${value.color}");
        Utils.snackbarSuccess('taskList fetched');
        loading.value = false;
      }
      else{
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