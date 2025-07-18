import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/master/division/update/UpdateDivisionRequestModels.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../resources/appUrls/app_urls.dart';

class UpdateDivisionViewModel extends GetxController {
  final Repositories _api = Repositories();
  RxBool loading = false.obs;

  Future<void> updateDivisionSettingApi(BuildContext context, String id, UpdateDivisionRequestModels updateDivisionRequestModel, String? filePath) async {
    loading.value = true;

    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(AppUrls.updateDivisionList(id)));

      final sp = await SharedPreferences.getInstance();
      String? token = sp.getString('accessToken');

      request.headers['Authorization'] = 'Bearer $token';

      // Add the fields to the request
      request.fields['name'] = updateDivisionRequestModel.name ?? '';
      request.fields['mobileNo'] = updateDivisionRequestModel.mobileNo ?? '';
      request.fields['status'] = updateDivisionRequestModel.status ?? '';
      request.fields['contactPerson'] = updateDivisionRequestModel.contactPerson ?? '';
      request.fields['email'] = updateDivisionRequestModel.email ?? '';
      request.fields['address'] = updateDivisionRequestModel.address ?? '';

      print('Request Fields: ${request.fields}');

      if (filePath != null) {
        request.files.add(await http.MultipartFile.fromPath('logo', filePath));
        // print('File added: $filePath');
      }

      // Send the request
      var response = await request.send();

      // // Log the response status code
      // print('Response Status Code: ${response.statusCode}');

      // Handle the response
      if (response.statusCode == 200) {
        Utils.snackbarSuccess('Division updated successfully');
        // print('Update Division Message: ${response.reasonPhrase}');
      } else {
        // Read the response body for more details
        final responseBody = await response.stream.bytesToString();
        // print('Response Body: $responseBody');

        // Handle unauthorized error
        if (response.statusCode == 401) {
          Utils.snackbarFailed('Unauthorized: Please log in again.');
        } else {
          // Check for specific error message
          if (responseBody.contains("No file provided.")) {
            Utils.snackbarFailed('No File Provided.');
          } else {
            Utils.snackbarFailed('Failed to update division: ${response.reasonPhrase}');
          }
        }
      }
    } catch (error) {
      if (kDebugMode) print("Error: $error");
    } finally {
      loading.value = false; // Set loading to false after the request is complete
    }
  }
}