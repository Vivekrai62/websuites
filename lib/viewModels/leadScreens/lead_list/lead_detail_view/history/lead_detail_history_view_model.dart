// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
//
// import '../../../../../Utils/utils.dart';
// import '../../../../../data/models/requestModels/lead/lead_list/lead_detail_view/history/lead_detail_history_request_model.dart';
// import '../../../../../data/repositories/repositories.dart';
//
// class LeadDetailHistoryViewModel extends GetxController{
//
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   Future<void> leadDetailHistory(BuildContext context) async {
//     loading.value = true;
//     LeadDetailHistoryRequestModel leadDetailHistoryRequestModel = LeadDetailHistoryRequestModel(activity:"all");
//     _api.leadDetailHistory(leadDetailHistoryRequestModel.toJson()).then((value) {
//       if(value.isNotEmpty){
//         for (var responseData in value) {
//           if (kDebugMode) {
//             print("Lead Detail  History Department ${responseData.activity}");
//             print("Lead Detail  History User${responseData.remark}");
//             print("Lead Detail  History Meeting ${responseData.meetingWithName}");
//             print("Lead Detail  History User  last${responseData.createdBy?.firstName}");
//           }
//           Utils.snackbarSuccess('Lead Detail Proposal data fetch');
//         }
//         loading.value = false;
//       }
//       else {
//         Utils.snackbarFailed('Lead Detail activity call not fetched');
//       }
//     }).onError((error, stackTrace) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     });
//   }
//
//
//
// }
//
//
