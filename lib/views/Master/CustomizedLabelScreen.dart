// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
// import '../../../../../resources/strings/strings.dart';
// import '../../../../../resources/textStyles/text_styles.dart';
// import '../../../../../utils/MasterScreen/MasterUtils.dart';
// import '../../data/models/controller.dart';
// import '../../utils/components/widgets/drawer/custom_drawer.dart';
// import '../../utils/responsive/bodies/Responsive.dart';
// import '../../viewModels/leadScreens/leadMasters/controller.dart';
// import '../../viewModels/master/customizeLabels/master_customize_viewModel.dart';
//
// class CustomizedLabelScreen extends StatefulWidget {
//   const CustomizedLabelScreen({super.key});
//
//   @override
//   State<CustomizedLabelScreen> createState() => _CustomizedLabelScreenState();
// }
//
// class _CustomizedLabelScreenState extends State<CustomizedLabelScreen> {
//   final LeadMasterController controller = Get.put(LeadMasterController());
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
//   final ScreenController _screenController = Get.put(ScreenController());
//   late MasterCustomizeListViewModel viewModel;
//   String userName = '';
//   String userEmail = '';
//
//   @override
//   void initState() {
//     super.initState();
//     // Initializing the view model for master customization
//     viewModel = Get.put(MasterCustomizeListViewModel());
//     _fetchUserDataAndCustomizeList();
//   }
//
//   Future<void> _fetchUserDataAndCustomizeList() async {
//     final userData = await MasterScreenUtils.fetchUserData();
//     setState(() {
//       userName = userData['userName'] ?? '';
//       userEmail = userData['userEmail'] ?? '';
//     });
//     await viewModel.masterCustomizeList(context); // Fetch the customized customer_list
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     return MasterScreenUtils.buildCommonScaffold(
//       scaffoldKey: _scaffoldKey,
//       globalKey: _globalKey,
//       userName: userName,
//       userEmail: userEmail,
//       title: Strings.mastercustomlabel,
//       onAddPressed: () {
//         // Handle Add button press
//       },
//       drawer: Obx(
//             () =>
//                 CustomDrawer(
//                   selectedIndex: 0, // Customize as needed
//                   onItemSelected: (index) {
//                     // Handle item selection
//                   },
//                   isCollapsed: false,
//                   onCollapseToggle: () {
//                     // Handle drawer collapse/expand
//                   },
//                   isTabletOrDesktop: screenWidth >= 500,
//                 ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//          CreateNewLeadScreenCard(hintText: Strings.select,
//          categories: [
//
//          ],
//
//
//
//          ),
//
//           const SizedBox(height: 20),
//           Expanded(
//             child: Obx(() {
//               final customizeList = viewModel.masterCustomizeListResult; // Customize customer_list from ViewModel
//
//               // Check if the customer_list is empty or still loading
//               if (viewModel.loading.value) {
//                 return const Center(child: CircularProgressIndicator()); // Show a loader while fetching
//               }
//
//               if (customizeList.isEmpty) {
//                 return const Center(child: Text("No Data Found")); // Show a message if customer_list is empty
//               }
//
//               return MasterScreenUtils.buildDataTable(
//                 context: context,
//                 columns: const [
//                   DataColumn(label: Text(Strings.sno, style: TextStyles.masterScreen)),
//                   DataColumn(label: Text(Strings.masterkey, style: TextStyles.masterScreen)),
//                   DataColumn(label: Text(Strings.masterLangauge, style: TextStyles.masterScreen)),
//                   DataColumn(label: Text(Strings.masterUpdated_Date, style: TextStyles.masterScreen)),
//                   DataColumn(label: Text(Strings.action, style: TextStyles.masterScreen)),
//                 ],
//                 rows: List.generate(customizeList.length, (index) {
//                   final item = customizeList[index];
//                   return DataRow(cells: [
//                     DataCell(Text('${index + 1}')),
//                     DataCell(Text(item.key ?? '', style: TextStyles.namelength)),
//
//
//                     DataCell(
//                       Container(
//                         padding: EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                           color: const Color(0x1F7367F0), // Background color with opacity #7367f01f
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           item.defaultLabel ?? '',
//                           style: TextStyle(
//                             // fontSize: 13,
//                             color: const Color(0xFF7367F0), // Text color #7367f0
//                           ),
//                         ),
//                       ),
//                     ),
//
//
//
//
//
//                     DataCell(Text(item.updatedAt ?? '', style: TextStyles.datatable)),
//
//                     DataCell(IconButton(
//                       icon: const Icon(Icons.mode_edit_outline_outlined),
//                       onPressed: () {
//                         // Handle edit action
//                       },
//                     )),
//                   ]);
//                 }),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
