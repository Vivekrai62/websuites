import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/leads/trashLeads/leadTypes/lead_types_response_model.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../views/leadScreens/leadList/widgets/manat.dart';

class ListLeadTypeViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<FilterOptionItem> leadTypeItems = <FilterOptionItem>[].obs;
  RxList<LeadTypesResponseModel> leadTypesRes = <LeadTypesResponseModel>[].obs;

  Future<void> leadListLeadType(BuildContext context) async {
    loading.value = true;

    try {
      final value = await _api.leadListLeadType();

      if (value.isNotEmpty) {
        // Save the full response to leadTypesRes list
        leadTypesRes.value = value;

        // Create the filtered items list for the UI
        leadTypeItems.value = value.map((leadType) {
          return FilterOptionItem(label: leadType.name ?? "Unknown");
        }).toList();
      } else {
        // Optionally handle the empty response case
        // Utils.snackbarFailed('No lead types found.');
      }
    } catch (error, stacktrace) {
      // Handle errors and print stacktrace for debugging
      // print("Error in leadListLeadType: $error");
      // print("Stacktrace: $stacktrace");
      // Utils.snackbarFailed('Error fetching lead types: $error');
    } finally {
      loading.value = false; // Ensure loading is updated
    }
  }

  void filterLeadsType(String query) {
    if (query.isEmpty) {
      // Reset to the full list when the query is empty
      leadTypeItems.assignAll(leadTypesRes.map((leadType) {
        return FilterOptionItem(label: leadType.name ?? "Unknown");
      }).toList());
    } else {
      // Filter leadTypeItems based on the query
      leadTypeItems.assignAll(leadTypesRes.where((leadType) {
        final name = leadType.name ?? '';
        return name.toLowerCase().contains(query.toLowerCase());
      }).map((leadType) {
        return FilterOptionItem(label: leadType.name ?? "Unknown");
      }).toList());
    }
  }
}
