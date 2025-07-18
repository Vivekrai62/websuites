// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
//
// import '../../../Utils/utils.dart';
// import '../../data/repositories/repositories.dart';
//
// class HomeScreenLeadSourceViewModel extends GetxController {
//    final _api = Repositories();
//    RxBool loading = false.obs;
//    Future <void> LeadSource(BuildContext, context) async {
//       loading.value = true;
//
//       _api.dbLeadsSourceApi().then((response){
//
//          if(response.id != null){
//
//             Utils.snackbarSuccess('lead Source Yes');
//             loading.value = false;
//
//          }else{
//             Utils.snackbarFailed('lead Source No');
//
//          }
//       }).onError((error, stackTrace) {
//          if (kDebugMode) {
//             print(error.toString());
//          }
//       });
//
//    }
// }