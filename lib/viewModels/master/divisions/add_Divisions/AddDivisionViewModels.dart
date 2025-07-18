import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for JSON decoding

import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/master/division/add_division/AddDivisionRequestModels.dart';
import '../../../../data/models/responseModels/master/divisions/add_division/AddDivisionResponseModels.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../resources/appUrls/app_urls.dart';

class AddDivisionViewModels extends GetxController {
  final Repositories _api = Repositories();
  RxBool loading = false.obs;
  RxList<AddDivisionResponseModels> masterAddDivision = <AddDivisionResponseModels>[].obs;

  Future<void> addDivisionSettingApi(
      BuildContext context,
      AddDivisionRequestModels addDivision,
      String? filePath, // Add filePath parameter
      ) async {
    loading.value = true;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(AppUrls.masterAddDivision));

      final sp = await SharedPreferences.getInstance();
      String? token = sp.getString('accessToken');
      request.headers['Authorization'] = 'Bearer $token';

      request.fields['name'] = addDivision.name ?? '';
      request.fields['mobileNo'] = addDivision.mobileNo ?? '';
      request.fields['contactPerson'] = addDivision.contactPerson ?? '';
      request.fields['email'] = addDivision.email ?? '';
      request.fields['address'] = addDivision.address ?? '';

      print('Request Fields: ${request.fields}');

      if (filePath != null) {request.files.add(await http.MultipartFile.fromPath('logo', filePath));
      }

      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> jsonResponse = json.decode(responseBody); // Decode the JSON string
        final newDivision = AddDivisionResponseModels.fromJson(jsonResponse); // Pass the decoded JSON
        masterAddDivision.add(newDivision); // Add the new division to the customer_list
        Utils.snackbarSuccess('Division added successfully');
      } else {
        final responseBody = await response.stream.bytesToString();
        Utils.snackbarFailed('Failed to add division: ${response.reasonPhrase}');
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error: $error");
      }
      Utils.snackbarFailed('Failed to add division');
    } finally {
      loading.value = false; // Set loading to false after the request is complete
    }
  }
}