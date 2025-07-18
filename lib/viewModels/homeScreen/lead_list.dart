//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// import '../../../Utils/utils.dart';
//
// class HomeScreenLeadListViewModel extends GetxController {
//
//   final _api = LoginRepository();
//
//   RxBool loading = false.obs;
//
//   Future<void> DB_LeadList(BuildContext context)async{
//
//     loading.value = true;
//     _api.DB_LeadsListApi().then((value){
//       if(value.items != null){
//         Utils.SnackbarSuccess('leads customer_list fetched');
//
//       }else{
//         Utils.SnackbarFailed('leads customer_list not fetched');
//       }
//       loading.value = false;
//
//     }).onError((error, stackTrace){
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     }
//     );
//   }
// }