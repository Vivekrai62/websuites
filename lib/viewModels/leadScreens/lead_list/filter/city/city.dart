import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../data/models/requestModels/customer/customer_city/customer_city.dart';
import '../../../../../data/models/responseModels/customers/list/customer_city/customer_city.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../../views/leadScreens/leadList/widgets/manat.dart';

class FilterCityViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<FilterOptionItem> leadCityFilters = <FilterOptionItem>[].obs;

  CitySearchRequestModel leadsCitiesFilters =
      CitySearchRequestModel(search: '');

  Future<void> filterCityApi(BuildContext context) async {
    loading.value = true;
    try {
      // Use the leadsCitiesFilters model that's defined in the class
      FilterCityResponseModel response =
          await _api.filterCityApi(leadsCitiesFilters.toJson());

      // Check if items exist and have data
      if (response.items != null && response.items!.isNotEmpty) {
        leadCityFilters.value = response.items!.map((item) {
          return FilterOptionItem(label: item.name ?? "Unknown");
        }).toList();
        print(response.items?.first.state?.name);
        // Utils.snackbarSuccess('Lead Filter city fetched successfully');
      } else {
        // Utils.snackbarFailed('No leads found');
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      // Utils.snackbarFailed('An error occurred while fetching cities');
    } finally {
      loading.value = false;
    }
  }
}
