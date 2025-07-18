import 'package:get/get.dart';
import 'package:websuites/data/models/responseModels/leads/createNewLead/pincode/pincode.dart';
import 'package:websuites/data/repositories/repositories.dart';

import '../../../../data/models/responseModels/leads/createNewLead/city/city_search.dart';
import '../../../../data/models/responseModels/leads/list/pin_code_city_search/PinCodeCityResModel.dart';
import '../../../../data/network/network_api_services.dart';
import '../../../../resources/appUrls/app_urls.dart';
import '../../lead_list/pin_code_city_search/PinCodeCityViewModel.dart';

class PinCodeViewModel extends GetxController {
  final _apiService = NetworkApiServices();
  final Repositories _repository = Repositories();
  final PinCodeCityViewModel _cityViewModel = Get.put(PinCodeCityViewModel());

  RxBool isLoading = false.obs;
  RxList<PinCodeModelResponseModel> searchResults = <PinCodeModelResponseModel>[].obs;
  RxString errorMessage = ''.obs;
  RxString apiResponse = ''.obs;

  RxString matchingCity = ''.obs;
  RxString matchingState = ''.obs;
  RxString matchingDistrict = ''.obs;
  RxString matchingCountry = ''.obs;
  RxString stateId = ''.obs;

  RxList<PinCodeModelResponseModel> allPincodes = <PinCodeModelResponseModel>[].obs;
  RxList<CityResponseModel> cityResults = <CityResponseModel>[].obs;

  List<PinCodeModelResponseModel> get filteredPincodeList => searchResults.toList();

  void searchPartialPincode(String partialQuery) {
    print('🔍 [PinCodeViewModel] searchPartialPincode called with query: "$partialQuery"');
    errorMessage.value = '';
    print('  Cleared errorMessage');

    if (partialQuery.isEmpty) {
      print('  Query is empty, clearing results');
      _clearResults();
      return;
    }

    if (allPincodes.isNotEmpty) {
      print('  Filtering pincodes from allPincodes (count: ${allPincodes.length})');
      searchResults.value = allPincodes
          .where((pincode) => pincode.code != null && pincode.code!.startsWith(partialQuery))
          .toList();
      print('  Filtered results: ${searchResults.map((p) => p.code).toList()}');
    } else {
      print('  allPincodes is empty, no filtering performed');
    }

    if (searchResults.isEmpty && partialQuery.length < 6) {
      print('  No results and query length < 6, keeping errorMessage empty');
      errorMessage.value = '';
    }
  }

  Future<void> searchPincode(String query, {String? providedStateId}) async {
    print('🚀 [PinCodeViewModel] searchPincode called with query: "$query"');
    print('  Query length: ${query.length}');
    print('  Provided StateId: ${providedStateId ?? "null"}');
    print('  Current searchResults length: ${searchResults.length}');
    print('  Current allPincodes length: ${allPincodes.length}');

    if (query.isEmpty) {
      print('❌ Error: Empty pincode');
      errorMessage.value = 'Please enter a pincode';
      _clearResults();
      return;
    }

    if (query.length != 6 || !RegExp(r'^\d{6}$').hasMatch(query)) {
      print('❌ Error: Invalid pincode format (must be 6 digits)');
      errorMessage.value = 'Please enter a valid 6-digit pincode';
      _clearResults();
      return;
    }

    try {
      print('⏳ Setting isLoading to true');
      isLoading.value = true;
      errorMessage.value = '';
      apiResponse.value = '';

      // Use provided stateId or the one from previous search
      String? searchStateId = providedStateId ?? (stateId.value.isNotEmpty ? stateId.value : null);

      print('📡 Calling createLeadPinCode API with pincode: $query, stateId: ${searchStateId ?? "null"}');
      final results = await _repository.createLeadPinCode(query, stateId: searchStateId);
      print('✅ createLeadPinCode API call completed');
      print('  Raw results count: ${results.length}');

      if (results.isNotEmpty) {
        print('📋 API Results:');
        for (int i = 0; i < results.length; i++) {
          final result = results[i];
          print('    [$i] Code: ${result.code}');
          print('        District: ${result.district?.name}');
          print('        State: ${result.district?.state?.name}');
          print('        Country: ${result.district?.state?.country?.name}');
          print('        State ID: ${result.district?.state?.id}');
        }

        print('  Assigning results to searchResults');
        searchResults.assignAll(results);
        searchResults.refresh(); // Ensure UI updates
        print('  searchResults updated, new length: ${searchResults.length}');
        allPincodes.assignAll(results);
        print('  allPincodes updated, length: ${allPincodes.length}');

        var first = results.first;
        matchingCity.value = first.district?.name ?? 'No City';
        matchingState.value = first.district?.state?.name ?? 'No State';
        matchingDistrict.value = first.district?.name ?? 'No District';
        matchingCountry.value = first.district?.state?.country?.name ?? 'No Country';
        stateId.value = first.district?.state?.id ?? '';
        apiResponse.value = 'Pincode details fetched successfully';

        print('📍 Updated matching fields:');
        print('    City: ${matchingCity.value}');
        print('    State: ${matchingState.value}');
        print('    District: ${matchingDistrict.value}');
        print('    Country: ${matchingCountry.value}');
        print('    State ID: ${stateId.value}');

        // Since we already have the district data from pincode API,
        // we should use that instead of making another API call
        if (first.district?.name != null) {
          print('🏙️ Using district data from pincode API: ${first.district?.name}');
          final cityData = PinCodeCityModelResModel(
            name: first.district?.name,
            id: first.district?.id,
          );
          print('  Created city data: name="${cityData.name}", id="${cityData.id}"');
          _cityViewModel.leadPinCodeSearch.assignAll([cityData]);
          _cityViewModel.leadPinCodeSearch.refresh();
          print('  Updated _cityViewModel.leadPinCodeSearch, length: ${_cityViewModel.leadPinCodeSearch.length}');
        }

        // Optional: If you still need to fetch additional city data,
        // call the leadPinCodeCitySearch method instead of createNewLeadCityApi
        if (stateId.value.isNotEmpty) {
          print('📡 Calling leadPinCodeCitySearch API with stateId: ${stateId.value}, pincode: $query');
          // await _cityViewModel.leadPinCodeCitySearch(stateId.value, query);
          print('✅ leadPinCodeCitySearch completed');
          print('  Cities fetched count: ${_cityViewModel.leadPinCodeSearch.length}');
          if (_cityViewModel.leadPinCodeSearch.isNotEmpty) {
            print('  Cities found: ${_cityViewModel.leadPinCodeSearch.map((city) => city.name).toList()}');
          } else {
            print('  No additional cities found for stateId: ${stateId.value}, pincode: $query');
          }
        }
      } else {
        print('❌ No matching pincode found');
        errorMessage.value = 'No matching pincode found. Please verify the pincode.';
        _clearResults();
      }
    } catch (e, stackTrace) {
      print('💥 [PinCodeViewModel] Error in searchPincode: $e');
      print('  StackTrace: $stackTrace');
      errorMessage.value = 'Error fetching pincode details: ${e.toString().replaceAll('Exception: ', '')}';
      _clearResults();
    } finally {
      print('🏁 searchPincode completed');
      isLoading.value = false;
      print('  Final state:');
      print('    isLoading: ${isLoading.value}');
      print('    searchResults length: ${searchResults.length}');
      print('    filteredPincodeList length: ${filteredPincodeList.length}');
      print('    errorMessage: "${errorMessage.value}"');
      print('    apiResponse: "${apiResponse.value}"');
    }
  }

