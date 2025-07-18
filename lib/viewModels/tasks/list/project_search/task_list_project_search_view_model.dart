import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/task/list/project_search/task_list_project_search_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class TaskListProjectSearchViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> projectSearch(BuildContext context) async {
    loading.value = true;
    ProjectSearchRequestModel request = ProjectSearchRequestModel(search: "");
    _api.projectSearch(request.toJson()).then((value) {
      if(value.isNotEmpty) {
        for (var data in value) {
          print("Response Task Project Search List i ${data.id}");
          print("Response Task Project Search List Project name ${data.projectName}");
        }

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