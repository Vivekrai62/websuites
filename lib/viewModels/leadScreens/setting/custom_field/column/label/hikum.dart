// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
// import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
// import '../../../../data/models/responseModels/leads/setting/field_setting/field_setting.dart';
// import '../../../../resources/imageStrings/image_strings.dart';
// import '../../../../utils/appColors/app_colors.dart';
// import '../../../../utils/checkbox/LabeledCheckbox.dart';
// import '../../../../utils/fontfamily/FontFamily.dart';
// import '../../../../viewModels/leadScreens/setting/field_setting/create_update/lead_list_update_field_view_model.dart';
// import '../../../../viewModels/leadScreens/setting/field_setting/field_setting.dart';
// import '../../../../viewModels/leadScreens/setting/roles/roles.dart';
//
// class LeadSettingFieldScreen extends StatefulWidget {
//   const LeadSettingFieldScreen({super.key});
//
//   static void showCreateFieldDialog(BuildContext context, LeadFieldSettingViewModel viewModel) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) => LeadSettingFieldScreenBottomSheet(viewModel: viewModel),
//     );
//   }
//
//   @override
//   State<LeadSettingFieldScreen> createState() => _LeadSettingFieldScreenState();
// }
//
// class _LeadSettingFieldScreenState extends State<LeadSettingFieldScreen> {
//   final LeadFieldSettingViewModel viewModel = Get.put(LeadFieldSettingViewModel());
//   final LeadSettingRolesViewmodel rolesViewModel = Get.put(LeadSettingRolesViewmodel());
//   final LeadListUpdateFieldViewModel updateViewModel = Get.put(LeadListUpdateFieldViewModel());
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }
//
//   Future<void> _loadData() async {
//     try {
//       await viewModel.fieldSettingList(context);
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load fields: $error')),
//       );
//     }
//     try {
//       await rolesViewModel.settingRoles(context);
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load roles: $error')),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     Get.delete<LeadFieldSettingViewModel>();
//     Get.delete<LeadSettingRolesViewmodel>();
//     Get.delete<LeadListUpdateFieldViewModel>();
//     super.dispose();
//   }
//
//   Color getFieldColor(String fieldName) {
//     final colors = [
//       Colors.orange[400],
//       Colors.green[400],
//       Colors.blue[400],
//       Colors.purple[400],
//       Colors.red[400],
//       Colors.teal[400],
//       Colors.indigo[400],
//     ];
//     return colors[fieldName.hashCode % colors.length] ?? Colors.grey;
//   }
//
//   IconData getFieldIcon(String fieldType) {
//     switch (fieldType) {
//       case "Text":
//         return Icons.text_fields;
//       case "Checkbox":
//         return Icons.check_box;
//       case "Date":
//         return Icons.calendar_today;
//       case "Email":
//         return Icons.email;
//       case "Number":
//         return Icons.numbers;
//       default:
//         return Icons.label;
//     }
//   }
//
//   Widget buildFieldItem(FieldSettingResponseModel field) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
//       child: ContainerUtils(
//         paddingTop: 5,
//         paddingBottom: 5,
//         paddingRight: 0,
//         paddingLeft: 15,
//         child: Row(
//           children: [
//             Container(
//               width: 32,
//               height: 32,
//               decoration: BoxDecoration(
//                 color: getFieldColor(field.name.toString()),
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: Icon(
//                   getFieldIcon(field.type.toString()),
//                   color: Colors.white,
//                   size: 16,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 15),
//             Expanded(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     field.name.toString(),
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontFamily: FontFamily.sfPro,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const SizedBox(width: 8),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(3),
//                     color: AllColors.textField2,
//                   ),
//                   child: Text(field.type.toString()),
//                 ),
//                 const SizedBox(width: 10),
//                 LabeledCheckbox(
//                   key: Key('status_${field.id}'),
//                   value: field.isStatusFixed,
//                   onChanged: (bool? newValue) {
//                     if (newValue != null) {
//                       setState(() {
//                         field.isStatusFixed = newValue;
//                       });
//                     }
//                   },
//                   activeColor: AllColors.mediumPurple,
//                   alignment: MainAxisAlignment.start,
//                 ),
//                 const SizedBox(width: 10),
//                 Container(
//                   width: 60,
//                   alignment: Alignment.center,
//                   child: IconButton(
//                     icon: Image.asset(
//                       ImageStrings.edit,
//                       height: 17,
//                       width: 16,
//                       color: AllColors.figmaGrey,
//                     ),
//                     onPressed: () {
//                       RxList<String>? selectedRoles = field.leadFieldEditRestrictions
//                           ?.map((hideRole) => hideRole.role?.name ?? 'N/A')
//                           .toList()
//                           .obs;
//
//                       showDialog(
//                         context: context,
//                         barrierDismissible: false,
//                         builder: (context) {
//                           return AlertDialog(
//                             backgroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             contentPadding: EdgeInsets.fromLTRB(
//                               15,
//                               15,
//                               15,
//                               MediaQuery.of(context).viewInsets.bottom + 16,
//                             ),
//                             content: SingleChildScrollView(
//                               child: Obx(() {
//                                 if (rolesViewModel.loading.value) {
//                                   return const Center(child: CircularProgressIndicator());
//                                 }
//
//                                 final roles = rolesViewModel.roles;
//                                 final categories = roles.isNotEmpty
//                                     ? roles.map((role) => role.name ?? 'Unknown').toList()
//                                     : ['No roles available'];
//
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           "Update Permissions",
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black87,
//                                           ),
//                                         ),
//                                         const Spacer(),
//                                         InkWell(
//                                           onTap: () => Get.back(),
//                                           child: const Icon(Icons.close),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 12),
//                                     const Text(
//                                       'View Restriction For Particular Roles*',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.black54,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 16),
//                                     CreateNewLeadScreenCard(
//                                       isMultiSelect: true,
//                                       hintText: "Select",
//                                       categories: categories,
//                                       value: selectedRoles!.isNotEmpty ? selectedRoles.join(', ') : 'N/A',
//                                       onCategoriesChanged: (List<String> newRoles) {
//                                         selectedRoles.assignAll(newRoles);
//                                       },
//                                     ),
//                                     const SizedBox(height: 24),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         TextButton(
//                                           onPressed: () => Navigator.of(context).pop(),
//                                           style: TextButton.styleFrom(
//                                             foregroundColor: Colors.black54,
//                                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(8),
//                                               side: BorderSide(color: Colors.grey.shade300),
//                                             ),
//                                           ),
//                                           child: const Text(
//                                             'Cancel',
//                                             style: TextStyle(fontSize: 16, color: Colors.black54),
//                                           ),
//                                         ),
//                                         const SizedBox(width: 10),
//                                         TextButton.icon(
//                                           onPressed: () async {
//                                             try {
//                                               await updateViewModel.leadListFieldUpdate(
//                                                 context,
//                                                 fieldId: field.id.toString(),
//                                                 roleIds: rolesViewModel.roles
//                                                     .where((role) => selectedRoles.contains(role.name))
//                                                     .map((role) => role.id ?? '')
//                                                     .toList(),
//                                               );
//                                               Navigator.of(context).pop();
//                                             } catch (error) {
//                                               ScaffoldMessenger.of(context).showSnackBar(
//                                                 SnackBar(content: Text('Failed to update permissions: $error')),
//                                               );
//                                             }
//                                           },
//                                           style: TextButton.styleFrom(
//                                             backgroundColor: AllColors.mediumPurple,
//                                             foregroundColor: Colors.white,
//                                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                           ),
//                                           icon: const Icon(Icons.check, size: 18, color: Colors.white),
//                                           label: const Text(
//                                             'Update Permission',
//                                             style: TextStyle(fontSize: 16, color: Colors.white),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 8),
//                                   ],
//                                 );
//                               }),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final leadFieldSettings = viewModel.leadFiledSettings;
//       return viewModel.loading.value
//           ? const Center(child: CircularProgressIndicator())
//           : leadFieldSettings.isEmpty
//           ? const Center(child: Text('No lead settings found'))
//           : ListView.builder(
//         padding: EdgeInsets.zero,
//         itemCount: leadFieldSettings.length,
//         itemBuilder: (context, index) => buildFieldItem(leadFieldSettings[index]),
//       );
//     });
//   }
// }
//
//
// class LeadSettingFieldScreenBottomSheet extends StatefulWidget {
//   final LeadFieldSettingViewModel viewModel;
//
//   const LeadSettingFieldScreenBottomSheet({super.key, required this.viewModel});
//
//   @override
//   _LeadSettingFieldScreenBottomSheetState createState() => _LeadSettingFieldScreenBottomSheetState();
// }
//
// class _LeadSettingFieldScreenBottomSheetState extends State<LeadSettingFieldScreenBottomSheet> {
//   bool _showDetails = false;
//   String? _selectedType;
//   bool _hasFieldForError = false;
//   bool _hasFieldLabelError = false;
//   bool _isRequired = false;
//
//   final List<String> fieldTypes = [
//     "Text", "Checkbox", "Date", "DateTime", "Time", "Email", "Number", "Phone",
//     "Percent", "Picklist", "Picklist (Multi-select)", "TextArea", "Radio", "URL",
//     "Picklist (Custom)", "Document", "Image"
//   ];
//
//   final TextEditingController _fieldForController = TextEditingController();
//   final TextEditingController _fieldLabelController = TextEditingController();
//   final TextEditingController _maxLengthController = TextEditingController();
//   final TextEditingController _patternController = TextEditingController();
//   final TextEditingController _defaultValueController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _patternController.text = _getDefaultPattern(_selectedType);
//   }
//
//   @override
//   void dispose() {
//     _fieldForController.dispose();
//     _fieldLabelController.dispose();
//     _maxLengthController.dispose();
//     _patternController.dispose();
//     _defaultValueController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }
//
//   String _getDefaultPattern(String? type) {
//     switch (type) {
//       case "Email":
//         return r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}";
//       case "Phone":
//         return r"[0-9]{10}";
//       case "Number":
//         return r"[0-9]+";
//       case "Percent":
//         return r"-?[0-9]+(\.[0-9]+)?%?";
//       case "URL":
//         return r"https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}";
//       default:
//         return r"[a-zA-Z]+";
//     }
//   }
//
//   Widget _buildBottomSheetContent() {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             spreadRadius: 1,
//           )
//         ],
//       ),
//       height: MediaQuery.of(context).size.height * 0.85,
//       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.only(top: 10, bottom: 5),
//             width: 60,
//             height: 5,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Row(
//               children: [
//                 Text(
//                   _showDetails ? "Field Details" : "Select Field Type",
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "SFPro",
//                   ),
//                 ),
//                 const Spacer(),
//                 InkWell(
//                   onTap: () => Get.back(),
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.close, size: 20),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Divider(),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: _showDetails
//                   ? _buildFieldDetailsScreen()
//                   : _buildFieldTypeSelectionScreen(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFieldTypeSelectionScreen() {
//     final Map<String, String> fieldDescriptions = {
//       "Text": "For letters and numbers",
//       "Checkbox": "True or False value",
//       "Date": "Pick a date",
//       "DateTime": "Pick date and time",
//       "Time": "Pick a time",
//       "Email": "Enter email address",
//       "Number": "Enter any number",
//       "Phone": "Enter phone number",
//       "Percent": "Enter percentage (e.g., -10%)",
//       "Picklist": "Select from a list",
//       "Picklist (Multi-select)": "Select multiple from a list",
//       "TextArea": "Enter multiple lines",
//       "Radio": "Choose from a list",
//       "URL": "Enter a URL (HTTP protocol)",
//       "Picklist (Custom)": "Custom list selection",
//       "Document": "Upload a document",
//       "Image": "Upload an image",
//     };
//
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         int crossAxisCount = 2;
//         double aspectRatio = 2.5;
//
//         if (constraints.maxWidth >= 900) {
//           crossAxisCount = 4;
//           aspectRatio = 3.2;
//         } else if (constraints.maxWidth >= 600) {
//           crossAxisCount = 3;
//           aspectRatio = 2.8;
//         }
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildStepHeader(
//               step: 1,
//               title: "FIELD TYPE",
//               subtitle: "Choose one type",
//               isActive: true,
//             ),
//             const SizedBox(height: 16),
//             _buildStepHeader(
//               step: 2,
//               title: "FIELD DETAILS",
//               subtitle: "Enter details",
//               isActive: false,
//             ),
//             const SizedBox(height: 20),
//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: crossAxisCount,
//                 childAspectRatio: aspectRatio,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemCount: fieldTypes.length,
//               itemBuilder: (context, index) {
//                 final type = fieldTypes[index];
//                 final isSelected = _selectedType == type;
//
//                 return InkWell(
//                   onTap: () {
//                     setState(() {
//                       _selectedType = _selectedType == type ? null : type;
//                       _patternController.text = _getDefaultPattern(_selectedType);
//                     });
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color: isSelected ? AllColors.mediumPurple : Colors.grey[300]!,
//                         width: 1.5,
//                       ),
//                       color: isSelected ? AllColors.mediumPurple.withOpacity(0.1) : Colors.white,
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           isSelected ? Icons.check_circle : Icons.circle_outlined,
//                           color: isSelected ? AllColors.mediumPurple : Colors.grey[400],
//                           size: 18,
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 type,
//                                 style: TextStyle(
//                                   fontFamily: "SFPro",
//                                   fontSize: 14,
//                                   fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                                   color: isSelected ? AllColors.mediumPurple : Colors.black87,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               Text(
//                                 fieldDescriptions[type] ?? '',
//                                 style: TextStyle(
//                                   fontFamily: "SFPro",
//                                   fontSize: 12,
//                                   color: isSelected
//                                       ? AllColors.mediumPurple.withOpacity(0.7)
//                                       : Colors.grey[600],
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: _selectedType == null
//                   ? null
//                   : () {
//                 setState(() {
//                   _showDetails = true;
//                 });
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AllColors.mediumPurple,
//                 minimumSize: const Size(double.infinity, 48),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 elevation: 0,
//                 disabledBackgroundColor: Colors.grey[300],
//               ),
//               child: const Text(
//                 "Next",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "SFPro",
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildFieldDetailsScreen() {
//     // Define field types that require specific inputs
//     final textBasedTypes = ['Text', 'Email', 'Number', 'Phone', 'Percent']; // Removed URL and TextArea
//     final picklistTypes = ['Picklist (Custom)']; // Only Picklist (Custom) shows options
//     final booleanTypes = ['Checkbox', 'Radio'];
//     final dateTypes = ['Date', 'DateTime', 'Time'];
//     final fileTypes = ['Image']; // Only Image shows default value
//
//     // Controller for picklist options
//     final TextEditingController _picklistOptionsController = TextEditingController();
//
//     // Validate inputs
//     void validateInputs() {
//       setState(() {
//         _hasFieldForError = _fieldForController.text.isEmpty;
//         _hasFieldLabelError = _fieldLabelController.text.isEmpty;
//       });
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildStepHeader(
//           step: 1,
//           title: "FIELD TYPE",
//           subtitle: "Choose one type",
//           isActive: false,
//         ),
//         const SizedBox(height: 16),
//         _buildStepHeader(
//           step: 2,
//           title: "FIELD DETAILS",
//           subtitle: "Enter details",
//           isActive: true,
//         ),
//         const SizedBox(height: 20),
//         Row(
//           children: [
//             const Text(
//               "Type: ",
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: "SFPro",
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               decoration: BoxDecoration(
//                 color: AllColors.mediumPurple,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Text(
//                 _selectedType!,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: "SFPro",
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 20),
//         // Common fields for all types
//         _buildTextField(
//           controller: _fieldForController,
//           label: "Field For",
//           isRequired: true,
//           hasError: _hasFieldForError,
//           errorText: "Field For is required",
//         ),
//         const SizedBox(height: 12),
//
//         _buildTextField(
//           controller: _fieldLabelController,
//           label: "Field Label",
//           isRequired: true,
//           hasError: _hasFieldLabelError,
//           errorText: "Field Label is required",
//         ),
//         const SizedBox(height: 12),
//         // Conditional fields based on type
//         if (textBasedTypes.contains(_selectedType)) ...[
//           _buildTextField(
//             controller: _maxLengthController,
//             label: "Max Length",
//             keyboardType: TextInputType.number,
//             helperText: "Maximum length for this field",
//           ),
//           const SizedBox(height: 12),
//           _buildTextField(
//             controller: _patternController,
//             label: "Pattern",
//             helperText: "Don't use a forward slash (/), starting and end of pattern string",
//           ),
//           const SizedBox(height: 12),
//         ],
//         if (picklistTypes.contains(_selectedType)) ...[
//           _buildTextField(
//             controller: _picklistOptionsController,
//             label: "Options (comma-separated)",
//             helperText: "Enter options separated by commas (e.g., Option1, Option2, Option3)",
//           ),
//           const SizedBox(height: 12),
//         ],
//         if (!booleanTypes.contains(_selectedType) && !fileTypes.contains(_selectedType) && _selectedType != 'Document') ...[
//           _buildTextField(
//             controller: _defaultValueController,
//             label: "Default Value",
//           ),
//           const SizedBox(height: 12),
//         ],
//         if (booleanTypes.contains(_selectedType)) ...[
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey[300]!),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//             child: Row(
//               children: [
//                 Checkbox(
//                   value: _defaultValueController.text == 'true',
//                   onChanged: (value) {
//                     setState(() {
//                       _defaultValueController.text = value == true ? 'true' : 'false';
//                     });
//                   },
//                   activeColor: AllColors.mediumPurple,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 const Text(
//                   "Default Value",
//                   style: TextStyle(
//                     fontFamily: "SFPro",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
//         ],
//         if (_selectedType == 'TextArea') ...[
//           _buildTextField(
//             controller: _maxLengthController,
//             label: "Max Length",
//             keyboardType: TextInputType.number,
//             helperText: "Maximum length for this field",
//           ),
//           const SizedBox(height: 12),
//         ],
//         if (_selectedType == 'URL') ...[
//           _buildTextField(
//             controller: _patternController,
//             label: "Pattern",
//             helperText: "Don't use a forward slash (/), starting and end of pattern string",
//           ),
//           const SizedBox(height: 12),
//         ],
//
//         if (dateTypes.contains(_selectedType)) ...[
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Default Value'),
//
//               CreateNewLeadScreenCard(hintText: 'Select Date',isDateField: true,prefixIcon: Icon(Icons.date_range_sharp,color: AllColors.mediumPurple,size: 20,),),
//             ],
//           ),
//           const SizedBox(height: 12),
//         ],
//
//         _buildTextField(
//           controller: _descriptionController,
//           label: "Description",
//           maxLines: 3,
//         ),
//         const SizedBox(height: 12),
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.grey[300]!),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//           child: Row(
//             children: [
//               Checkbox(
//                 value: _isRequired,
//                 onChanged: (value) {
//                   setState(() {
//                     _isRequired = value ?? false;
//                   });
//                 },
//                 activeColor: AllColors.mediumPurple,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//               const Text(
//                 "Required",
//                 style: TextStyle(
//                   fontFamily: "SFPro",
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         const Text(
//           "(*) indicates required fields",
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.red,
//             fontFamily: "SFPro",
//           ),
//         ),
//         const SizedBox(height: 24),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             OutlinedButton(
//               onPressed: () {
//                 setState(() {
//                   _showDetails = false;
//                 });
//               },
//               style: OutlinedButton.styleFrom(
//                 side: BorderSide(color: AllColors.mediumPurple),
//                 minimumSize: const Size(150, 48),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Text(
//                 "Back",
//                 style: TextStyle(
//                   fontFamily: "SFPro",
//                   color: AllColors.mediumPurple,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: (){},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AllColors.mediumPurple,
//                 minimumSize: const Size(150, 48),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 elevation: 0,
//               ),
//               child: const Text(
//                 "Create",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "SFPro",
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
//
//   Widget _buildStepHeader({
//     required int step,
//     required String title,
//     required String subtitle,
//     required bool isActive,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 24,
//           height: 24,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: isActive ? AllColors.mediumPurple : Colors.grey[300],
//           ),
//           child: Text(
//             step.toString(),
//             style: TextStyle(
//               color: isActive ? Colors.white : Colors.grey[600],
//               fontWeight: FontWeight.bold,
//               fontSize: 12,
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: isActive ? Colors.black : Colors.grey[600],
//                 fontFamily: "SFPro",
//               ),
//             ),
//             Text(
//               subtitle,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey[600],
//                 fontFamily: "SFPro",
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     bool isRequired = false,
//     bool hasError = false,
//     String? errorText,
//     String? helperText,
//     TextInputType? keyboardType,
//     int maxLines = 1,
//   }) {
//     // Apply red border for "Field Label" field in all cases
//     bool isFieldLabel = label == "Field Label";
//     bool isDescription = label == "Description";
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "$label${isRequired ? '*' : ''}",
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w500,
//             fontFamily: "SFPro",
//           ),
//         ),
//         const SizedBox(height: 6),
//         CreateNewLeadScreenCard(
//           hintText: '',
//           controller: controller,
//           keyboardType: keyboardType,
//           allowCustomBorderInput:isDescription ? BorderRadius.circular(12) : null,
//           maxLines: maxLines,
//           borderColor: isFieldLabel || hasError ? Colors.red : AllColors.mediumPurple ,// Default to red for unfocused state
//           hasError: hasError,
//           suffixIcon: isFieldLabel ? Icon(Icons.error_outline, color: AllColors.darkRed) : null,
//           errorMessage: hasError ? errorText : null,
//         ),
//         if (helperText != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 4, left: 4),
//             child: Text(
//               helperText,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey[600],
//                 fontFamily: "SFPro",
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return _buildBottomSheetContent();
//   }
// }
