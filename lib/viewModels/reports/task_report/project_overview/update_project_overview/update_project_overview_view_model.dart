// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import '../../../../../Utils/utils.dart';
// import '../../../../../data/repositories/repositories.dart';
// class UpdateProjectOverViewModel extends GetxController{
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   UpdateProjectOverviewRequestModel request = UpdateProjectOverviewRequestModel(
//     billingType: "Project Hours",
//     company: "b4d281c7-1e8d-45ff-b719-d4e92ec94d06",
//     customer: "de8c01f4-c130-42b7-bdaf-d943eaf6ad4b",
//     deadline: "2024-12-29",
//     demoUrl: "http///rjk4tgjkjkkljl",
//     description: "<p><br></p>",
//     estimatedHours: 20,
//     liveUrl: "http/////liilkhltlhejjkklj",
//     members: ["18aae555-f46e-4bff-bc1d-6849dceb279f"],
//     projectName: "Whsuites",
//     startDate: "2024-07-30T00:00:00.000Z",
//     status: "Not Started",
//     tags: [],
//     totalRate: 8,
//   );
//
//
//   Future<void> updateProjectOverview (BuildContext context) async {
//     loading.value = true;
//     _api.updateProjectOverView(request.toJson()).then((response) {
//       if (response.id!=null && response.id!.isNotEmpty) {
//           print('Update Project Overview List  ${response.id}');
//           print('Update Project Overview members${response.members}');
//           print('Update Project Overview  rating ${response.totalRate}');
//           print('Update Project Overview target ${response.customer?.firstName}');
//
//         Utils.snackbarSuccess('sales data  fetched');
//         loading.value = false;
//
//       }else{
//         Utils.snackbarFailed('sales not fetched');
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
// }