import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/models/responseModels/leads/createNewLead/city/city_search.dart';
import '../../../../data/repositories/repositories.dart';
class CreateLeadCityViewModel extends GetxController{
  var repository = Repositories();
  RxBool isLoading = false.obs;
  RxList<CityResponseModel> pincodeList = <CityResponseModel>[].obs;
  RxString errorMessage = ''.obs;
  var filteredPincodeList = <CityResponseModel>[].obs; // List to display matching pincodes
  RxString matchingCity = ''.obs; // The city name or related information for the pincode
  RxString matchingState = ''.obs; // To store state name
  RxString matchingDistrict = ''.obs; // To store district name
  RxInt selectedIndex = (-1).obs;


  Future<void>searchCity(String query)async{
    if (query.isEmpty) {
      errorMessage.value = 'Please enter at least 3 characters';
      filteredPincodeList.clear();
      return;
    }
    else {
      // Clear the error message if query length is 3 or more
      errorMessage.value = '';
    }

    try {
      isLoading.value = true; // Start loading
      // Call the API with the query parameter
      List<CityResponseModel> response = await repository.createNewLeadCityApi(query);
      pincodeList.value = response; // Set the data from API
      if (response.isNotEmpty) {
        filteredPincodeList.value = response; // Update filtered customer_list with response
        var firstMatch = filteredPincodeList.first; // Take first matching pincode
        // Safely extract district and state names
        matchingCity.value = firstMatch.name?? "No Value";
        matchingState.value = firstMatch.state?.name ?? "No Value";
      } else {
        // Reset values if no matching pincode found
        matchingCity.value = "No matching city found";
        matchingState.value = "";
        matchingDistrict.value = "";
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error searching pin code: $e");
      }
      errorMessage.value = "Error fetching pincode details.";
    } finally {
      isLoading.value = false; // Stop loading
    }
  }



}