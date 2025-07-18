import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/repositories/repositories.dart';
class TaskReportRemoveAttachmentViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> taskRemoveAttachment (BuildContext context) async {
    loading.value = true;
    _api.taskReportRemoveAttachment().then((response) {
      if (response.raw!=null) {
      print("Task Report Remove Attachment Response ${response.affected}");
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