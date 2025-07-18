// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../Utils/utils.dart';
// import '../../../../../data/models/responseModels/leads/customer_list/filter/userlist/LeadUserFilterResModel.dart';
// import '../../../../../data/repositories/repositories.dart';
// import '../../../../../views/leadScreens/leadList/widgets/manat.dart';
//
// class LeadUserListViewModel extends GetxController {
// final _api = Repositories();
// RxBool loading = false.obs;
// RxList<FilterOptionItem> searchAssi = <FilterOptionItem>[].obs;
//
// Future<void> leadUsersApi(BuildContext context) async {
//   loading.value = true;
//
//   try {
//   final List<LeadUserFilterResModel> response = await _api.leadUsersApi();
//   loading.value = false;
//
//   if (response.isNotEmpty) {
//   searchAssi.clear();
//   for (var user in response) {
//   if (user.id != null) {
//   String userName = "${user.firstName ?? ''} ${user.lastName ?? ''}".trim();
//   searchAssi.add(FilterOptionItem(label: userName, id: user.id!));
//   }
//   }
//   Utils.snackbarSuccess('Lead Users loaded successfully');
//   } else {
//   Utils.snackbarFailed('No Lead users found');
//   }
//   } catch (error) {
//   loading.value = false;
//   Utils.snackbarFailed('Failed to load users: ${error.toString()}');
//   }
// }
// }