// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import '../../../../../Utils/utils.dart';
// import '../../../../../data/repositories/repositories.dart';
//
// class CreateProjectReminderViewModel extends GetxController{
//
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   Future<void> createProjectReminder(BuildContext context) async {
//     loading.value = true;
//     // List<DateModel> dates = [
//     //   DateModel(day: "23", month: 12),
//     //   DateModel(day: "17", month: 10),
//     // ];
//     // RequestModel requestModel = RequestModel(
//     //   dates: dates,
//     //   project: "65189f4c-843e-41e6-953c-6dabcd21f4a0",
//     //   users: ["61986b57-37f2-4353-920e-dfb4ff25aac7"],
//     // );
//
//     final requestModel = RequestModel(
//       dates: [
//         Date(day: "16", month: 4),
//         Date(day: "12", month: 10),
//       ],
//       project: "65189f4c-843e-41e6-953c-6dabcd21f4a0",
//       users: ["61986b57-37f2-4353-920e-dfb4ff25aac7"],
//     );
//     print("Request Create Project Reminder${requestModel}");
//     _api.createProjectReminder(requestModel.toJson()).then((response) {
//       if (response.isNotEmpty) {
//         Utils.snackbarFailed('Project OverView not fetched');
//       }
//       else{
//         Utils.snackbarFailed('Project OverView not fetched');
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
//
//
//
//
// }