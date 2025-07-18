import 'package:get/get.dart';

import '../../../../data/models/requestModels/role/edit_role/RoleListEditRequestModel.dart';
import '../../../../data/network/network_api_services.dart';
import '../../../../resources/appUrls/app_urls.dart';

class RoleListEditViewModel extends GetxController {
  final _loading = false.obs;
  final _error = ''.obs;
  final NetworkApiServices _apiService = NetworkApiServices();

  bool get loading => _loading.value;
  String get error => _error.value;

  Future<bool> roleListEditApi(
    String roleId, {
    required String name,
    required String description,
  }) async {
    try {
      _loading.value = true;
      _error.value = '';

      final data = RoleListEditRequestModel(
        name: name,
        description: description,
      ).toJson();

      String url = AppUrls.roleEdit(roleId); // Pass the roleId to the URL
      await _apiService.patchApi(url, data);
      return true;
    } catch (e) {
      print("Error updating role: $e");
      _error.value = e.toString();
      return false;
    } finally {
      _loading.value = false;
    }
  }
}
