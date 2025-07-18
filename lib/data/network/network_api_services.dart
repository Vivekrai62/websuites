import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Utils/Routes/routes_name.dart';
import '../../viewModels/saveToken/save_token.dart';
import '../app_exceptions.dart';
import 'base_api_services.dart';

// class NetworkApiServices extends BaseApiServices {
//   @override
//   Future getApi(String url) async {
//     if (kDebugMode) {
//       print(url);
//     }
//     dynamic responseJson;
//     try {
//       final sp = await SharedPreferences.getInstance();
//       String? token = sp.getString('accessToken');
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer ${token ?? ''}',
//         },
//       ).timeout(const Duration(seconds: 90));
//       if (response.statusCode == 200) {
//         print("Response");
//         // Decode the response body as a List of dynamic
//         // List<dynamic> responseJson = jsonDecode(response.body);
//         // Convert the customer_list of dynamic to a customer_list of LeadSource objects
//         // List<SourceResponseModel> result = responseJson
//         //     .map((leadSourceJson) => SourceResponseModel.fromJson(leadSourceJson))
//         //     .toList();
//         // print("CreateLead ${result}");
//         // var data =result;
//         // print("Data ${data[0].id}");
//       }
//       // List<SourceResponseModel> leadSources = responseJson
//       //     .map((leadSourceJson) => LeadSource.fromJson(leadSourceJson))
//       //     .toList();
//
//       print("Response${response.body}");
//       responseJson = returnResponse(response);
//     } on TimeoutException {
//       //  _showTimeoutDialog();
//       throw RequestTimeOut('Request Time out');
//     } on SocketException {
//       throw InternetExceptions('Internet Exception');
//     } on Exception catch (e) {
//       _handleError(e);
//       rethrow;
//     }
//     return responseJson;
//   }
//
//   Future deleteApi(String url) async {
//     if (kDebugMode) {
//       print(url);
//     }
//     dynamic responseJson;
//     try {
//       final sp = await SharedPreferences.getInstance();
//       String? token = sp.getString('accessToken');
//
//       final response = await http.delete(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer ${token ?? ''}',
//         },
//       ).timeout(const Duration(seconds: 90));
//
//       responseJson = returnResponse(response);
//     } on TimeoutException {
//       throw RequestTimeOut('Request Time out');
//     } on SocketException {
//       throw InternetExceptions('');
//     } on Exception catch (e) {
//       _handleError(e);
//       rethrow; // Propagate the error up the chain
//     }
//     return responseJson;
//   }
//
//   @override
//   // It's optional  for check error
//   // Future patchApi(String url,dynamic data) async {
//   //   final sp = await SharedPreferences.getInstance();
//   //   String? token = sp.getString('accessToken');
//   //   if (kDebugMode) {
//   //     print(url);
//   //     print('PATCH Data: $data');
//   //     print('Requested Data: Patch $data}}');
//   //     print('PATCH Encoded Data: ${jsonEncode(data)}');
//   //   }
//   //   dynamic responseJson;
//   //   try {
//   //     final response = await http.patch(Uri.parse(url),
//   //       headers: {
//   //           "Authorization": "Bearer ${token ??''}",
//   //       },
//   //       body:data,
//   //       // body:data!= null?jsonEncode(data) :'',).timeout(const Duration(seconds: 90)
//   //     ).timeout(const Duration(seconds: 90));
//   //     print('Raw Response: ${response.body}'); // Check the raw response
//   //     print('Status Code: ${response.statusCode}');
//   //      print("patch data $data");
//   //     print("response payment Update $response");
//   //     final responseJson = returnResponse(response);
//   //     if(kDebugMode){
//   //       log(response.toString());
//   //     }
//   //     return responseJson;
//   //   } catch (e) {
//   //     print("Patch error Order Update $e");
//   //     _handleError(e);
//   //     rethrow;
//   //   }
//   //   // on TimeoutException {
//   //   //    _showTimeoutDialog();
//   //   //   throw RequestTimeOut('Request Time out');
//   //   // } on SocketException {
//   //   //   throw InternetExceptions('');
//   //   // } on Exception catch (e) {
//   //   //   _handleError(e);
//   //   //   print("Patch error$e");
//   //   //   rethrow; // Propagate the error up the chain
//   //   // }
//   //   return responseJson;
//   // } //
//
//   Future patchApi(String url, dynamic data) async {
//     final sp = await SharedPreferences.getInstance();
//     String? token = sp.getString('accessToken');
//
//     if (kDebugMode) {
//       print(url);
//       print('PATCH Request Data: $data');
//     }
//
//     try {
//       // Convert data to JSON string and set proper headers
//       final response = await http
//           .patch(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer ${token ?? ''}',
//           'Content-Type': 'application/json', // Add this header
//         },
//         body: jsonEncode(data), // Properly encode the data
//       )
//           .timeout(const Duration(seconds: 90));
//
//       if (kDebugMode) {
//         print('Response Status Code: ${response.statusCode}');
//         print('Response Body: ${response.body}');
//       }
//
//       return returnResponse(response);
//     } catch (e) {
//       print("Patch error: $e");
//       _handleError(e);
//       rethrow;
//     }
//   }
//
//   @override
//   Future<dynamic> postApiResponse(String url, data) async {
//     final sp = await SharedPreferences.getInstance();
//     String? token = sp.getString('accessToken');
//     if (kDebugMode) {
//       print(url);
//       print(token);
//       print('Requested Data Post: >>>>>>${jsonEncode(data)}');
//     }
//     try {
//       final response = await http
//           .post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer ${token ?? ''}"
//         },
//         body: data != null ? jsonEncode(data) : '',
//       )
//           .timeout(const Duration(seconds: 90));
//       final responseJson = returnResponse(response);
//       if (kDebugMode) {
//         print("response Project Reminder $responseJson");
//         log(response.toString());
//       }
//       return responseJson;
//     } catch (e) {
//       _handleError(e);
//       rethrow;
//     }
//   }
//
//   Future postApiResponseRequest(
//       http.MultipartRequest request, String token) async {
//     if (kDebugMode) {
//       print("Request Order Payments value $request");
//     }
//     try {
//       // Set the authorization header
//       request.headers['Authorization'] = 'Bearer ${token ?? ''}';
//       // Use http.Client to send the multipart request
//       final client = http.Client();
//       final response =
//       await client.send(request).timeout(const Duration(seconds: 60));
//
//       // Read and parse the response
//       final responseBody = await response.stream.bytesToString();
//       final responseJson =
//       returnResponse(http.Response(responseBody, response.statusCode));
//       if (kDebugMode) {
//         print("Json response : ${responseJson.toString()}");
//       }
//       final responseToken = response.headers['authorization'] ??
//           json.decode(responseBody)['authorization'];
//       // Close the client
//       client.close();
//
//       print("Response Token: $responseToken");
//
//       return responseJson;
//     } catch (e) {
//       _handleError(e);
//       rethrow; // Propagate the error up the chain
//     }
//   }
//
// // Helper function to handle errors
//   void _handleError(dynamic e) {
//     if (e is SocketException) {
//       print(" $e");
//       throw InternetExceptions('No internet');
//     } else if (e is TimeoutException) {
//       throw RequestTimeOut('Request Time out');
//     }
//   }
//
//   Future<String> postApiResponseToken() async {
//     final sp = await SharedPreferences.getInstance();
//     return sp.getString('accessToken') ?? '';
//   }
//
//   dynamic returnResponse(http.Response response) {
//     if (kDebugMode) {
//       print('Response Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//     }
//
//     switch (response.statusCode) {
//       case 200:
//       // Check if response body is empty or just contains plain text
//         if (response.body.isEmpty) {
//           return {'success': true, 'message': 'Operation completed successfully'};
//         }
//
//         try {
//           var responseJson = json.decode(response.body.toString());
//           return responseJson;
//         } catch (e) {
//           // If JSON parsing fails, return the plain text as a message
//           print('JSON parsing failed, returning plain text response');
//           return {'success': true, 'message': response.body};
//         }
//
//       case 201:
//         if (response.body.isEmpty) {
//           return {'success': true, 'message': 'Operation completed successfully'};
//         }
//
//         try {
//           var responseJson = json.decode(response.body.toString());
//           return responseJson;
//         } catch (e) {
//           return {'success': true, 'message': response.body};
//         }
//
//       case 400:
//         try {
//           var responseJson = json.decode(response.body.toString());
//           return responseJson;
//         } catch (e) {
//           return {'error': true, 'message': response.body};
//         }
//
//       case 401:
//         _handleUnauthorized();
//         break;
//
//       case 403:
//         try {
//           var responseJson = json.decode(response.body.toString());
//           return responseJson;
//         } catch (e) {
//           return {'error': true, 'message': response.body};
//         }
//
//       case 404:
//         try {
//           var responseJson = json.decode(response.body.toString());
//           return responseJson;
//         } catch (e) {
//           return {'error': true, 'message': response.body};
//         }
//
//       case 405:
//         try {
//           var responseJson = json.decode(response.body.toString());
//           return responseJson;
//         } catch (e) {
//           return {'error': true, 'message': response.body};
//         }
//
//       case 422:
//         try {
//           var responseJson = json.decode(response.body.toString());
//           return responseJson;
//         } catch (e) {
//           return {'error': true, 'message': response.body};
//         }
//
//       case 500:
//         try {
//           var responseJson = json.decode(response.body.toString());
//           return responseJson;
//         } catch (e) {
//           return {'error': true, 'message': response.body};
//         }
//
//       default:
//         throw FetchDataException(
//             'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
//     }
//   }
//
//   void _handleUnauthorized() async {
//     await Get.defaultDialog(
//       barrierDismissible: false,
//       title: "Session Expired",
//       middleText: "Your session has expired. Please log in again.",
//       onConfirm: () async {
//         // Clear any user-related data
//         await _logoutAndNavigateToSignIn();
//       },
//     );
//   }
//
//   Future<void> _logoutAndNavigateToSignIn() async {
//     SaveUserData userViewModel = SaveUserData();
//     userViewModel.removeUser();
//     Get.offAllNamed(RoutesName.login_screen);
//   }
//
//   @override
//   Future deleteApiResponse(String url) {
//     // TODO: implement deleteApiResponse
//     throw UnimplementedError();
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/routes/routes_name.dart' hide RoutesName;
import '../../viewModels/saveToken/save_token.dart';
import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getApi(String url) async {
    if (kDebugMode) {
      // print('🔍 GET URL: $url');
    }
    dynamic responseJson;
    try {
      final sp = await SharedPreferences.getInstance();
      String? token = sp.getString('accessToken');
      // print('🔍 Token: ${token != null ? "Present" : "Missing"}');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token ?? ''}',
        },
      ).timeout(const Duration(seconds: 90));
      //
      // print('🔍 Response Status Code: ${response.statusCode}');
      // print('🔍 Response Headers: ${response.headers}');

      if (kDebugMode) {
        // print('🔍 GET Response Body: ${response.body}');
      }
      responseJson = returnResponse(response);
      // print('🔍 Processed Response: $responseJson');
    } on TimeoutException {
      // print('❌ Timeout Exception');
      throw RequestTimeOut('Request timed out');
    } on SocketException {
      // print('❌ Socket Exception');
      throw InternetExceptions('No internet connection');
    } catch (e) {
      // print('❌ General Exception: $e');
      _handleError(e);
      rethrow;
    }
    return responseJson;
  }

  Future deleteApi(String url) async {
    if (kDebugMode) {
      // print('DELETE URL: $url');
    }
    dynamic responseJson;
    try {
      final sp = await SharedPreferences.getInstance();
      String? token = sp.getString('accessToken');
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token ?? ''}',
        },
      ).timeout(const Duration(seconds: 90));
      if (kDebugMode) {
        // print('DELETE Response: ${response.body}');
      }
      responseJson = returnResponse(response);
    } on TimeoutException {
      throw RequestTimeOut('Request timed out');
    } on SocketException {
      throw InternetExceptions('No internet connection');
    } catch (e) {
      _handleError(e);
      rethrow;
    }
    return responseJson;
  }

  @override
  Future patchApi(String url, dynamic data) async {
    final sp = await SharedPreferences.getInstance();
    String? token = sp.getString('accessToken');
    if (kDebugMode) {
      // print('PATCH URL: $url');
      // print('PATCH Request Data: $data');
    }
    try {
      final response = await http
          .patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token ?? ''}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      )
          .timeout(const Duration(seconds: 90));
      if (kDebugMode) {
        // print('PATCH Response Status Code: ${response.statusCode}');
        // print('PATCH Response Body: ${response.body}');
      }
      return returnResponse(response);
    } catch (e) {
      _handleError(e, context: 'PATCH');
      rethrow;
    }
  }

  // Add PUT API method
  Future<Map<String, dynamic>> putApi(String url, dynamic data) async {
    final sp = await SharedPreferences.getInstance();
    String? token = sp.getString('accessToken');
    if (kDebugMode) {
      print('PUT URL: $url');
      print('PUT Request Data: ${jsonEncode(data)}');
    }
    try {
      final response = await http
          .put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token ?? ''}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      )
          .timeout(const Duration(seconds: 90));
      if (kDebugMode) {
        print('PUT Response Status Code: ${response.statusCode}');
        print('PUT Response Body: ${response.body}');
      }
      return {
        'body': returnResponse(response),
        'statusCode': response.statusCode,
      };
    } catch (e) {
      _handleError(e, context: 'PUT');
      rethrow;
    }
  }

  @override
  Future<dynamic> postApiResponse(String url, dynamic data) async {
    final sp = await SharedPreferences.getInstance();
    String? token = sp.getString('accessToken');
    if (kDebugMode) {
      // print('POST URL: $url');
      // print('POST Token: $token');
      // print('POST Request Data: ${jsonEncode(data)}');
    }
    try {
      final response = await http
          .post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token ?? ''}',
        },
        body: data != null ? jsonEncode(data) : '',
      )
          .timeout(const Duration(seconds: 90));
      final responseJson = returnResponse(response);
      if (kDebugMode) {
        // print('POST Response: $responseJson');
        // log('POST Response Full: ${response.toString()}');
      }
      return responseJson;
    } catch (e) {
      _handleError(e, context: 'POST');
      rethrow;
    }
  }

  Future postApiResponseRequest(
      String url, Map<String, dynamic>? formData) async {
    final sp = await SharedPreferences.getInstance();
    String? token = sp.getString('accessToken');
    if (kDebugMode) {
      // print('Multipart POST URL: $url');
      // print('Multipart Form Data: $formData');
      // print('Multipart Token: $token');
    }
    try {
      if (formData == null) {
        // Fallback to standard POST request if formData is null
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer ${token ?? ''}',
            'Content-Type': 'application/json',
          },
        ).timeout(const Duration(seconds: 60));
        final responseJson = returnResponse(response);
        if (kDebugMode) {
          // print('Multipart Fallback Response: ${response.body}');
        }
        return responseJson;
      }

      // Create multipart request
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer ${token ?? ''}';

      // Add form fields
      formData.forEach((key, value) {
        if (value is List) {
          // Handle array fields like websites[] and divisions[]
          for (var item in value) {
            request.fields[key] = item.toString();
          }
        } else if (value is File) {
          // Handle file upload
          request.files.add(
            http.MultipartFile.fromBytes(
              key,
              value.readAsBytesSync(),
              filename: value.path.split('/').last,
            ),
          );
        } else {
          request.fields[key] = value.toString();
        }
      });

      final client = http.Client();
      final response =
      await client.send(request).timeout(const Duration(seconds: 60));
      final responseBody = await response.stream.bytesToString();
      final responseJson =
      returnResponse(http.Response(responseBody, response.statusCode));
      client.close();

      // if (kDebugMode) {
      //   // print('Multipart Response: $responseBody');
      // }

      // Extract token if present
      final responseToken = response.headers['authorization'] ??
          (responseBody.isNotEmpty
              ? jsonDecode(responseBody)['authorization']
              : null);
      // if (kDebugMode && responseToken != null) {
      //   print('Response Token: $responseToken');
      // }

      return responseJson;
    } catch (e) {
      _handleError(e, context: 'Multipart POST');
      rethrow;
    }
  }

  // Improved error handling
  void _handleError(dynamic e, {String? context}) {
    if (e is SocketException) {
      // if (kDebugMode) {
      //   print('$context Error: SocketException - $e');
      // }
      throw InternetExceptions('No internet connection');
    } else if (e is TimeoutException) {
      // if (kDebugMode) {
      //   print('$context Error: TimeoutException - $e');
      // }
      throw RequestTimeOut('Request timed out');
    } else {
      // if (kDebugMode) {
      //   print('$context Error: General Exception - $e');
      // }
      throw FetchDataException('An error occurred: $e');
    }
  }

  Future<String> postApiResponseToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString('accessToken') ?? '';
  }

  dynamic returnResponse(http.Response response) {
    // if (kDebugMode) {
    //   print('Response Status Code: ${response.statusCode}');
    //   print('Response Body: ${response.body}');
    // }

    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.body.isEmpty) {
          return {
            'success': true,
            'message': 'Operation completed successfully'
          };
        }
        try {
          return json.decode(response.body);
        } catch (e) {
          if (kDebugMode) {
            // print('JSON parsing failed: $e');
          }
          return {'success': true, 'message': response.body};
        }
      case 400:
      case 403:
      case 404:
      case 405:
      case 422:
      case 500:
        try {
          return json.decode(response.body);
        } catch (e) {
          return {'error': true, 'message': response.body};
        }
      case 401:
        _handleUnauthorized();
        throw FetchDataException('Unauthorized: Please log in again');
      default:
        throw FetchDataException(
            'Error occurred with StatusCode: ${response.statusCode}');
    }
  }

  void _handleUnauthorized() async {
    await Get.defaultDialog(
      barrierDismissible: false,
      title: 'Session Expired',
      middleText: 'Your session has expired. Please log in again.',
      onConfirm: () async {
        await _logoutAndNavigateToSignIn();
      },
    );
  }

  Future<void> _logoutAndNavigateToSignIn() async {
    SaveUserData userViewModel = SaveUserData();
    await userViewModel.removeUser();
    Get.offAllNamed(RoutesName.login_screen);
  }

  @override
  Future deleteApiResponse(String url) {
    return deleteApi(url); // Delegate to existing deleteApi method
  }
}

