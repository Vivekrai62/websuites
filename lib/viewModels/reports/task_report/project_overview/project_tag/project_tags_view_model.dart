// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import '../../../../../Utils/utils.dart';
// import '../../../../../data/repositories/repositories.dart';
// class ProjectTagViewModel extends GetxController{
//
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   Future<void> taskProjectTag(BuildContext context) async {
//     loading.value = true;
//     _api.projectTag().then((response) {
//       if(response.isNotEmpty){
//         for (var responseData in response) {
//             print("Project tag  List name ${responseData.name}");
//           Utils.snackbarSuccess('Lead Detail Proposal data fetch');
//         }
//         loading.value = false;
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
// }