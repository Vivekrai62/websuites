// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../Utils/utils.dart';
// import '../../../../../../data/models/requestModels/report/task_report/task/filter/assign/task_filter_assign_request_model.dart';
// import '../../../../../../data/repositories/repositories.dart';
//
// class ReportTaskFilterAssignViewModel extends GetxController{
//
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   Future<void> taskFilterAssign (BuildContext context) async {
//     loading.value = true;
//     TaskFilterAssignRequestModel requestModel= TaskFilterAssignRequestModel(userId: "52fd0c63-4a9b-4047-8736-0cace72393d6");
//     _api.taskFilterAssign(requestModel.toJson()).then((response) {
//       if (response.isNotEmpty) {
//         // Process each lead item
//         for (var data in response) {
//           print('Task Filter Assign  email  ${data.email}');
//           print('Task Filter Assign name ${data.firstName}');
//
//         }
//         Utils.snackbarSuccess('Task Report fetched successfully');
//       }
//       else{
//         Utils.snackbarFailed('Task Report not fetched');
//       }
//     }).onError((error, stackTrace) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     }
//     );
//   }
//
//
//
//
//
//
//
// }