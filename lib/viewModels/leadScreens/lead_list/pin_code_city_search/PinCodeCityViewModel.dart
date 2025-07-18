import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../data/models/responseModels/leads/list/pin_code_city_search/PinCodeCityResModel.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../data/network/network_api_services.dart';

import 'package:get/get.dart';
import '../../../../../data/models/responseModels/leads/list/pin_code_city_search/PinCodeCityResModel.dart';
import '../../../../../data/repositories/repositories.dart';

class PinCodeCityViewModel extends GetxController {
  final Repositories _repositories = Repositories();
  RxBool loading = false.obs;
  RxList<PinCodeCityModelResModel> leadPinCodeSearch = <PinCodeCityModelResModel>[].obs;
  RxString errorMessage = ''.obs;
  RxList<PinCodeCityModelResModel> allCities = <PinCodeCityModelResModel>[].obs;

  Future<void> searchCities(String stateId, String searchQuery) async {
    print('🚀 [ViewModel] searchCities called');
    print('🏛️ [ViewModel] StateId: $stateId');
    print('🔍 [ViewModel] SearchQuery: "$searchQuery"');

    if (stateId.isEmpty) {
      errorMessage.value = 'Invalid state ID';
      print('❌ [ViewModel] Invalid state ID provided');
      return;
    }

    final queryToUse = searchQuery.isEmpty ? '' : searchQuery;
    print('🎯 [ViewModel] Query to use: "$queryToUse"');

    loading.value = true;
    print('⏳ [ViewModel] Loading started...');

    try {
      final cities = await _repositories.leadPinCodeCitySearch(stateId, queryToUse);
      print('📦 [ViewModel] Received cities from repository: ${cities.length}');

      if (cities.isNotEmpty) {
        print('🏙️ [ViewModel] City list:');
        for (int i = 0; i < cities.length; i++) {
          print('   ${i + 1}. ${cities[i].name} (ID: ${cities[i].id})');
        }
        allCities.assignAll(cities);
        leadPinCodeSearch.assignAll(cities);
        errorMessage.value = '';
      } else {
        errorMessage.value = searchQuery.isEmpty ? 'Please enter a city name to search' : 'No cities found for "$searchQuery"';
        leadPinCodeSearch.clear();
        print('⚠️ [ViewModel] No cities found for query: "$searchQuery"');
      }
    } catch (error, stackTrace) {
      errorMessage.value = 'Error fetching city data: $error';
      leadPinCodeSearch.clear();
      print('💥 [ViewModel] Error: $error');
      print('📍 [ViewModel] StackTrace: $stackTrace');
    } finally {
      loading.value = false;
      print('🏁 [ViewModel] Loading completed. Cities: ${leadPinCodeSearch.length}, Error: "${errorMessage.value}"');
    }
  }

  void filterCities(String query) {
    if (query.isEmpty) {
      leadPinCodeSearch.assignAll(allCities);
    } else {
      final filteredCities = allCities.where((city) {
        final cityName = city.name ?? '';
        return cityName.toLowerCase().contains(query.toLowerCase());
      }).toList();

      filteredCities.sort((a, b) {
        final aName = a.name ?? '';
        final bName = b.name ?? '';
        final aStartsWith = aName.toLowerCase().startsWith(query.toLowerCase());
        final bStartsWith = bName.toLowerCase().startsWith(query.toLowerCase());
        if (aStartsWith && !bStartsWith) return -1;
        if (!aStartsWith && bStartsWith) return 1;
        return aName.compareTo(bName);
      });

      leadPinCodeSearch.assignAll(filteredCities);
    }
  }

  void clear() {
    print('🧹 [ViewModel] Clearing state');
    leadPinCodeSearch.clear();
    allCities.clear();
    errorMessage.value = '';
  }
}