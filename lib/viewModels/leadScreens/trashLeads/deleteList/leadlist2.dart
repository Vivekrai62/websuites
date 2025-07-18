// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:developer' as developer;
// import '../../../../data/models/responseModels/leads/LeadTrash/TrashLeads.dart';
// import '../../../../data/repositories/repositories.dart';
//
// Future<void> deleteList(BuildContext context) async {
//   try {
//     isLoading.value = true;
//
//     // First fetch the trash leads
//     LeadTrashResponseModel response = await _repository.getTrashListApi();
//
//     if (response.items.isNotEmpty) {
//       trashLeads.clear();
//       trashLeads.addAll(response.items);
//
//       _logTrashLeadsData(response);
//
//       // Log the lead IDs for deletion
//       List<String> leadIds = trashLeads.map((item) => item.id!).toList();
//       developer.log('Deleting lead IDs: $leadIds', name: 'DeleteListViewModel');
//
//       // Delete the leads
//       await _repository.deleteLeadsApi(leadIds);
//
//       // Clear the local customer_list after successful deletion
//       trashLeads.clear();
//
//       // Show success message
//       showSuccessDialog(context, 'Leads successfully deleted');
//     } else {
//       showInfoDialog(context, 'No leads found in trash');
//     }
//   } catch (e, stackTrace) {
//     developer.log('Error during lead deletion', error: e, stackTrace: stackTrace, name: 'DeleteListViewModel');
//
//     if (e.toString().contains('foreign key constraint fails')) {
//       showErrorDialog(context, 'Cannot delete leads due to existing references.');
//     } else {
//       showErrorDialog(context, 'Failed to delete leads: ${e.toString()}');
//     }
//   } finally {
//     isLoading.value = false;
//   }
// }
