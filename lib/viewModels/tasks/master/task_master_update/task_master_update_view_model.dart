import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/task/master/task_master_update/task_master_update_request_model.dart';
import '../../../../data/repositories/repositories.dart';

class TaskMasterUpdateViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;

  Future<void> taskMasterUpdateApi (BuildContext context) async {
    loading.value = true;
    TaskMasterUpdateRequestModel requestModel=TaskMasterUpdateRequestModel(name: 'Internal Calling', status:false);
    _api.taskMasterUpdate(requestModel.toJson()).then((value) {
      if(value.id!= null){
        Utils.snackbarSuccess('task Master Update data fetched');
        loading.value = false;
      }else{
        Utils.snackbarFailed('task Master update not fetched');
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