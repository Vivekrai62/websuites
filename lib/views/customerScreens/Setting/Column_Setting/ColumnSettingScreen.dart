// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//
// import '../../../../../../Utils/utils.dart';
// import '../../../../../../resources/textStyles/text_styles.dart';
// import '../../../../../../utils/MasterScreen/MasterUtils.dart';
// import '../../../../../../utils/appColors/app_colors.dart';
// import '../../../../../../utils/components/buttons/common_button.dart';
//
// import '../../../../../../views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
//
// import '../../../../data/models/responseModels/leads/setting/setting.dart';
// import '../../../../viewModels/leadScreens/Setting/setting.dart';
//
//
// class ColumnSettingView extends StatelessWidget {
//   final LeadSettingsViewModel settingsViewModel;
//   final BuildContext parentContext; // New field for context
//
//   const ColumnSettingView({Key? key, required this.settingsViewModel, required this.parentContext}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (settingsViewModel.loading.value) {
//         return Center(child: CircularProgressIndicator());
//       }
//       return
//         MasterScreenUtils.
//
//         buildDataTable(
//           context: context,
//           columns: const [
//             DataColumn(label: Text('Column', style: TextStyles.masterScreen)),
//             DataColumn(label: Text('Visible', style: TextStyles.masterScreen)),
//             DataColumn(label: Text('Search Filter', style: TextStyles.masterScreen)),
//             DataColumn(label: Text('Update Permission', style: TextStyles.masterScreen)),
//           ],
//           rows: settingsViewModel.settings.isNotEmpty
//               ? List.generate(
//             settingsViewModel.settings.length,
//                 (index) => _buildDataRow(settingsViewModel.settings[index], index),
//           )
//               : [],
//         );
//     });
//   }
//
//
//
//   DataRow _buildDataRow(LeadSettingResponseModel setting, int index) {
//     return DataRow(cells: [
//       DataCell(
//         Row(
//           children: [
//             // Container with 'S'
//             Container(
//               alignment: Alignment.center,
//               width: 18,
//               height: 18,
//               decoration: BoxDecoration(
//                 color: AllColors.mediumPurple,
//                 borderRadius: BorderRadius.circular(7),
//               ),
//               child: Text(
//                 'S',
//                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
//               ),
//             ),
//             SizedBox(width: 8), // Space between container and field name
//             Text(setting.fieldName, style: TextStyles.namelength),
//           ],
//         ),
//       ),
//
//       // Visible Checkbox
//       DataCell(
//         SizedBox(
//           height: 16,
//           child: Checkbox(
//             value: setting.isVisible.value,
//             onChanged: (value) {
//               setting.isVisible.value = value ?? false;
//             },
//             activeColor: AllColors.mediumPurple,
//             checkColor: Colors.white,
//             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             side: MaterialStateBorderSide.resolveWith((states) {
//               return BorderSide(
//                 color: states.contains(MaterialState.selected) ? AllColors.mediumPurple : Colors.grey,
//                 width: 2,
//               );
//             }
//
//             ),
//           ),
//         ),
//       ),
//
//       // Search Filter Checkbox
//       DataCell(
//         SizedBox(
//           height: 16,
//           child: Checkbox(
//             value: setting.isSearchFilter.value,
//             onChanged: (value) {
//               setting.isSearchFilter.value = value ?? false;
//             },
//             activeColor: AllColors.mediumPurple,
//             checkColor: Colors.white,
//             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             side: MaterialStateBorderSide.resolveWith((states) {
//               return BorderSide(
//                 color: states.contains(MaterialState.selected) ? AllColors.mediumPurple : Colors.grey,
//                 width: 2,
//               );
//             }),
//           ),
//         ),
//       ),
//
//       // Edit Button
//       DataCell(
//         IconButton(
//           icon: Image.asset('assets/icons/edit.png', height: 20),
//           onPressed: () => _showEditDialog(setting, parentContext), // Use the passed context
//         ),
//       ),
//     ]);
//   }
//
//
//
//   void _showEditDialog(LeadSettingResponseModel setting, BuildContext context) {
//     final TextEditingController textFieldController = TextEditingController();
//     final List<String> categories = List.generate(40, (index) => 'Item ${index + 1}');
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           contentPadding: EdgeInsets.all(20),
//           title: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Update Permission', style: TextStyles.masterScreen),
//               SizedBox(width: 10),
//               Icon(Icons.star, color: Colors.red),
//             ],
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Column View Restriction For Particular Roles',
//                   style: TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 20),
//                 CreateNewLeadScreenCard(
//                   hintText: 'Select Category',
//                   categories: categories,
//                   onCategoriesChanged: (selectedCategories) {
//                     textFieldController.text = selectedCategories.join(', ');
//                   },
//                   controller: textFieldController,
//                   isMultiSelect: true,
//                   allowCustomInput: false,
//                 ),
//                 SizedBox(height: 20),
//                 CommonButton(
//                   title: 'Update Now',
//                   onPress: () {
//                     Get.back();
//                     Utils.snackbarSuccess('Updated successfully');
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }