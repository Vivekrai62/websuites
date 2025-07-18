import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/models/requestModels/lead/lead_list/filter/state/StateFilterResponseModel.dart';
import '../../../../../data/models/responseModels/leads/list/filter/country_code/country_code.dart';
import '../../../../../data/repositories/repositories.dart';
class LeadListCountryCodeViewModel extends GetxController{
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<CountriesWithPhoneCode> countryListCode = <CountriesWithPhoneCode>[].obs;

  Future<void> countryCodeApi(BuildContext context) async {
    loading.value = true; // Set loading to true
    try {
      final response = await _api.countryCodeApi();
      if (response.countriesWithPhoneCode != null &&
          response.countriesWithPhoneCode!.isNotEmpty) {
        // Sort the countries by name in ascending order
        response.countriesWithPhoneCode!.sort((a, b) =>
            (a.name ?? '').compareTo(b.name ?? ''));

        // Update the observable customer_list
        countryListCode.value = response.countriesWithPhoneCode!;
        // Utils.snackbarSuccess('Lead customer_list Country code fetched successfully');
      } else {
        // Utils.snackbarFailed('No leads found');
      }
    } catch (error) {
      // Utils.snackbarFailed('Failed to fetch leads');
      // print('Error: $error');
    } finally {
      loading.value = false; // Set loading to false
    }
  }



  }


class StateListViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<StateFilterResponseModel> stateList = <StateFilterResponseModel>[].obs;

  Future<void> stateFilter(String countryId) async {
    loading.value = true;
    try {
      final response = await _api.stateFilter(countryId); // Pass the countryId to the API call
      if (response.isNotEmpty) {
        response.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
        stateList.assignAll(response);
        // Utils.snackbarSuccess('State customer_list fetched successfully');
      } else {
        // Utils.snackbarFailed('No state found');
      }
    } catch (error) {
      // Utils.snackbarFailed('Failed to fetch state');
      // print('Error: $error');
    } finally {
      loading.value = false;
    }
  }


}