  Future<void> _fetchCityData(String cityName) async {
    print('🏙️ [_fetchCityData] Called with cityName: "$cityName"');
    try {
      print('  Calling createNewLeadCityApi');

      // Add type safety and error handling
      dynamic apiResponse = await _repository.createNewLeadCityApi(cityName);
      print('  Raw API response type: ${apiResponse.runtimeType}');
      print('  Raw API response: $apiResponse');

      List<CityResponseModel> cities = [];

      // Handle different response types
      if (apiResponse is List) {
        // If it's already a list, cast it
        cities = (apiResponse as List).cast<CityResponseModel>();
      } else if (apiResponse is Map) {
        // If it's a single object in a map, try to convert
        try {
          final cityModel = CityResponseModel.fromJson(apiResponse as Map<String, dynamic>);
          cities = [cityModel];
        } catch (e) {
          print('  Error converting Map to CityResponseModel: $e');
          throw Exception('Invalid city data format received from API');
        }
      } else {
        print('  Unexpected response type: ${apiResponse.runtimeType}');
        throw Exception('Unexpected response format from city API');
      }

      print('✅ createNewLeadCityApi completed, results: ${cities.map((e) => e.name).toList()}');
      cityResults.assignAll(cities);
      print('  cityResults updated, length: ${cityResults.length}');

      if (cities.isNotEmpty) {
        print('  City data fetched successfully, count: ${cities.length}');
        // Update _cityViewModel with city data
        _cityViewModel.leadPinCodeSearch.assignAll(
          cities.map((city) => PinCodeCityModelResModel(name: city.name, id: city.id)).toList(),
        );
        _cityViewModel.leadPinCodeSearch.refresh();
        print('  Updated _cityViewModel.leadPinCodeSearch with ${cities.length} cities');
      } else {
        print('  No cities found from createNewLeadCityApi');
      }
    } catch (e, stackTrace) {
      print('💥 [_fetchCityData] Error: $e');
      print('  StackTrace: $stackTrace');
      errorMessage.value = 'Error fetching city data: ${e.toString().replaceAll('Exception: ', '')}';
    }
  }

  void clear() {
    print('🧹 [PinCodeViewModel] Clearing state');
    _clearResults();
    errorMessage.value = '';
    apiResponse.value = '';
    stateId.value = '';
    cityResults.clear();
    _cityViewModel.clear();
    print('  State cleared');
  }

  void _clearResults() {
    print('🧹 [PinCodeViewModel] Clearing search results');
    searchResults.clear();
    matchingCity.value = '';
    matchingState.value = '';
    matchingDistrict.value = '';
    matchingCountry.value = '';
    cityResults.clear();
    print('  Results cleared');
  }
}