import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../data/models/requestModels/role/edit_role/check_box_permission/RoleCheckEditRequestModel.dart';
import '../../../../../data/models/responseModels/roles/edit_role/check_box_permission/RoleCheckEditResponseModel.dart';

class RoleEditCheckController {
  final String baseUrl = 'https://dev.whsuites.com/api/role-permissions/';
  final String permissionId;

  // Constructor to accept id dynamically
  RoleEditCheckController({required this.permissionId});

  // Method to call the PATCH API and handle the response
  Future<RoleCheckEditResponseModel> roleCheckEditApi(
      List<RoleEditCheckRequestModel> requestBody) async {
    final url = Uri.parse('$baseUrl$permissionId'); // Full API URL

    try {
      // Sending PATCH request to API
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody
            .map((e) => e.toJson())
            .toList()), // Convert request body to JSON
      );

      if (response.statusCode == 201) {
        // Static Success: 201 indicates successful creation
        return RoleCheckEditResponseModel(
            success: true, message: 'Resource created successfully.');
      } else {
        // Static Failure: Something went wrong
        return RoleCheckEditResponseModel(
            success: false,
            message:
                'Failed to create resource. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network error or exception
      return RoleCheckEditResponseModel(
          success: false, message: 'Error occurred: $error');
    }
  }
}
