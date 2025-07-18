// home_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/responseModels/dashboard/db_count_response_model.dart';
import '../../../../data/models/responseModels/dashboard/main_dashboard/List/MainDashboardChartsList.dart';
import '../../../../data/models/responseModels/login/login_response_model.dart';
import '../../../../resources/iconStrings/icon_strings.dart';
import '../../../../resources/svg/svg_string.dart';
import '../../../../resources/textStyles/responsive/test_responsive.dart';
import '../../../../utils/appColors/app_colors.dart';
import '../../../../utils/components/buttons/common_button.dart';
import '../../../../utils/dark_mode/dark_mode.dart';
import '../../../../viewModels/dashboard/main_dashboard/MainDashboardListViewModel.dart';
import '../../../../viewModels/saveToken/save_token.dart';

// class DrawerController extends GetxController {
//   final RxString selectedNav = 'Dashboard'.obs;
//   final RxString selectedSubNav = ''.obs;
//   final RxBool isAccountsExpanded = false.obs;
//   final RxBool isLeadsExpanded = false.obs;
//   final RxBool isOrdersExpanded = false.obs;
//   final RxBool isSalesExpanded = false.obs;
//   final RxBool isProductsExpanded = false.obs;
//   final RxBool isInventoryExpanded = false.obs;
//   final RxBool isProjectsExpanded = false.obs;
//   final RxBool isTasksExpanded = false.obs;
//   final RxBool isMarketingExpanded = false.obs;
//   /////////////////////////////////////////////
//   final RxBool isReportsExpanded = false.obs;
//   final RxBool isAnalylticsExpanded = false.obs;
//   final RxBool isUsersExpanded = false.obs;
//   final RxBool isHRMExpanded = false.obs;
//   final RxBool isHelpdeskExpanded = false.obs;
//   final RxBool isLogsExpanded = false.obs;
//   final RxBool isFileManagerExpanded = false.obs;
//   final RxBool isSettingsExpanded = false.obs;
//
//   RxString currentlyExpandedNav = ''.obs;
//
//   void preserveCurrentState() {
//     final currentNav = selectedNav.value;
//     final currentSubNav = selectedSubNav.value;
//     final isLeadsExp = isLeadsExpanded.value;
//     final isAccountsExp = isAccountsExpanded.value;
//     final isOrdersExp = isOrdersExpanded.value;
//     final isSalesExp = isSalesExpanded.value;
//     final isProductsExp = isProductsExpanded.value;
//     final isInventoryExp = isInventoryExpanded.value;
//     final isProjectsExp = isProjectsExpanded.value;
//     final isTasksExp = isTasksExpanded.value;
//     final isMarketingExp = isMarketingExpanded.value;
//     /////////////////////////////////////////////
//     final isReportsExp = isReportsExpanded.value;
//     final isAnalylticsExp = isAnalylticsExpanded.value;
//     final isUsersExp = isUsersExpanded.value;
//     final isHRMExpandedExp = isHRMExpanded.value;
//     final isHelpdeskExp = isHelpdeskExpanded.value;
//     final isLogsExp = isLogsExpanded.value;
//     final isFileManagerExp = isFileManagerExpanded.value;
//     final isSettingsExp = isSettingsExpanded.value;
//
//     selectedNav.value = currentNav;
//     selectedSubNav.value = currentSubNav;
//     isLeadsExpanded.value = isLeadsExp;
//     isAccountsExpanded.value = isAccountsExp;
//     isOrdersExpanded.value = isOrdersExp;
//     isSalesExpanded.value = isSalesExp;
//     isProductsExpanded.value = isProductsExp;
//     isInventoryExpanded.value = isInventoryExp;
//     isProjectsExpanded.value = isProjectsExp;
//     isTasksExpanded.value = isTasksExp;
//     isMarketingExpanded.value = isMarketingExp;
//     /////////////////////////////////////////////
//     isReportsExpanded.value = isReportsExp;
//     isAnalylticsExpanded.value = isAnalylticsExp;
//     isUsersExpanded.value = isUsersExp;
//     isHRMExpanded.value = isHRMExpandedExp;
//     isHelpdeskExpanded.value = isHelpdeskExp;
//     isLogsExpanded.value = isLogsExp;
//     isFileManagerExpanded.value = isFileManagerExp;
//     isSettingsExpanded.value = isSettingsExp;
//   }
//
//   void handleNavItemClick(String title, VoidCallback? onExpand) {
//     // Close all other expansions before handling the new one
//     if (title != currentlyExpandedNav.value) {
//       closeAllExpansions();
//       currentlyExpandedNav.value = title;
//     }
//
//     selectedNav.value = title;
//
//     if (selectedNav.value != 'Accounts' &&
//         selectedNav.value != 'Leads' &&
//         selectedNav.value != 'Customer') {
//       selectedSubNav.value = '';
//     }
//
//     if (onExpand != null) {
//       onExpand();
//     }
//   }
//
//   void toggleSubNav(String title) {
//     selectedSubNav.value = title;
//   }
//
//   void expandAccounts() {
//     // Close leads expansion if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     isAccountsExpanded.toggle();
//     currentlyExpandedNav.value = isAccountsExpanded.value ? 'Customer' : '';
//   }
//
//   void expandOrders() {
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     isOrdersExpanded.toggle();
//     currentlyExpandedNav.value = isOrdersExpanded.value ? 'Orders' : '';
//   }
//
//   void expandProducts() {
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//     if (isSalesExpanded.value) {
//       isSalesExpanded.value = false;
//     }
//     isProductsExpanded.toggle();
//     currentlyExpandedNav.value = isProductsExpanded.value ? 'Products' : '';
//   }
//
//   void expandLeads() {
//     // Close accounts expansion if open
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     isLeadsExpanded.toggle();
//     currentlyExpandedNav.value = isLeadsExpanded.value ? 'Leads' : '';
//   }
//
//   void expandSales() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//     isSalesExpanded.toggle();
//     currentlyExpandedNav.value = isSalesExpanded.value ? 'Sales' : '';
//   }
//
//   void expandInventory() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//
//     isInventoryExpanded.toggle();
//     currentlyExpandedNav.value = isInventoryExpanded.value ? 'Inventory' : '';
//   }
//
//   void expandProjects() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//
//     isProjectsExpanded.toggle();
//     currentlyExpandedNav.value = isProjectsExpanded.value ? 'Projects' : '';
//   }
//
//   void expandTasks() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//
//     isTasksExpanded.toggle();
//     currentlyExpandedNav.value = isTasksExpanded.value ? 'Tasks' : '';
//   }
//
//   void expandMarketing() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//
//     isMarketingExpanded.toggle();
//     currentlyExpandedNav.value = isMarketingExpanded.value ? 'Marketing' : '';
//   }
//   /////////////////////////////////
//
//   void expandReports() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//
//     isReportsExpanded.toggle();
//     currentlyExpandedNav.value = isReportsExpanded.value ? 'Reports' : '';
//   }
//
//   void expandAnalytics() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//
//     isAnalylticsExpanded.toggle();
//     currentlyExpandedNav.value = isAnalylticsExpanded.value ? 'Analytics' : '';
//   }
//
//   void expandUsers() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//
//     isUsersExpanded.toggle();
//     currentlyExpandedNav.value = isUsersExpanded.value ? 'Users' : '';
//   }
//
//   void expandHRM() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//
//     isHRMExpanded.toggle();
//     currentlyExpandedNav.value = isHRMExpanded.value ? 'HRM' : '';
//   }
//
//   void expandHelpdesk() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//
//     isHelpdeskExpanded.toggle();
//     currentlyExpandedNav.value = isHelpdeskExpanded.value ? 'HelpDesk' : '';
//   }
//
//   void expandLogs() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//
//     isLogsExpanded.toggle();
//     currentlyExpandedNav.value = isLogsExpanded.value ? 'Logs' : '';
//   }
//
//   void expandFileManager() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//
//     isFileManagerExpanded.toggle();
//     currentlyExpandedNav.value =
//         isFileManagerExpanded.value ? 'File Manager' : '';
//   }
//
//   void expandSettings() {
//     // Close other expansions if open
//     if (isLeadsExpanded.value) {
//       isLeadsExpanded.value = false;
//     }
//     if (isAccountsExpanded.value) {
//       isAccountsExpanded.value = false;
//     }
//     if (isOrdersExpanded.value) {
//       isOrdersExpanded.value = false;
//     }
//
//     isSettingsExpanded.toggle();
//     currentlyExpandedNav.value = isSettingsExpanded.value ? 'Settings' : '';
//   }
//
//   void closeAllExpansions() {
//     isAccountsExpanded.value = false;
//     isLeadsExpanded.value = false;
//     isOrdersExpanded.value = false;
//     isSalesExpanded.value = false;
//     isProductsExpanded.value = false;
//     isInventoryExpanded.value = false;
//     isProjectsExpanded.value = false;
//     isTasksExpanded.value = false;
//     isMarketingExpanded.value = false;
//     ///////////////////////////////////////////////
//     isReportsExpanded.value = false;
//     isAnalylticsExpanded.value = false;
//     isUsersExpanded.value = false;
//     isHRMExpanded.value = false;
//     isHelpdeskExpanded.value = false;
//     isLogsExpanded.value = false;
//     isFileManagerExpanded.value = false;
//     isSettingsExpanded.value = false;
//
//     currentlyExpandedNav.value = '';
//     selectedSubNav.value = '';
//   }
// }
//
// // custom_drawer.dart
// class CustomDrawerManager extends StatefulWidget {
//   final Function(String, String) onNavigation;
//   final bool isLocalCollapsed;
//   final Function(bool) onCollapseToggle;
//
//   CustomDrawerManager({
//     super.key,
//     required this.onNavigation,
//     required this.isLocalCollapsed,
//     required this.onCollapseToggle,
//   }) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final controller = Get.find<DrawerController>();
//       if (controller.selectedNav.value.isEmpty) {
//         onNavigation('Dashboard', '');
//       } else {
//         onNavigation(
//             controller.selectedNav.value, controller.selectedSubNav.value);
//       }
//     });
//   }
//
//   final DrawerController controller = Get.put(DrawerController());
//   final _saveUser = SaveUserData();
//
//   String userName = '';
//   String? userEmail = "";
//
//   @override
//   _CustomDrawerManagerState createState() => _CustomDrawerManagerState();
// }
//
// class _CustomDrawerManagerState extends State<CustomDrawerManager> {
//   String userName = '';
//   String mobile = '';
//
//   final MainDashboardListViewModel userProfile = MainDashboardListViewModel();
//
//   @override
//   void initState() {
//     super.initState();
//     Get.put(MainDashboardListViewModel());
//     // Call fetchUserData in the controller
//     Get.find<MainDashboardListViewModel>().mainDashboardItem();
//     // Initialize navigation
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final controller = Get.find<DrawerController>();
//       if (controller.selectedNav.value.isEmpty) {
//         widget.onNavigation('Dashboard', '');
//       } else {
//         widget.onNavigation(
//             controller.selectedNav.value, controller.selectedSubNav.value);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final MainDashboardListViewModel controller = Get.find();
//
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.only(
//           top: 51,
//           left: widget.isLocalCollapsed ? 8 : 15,
//           right: widget.isLocalCollapsed ? 8 : 20,
//           bottom: 15,
//         ),
//         child: Obx(() => Column(
//               crossAxisAlignment: widget.isLocalCollapsed
//                   ? CrossAxisAlignment.center
//                   : CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 0),
//                   child: Column(
//                     crossAxisAlignment: widget.isLocalCollapsed
//                         ? CrossAxisAlignment.center
//                         : CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: widget.isLocalCollapsed ? 0 : 12, bottom: 0),
//                         child: Row(
//                           mainAxisAlignment: widget.isLocalCollapsed
//                               ? MainAxisAlignment.center
//                               : MainAxisAlignment.start,
//                           children: [
//                             Column(
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.white,
//                                   ),
//                                   child: ClipOval(
//                                     child: Image.asset(
//                                       "assets/images/profile.png",
//                                       height: 48,
//                                       width: 48,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             if (!widget.isLocalCollapsed) ...[
//                               const SizedBox(width: 13),
//                               Obx(() => Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       ResponsiveText.getDrawerUserTextSize(
//                                         context,
//                                         controller.userName.value,
//                                       ),
//                                       SizedBox(
//                                         height: 2.5,
//                                       ),
//                                       ResponsiveText.getDrawerUserTextMobSize(
//                                         context,
//                                         '+91-${controller.mobile.value}',
//                                       )
//                                     ],
//                                   )),
//                             ],
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 21),
//                       // _buildNavItem(
//                       //     context: context,
//                       //     title: 'Practice Screen',
//                       //     image: IconStrings.campaign),
//                       // const SizedBox(height: 10),
//                       _buildNavItem(
//                           context: context,
//                           title: 'Dashboard',
//                           image: IconStrings.dashboard),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                           context: context,
//                           title: 'Calender',
//                           image: IconStrings.calender,
//                           imageWidth: 18.7,
//                           imageHeight: 18.7
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Leads',
//                         hasSubmenu: true,
//                         onExpand: widget.controller.expandLeads,
//                         isExpanded: widget.controller.isLeadsExpanded.value,
//                         image: IconStrings.lead,
//                       ),
//
//                       Column(
//                         children: [
//                           if (widget.controller.isLeadsExpanded.value) ...[
//                             _buildSubNavItem(context, 'Create'),
//                             _buildSubNavItem(context, 'List'),
//                             _buildSubNavItem(context, 'Proformas'),
//                             _buildSubNavItem(context, 'Setting'),
//                             _buildSubNavItem(context, 'Trash'),
//                           ],
//                         ],
//                       ),
//
//
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//
//                         context: context,
//                         title: 'Customer',
//                         hasSubmenu: true,
//                         onExpand: widget.controller.expandAccounts,
//                         isExpanded: widget.controller.isAccountsExpanded.value,
//                         image: IconStrings.customers,
//                           imageWidth: 19.2,
//                           imageHeight: 19.2,
//
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isAccountsExpanded.value) ...[
//                             _buildSubNavItem(context, 'Create'),
//                             _buildSubNavItem(context, 'List'),
//                             _buildSubNavItem(context, 'Proformas'),
//                             _buildSubNavItem(context, 'Credential'),
//                             _buildSubNavItem(context, 'Services Areas'),
//                             _buildSubNavItem(context, 'Setting'),
//                             _buildSubNavItem(context, 'Trash')
//                           ],
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Orders',
//                         image: IconStrings.orders,
//                         onExpand: widget.controller
//                             .expandOrders, // Corrected to use the method
//                         isExpanded: widget.controller.isOrdersExpanded.value,
//                         hasSubmenu: true,
//                       ),
//
//                       Column(
//                         children: [
//                           if (widget.controller.isOrdersExpanded.value) ...[
//                             _buildSubNavItem(context, 'Create'),
//                             _buildSubNavItem(context, 'List'),
//                             _buildSubNavItem(context, 'Payments'),
//                             _buildSubNavItem(context, 'Payments Reminder'),
//                             _buildSubNavItem(context, 'One Time Services'),
//                             _buildSubNavItem(context, 'Recurring Services'),
//                             _buildSubNavItem(context, 'Orderless Services'),
//                             _buildSubNavItem(context, 'Activations'),
//                             _buildSubNavItem(context, 'Settings'),
//                           ],
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Sales',
//                         image: IconStrings.sales,
//                         onExpand: widget.controller
//                             .expandSales, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isSalesExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: true,
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isSalesExpanded.value) ...[
//                             _buildSubNavItem(context, 'Target'),
//                             _buildSubNavItem(context, 'Projection'),
//                           ],
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Products',
//                         image: IconStrings.products,
//                         onExpand: widget.controller
//                             .expandProducts, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isProductsExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: true,
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isProductsExpanded.value) ...[
//                             _buildSubNavItem(context, 'Products'),
//                             _buildSubNavItem(context, 'Services'),
//                             _buildSubNavItem(context, 'Categories'),
//                             _buildSubNavItem(context, 'Brands'),
//                             _buildSubNavItem(context, 'Gst Setting'),
//                             _buildSubNavItem(context, 'Activations Forms'),
//                             _buildSubNavItem(context, 'Settings'),
//                           ],
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Inventory',
//                         image: IconStrings.analytics,
//                         onExpand: widget.controller
//                             .expandInventory, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isInventoryExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: true,
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isInventoryExpanded.value) ...[
//                             _buildSubNavItem(context, 'Stock'),
//                             _buildSubNavItem(context, 'Request'),
//                             _buildSubNavItem(context, 'Transactions'),
//                             _buildSubNavItem(context, 'Vendors'),
//                             _buildSubNavItem(context, 'Refil Stock'),
//                           ],
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Projects',
//                         image: IconStrings.projects,
//                         onExpand: widget.controller
//                             .expandProjects, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isProjectsExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: true,
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isProjectsExpanded.value) ...[
//                             _buildSubNavItem(context, 'List'),
//                             _buildSubNavItem(context, 'Setting'),
//                           ],
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Tasks',
//                         image: IconStrings.tasks,
//                         onExpand: widget.controller
//                             .expandTasks, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isTasksExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: true,
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isTasksExpanded.value) ...[
//                             _buildSubNavItem(context, 'List'),
//                             _buildSubNavItem(context, 'Setting'),
//                           ],
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Marketing',
//                         image: IconStrings.campaign,
//                         onExpand: widget.controller
//                             .expandMarketing, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isMarketingExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: true,
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isMarketingExpanded.value) ...[
//                             _buildSubNavItem(context, 'SMS'),
//                             _buildSubNavItem(context, 'WhatsApp'),
//                           ],
//                         ],
//                       ),
//
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Reports',
//                         image: IconStrings.analytics,
//                         onExpand: widget.controller
//                             .expandReports, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isReportsExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: true,
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isReportsExpanded.value) ...[
//                             _buildSubNavItem(context, 'Lead Reports'),
//                             _buildSubNavItem(context, 'Customer Reports'),
//                             _buildSubNavItem(context, 'Task Reports'),
//                             _buildSubNavItem(context, 'Employee Reports'),
//                             _buildSubNavItem(context, 'Product-Wise Sale'),
//                             _buildSubNavItem(context, 'Recurring Service'),
//                           ],
//                         ],
//                       ),
//
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Analytics',
//                         image: IconStrings.sales,
//                         onExpand: widget.controller
//                             .expandAnalytics, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isAnalylticsExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: true,
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isAnalylticsExpanded.value) ...[
//                             _buildSubNavItem(context, 'Sale'),
//                             _buildSubNavItem(context, 'Lead'),
//                             _buildSubNavItem(context, 'Customer'),
//                             _buildSubNavItem(context, 'PH Performance'),
//                           ],
//                         ],
//                       ),
//
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Users',
//                         image: IconStrings.users,
//                         onExpand: widget.controller
//                             .expandUsers, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isUsersExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: true,
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isUsersExpanded.value) ...[
//                             _buildSubNavItem(context, 'List'),
//                             _buildSubNavItem(context, 'Role'),
//                             _buildSubNavItem(context, 'Department'),
//                             _buildSubNavItem(context, 'Activities'),
//                           ],
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'HRM',
//                         image: IconStrings.hrm,
//                         onExpand: widget.controller
//                             .expandHRM, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isHRMExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: true,
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isHRMExpanded.value) ...[
//                             _buildSubNavItem(context, 'Attendance'),
//                             _buildSubNavItem(context, 'Leave'),
//                           ],
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'HelpDesk',
//                         image: IconStrings.sales,
//                         onExpand: widget.controller
//                             .expandHelpdesk, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isHelpdeskExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: true,
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isHelpdeskExpanded.value) ...[
//                             _buildSubNavItem(context, 'List'),
//                           ],
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Logs',
//                         image: IconStrings.lead,
//                         onExpand: widget.controller
//                             .expandLogs, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isLogsExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: false,
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'File Manager',
//                         image: IconStrings.serviceArea,
//                         onExpand: widget.controller
//                             .expandFileManager, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isFileManagerExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: false,
//                       ),
//                       const SizedBox(height: 5),
//                       _buildNavItem(
//                         context: context,
//                         title: 'Settings',
//                         image: IconStrings.sales,
//                         onExpand: widget.controller
//                             .expandSettings, // Change this to expandSales instead of expandOrders
//                         isExpanded: widget.controller.isSettingsExpanded
//                             .value, // Use isSalesExpanded instead of isOrdersExpanded
//                         hasSubmenu: true,
//                       ),
//                       Column(
//                         children: [
//                           if (widget.controller.isSettingsExpanded.value) ...[
//                             _buildSubNavItem(context, 'Dashboard'),
//                             _buildSubNavItem(context, 'Division'),
//                             _buildSubNavItem(context, 'Proposal'),
//                             _buildSubNavItem(context, 'Cities'),
//                           ],
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(left: 17, top: 10),
//                 //   child: CommonButton(
//                 //     color: AllColors.practiceColor,
//                 //     height: 30,
//                 //     width: widget.isLocalCollapsed ? 60 : 120,
//                 //     title: 'Log out',
//                 //     onPress: () {
//                 //       _saveUser.removeUser();
//                 //       Get.offNamed('/login_screen');
//                 //       Get.snackbar('Logout', 'Logout Successful');
//                 //     },
//                 //   ),
//                 // ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: widget.isLocalCollapsed ? 0 : 8,
//                     top: 20,
//                     bottom: 0,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: widget.isLocalCollapsed
//                         ? MainAxisAlignment.center
//                         : MainAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           widget.controller.preserveCurrentState();
//                           widget.onCollapseToggle(!widget.isLocalCollapsed);
//                           widget.onNavigation(
//                             widget.controller.selectedNav.value,
//                             widget.controller.selectedSubNav.value,
//                           );
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: AllColors.practiceColor,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Icon(
//                             widget.isLocalCollapsed
//                                 ? Icons.arrow_forward_ios_sharp
//                                 : Icons.arrow_back_ios_sharp,
//                             color: Colors.white,
//                             size: 18,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
//
//   Widget _buildNavItem({
//     required BuildContext context,
//     required String title,
//     required String image, // Path to image asset
//     bool hasSubmenu = false,
//     VoidCallback? onExpand,
//     bool isExpanded = false,
//     double? imageHeight, // Optional height
//     double? imageWidth, // Optional width
//   }) {
//     return Obx(() {
//       final bool isSelected = widget.controller.selectedNav.value == title;
//       final bool isSvg = image.endsWith('.svg');
//
//       return GestureDetector(
//         onTap: () {
//           if (hasSubmenu) {
//             if (widget.isLocalCollapsed) {
//               widget.onCollapseToggle(false);
//               widget.controller.handleNavItemClick(title, onExpand);
//             } else {
//               widget.controller.handleNavItemClick(title, onExpand);
//             }
//           } else {
//             widget.controller.handleNavItemClick(title, null);
//             widget.onNavigation(widget.controller.selectedNav.value,
//                 widget.controller.selectedSubNav.value);
//           }
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             color: isSelected ? AllColors.practiceColor : null,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           height: 36,
//           width: widget.isLocalCollapsed ? 44 : 190,
//           padding: EdgeInsets.symmetric(
//               horizontal: widget.isLocalCollapsed ? 8 : 16),
//           child: Row(
//             mainAxisAlignment: widget.isLocalCollapsed
//                 ? MainAxisAlignment.center
//                 : MainAxisAlignment.start,
//             children: [
//               isSvg
//                   ? SvgIcon(
//                       assetPath: image,
//                       size: imageWidth ?? 20.0, // Use provided width or default
//                       color: isSelected
//                           ? Colors.white
//                           : (Theme.of(context).brightness == Brightness.dark
//                               ? Colors.white
//                               : AllColors.bottomNavColor),
//                     )
//                   : Image.asset(
//                       image,
//                       color: isSelected
//                           ? Colors.white
//                           : (Theme.of(context).brightness == Brightness.dark
//                               ? Colors.white
//                               : AllColors.bottomNavColor),
//                       height: imageHeight ?? 19,
//                       width: imageWidth ?? 19,
//                     ),
//               if (!widget.isLocalCollapsed) ...[
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: ResponsiveText.getDrawerTextSize(
//                     color: isSelected
//                         ? Colors.white
//                         : (Theme.of(context).brightness == Brightness.dark
//                         ? Colors.white
//                         : AllColors.bottomNavColor),
//
//                     context,
//                     title,
//                   ),
//
//                   // Text(
//                   //   title,
//                   //   overflow: TextOverflow.ellipsis,
//                   //   style: TextStyle(
//                   //     color: isSelected
//                   //         ? Colors.white
//                   //         : (Theme.of(context).brightness == Brightness.dark
//                   //             ? Colors.white
//                   //             : AllColors.bottomNavColor),
//                   //     fontWeight:
//                   //         isSelected ? FontWeight.w500 : FontWeight.normal,
//                   //   ),
//                   // ),
//                 ),
//                 if (hasSubmenu)
//                   Icon(
//                     isExpanded ? Icons.expand_less : Icons.expand_more,
//                     color: isSelected ? Colors.white : Colors.grey[600],
//                   ),
//               ],
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget _buildSubNavItem(BuildContext context, String title) {
//     return Obx(() {
//       final bool isSelected = widget.controller.selectedSubNav.value == title;
//
//       return !widget.isLocalCollapsed
//           ? GestureDetector(
//               onTap: () {
//                 widget.controller.toggleSubNav(title);
//                 widget.onNavigation(widget.controller.selectedNav.value, title);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 6, left: 10, right: 30),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: isSelected ? AllColors.lightPracticeColor : null,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   height: 28,
//                   width: 170,
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     children: [
//                       // Text(
//                       //   title,
//                       //   style: TextStyle(
//                       //     color: isSelected
//                       //         ? AllColors.bottomNavColor
//                       //         : (Theme.of(context).brightness == Brightness.dark
//                       //             ? Colors.white
//                       //             : AllColors.bottomNavColor),
//                       //     fontSize: 14,
//                       //   ),
//                       // ),
//
//                       ResponsiveText.getDrawerTextSize(
//                         color: isSelected
//                             ? AllColors.bottomNavColor
//                             : (Theme.of(context).brightness == Brightness.dark
//                             ? Colors.white
//                             : AllColors.bottomNavColor),
//
//                         context,
//                         title,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           : Container();
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/responseModels/dashboard/db_count_response_model.dart';
import '../../../../data/models/responseModels/dashboard/main_dashboard/List/MainDashboardChartsList.dart';
import '../../../../data/models/responseModels/login/login_response_model.dart';
import '../../../../resources/iconStrings/icon_strings.dart';
import '../../../../resources/svg/svg_string.dart';
import '../../../../resources/textStyles/responsive/test_responsive.dart';
import '../../../../utils/appColors/app_colors.dart';
import '../../../../utils/components/buttons/common_button.dart';
import '../../../../utils/dark_mode/dark_mode.dart';
import '../../../../viewModels/dashboard/main_dashboard/MainDashboardListViewModel.dart';
import '../../../../viewModels/saveToken/save_token.dart';

class DrawerController extends GetxController {
  final RxString selectedNav = 'Dashboard'.obs;
  final RxString selectedSubNav = ''.obs;
  final RxBool isAccountsExpanded = false.obs;
  final RxBool isLeadsExpanded = false.obs;
  final RxBool isOrdersExpanded = false.obs;
  final RxBool isSalesExpanded = false.obs;
  final RxBool isProductsExpanded = false.obs;
  final RxBool isInventoryExpanded = false.obs;
  final RxBool isProjectsExpanded = false.obs;
  final RxBool isTasksExpanded = false.obs;
  final RxBool isMarketingExpanded = false.obs;
  final RxBool isReportsExpanded = false.obs;
  final RxBool isAnalylticsExpanded = false.obs;
  final RxBool isUsersExpanded = false.obs;
  final RxBool isHRMExpanded = false.obs;
  final RxBool isHelpdeskExpanded = false.obs;
  final RxBool isLogsExpanded = false.obs;
  final RxBool isFileManagerExpanded = false.obs;
  final RxBool isSettingsExpanded = false.obs;

  RxString currentlyExpandedNav = ''.obs;

  void preserveCurrentState() {
    final currentNav = selectedNav.value;
    final currentSubNav = selectedSubNav.value;
    final isLeadsExp = isLeadsExpanded.value;
    final isAccountsExp = isAccountsExpanded.value;
    final isOrdersExp = isOrdersExpanded.value;
    final isSalesExp = isSalesExpanded.value;
    final isProductsExp = isProductsExpanded.value;
    final isInventoryExp = isInventoryExpanded.value;
    final isProjectsExp = isProjectsExpanded.value;
    final isTasksExp = isTasksExpanded.value;
    final isMarketingExp = isMarketingExpanded.value;
    final isReportsExp = isReportsExpanded.value;
    final isAnalylticsExp = isAnalylticsExpanded.value;
    final isUsersExp = isUsersExpanded.value;
    final isHRMExpandedExp = isHRMExpanded.value;
    final isHelpdeskExp = isHelpdeskExpanded.value;
    final isLogsExp = isLogsExpanded.value;
    final isFileManagerExp = isFileManagerExpanded.value;
    final isSettingsExp = isSettingsExpanded.value;

    selectedNav.value = currentNav;
    selectedSubNav.value = currentSubNav;
    isLeadsExpanded.value = isLeadsExp;
    isAccountsExpanded.value = isAccountsExp;
    isOrdersExpanded.value = isOrdersExp;
    isSalesExpanded.value = isSalesExp;
    isProductsExpanded.value = isProductsExp;
    isInventoryExpanded.value = isInventoryExp;
    isProjectsExpanded.value = isProjectsExp;
    isTasksExpanded.value = isTasksExp;
    isMarketingExpanded.value = isMarketingExp;
    isReportsExpanded.value = isReportsExp;
    isAnalylticsExpanded.value = isAnalylticsExp;
    isUsersExpanded.value = isUsersExp;
    isHRMExpanded.value = isHRMExpandedExp;
    isHelpdeskExpanded.value = isHelpdeskExp;
    isLogsExpanded.value = isLogsExp;
    isFileManagerExpanded.value = isFileManagerExp;
    isSettingsExpanded.value = isSettingsExp;
  }

  void handleNavItemClick(String title, VoidCallback? onExpand) {
    if (title != currentlyExpandedNav.value) {
      closeAllExpansions();
      currentlyExpandedNav.value = title;
    }

    selectedNav.value = title;

    if (selectedNav.value != 'Accounts' &&
        selectedNav.value != 'Leads' &&
        selectedNav.value != 'Customer') {
      selectedSubNav.value = '';
    }

    if (onExpand != null) {
      onExpand();
    }
  }

  void toggleSubNav(String title) {
    selectedSubNav.value = title;
  }

  void expandAccounts() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    isAccountsExpanded.toggle();
    currentlyExpandedNav.value = isAccountsExpanded.value ? 'Customer' : '';
  }

  void expandOrders() {
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    isOrdersExpanded.toggle();
    currentlyExpandedNav.value = isOrdersExpanded.value ? 'Orders' : '';
  }

  void expandProducts() {
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    if (isSalesExpanded.value) {
      isSalesExpanded.value = false;
    }
    isProductsExpanded.toggle();
    currentlyExpandedNav.value = isProductsExpanded.value ? 'Products' : '';
  }

  void expandLeads() {
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    isLeadsExpanded.toggle();
    currentlyExpandedNav.value = isLeadsExpanded.value ? 'Leads' : '';
  }

  void expandSales() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isSalesExpanded.toggle();
    currentlyExpandedNav.value = isSalesExpanded.value ? 'Sales' : '';
  }

  void expandInventory() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isInventoryExpanded.toggle();
    currentlyExpandedNav.value = isInventoryExpanded.value ? 'Inventory' : '';
  }

  void expandProjects() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isProjectsExpanded.toggle();
    currentlyExpandedNav.value = isProjectsExpanded.value ? 'Projects' : '';
  }

  void expandTasks() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isTasksExpanded.toggle();
    currentlyExpandedNav.value = isTasksExpanded.value ? 'Tasks' : '';
  }

  void expandMarketing() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isMarketingExpanded.toggle();
    currentlyExpandedNav.value = isMarketingExpanded.value ? 'Marketing' : '';
  }

  void expandReports() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isReportsExpanded.toggle();
    currentlyExpandedNav.value = isReportsExpanded.value ? 'Reports' : '';
  }

  void expandAnalytics() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isAnalylticsExpanded.toggle();
    currentlyExpandedNav.value = isAnalylticsExpanded.value ? 'Analytics' : '';
  }

  void expandUsers() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isUsersExpanded.toggle();
    currentlyExpandedNav.value = isUsersExpanded.value ? 'Users' : '';
  }

  void expandHRM() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isHRMExpanded.toggle();
    currentlyExpandedNav.value = isHRMExpanded.value ? 'HRM' : '';
  }

  void expandHelpdesk() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isHelpdeskExpanded.toggle();
    currentlyExpandedNav.value = isHelpdeskExpanded.value ? 'HelpDesk' : '';
  }

  void expandLogs() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isLogsExpanded.toggle();
    currentlyExpandedNav.value = isLogsExpanded.value ? 'Logs' : '';
  }

  void expandFileManager() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isFileManagerExpanded.toggle();
    currentlyExpandedNav.value = isFileManagerExpanded.value ? 'File Manager' : '';
  }

  void expandSettings() {
    if (isLeadsExpanded.value) {
      isLeadsExpanded.value = false;
    }
    if (isAccountsExpanded.value) {
      isAccountsExpanded.value = false;
    }
    if (isOrdersExpanded.value) {
      isOrdersExpanded.value = false;
    }
    isSettingsExpanded.toggle();
    currentlyExpandedNav.value = isSettingsExpanded.value ? 'Settings' : '';
  }

  void closeAllExpansions() {
    isAccountsExpanded.value = false;
    isLeadsExpanded.value = false;
    isOrdersExpanded.value = false;
    isSalesExpanded.value = false;
    isProductsExpanded.value = false;
    isInventoryExpanded.value = false;
    isProjectsExpanded.value = false;
    isTasksExpanded.value = false;
    isMarketingExpanded.value = false;
    isReportsExpanded.value = false;
    isAnalylticsExpanded.value = false;
    isUsersExpanded.value = false;
    isHRMExpanded.value = false;
    isHelpdeskExpanded.value = false;
    isLogsExpanded.value = false;
    isFileManagerExpanded.value = false;
    isSettingsExpanded.value = false;

    currentlyExpandedNav.value = '';
    selectedSubNav.value = '';
  }
}

