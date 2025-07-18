import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/master/cities/master_cities_response_model.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../utils/utils.dart';

class MasterCitiesViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  // Store the response model
  Rx<MasterCitiesResponseModel?> citiesData = Rx<MasterCitiesResponseModel?>(null);

  Future<void> masterCities(BuildContext context) async {
    loading.value = true;
    try {
      final value = await _api.masterCitiesApi();
      if (value.items != null) {
        citiesData.value = value;
        Utils.snackbarSuccess('Cities fetched successfully');
      } else {
        Utils.snackbarFailed('No cities data available');
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      Utils.snackbarFailed('Failed to fetch cities');
    } finally {
      loading.value = false;
    }
  }
}
