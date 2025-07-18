// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:websuites/utils/appColors/app_colors.dart';
// import '../../../../../../resources/textStyles/text_styles.dart';
//
// import '../../../../Utils/utils.dart';
// import '../../../../viewModels/leadScreens/Setting/custom_field/custom_fields.dart';
//
//
//
//
// class FieldSettingView extends StatefulWidget {
//   const FieldSettingView({Key? key}) : super(key: key);
//
//   @override
//   _FieldSettingViewState createState() => _FieldSettingViewState();
// }
//
// class _FieldSettingViewState extends State<FieldSettingView> {
//   // final FieldSettingController _controller = Get.put(FieldSettingController());
//   final LeadSettingCustomFieldsViewmodel _controller2 = Get.put(LeadSettingCustomFieldsViewmodel());
//
//   @override
//   void initState() {
//     super.initState();
//     // _controller.fieldSettingList(context);
//     _controller2.settingCustomFields(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildLegend(),
//         SizedBox(height: 16),
//         Obx(() => _buildDataTable()),
//       ],
//     );
//   }
//
//   Widget _buildLegend() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildLegendRow('S', AllColors.mediumPurple, 'Standard fields'),
//         SizedBox(height: 8),
//         _buildLegendRow('C', AllColors.mediumYellow, 'Custom fields'),
//       ],
//     );
//   }
//
//   Widget _buildLegendRow(String letter, Color color, String text) {
//     return Row(
//       children: [
//         Image.asset('assets/icons/doticon.png', height: 10),
//         SizedBox(width: 5),
//         Container(
//           alignment: Alignment.center,
//           width: 18,
//           height: 18,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(7),
//           ),
//           child: Text(
//             letter,
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
//           ),
//         ),
//         Text(" - $text"),
//       ],
//     );
//   }
//
//   Widget _buildDataTable() {
//     if (_controller.loading.value || _controller2.loading.value) {
//       return Center(child: CircularProgressIndicator());
//     }
//
//     // Combine data from both controllers
//     final combinedSettings = _controller.fieldsettings
//         .map((setting) => _buildDataRow(setting, true)) // True for standard fields
//         .toList()
//       ..addAll(_controller2.customFields.map((setting) => _buildDataRow(setting, false))); // False for custom fields
//
//     return MasterScreenUtils.buildDataTable(
//       context: context,
//       columns: [
//         DataColumn(label: Text('Field Name', style: TextStyles.masterScreen)),
//         const DataColumn(label: Text('Type', style: TextStyles.masterScreen)),
//         const DataColumn(label: Text('Is Required', style: TextStyles.masterScreen)),
//         const DataColumn(label: Text('Actions', style: TextStyles.masterScreen)),
//       ],
//       rows: combinedSettings,
//     );
//   }
//
//
//   // Method to build a data row based on the field setting
//   DataRow _buildDataRow(dynamic setting, bool isStandardField) {
//     return DataRow(cells: [
//       DataCell(
//         Row(
//           children: [
//             Container(
//               alignment: Alignment.center,
//               width: 18,
//               height: 18,
//               decoration: BoxDecoration(
//                 color: isStandardField ? AllColors.mediumPurple : AllColors.mediumYellow,
//                 borderRadius: BorderRadius.circular(7),
//               ),
//               child: Text(
//
//                 isStandardField ? 'S' : 'C',
//                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
//               ),
//             ),
//             SizedBox(width: 8),
//             Text(setting.name ?? 'N/A', style: TextStyles.namelength),
//           ],
//         ),
//       ),
//       DataCell(Text(setting.type ?? 'N/A', style: TextStyles.namelength)),
//       DataCell(
//         Row(
//           children: [
//             SizedBox(
//               height: 16,
//               child: Checkbox(
//                 value: setting.isRequired ?? false,
//                 onChanged: setting.isStatusFixed == true ? null : (value) {
//                   _controller2.toggleFieldRequired(setting.id!, value);
//                   _controller.toggleFieldRequired(setting.id!, value);
//                   Utils.snackbarSuccess('You have updated Field');
//                 },
//                 activeColor: AllColors.mediumPurple,
//               ),
//             ),
//             SizedBox(width: 8),
//             if (setting.isStatusFixed == true)
//               Icon(Icons.lock, color: Color(0xFF7C8285), size: 20),
//           ],
//         ),
//       ),
//       DataCell(
//         IconButton(
//           icon: Image.asset('assets/icons/edit.png', height: 20),
//           onPressed: setting.isStatusFixed == true ? null : () {
//             // Handle edit action
//           },
//         ),
//       ),
//     ]);
//   }
// }