class CustomDrawerManager extends StatefulWidget {
  final Function(String, String) onNavigation;
  final bool isLocalCollapsed;
  final Function(bool) onCollapseToggle;
  final GlobalKey<ScaffoldState> scaffoldKey; // Add scaffoldKey

  CustomDrawerManager({
    super.key,
    required this.onNavigation,
    required this.isLocalCollapsed,
    required this.onCollapseToggle,
    required this.scaffoldKey, // Require scaffoldKey
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<DrawerController>();
      if (controller.selectedNav.value.isEmpty) {
        onNavigation('Dashboard', '');
      } else {
        onNavigation(
            controller.selectedNav.value, controller.selectedSubNav.value);
      }
    });
  }

  final DrawerController controller = Get.put(DrawerController());
  final _saveUser = SaveUserData();

  String userName = '';
  String? userEmail = "";

  @override
  _CustomDrawerManagerState createState() => _CustomDrawerManagerState();
}

class _CustomDrawerManagerState extends State<CustomDrawerManager> {
  String userName = '';
  String mobile = '';

  final MainDashboardListViewModel userProfile = MainDashboardListViewModel();

  @override
  void initState() {
    super.initState();
    Get.put(MainDashboardListViewModel());
    Get.find<MainDashboardListViewModel>().mainDashboardItem();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<DrawerController>();
      if (controller.selectedNav.value.isEmpty) {
        widget.onNavigation('Dashboard', '');
      } else {
        widget.onNavigation(
            controller.selectedNav.value, controller.selectedSubNav.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final MainDashboardListViewModel controller = Get.find();
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 51,
          left: widget.isLocalCollapsed ? 8 : 15,
          right: widget.isLocalCollapsed ? 8 : 20,
          bottom: 15,
        ),
        child: Obx(() => Column(
          crossAxisAlignment: widget.isLocalCollapsed
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                crossAxisAlignment: widget.isLocalCollapsed
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: widget.isLocalCollapsed ? 0 : 12, bottom: 0),
                    child: Row(
                      mainAxisAlignment: widget.isLocalCollapsed
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/profile.png",
                                  height: 48,
                                  width: 48,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (!widget.isLocalCollapsed) ...[
                          const SizedBox(width: 13),
                          Obx(() => Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              ResponsiveText.getDrawerUserTextSize(
                                context,
                                controller.userName.value,
                              ),
                              SizedBox(
                                height: 2.5,
                              ),
                              ResponsiveText.getDrawerUserTextMobSize(
                                context,
                                '+91-${controller.mobile.value}',
                              )
                            ],
                          )),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 21),
                  _buildNavItem(
                    context: context,
                    title: 'Practice',
                    image: IconStrings.phone,
                    isMobile: isMobile, // Pass isMobile
                  ),


                  _buildNavItem(
                    context: context,
                    title: 'Dashboard',
                    image: IconStrings.dashboard,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Calender',
                    image: IconStrings.calender,
                    imageWidth: 18.7,
                    imageHeight: 18.7,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Leads',
                    hasSubmenu: true,
                    onExpand: widget.controller.expandLeads,
                    isExpanded: widget.controller.isLeadsExpanded.value,
                    image: IconStrings.lead,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isLeadsExpanded.value) ...[
                        _buildSubNavItem(context, 'Create', isMobile),
                        _buildSubNavItem(context, 'List', isMobile),
                        _buildSubNavItem(context, 'Proformas', isMobile),
                        _buildSubNavItem(context, 'Setting', isMobile),
                        _buildSubNavItem(context, 'Trash', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Customer',
                    hasSubmenu: true,
                    onExpand: widget.controller.expandAccounts,
                    isExpanded: widget.controller.isAccountsExpanded.value,
                    image: IconStrings.customers,
                    imageWidth: 19.2,
                    imageHeight: 19.2,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isAccountsExpanded.value) ...[
                        _buildSubNavItem(context, 'Create', isMobile),
                        _buildSubNavItem(context, 'List', isMobile),
                        _buildSubNavItem(context, 'Proformas', isMobile),
                        _buildSubNavItem(context, 'Credential', isMobile),
                        _buildSubNavItem(context, 'Services Areas', isMobile),
                        _buildSubNavItem(context, 'Setting', isMobile),
                        _buildSubNavItem(context, 'Trash', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Orders',
                    image: IconStrings.orders,
                    onExpand: widget.controller.expandOrders,
                    isExpanded: widget.controller.isOrdersExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isOrdersExpanded.value) ...[
                        _buildSubNavItem(context, 'Create', isMobile),
                        _buildSubNavItem(context, 'List', isMobile),
                        _buildSubNavItem(context, 'Payments', isMobile),
                        _buildSubNavItem(context, 'Payments Reminder', isMobile),
                        _buildSubNavItem(context, 'One Time Services', isMobile),
                        _buildSubNavItem(context, 'Recurring Services', isMobile),
                        _buildSubNavItem(context, 'Orderless Services', isMobile),
                        _buildSubNavItem(context, 'Activations', isMobile),
                        _buildSubNavItem(context, 'Settings', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Sales',
                    image: IconStrings.sales,
                    onExpand: widget.controller.expandSales,
                    isExpanded: widget.controller.isSalesExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isSalesExpanded.value) ...[
                        _buildSubNavItem(context, 'Target', isMobile),
                        _buildSubNavItem(context, 'Projection', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Products',
                    image: IconStrings.products,
                    onExpand: widget.controller.expandProducts,
                    isExpanded: widget.controller.isProductsExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isProductsExpanded.value) ...[
                        _buildSubNavItem(context, 'Products', isMobile),
                        _buildSubNavItem(context, 'Services', isMobile),
                        _buildSubNavItem(context, 'Categories', isMobile),
                        _buildSubNavItem(context, 'Brands', isMobile),
                        _buildSubNavItem(context, 'Gst Setting', isMobile),
                        _buildSubNavItem(context, 'Activations Forms', isMobile),
                        _buildSubNavItem(context, 'Settings', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Inventory',
                    image: IconStrings.analytics,
                    onExpand: widget.controller.expandInventory,
                    isExpanded: widget.controller.isInventoryExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isInventoryExpanded.value) ...[
                        _buildSubNavItem(context, 'Stock', isMobile),
                        _buildSubNavItem(context, 'Request', isMobile),
                        _buildSubNavItem(context, 'Transactions', isMobile),
                        _buildSubNavItem(context, 'Vendors', isMobile),
                        _buildSubNavItem(context, 'Refil Stock', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Projects',
                    image: IconStrings.projects,
                    onExpand: widget.controller.expandProjects,
                    isExpanded: widget.controller.isProjectsExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isProjectsExpanded.value) ...[
                        _buildSubNavItem(context, 'List', isMobile),
                        _buildSubNavItem(context, 'Setting', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Tasks',
                    image: IconStrings.tasks,
                    onExpand: widget.controller.expandTasks,
                    isExpanded: widget.controller.isTasksExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isTasksExpanded.value) ...[
                        _buildSubNavItem(context, 'List', isMobile),
                        _buildSubNavItem(context, 'Setting', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Marketing',
                    image: IconStrings.campaign,
                    onExpand: widget.controller.expandMarketing,
                    isExpanded: widget.controller.isMarketingExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isMarketingExpanded.value) ...[
                        _buildSubNavItem(context, 'SMS', isMobile),
                        _buildSubNavItem(context, 'WhatsApp', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Reports',
                    image: IconStrings.analytics,
                    onExpand: widget.controller.expandReports,
                    isExpanded: widget.controller.isReportsExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isReportsExpanded.value) ...[
                        _buildSubNavItem(context, 'Lead Reports', isMobile),
                        _buildSubNavItem(context, 'Customer Reports', isMobile),
                        _buildSubNavItem(context, 'Task Reports', isMobile),
                        _buildSubNavItem(context, 'Employee Reports', isMobile),
                        _buildSubNavItem(context, 'Product-Wise Sale', isMobile),
                        _buildSubNavItem(context, 'Recurring Service', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Analytics',
                    image: IconStrings.sales,
                    onExpand: widget.controller.expandAnalytics,
                    isExpanded: widget.controller.isAnalylticsExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isAnalylticsExpanded.value) ...[
                        _buildSubNavItem(context, 'Sale', isMobile),
                        _buildSubNavItem(context, 'Lead', isMobile),
                        _buildSubNavItem(context, 'Customer', isMobile),
                        _buildSubNavItem(context, 'PH Performance', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Users',
                    image: IconStrings.users,
                    onExpand: widget.controller.expandUsers,
                    isExpanded: widget.controller.isUsersExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isUsersExpanded.value) ...[
                        _buildSubNavItem(context, 'List', isMobile),
                        _buildSubNavItem(context, 'Role', isMobile),
                        _buildSubNavItem(context, 'Department', isMobile),
                        _buildSubNavItem(context, 'Activities', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'HRM',
                    image: IconStrings.hrm,
                    onExpand: widget.controller.expandHRM,
                    isExpanded: widget.controller.isHRMExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isHRMExpanded.value) ...[
                        _buildSubNavItem(context, 'Attendance', isMobile),
                        _buildSubNavItem(context, 'Leave', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'HelpDesk',
                    image: IconStrings.sales,
                    onExpand: widget.controller.expandHelpdesk,
                    isExpanded: widget.controller.isHelpdeskExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isHelpdeskExpanded.value) ...[
                        _buildSubNavItem(context, 'List', isMobile),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Logs',
                    image: IconStrings.lead,
                    onExpand: widget.controller.expandLogs,
                    isExpanded: widget.controller.isLogsExpanded.value,
                    hasSubmenu: false,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'File Manager',
                    image: IconStrings.serviceArea,
                    onExpand: widget.controller.expandFileManager,
                    isExpanded: widget.controller.isFileManagerExpanded.value,
                    hasSubmenu: false,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  const SizedBox(height: 5),
                  _buildNavItem(
                    context: context,
                    title: 'Settings',
                    image: IconStrings.sales,
                    onExpand: widget.controller.expandSettings,
                    isExpanded: widget.controller.isSettingsExpanded.value,
                    hasSubmenu: true,
                    isMobile: isMobile, // Pass isMobile
                  ),
                  Column(
                    children: [
                      if (widget.controller.isSettingsExpanded.value) ...[
                        _buildSubNavItem(context, 'Dashboard', isMobile),
                        _buildSubNavItem(context, 'Division', isMobile),
                        _buildSubNavItem(context, 'Proposal', isMobile),
                        _buildSubNavItem(context, 'Cities', isMobile),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: widget.isLocalCollapsed ? 0 : 8,
                top: 20,
                bottom: 0,
              ),
              child: Row(
                mainAxisAlignment: widget.isLocalCollapsed
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.controller.preserveCurrentState();
                      widget.onCollapseToggle(!widget.isLocalCollapsed);
                      widget.onNavigation(
                        widget.controller.selectedNav.value,
                        widget.controller.selectedSubNav.value,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AllColors.mediumPurple,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        widget.isLocalCollapsed
                            ? Icons.arrow_forward_ios_sharp
                            : Icons.arrow_back_ios_sharp,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required String title,
    required String image,
    bool hasSubmenu = false,
    VoidCallback? onExpand,
    bool isExpanded = false,
    double? imageHeight,
    double? imageWidth,
    required bool isMobile, // Add isMobile parameter
  }) {
    return Obx(() {
      final bool isSelected = widget.controller.selectedNav.value == title;
      final bool isSvg = image.endsWith('.svg');

      return GestureDetector(
        onTap: () {
          if (hasSubmenu) {
            if (widget.isLocalCollapsed) {
              widget.onCollapseToggle(false);
              widget.controller.handleNavItemClick(title, onExpand);
            } else {
              widget.controller.handleNavItemClick(title, onExpand);
            }
          } else {
            widget.controller.handleNavItemClick(title, null);
            widget.onNavigation(widget.controller.selectedNav.value,
                widget.controller.selectedSubNav.value);
            // Close drawer in mobile view
            if (isMobile) {
              widget.scaffoldKey.currentState?.closeDrawer();
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AllColors.mediumPurple : null,
            borderRadius: BorderRadius.circular(30),
          ),
          height: 36,
          width: widget.isLocalCollapsed ? 44 : 190,
          padding: EdgeInsets.symmetric(
              horizontal: widget.isLocalCollapsed ? 8 : 16),
          child: Row(
            mainAxisAlignment: widget.isLocalCollapsed
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              isSvg
                  ? SvgIcon(
                assetPath: image,
                size: imageWidth ?? 20.0,
                color: isSelected
                    ? Colors.white
                    : (Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : AllColors.bottomNavColor),
              )
                  : Image.asset(
                image,
                color: isSelected
                    ? Colors.white
                    : (Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : AllColors.bottomNavColor),
                height: imageHeight ?? 19,
                width: imageWidth ?? 19,
              ),
              if (!widget.isLocalCollapsed) ...[
                const SizedBox(width: 14),
                Expanded(
                  child: ResponsiveText.getDrawerTextSize(
                    color: isSelected
                        ? Colors.white
                        : (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : AllColors.bottomNavColor),
                    context,
                    title,
                  ),
                ),
                if (hasSubmenu)
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isSelected ? Colors.white : Colors.grey[600],
                  ),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSubNavItem(BuildContext context, String title, bool isMobile) {
    return Obx(() {
      final bool isSelected = widget.controller.selectedSubNav.value == title;

      return !widget.isLocalCollapsed
          ? GestureDetector(
        onTap: () {
          widget.controller.toggleSubNav(title);
          widget.onNavigation(widget.controller.selectedNav.value, title);
          // Close drawer in mobile view
          if (isMobile) {
            widget.scaffoldKey.currentState?.closeDrawer();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 6, left: 10, right: 30),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AllColors.microPurple : null,
              borderRadius: BorderRadius.circular(30),
            ),
            height: 28,
            width: 170,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ResponsiveText.getDrawerTextSize(
                  color: isSelected
                      ? AllColors.mediumPurple
                      : (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : AllColors.bottomNavColor),
                  context,
                  title,
                ),
              ],
            ),
          ),
        ),
      )
          : Container();
    });
  }
}
