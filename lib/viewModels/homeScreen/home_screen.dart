// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../Utils/utils.dart';
// import '../../data/repositories/repositories.dart';
//
// class HomeScreenViewModel extends GetxController {
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   Future<void> dashboard(BuildContext context)async{
//     loading.value = true;
//     _api.dashboardApi().then((value){
//       if(value.id != null){
//         Utils.snackbarSuccess('charts fetched');
//
//       }else{
//         Utils.snackbarFailed('charts not fetched');
//       }
//       loading.value = false;
//
//     }).onError((error, stackTrace) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     }
//     );
//   }
// }
//
