//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../resources/strings/strings.dart';
// import '../../../../../viewModels/master/departments/master_departments_viewModel.dart';
// import '../../data/models/controller.dart';
// import '../../resources/textStyles/text_styles.dart';
// import '../../utils/MasterScreen/MasterUtils.dart';
// import '../../utils/components/widgets/drawer/custom_drawer.dart';
// import '../../utils/responsive/bodies/Responsive.dart';
// import '../../viewModels/leadScreens/leadMasters/controller.dart';
//
//
// class MasterDepartmentScreen extends StatefulWidg
//   const MasterDepartmentScreen({super.key});
//
//   @override
//   State<MasterDepartmentScreen> createState() => _MasterDepartmentScreenState();
// }
//
// class _MasterDepartmentScreenState extends State<MasterDepartmentScreen> {
//   final LeadMasterController controller = Get.put(LeadMasterController());
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
//   final ScreenController _screenController = Get.put(ScreenController());
//   late MasterDepartmentsViewModel viewModel;
//   String userName = '';
//   String userEmail = '';
//
//   @override
//   void initState() {
//     super.initState();
//     viewModel = Get.put(MasterDepartmentsViewModel());
//     _fetchUserDataAndDepartments();
//   }
//
//   Future<void> _fetchUserDataAndDepartments() async {
//     final userData = await MasterScreenUtils.fetchUserData();
//     setState(() {
//       userName = userData['userName'] ?? '';
//       userEmail = userData['userEmail'] ?? '';
//     });
//     await viewModel.masterDepartments(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     return MasterScreenUtils.buildCommonScaffold(
//       // scaffoldKey: _scaffoldKey,
//       // globalKey: _globalKey,
//       // userName: userName,
//       // userEmail: userEmail,
//       // title: Strings.masterDepartment,
//       // addButtonTitle: Strings.add_department,
//       // onAddPressed: () {},
//       // drawer: Obx(
//       //       () =>
//       //           CustomDrawer(
//       //             selectedIndex: 0, // Customize as needed
//       //             onItemSelected: (index) {
//       //               // Handle item selection
//       //             },
//       //             isCollapsed: false,
//       //             onCollapseToggle: () {
//       //               // Handle drawer collapse/expand
//       //             },
//       //             isTabletOrDesktop: screenWidth >= 500,
//       //           ),
//       // ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           MasterScreenUtils.buildSearchField(),
//           const SizedBox(height: 20),
//           Expanded(
//             child: Obx(() {
//               final departments = viewModel.departments;
//               return MasterScreenUtils.buildDataTable(
//                 context: context,  // Pass the context here
//                 columns: const [
//                   DataColumn(label: Text(Strings.sno,style: TextStyles.masterScreen,),),
//                   DataColumn(label: Text(Strings.name, style: TextStyles.masterScreen)),
//                   DataColumn(label: Text(Strings.description, style: TextStyles.masterScreen,)),
//                   DataColumn(label: Text(Strings.created_date, style:TextStyles.masterScreen,)),
//                   DataColumn(label: Text(Strings.action, style: TextStyles.masterScreen,)),
//                 ],
//                 rows: List.generate(departments.length, (index) {
//                   final department = departments[index];
//                   return DataRow(cells: [
//                     DataCell(Text('${index + 1}')),
//                     DataCell(Text(department.name ?? '', style: TextStyles.namelength)),
//                     DataCell(Text(department.description ?? '', style: TextStyles.datatable)),
//                     DataCell(Text(department.createdAt ?? '', style: TextStyles.datatable)),
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