import 'package:get/get.dart';

import '../../../../data/models/responseModels/leads/createNewLead/divisions/divisions_response_model.dart';
import '../../../../data/repositories/repositories.dart';

class DivisionsViewModel extends GetxController {
  final Repositories _api = Repositories();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<DivisionsResponseModel> divisionsList = <DivisionsResponseModel>[].obs;
  RxList<String> selectedDivisions = <String>[].obs;

  @override 
  void onInit() {
    super.onInit();
    fetchDivisions(); // Fetch divisions on initialization
  }

  void toggleDivisionSelection(String division) {
    if (selectedDivisions.contains(division)) {
      selectedDivisions.remove(division);
    } else {
      selectedDivisions.add(division);
    }
    // print('Selected Divisions: $selectedDivisions');
    selectedDivisions.refresh();
  }

  Future<void> fetchDivisions() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final List<DivisionsResponseModel> response =
      await _api.createNewLeadDivisionsApi();
      divisionsList.assignAll(response);
    } catch (e) {
      errorMessage.value = 'Error fetching divisions: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void updateSelectedDivisions(List<String> divisions) {
    selectedDivisions.assignAll(divisions);
  }
}