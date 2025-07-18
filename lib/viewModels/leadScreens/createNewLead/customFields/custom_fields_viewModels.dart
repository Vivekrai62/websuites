// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../data/repositories/repositories.dart';
// import '../../../../utils/utils.dart';
// import '../../../../data/models/responseModels/leads/createNewLead/leadCustomFields/lead_custom_fields.dart';
//
// class CustomFieldsViewModel extends GetxController {
//   final _api = Repositories();
//   RxBool loading = false.obs;
//   RxList<LeadCustomFieldsResponseModel> customFields = <LeadCustomFieldsResponseModel>[].obs;
//
//   Future<void> createNewLeadCustomFields(BuildContext context) async {
//     loading.value = true;
//
//     try {
//       final response = await _api.createNewLeadCustomFieldsApi();
//       loading.value = false;
//
//       if (response is List) {
//         customFields.value = response;
//         print("Custom fields fetched: ${customFields.length}");
//         customFields.forEach((field) {
//           print("Field: ${field.fieldName}, Type: ${field.type}, Answers: ${field.answers}");
//         });
//         Utils.snackbarSuccess('Custom fields fetched successfully');
//
//         // Check for customer division data
//         List<String> customerDivisions = getCustomerDivision();
//         if (customerDivisions.isNotEmpty) {
//           print("Customer division fetch success: $customerDivisions");
//         } else {
//           print("Customer division data is empty");
//         }
//       } else {
//         print("Unexpected response format: $response");
//         Utils.snackbarFailed('Unexpected response format');
//       }
//     } catch (error) {
//       loading.value = false;
//       print("Error fetching custom fields: $error");
//       Utils.snackbarFailed('An error occurred: ${error.toString()}');
//     }
//   }
//
//   List<String> getCustomerDivision() {
//     List<String> result = _getFieldAnswers('customer_division');
//     print("getCustomerDivision called. Result: $result");
//     return result;
//   }
//
//   List<String> getIndustry() {
//     return _getFieldAnswers('industry');
//   }
//
//   List<String> getIndustryType() {
//     return _getFieldAnswers('industryType');
//   }
//
//   List<String> getLeadCategory() {
//     return _getFieldAnswers('lead_category');
//   }
//
//   List<String> _getFieldAnswers(String fieldName) {
//     print("_getFieldAnswers called for field: $fieldName");
//     final field = customFields.firstWhere(
//           (field) => field.fieldName == fieldName,
//       orElse: () {
//         print("Field $fieldName not found");
//         return LeadCustomFieldsResponseModel(
//           id: '',
//           fieldFor: '',
//           fieldLabel: '',
//           fieldName: '',
//           type: '',
//           description: '',
//           answers: '',
//           pattern: '',
//           maxValue: 0,
//           required: false,
//           requiredForCustomer: false,
//           defaultValue: '',
//           multiple: false,
//           createdAt: null,
//           updatedAt: null,
//           leadCustomFieldEditRestrictions: [],
//           restrictedRoles: [],
//         );
//       },
//     );
//
//     List<String> answers = field.answers?.split(',').map((e) => e.trim()).toList() ?? [];
//     print("Answers for $fieldName: $answers");
//     return answers;
//   }
// }




import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/responseModels/leads/createNewLead/leadCustomFields/lead_custom_fields.dart';
import '../../../../../data/repositories/repositories.dart';


// class CreateLeadCustomFieldsViewModel extends GetxController {
//   final repository = Repositories();
//   RxBool loading = false.obs;
//   var errorMessage = ''.obs;
//
//   RxList<String> industryTypeList = <String>[].obs;
//   RxList<String> leadCategory = <String>[].obs;
//   RxList<String> socialLinkList = <String>[].obs;
//   RxList<String> customDivisionList = <String>[].obs;
//   RxList<String> industryList = <String>[].obs;
//
//   RxList<LeadCustomFieldsResponseModel> leadCustomFields = <LeadCustomFieldsResponseModel>[].obs;
//
//   Future<void> createNewLeadCustomFields(BuildContext context) async {
//     loading.value = true;
//     try {
//       List<LeadCustomFieldsResponseModel> result = await repository.createNewLeadCustomFieldsApi();
//       leadCustomFields.value = result;
//       if (result.isNotEmpty) {
//         industryTypeList.clear();
//         leadCategory.clear();
//         socialLinkList.clear();
//         customDivisionList.clear();
//         industryList.clear();
//         for (var field in result) {
//           print("Custom Field ID: ${field.id}");
//           print("Custom Field Answers: ${field.answers}");
//           List<String> answersList = field.answers?.split(',').map((e) => e.trim()).toList() ?? [];
//           switch (field.id) {
//             case '02965ea4-4cb9-4ec0-a286-c4571e108185':
//               socialLinkList.addAll(answersList);
//               break;
//             case '50852b02-2f5e-463f-80d4-99a1c42e2a7b':
//               customDivisionList.addAll(answersList);
//               break;
//             case '6d63f939-1d62-45d6-97d4-e03d91be4468':
//               industryTypeList.addAll(answersList);
//               break;
//             case '82279d8c-771c-48ff-ad44-d2d67985e76d':
//               leadCategory.addAll(answersList);
//               break;
//             case 'cc119885-3c7d-46b6-9a17-4ba421822e02':
//               industryList.addAll(answersList);
//               break;
//             default:
//               print("Unhandled Custom Field ID: ${field.id}");
//           }
//         }
//         print("Custom Fields fetched successfully");
//       } else {
//         Utils.snackbarFailed('No custom fields found');
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("Error: ${error.toString()}");
//       }
//       Utils.snackbarFailed('Error fetching custom fields');
//     } finally {
//       loading.value = false;
//     }
//   }
// }

