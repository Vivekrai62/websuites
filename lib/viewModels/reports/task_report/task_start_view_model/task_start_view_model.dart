// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
//
// import '../../../../Utils/utils.dart';
// import '../../../../data/repositories/repositories.dart';
//
// class TaskStartViewModel extends GetxController{
//
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   Future<void> taskStart (BuildContext context) async {
//     loading.value = true;
//
//     _api.taskStartApi().then((response) {
//       if (response.taskInfo!=null ) {
//         // Process each lead item
//           print('Task Start id  ${response.taskInfo?.id}');
//           print("Task Start Status ${response.taskInfo?.status}");
//           print('Task Start description ${response.taskInfo?.description}');
//           print('Task Start Create By ${response.taskInfo?.createdBy?.firstName}');
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
// }