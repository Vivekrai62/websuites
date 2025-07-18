// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
//
// import '../../../../../data/repositories/repositories.dart';
//
// class LeadDetailAssignHistoryViewModel extends GetxController {
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   Future<void> leadDetailAssignHistory(BuildContext context) async {
//     loading.value = true;
//     _api.leadDetailAssignHistory().then((value) {
//       if (value.isNotEmpty) {
//         for (var responseData in value) {
//           if (kDebugMode) {
//             print(
//                 "Lead Detail Assign History Department ${responseData.department?.name}");
//             print("Lead Detail Assign History User${responseData.user?.id}");
//             print(
//                 "Lead Detail Assign History User  last${responseData.user?.firstName}");
//           }
//           // Utils.snackbarSuccess('Lead Detail Proposal data fetch');
//         }
//         loading.value = false;
//       } else {
//         // Utils.snackbarFailed('Lead Detail activity call not fetched');
//       }
//     }).onError((error, stackTrace) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     });
//   }
// }