class CreateLeadCustomFieldsViewModel extends GetxController {
  final repository = Repositories();
  RxBool loading = false.obs;
  var errorMessage = ''.obs;

  RxList<String> industryTypeList = <String>[].obs;
  RxList<String> leadCategory = <String>[].obs;
  RxList<String> socialLinkList = <String>[].obs;
  RxList<String> customDivisionList = <String>[].obs;
  RxList<String> industryList = <String>[].obs;

  RxList<LeadCustomFieldsResponseModel> leadCustomFields = <LeadCustomFieldsResponseModel>[].obs;

  Future<void> createNewLeadCustomFields(BuildContext context) async {
    loading.value = true;
    try {
      List<LeadCustomFieldsResponseModel> result = await repository.createNewLeadCustomFieldsApi();
      leadCustomFields.value = result;
      if (result.isNotEmpty) {
        industryTypeList.clear();
        leadCategory.clear();
        socialLinkList.clear();
        customDivisionList.clear();
        industryList.clear();
        for (var field in result) {
          print("Custom Field ID: ${field.id}");
          print("Custom Field Answers: ${field.answers}");
          List<String> answersList = field.answers?.split(',').map((e) => e.trim()).toList() ?? [];
          switch (field.id) {
            case '':
              socialLinkList.addAll(answersList);
              break;
            case '':
              customDivisionList.addAll(answersList);
              break;
            case '':
              industryTypeList.addAll(answersList);
              break;
            case '':
              leadCategory.addAll(answersList);
              break;
            case '':
              industryList.addAll(answersList);
              break;
            default:
              print("Unhandled Custom Field ID: ${field.id}");
          }
        }
        print("Custom Fields fetched successfully");
      } else {
        Utils.snackbarFailed('No custom fields found');
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error: ${error.toString()}");
      }
      Utils.snackbarFailed('Error fetching custom fields');
    } finally {
      loading.value = false;
    }
  }
}


//
//   // found an error  A value of type 'LeadCustomFieldsResponseModel' can't be assigned to a variable of type 'List<LeadCustomFieldsResponseModel>'.
//
// //Solution The issue you're encountering is that your method createNewLeadCustomFieldsApi() returns a single instance of LeadCustomFieldsResponseModel based on your code, but you are trying to assign it to a customer_list of LeadCustomFieldsResponseModel in the controller, which is causing the error.
//   // Future<void> createNewLeadCustomFields(BuildContext context) async {
//   //   loading.value = true;
//   //   try {
//   //     List<LeadCustomFieldsResponseModel>leadCustomFieldList = await repository.createNewLeadCustomFieldsApi();
//   //     if (fields.isNotEmpty) {
//   //       for (var field in fields) {
//   //         print("Custom Field ID: ${field['id']}");
//   //         print("Custom Field Answers: ${field['answers']}");
//   //       }
//   //       Utils.snackbarSuccess('Custom Fields fetched');
//   //     } else {
//   //       Utils.snackbarFailed('No custom fields found');
//   //     }
//   //   } catch (error) {
//   //     if (kDebugMode) {
//   //       print("Error: ${error.toString()}");
//   //     }
//   //     Utils.snackbarFailed('Error fetching custom fields');
//   //   } finally {
//   //     loading.value = false;
//   //   }
//   // }
//
//
//
// }

//old

// class CreateLeadCustomFieldsViewModel extends GetxController {
//   final repository = Repositories();
//   RxBool loading = false.obs;
//   var errorMessage = ''.obs;
//   // To track loading state
//   var selectedCategory = Rxn<Map<String, dynamic>>();
//   RxList<LeadCustomFieldsResponseModel> leadCustomFields = <LeadCustomFieldsResponseModel>[].obs;
//   RxList<String> industryList = <String>[].obs;
//
//   Future<void> createNewLeadCustomFields(BuildContext context) async {
//     loading.value = true;
//     try {
//       // Fetch the customer_list of LeadCustomFieldsResponseModel
//       List<LeadCustomFieldsResponseModel> result = await repository.createNewLeadCustomFieldsApi();
//       // Assign the customer_list to the reactive variable
//       leadCustomFields.value = result;
//       // Check if the customer_list is not empty
//       if (result.isNotEmpty) {
//         for (var field in result) {
//           print("Custom Field ID data: ${field.id}");
//           print("Custom Field Answers  data: ${field.answers}");
//
//           if (field.id == '6d63f939-1d62-45d6-97d4-e03d91be4468') {
//             // Assuming answers are a comma-separated string
//             List<String> industryTypes = field.answers?.split(',') ?? [];
//             print("Industry Types: $industryTypes");
//             industryList.addAll(industryTypes);
//             print("Industry List ${industryList}");
//             // You can store the industry types in a variable or process them further
//             // For example, if you want to store them in another reactive variable
//             // RxList<String> industryList = <String>[].obs;
//             // industryList.addAll(industryTypes);
//             // You can also add any additional logic to handle the industry types as needed.
//           }
//         }
//         Utils.snackbarSuccess('Custom Fields fetched');
//       } else {
//         Utils.snackbarFailed('No custom fields found');
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("Error: ${error.toString()}");///
//       }
//       Utils.snackbarFailed('Error fetching custom fields');
//     } finally {
//       loading.value = false;
//     }
//   }
// }


