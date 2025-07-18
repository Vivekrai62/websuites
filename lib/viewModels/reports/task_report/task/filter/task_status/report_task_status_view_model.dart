// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import '../../../../../../Utils/utils.dart';
// import '../../../../../../data/repositories/repositories.dart';
//
// class ReportTaskStatusViewmodel extends GetxController{
//
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   Future<void> taskStatusApi (BuildContext context) async {
//     loading.value = true;
//     _api.taskStatus().then((response) {
//       if (response.isNotEmpty) {
//         // Process each lead item
//         for (var data in response) {
//           print('Task Status name   ${data.name}');
//           print('Task Status reference  ${data.reference}');
//           print('Task Status color   ${data.color}');
//
//
//         }
//         Utils.snackbarSuccess('Task Status fetched successfully');
//       }
//       else{
//         Utils.snackbarFailed('Task Status  not fetched data');
//       }
//     }).onError((error, stackTrace) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     }
//     );
//
//
//   }
//
//
//
// }