// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import '../../../../../../Utils/utils.dart';
// import '../../../../../../data/repositories/repositories.dart';
// class ReportTaskTypeViewModel extends GetxController{
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   Future<void> taskTypeApi (BuildContext context) async {
//     loading.value = true;
//     _api.taskType().then((response) {
//       if (response.isNotEmpty) {
//         // Process each lead item
//         for (var data in response) {
//           print('Task Type name   ${data.name}');
//         }
//         Utils.snackbarSuccess('Task Type fetched successfully');
//       }
//       else{
//         Utils.snackbarFailed('Task Type  not fetched data');
//       }
//     }).onError((error, stackTrace) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     }
//     );
//
//
// }
// }