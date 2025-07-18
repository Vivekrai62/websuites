// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
//
// import '../../../../Utils/utils.dart';
// import '../../../../data/repositories/repositories.dart';
//
// class TaskDescriptionViewModel extends GetxController{
//
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   Future<void> taskDescription (BuildContext context) async {
//     loading.value = true;
//
//     _api.taskDescription().then((response) {
//       if (response.isNotEmpty) {
//         // Process each lead item
//         for (var data in response) {
//           print('Task Description  response  ${data.description}');
//           print('Task Description Create By  ${data.createdBy?.firstName}');
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
// }