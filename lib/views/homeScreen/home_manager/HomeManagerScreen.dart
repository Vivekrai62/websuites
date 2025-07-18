import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/PraticeScreen.dart';
import 'package:websuites/views/orderScreen/create/OrderCreateScreen.dart';
import '../../../checkDemo.dart';
import '../../../data/models/responseModels/leads/list/lead_list.dart';
import '../../../data/models/responseModels/roles/roles_response_model.dart';

import '../../../utils/appColors/app_colors.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';

import '../../../viewModels/customerScreens/customer_list/customer_detail_view/list/customer_detail_view_list_model.dart';
import '../../../viewModels/leadScreens/lead_list/detail/LeadDetailsViewModel.dart';
import '../../HRM/hrm/HrmAttendanceSceen.dart';
import '../../HRM/leave/HrmLeaveScreen.dart';
import '../../Master/Division.dart';
import '../../Master/ProposalScreen.dart';
import '../../Master/cities/SettingCitiesScreen.dart';
import '../../Master/dashboard/SettingDashboardScreen.dart';
import '../../analytics/sale/SaleAnalyticsScreen.dart';
import '../../bottomNavBarScreen/profile_Screen/bottom__nav_profile_screen.dart';
import '../../calender/Calender.dart';
import '../../customerScreens/Setting/CustomerSettingScreen.dart';
import '../../customerScreens/credential/CustomerCredentialScreen.dart';
import '../../customerScreens/customerList/CustomerListScreen.dart';
import '../../customerScreens/customerList/customerdetails/CustomerDetailsScreen.dart';
import '../../customerScreens/proformas/CustomerProformasScreen.dart';
import '../../customerScreens/search_sevices_areas/CustomerServicesAreas.dart';
import '../../customerScreens/trash/CustomerTrashScreen.dart';
import '../../inventory/request/InventoryRequestListScreen.dart';
import '../../inventory/rifilstock/InventoryRifilStockListScreen.dart';
import '../../inventory/stock/InventoryStockListScreen.dart';
import '../../inventory/transactions/InventoryTransactionsListScreen.dart';
import '../../inventory/vendors/InventoryVendorsListScreen.dart';
import '../../leadScreens/createNewLead/customer_create_screen.dart';
import '../../leadScreens/leadList/edit/LeadEditScreen.dart';
import '../../leadScreens/leadList/lead_deatils/LeadDetails.dart';
import '../../leadScreens/leadList/leadlist_screen.dart';
import '../../leadScreens/proformas/LeadProformasScreen.dart';
import '../../leadScreens/setting/LeadSettingScreen.dart';
import '../../leadScreens/trashLead/trash_lead_screen.dart';
import '../../notification/NotificationScreen.dart';
import '../../orderScreen/activations/OrderActivationsScreen.dart';
import '../../orderScreen/one_time_services/OrderOneTimeServices.dart';
import '../../orderScreen/orderListScreen/orderList_screen.dart';
import '../../orderScreen/orderPaymentsScreen/order_payments_screen.dart';
import '../../orderScreen/order_less_services_screen/OrderLessSeerviceScreen.dart';
import '../../orderScreen/payment_reminder/OrdersPaymentReminderScreen.dart';
import '../../orderScreen/recurring_services/OrdersRecurringServicesScreen.dart';
import '../../orderScreen/setting/OrderSettingScreen.dart';
import '../../products/activations_forms/ProductsActivationsForms.dart';
import '../../products/activations_forms/details/ProductsActivationsFormsDetails.dart';
import '../../products/brands/ProductBrandScreen.dart';
import '../../products/category/CategoryListScreen.dart';
import '../../products/gst/ProductGstListScreen.dart';
import '../../products/master/ProductMasterListScreen.dart';
import '../../products/productlist/ProductsScreen.dart';
import '../../products/services/ProductsServicesScreen.dart';
import '../../project/ProjectListScreen.dart';
import '../../project/details/ProjectDetailsScreen.dart';
import '../../project/master/ProjectMasterScreen.dart';
import '../../reports/employeeReport/ReportEmployeeScreen.dart';
import '../../reports/leadReports/ReportsLeadReportsScreen.dart';
import '../../reports/products_wise_sale_reports/ReportProductsWiseSaleScreen.dart';
import '../../reports/recurringServces/ReportRecurringServicesScreen.dart';
import '../../reports/taskreport/TaskReport.dart';
import '../../reports/taskreport/taskdetails/TaskDetailsScreen.dart';
import '../../rolesScreen/roles_screen.dart';
import '../../salesTargetScreen/projection/SaleProjectionScreen.dart';
import '../../salesTargetScreen/salesDetailsScreen/SalesDetailsScreen.dart';
import '../../salesTargetScreen/sales_target_screen.dart';
import '../../task/master/TasksMasterScreen.dart';
import '../../task/tasklist/TaskList.dart';
import '../../usersScreen/activity/UserActivityScreen.dart';
import '../../usersScreen/activity/userlocation/UserLocationScreen.dart';
import '../../usersScreen/departments/usersDepartmentsScreen.dart';
import '../../usersScreen/userlist/users_screen.dart';
import '../home_screen.dart';
import 'drawer/CustomDrawerManager.dart';
import 'package:websuites/data/models/responseModels/customers/list/customers_list_response_model.dart'
as customerModel; // Alias for customer model
import 'package:websuites/data/models/responseModels/products/activation_forms/ProductsActivationsFormsResModel.dart'
as productsActivations;
import 'package:websuites/data/models/responseModels/userList/activity/UserActivitiesResponseModel.dart'
as userActivities;

import 'package:websuites/data/models/responseModels/sales/sales_response_model.dart'
as salesModel; // Alias for customer model
import 'package:websuites/data/models/responseModels/tasks/list/tasks_list_response_model.dart'
as taskModel; // Alias for customer model

import 'package:websuites/data/models/responseModels/customers/list/customer_detail_view/list/customer_list_detail_view_list_response_model.dart'
as detailModel;


import 'package:websuites/data/models/responseModels/projects/list/projects_list_response_model.dart'
as projectModel; // project role

class HomeManagerController extends GetxController {
  final Rx<userActivities.Items?> selectedActivityItem =
  Rx<userActivities.Items?>(null); // Changed to Items
  final RxBool showOrderDetails = false.obs;
  final RxString selectedPeriod = 'This month'.obs;
  final RxString selectedNav = 'Dashboard'.obs;
  final RxString selectedSubNav = ''.obs;
  final RxBool isLocalCollapsed = false.obs;
  final Rx<Item?> selectedOrderItem = Rx<Item?>(null);
  final Rx<customerModel.Item?> selectedCustomerItem =
  Rx<customerModel.Item?>(null); // For customers
  final Rx<productsActivations.ProductsActivationsFormsResModel?>
  selectedProductsActivationsItem =
  Rx<productsActivations.ProductsActivationsFormsResModel?>(null);
  final Rx<projectModel.Item?> selectedProjectItem = Rx<projectModel.Item?>(null);

  final Rx<detailModel.CustomerListDetailViewListResponseModel?> selectedCustomerDetail = Rx<detailModel.CustomerListDetailViewListResponseModel?>(null);
  final Rx<salesModel.Item?> selectedSalesItem =
  Rx<salesModel.Item?>(null); // For sales
  final Rx<taskModel.Item?> selectedTaskItem =
  Rx<taskModel.Item?>(null); // For sales

  final Rx<Widget> lastScreen = Rx<Widget>(Container()); // Initial placeholder
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final RolesResponseModel role =
  RolesResponseModel();

  @override
  void onInit() {
    super.onInit();

    lastScreen.value = HomeScreen(scaffoldKey: scaffoldKey);

  }

  Widget buildDrawer() {
    return Obx(() => Drawer(
      backgroundColor: Theme.of(Get.context!).brightness == Brightness.dark
          ? AllColors.darkModeGrey
          : Colors.white,
      width: isLocalCollapsed.value ? 100 : 300,
      child: CustomDrawerManager(
        onNavigation: (nav, subNav) {
          updateNavigation(nav, subNav);
        },
        isLocalCollapsed: isLocalCollapsed.value,
        onCollapseToggle: toggleCollapse,
        scaffoldKey: scaffoldKey, // Pass scaffoldKey
      ),
    ));
  }

  void updateNavigation(String nav, String subNav) {
    selectedNav.value = nav;
    selectedSubNav.value = subNav;

    if (!(nav == 'Leads' && subNav == 'List')) {
      showOrderDetails.value = false;
      selectedOrderItem.value = null;
    }


    if (!(nav == 'Projects' && subNav == 'List')) {
      showOrderDetails.value = false;
      selectedProjectItem.value = null;
    }

    switch (nav) {


      case 'Practice':
        lastScreen.value = CheckDemo();
        break;


      case 'Dashboard':
        lastScreen.value = HomeScreen(scaffoldKey: scaffoldKey);
        break;



      case 'Notifications':
        lastScreen.value = NotificationScreen(scaffoldKey: scaffoldKey);
        break;

      case 'Profile':
        lastScreen.value = BottomNavProfileScreen(scaffoldKey: scaffoldKey);
        break;

      case 'Calender':
        lastScreen.value = CalenderScreen(scaffoldKey: scaffoldKey);
        break;

      case 'Leads':
        switch (subNav) {
          case 'List':
            lastScreen.value = LeadListScreen(
              scaffoldKey: scaffoldKey,
              onOrderSelected: (Item item, bool isForEdit) {
                showOrderDetails.value = true;
                selectedOrderItem.value = item;

                if (isForEdit) {
                  lastScreen.value = LeadEditScreen(
                    orderItem: item,
                    scaffoldKey: scaffoldKey,
                  );
                } else {
                  lastScreen.value = LeadDetailsScreen(
                    orderItem: item,
                    scaffoldKey: scaffoldKey,
                  );
                }
                update();
              },
            );
            break;

          case 'Create':
            lastScreen.value = CustomerCreateScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Proformas':
            lastScreen.value = LeadProformaList(
                scaffoldKey: scaffoldKey); // No need for extra reset here
            break;

          case 'Trash':
            lastScreen.value = TrashLeadScreen(
                scaffoldKey: scaffoldKey); // No need for extra reset here
            break;

          case 'Setting':
            lastScreen.value = LeadSettingScreen(
                scaffoldKey: scaffoldKey); // No need for extra reset here
            break;

          default:
            lastScreen.value = LeadListScreen(
              scaffoldKey: scaffoldKey,
              onOrderSelected: (Item item, bool isForEdit) {
                showOrderDetails.value = true;
                selectedOrderItem.value = item;

                if (isForEdit) {
                  // Set to edit screen
                  lastScreen.value = LeadEditScreen(
                    orderItem: item,
                    scaffoldKey: scaffoldKey,
                  );
                } else {
                  // Set to details screen
                  lastScreen.value = LeadDetailsScreen(
                    orderItem: item,
                    scaffoldKey: scaffoldKey,
                  );
                  final leadDetailsViewModel = Get.put(LeadDetailsViewModel());
                  leadDetailsViewModel.fetchLeadDetails(
                      Get.context!, item.id ?? '');
                }
                update();
              },
            );
            break;
        }
        break;

      case 'Customer':
        switch (subNav) {
          case 'Create':
            lastScreen.value = CustomerCreateScreen(scaffoldKey: scaffoldKey,);
            break;

          case 'List':
            lastScreen.value = CustomersListScreen(
              scaffoldKey: scaffoldKey,
              onOrderSelected: (customerModel.Item customer) async {
                // print('Selected customer.id: ${customer.id}, type: ${customer.id.runtimeType}');
                showOrderDetails.value = true;
                selectedOrderItem.value = null;
                selectedCustomerItem.value = customer;
                final viewModel = Get.put(CustomerListDetailViewListModel());
                try {
                  lastScreen.value = CustomerDetailsScreen(
                    customerId: customer.id,
                    customerData: null,
                    scaffoldKey: scaffoldKey,
                  );
                  update();

                  final detailedCustomer = await viewModel.customerDetailViewList(Get.context!, customer.id);
                  if (detailedCustomer != null) {
                    selectedCustomerDetail.value = detailedCustomer;
                    lastScreen.value = CustomerDetailsScreen(
                      customerId: customer.id,
                      customerData: detailedCustomer,
                      scaffoldKey: scaffoldKey,
                    );
                  } else {
                    Get.snackbar('Error', 'Failed to load customer details',
                        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                    lastScreen.value = CustomersListScreen(scaffoldKey: scaffoldKey);
                  }
                } catch (e) {
                  Get.snackbar('Error', 'Failed to load customer details: $e',
                      snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                  lastScreen.value = CustomersListScreen(scaffoldKey: scaffoldKey);
                }
                update();
              },
            );
            break;

          case 'Proformas':
            lastScreen.value = CustomerProformaList(scaffoldKey: scaffoldKey);
            break;

          case 'Credential':
            lastScreen.value =
                CustomerCredentialScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Trash':
            lastScreen.value = CustomerTrashScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Setting':
            lastScreen.value = CustomerSettingScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Services Areas':
            lastScreen.value = CustomerServicesAreas(scaffoldKey: scaffoldKey);
            break;

          default:
            lastScreen.value = CustomersListScreen(scaffoldKey: scaffoldKey);
            break;
        }
        break;

      case 'Orders':
        switch (subNav) {
          case 'Create':
            lastScreen.value = OrderCreateScreen(scaffoldKey: scaffoldKey);
            break;

          case 'List':
            lastScreen.value = OrderListScreen(scaffoldKey: scaffoldKey);

            break;

          case 'Payments':
            lastScreen.value = OrderPaymentsScreen(scaffoldKey: scaffoldKey);

            break;
          case 'Activations':
            lastScreen.value = OrderActivationsScreen(scaffoldKey: scaffoldKey);
            break;
          case 'One Time Services':
            lastScreen.value = OrderOneTimeServices(scaffoldKey: scaffoldKey);
            break;
          case 'Recurring Services':
            lastScreen.value =
                OrdersRecurringServicesScreen(scaffoldKey: scaffoldKey);
            break;
          case 'Payments Reminder':
            lastScreen.value =
                OrdersPaymentReminderScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Orderless Services':
            lastScreen.value = OrderLessServiceScreen(scaffoldKey: scaffoldKey);
            break;
          case 'Settings':
            lastScreen.value = OrderSettingScreen(scaffoldKey: scaffoldKey);
            break;
          default:
            lastScreen.value = OrderListScreen(scaffoldKey: scaffoldKey);
            break;
        }
        break;

      case 'Sales':
        switch (subNav) {
          case 'Target':
            lastScreen.value = SalesTargetScreen(
              scaffoldKey: scaffoldKey,
              onOrderSelected: (salesModel.Item sales) {
                showOrderDetails.value = true;
                selectedOrderItem.value = null;
                selectedCustomerItem.value = null;
                selectedSalesItem.value = sales;
                lastScreen.value = Salesdetailsscreen(
                  salesItem: sales, // Correct parameter name
                  scaffoldKey: scaffoldKey, // Include if added to constructor
                );
                update();
              },
            );
            break;

          case 'Projection':
            lastScreen.value = SaleProjectionScreen(scaffoldKey: scaffoldKey);
            break;

          default:
            lastScreen.value = SalesTargetScreen(scaffoldKey: scaffoldKey);
            break;
        }






      case 'Tasks':
        switch (subNav) {
          case 'List':
            lastScreen.value = TaskListScreen(
              scaffoldKey: scaffoldKey,
              onOrderSelected: (taskModel.Item task) {
                showOrderDetails.value = true;
                selectedOrderItem.value = null;
                selectedCustomerItem.value = null;
                selectedTaskItem.value = task;
                lastScreen.value = TaskDetailsScreen(
                  taskItem: {
                    'id': task.id ?? '',
                    'subject': task.subject ?? 'No Subject',
                    'status': task.status?.name ?? 'N/A',
                    'endOn': task.updatedAt != null
                        ? formatDateToLongMonth2(task.updatedAt!)
                        : 'N/A',
                    'startOn': task.startDate != null
                        ? formatDateToLongMonth2(task.startDate!)
                        : 'N/A',
                    'taskType': task.taskType?.name ?? 'N/A',
                    'deadline': task.deadline != null
                        ? formatDateToLongMonth2(task.deadline!)
                        : 'N/A',
                    'priority': task.priority ?? 'N/A',
                    'assignedTo': task.assigned.isNotEmpty
                        ? '${task.assigned[0].assignedTo?.firstName ?? ''} ${task.assigned[0].assignedTo?.lastName ?? ''}'
                        : 'N/A',
                    'createdBy': task.createdBy != null
                        ? '${task.createdBy!.firstName ?? ''} ${task.createdBy!.lastName ?? ''}'
                        : 'N/A',
                    'projectId': task.project?.id ?? '',
                    'projectName': task.project?.projectName ?? 'N/A',
                  },
                );
                update();
              },
            );
            break;

          case 'Setting':
            lastScreen.value = TasksMasterScreen(scaffoldKey: scaffoldKey);
            break;

          default:
            lastScreen.value = SalesTargetScreen(scaffoldKey: scaffoldKey);
            break;
        }

      case 'Reports':
        switch (subNav) {
          case 'Lead Reports':
            lastScreen.value = ReportsLeadReportsScreen(
              scaffoldKey: scaffoldKey,
              // onOrderSelected: (projectModel.Item project) {
              //   showOrderDetails.value = true;
              //   selectedProjectItem.value = project;
              //   lastScreen.value = ProjectDetailsScreen(
              //     projectId: project.id ?? '', // Pass projectId
              //     scaffoldKey: scaffoldKey,
              //   );
              //   update();
              // },
            );
            break;

          case 'Customer Reports':
            lastScreen.value = HrmLeaveScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Task Reports':
            lastScreen.value = TaskReportScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Employee Reports':
            lastScreen.value = ReportEmployeeScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Product-Wise Sale':
            lastScreen.value =
                ReportProductsWiseSaleScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Recurring Service':
            lastScreen.value =
                ReportRecurringServicesScreen(scaffoldKey: scaffoldKey);
            break;

          default:
            lastScreen.value = SalesTargetScreen(scaffoldKey: scaffoldKey);
            break;
        }

// Analytics  Screen

      case 'Analytics':
        switch (subNav) {
          case 'Sale':
            lastScreen.value = SaleAnalyticsScreen(
              scaffoldKey: scaffoldKey,
              // onOrderSelected: (projectModel.Item project) {
              //   showOrderDetails.value = true;
              //   selectedProjectItem.value = project;
              //   lastScreen.value = ProjectDetailsScreen(
              //     projectId: project.id ?? '', // Pass projectId
              //     scaffoldKey: scaffoldKey,
              //   );
              //   update();
              // },
            );
            break;

          case 'Lead':
            lastScreen.value = ProjectMasterScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Customer':
            lastScreen.value = ProjectMasterScreen(scaffoldKey: scaffoldKey);
            break;

          case 'PH Performance':
            lastScreen.value = ProjectMasterScreen(scaffoldKey: scaffoldKey);
            break;

          default:
            lastScreen.value = SalesTargetScreen(scaffoldKey: scaffoldKey);
            break;
        }

      case 'Products':
        switch (subNav) {
          case 'Products':
            lastScreen.value = ProductsListScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Brands':
            lastScreen.value = ProductBrandScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Services':
            lastScreen.value = ProductsServicesScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Categories':
            lastScreen.value = CategoryListScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Activations Forms':
            lastScreen.value = ProductsActivationsForms(
              scaffoldKey: scaffoldKey,
              onOrderSelected:
                  (productsActivations.ProductsActivationsFormsResModel
              activationsForms) {
                showOrderDetails.value = true;
                selectedOrderItem.value = null; // Clear lead selection
                selectedCustomerItem.value = null; // Clear customer selection
                selectedProductsActivationsItem.value =
                    activationsForms; // Store the selected activation form
                lastScreen.value = ProductsActivationsFormsDetails(
                  ActivationsId:
                  activationsForms.id ?? '', // Ensure id is not null
                  ActivationsData: activationsForms,
                  scaffoldKey: scaffoldKey,
                );
                update();
              },
            );
            break;

          case 'Gst Setting':
            lastScreen.value = ProductGstListScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Settings':
            lastScreen.value =
                ProductMasterListScreen(scaffoldKey: scaffoldKey);
            break;
        }

        break;

      case 'Projects':
        switch (subNav) {
          case 'List':
            lastScreen.value = ProjectListScreen(
              scaffoldKey: scaffoldKey,
              onOrderSelected: (projectModel.Item project) {
                showOrderDetails.value = true;
                selectedProjectItem.value = project;
                lastScreen.value = ProjectDetailsScreen(
                  projectId: project.id ?? '', // Pass projectId
                  scaffoldKey: scaffoldKey,
                );
                update();
              },
            );
            break;
          case 'Setting':
            lastScreen.value = ProjectMasterScreen(scaffoldKey: scaffoldKey);
            break;

          default:
            lastScreen.value = SalesTargetScreen(scaffoldKey: scaffoldKey);
            break;
        }

      case 'Users':
        switch (subNav) {
          case 'List':
            lastScreen.value = UsersScreen(
              scaffoldKey: scaffoldKey,
              // onOrderSelected: (projectModel.Item project) {
              //   showOrderDetails.value = true;
              //   selectedProjectItem.value = project;
              //   lastScreen.value = ProjectDetailsScreen(
              //     projectId: project.id ?? '', // Pass projectId
              //     scaffoldKey: scaffoldKey,
              //   );
              //   update();
              // },
            );
            break;

          case 'Role':
            lastScreen.value = RolesScreen(
              scaffoldKey: scaffoldKey,
            );

            break;

          case 'Department':
            lastScreen.value = UsersDepartmentsScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Activities':
            lastScreen.value = UserActivityScreen(
              scaffoldKey: scaffoldKey,
              onOrderSelected: (userActivities.Items activity) {
                // Changed to Items
                showOrderDetails.value = true;
                selectedOrderItem.value = null;
                selectedCustomerItem.value = null;
                selectedActivityItem.value = activity;
                lastScreen.value = MapScreen(
                  latitude: double.tryParse(activity.lat ?? '0.0') ?? 0.0,
                  longitude: double.tryParse(activity.lng ?? '0.0') ?? 0.0,
                  username:
                  '${activity.user?.firstName ?? ''} ${activity.user?.lastName ?? ''}',
                );
                update();
              },
            );
            break;

          default:
            lastScreen.value = SalesTargetScreen(scaffoldKey: scaffoldKey);
            break;
        }

      case 'Inventory':
        switch (subNav) {
          case 'Stock':
            lastScreen.value = InventoryStockListScreen(
              scaffoldKey: scaffoldKey,
              // onOrderSelected: (projectModel.Item project) {
              //   showOrderDetails.value = true;
              //   selectedProjectItem.value = project;
              //   lastScreen.value = ProjectDetailsScreen(
              //     projectId: project.id ?? '', // Pass projectId
              //     scaffoldKey: scaffoldKey,
              //   );
              //   update();
              // },
            );
            break;
          case 'Request':
            lastScreen.value =
                InventoryRequestListScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Transactions':
            lastScreen.value =
                InventoryTransactionsListScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Vendors':
            lastScreen.value =
                InventoryVendorsListScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Refil Stock':
            lastScreen.value =
                InventoryRifilStockListScreen(scaffoldKey: scaffoldKey);
            break;

          default:
            lastScreen.value = SalesTargetScreen(scaffoldKey: scaffoldKey);
            break;
        }

      case 'HRM':
        switch (subNav) {
          case 'Attendance':
            lastScreen.value = HrmAttendanceScreen(
              scaffoldKey: scaffoldKey,
              // onOrderSelected: (projectModel.Item project) {
              //   showOrderDetails.value = true;
              //   selectedProjectItem.value = project;
              //   lastScreen.value = ProjectDetailsScreen(
              //     projectId: project.id ?? '', // Pass projectId
              //     scaffoldKey: scaffoldKey,
              //   );
              //   update();
              // },
            );
            break;
          case 'Leave':
            lastScreen.value = HrmLeaveScreen(scaffoldKey: scaffoldKey);
            break;

          default:
            lastScreen.value = SalesTargetScreen(scaffoldKey: scaffoldKey);
            break;
        }

      case 'Settings':
        switch (subNav) {
          case 'Dashboard':
            lastScreen.value = SettingDashboardScreen(
              scaffoldKey: scaffoldKey,
              // onOrderSelected: (projectModel.Item project) {
              //   showOrderDetails.value = true;
              //   selectedProjectItem.value = project;
              //   lastScreen.value = ProjectDetailsScreen(
              //     projectId: project.id ?? '', // Pass projectId
              //     scaffoldKey: scaffoldKey,
              //   );
              //   update();
              // },
            );
            break;

          case 'Division':
            lastScreen.value = MasterDivisionScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Proposal':
            lastScreen.value = MasterProposalScreen(scaffoldKey: scaffoldKey);
            break;

          case 'Cities':
            lastScreen.value = SettingCitiesScreen(scaffoldKey: scaffoldKey);
            break;

          default:
            lastScreen.value = SalesTargetScreen(scaffoldKey: scaffoldKey);
            break;
        }

      default:
        lastScreen.value = HomeScreen(scaffoldKey: scaffoldKey);
        break;
    }
    update(); // Ensure UI reflects the change
  }

  void resetOrderDetails() {
    showOrderDetails.value = false;
    selectedOrderItem.value = null;
    selectedCustomerItem.value = null; // Clear selected customer
    selectedCustomerDetail.value = null; // Clear detailed customer data

    if (selectedNav.value == 'Customer' && selectedSubNav.value == 'List' && selectedCustomerItem.value != null) {
      showOrderDetails.value = true;
      lastScreen.value = CustomerDetailsScreen(
        customerId: selectedCustomerItem.value!.id ?? '',
        customerData: selectedCustomerDetail.value, // Use cached detailed data
        scaffoldKey: scaffoldKey,
      );
    } else if (selectedNav.value == 'Customer' && selectedSubNav.value == 'List') {
      lastScreen.value = CustomersListScreen(
        scaffoldKey: scaffoldKey,
        onOrderSelected: (customerModel.Item customer) async {
          // print('Selected customer.id: ${customer.id}, type: ${customer.id.runtimeType}');
          showOrderDetails.value = true;
          selectedOrderItem.value = null;
          selectedCustomerItem.value = customer;
          final viewModel = Get.put(CustomerListDetailViewListModel());
          try {
            lastScreen.value = CustomerDetailsScreen(
              customerId: customer.id,
              customerData: selectedCustomerDetail.value, // Use cached data if available
              scaffoldKey: scaffoldKey,
            );
            update();

            if (selectedCustomerDetail.value == null || selectedCustomerDetail.value!.id != customer.id) {
              final detailedCustomer = await viewModel.customerDetailViewList(Get.context!, customer.id);
              if (detailedCustomer != null) {
                selectedCustomerDetail.value = detailedCustomer; // Cache the detailed data
                lastScreen.value = CustomerDetailsScreen(
                  customerId: customer.id,
                  customerData: detailedCustomer,
                  scaffoldKey: scaffoldKey,
                );
              } else {

                lastScreen.value = CustomersListScreen(scaffoldKey: scaffoldKey);
              }
            }
          } catch (e) {
            Get.snackbar('Error', 'Failed to load customer details: $e',
                snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
            lastScreen.value = CustomersListScreen(scaffoldKey: scaffoldKey);
          }
          update();
        },
      );
    }else {
      // Handle other cases (Leads, Sales, Projects, etc.)
      if (selectedNav.value == 'Leads' && selectedSubNav.value == 'List') {
        lastScreen.value = LeadListScreen(
          scaffoldKey: scaffoldKey,
          onOrderSelected: (Item item, bool isForEdit) {
            showOrderDetails.value = true;
            selectedOrderItem.value = item;
            if (isForEdit) {
              lastScreen.value = LeadEditScreen(
                orderItem: item,
                scaffoldKey: scaffoldKey,
              );
            } else {
              lastScreen.value = LeadDetailsScreen(
                orderItem: item,
                scaffoldKey: scaffoldKey,
              );
            }
            update();
          },
        );
      } else if (selectedNav.value == 'Sales' && selectedSubNav.value == 'Target') {
        lastScreen.value = SalesTargetScreen(
          scaffoldKey: scaffoldKey,
          onOrderSelected: (salesModel.Item sales) {
            showOrderDetails.value = true;
            selectedOrderItem.value = null;
            selectedCustomerItem.value = null;
            selectedSalesItem.value = sales;
            lastScreen.value = Salesdetailsscreen(
              salesItem: sales,
              scaffoldKey: scaffoldKey,
            );
            update();
          },
        );
      } else if (selectedNav.value == 'Products' && selectedSubNav.value == 'Activations Forms') {
        lastScreen.value = ProductsActivationsForms(
          scaffoldKey: scaffoldKey,
          onOrderSelected: (productsActivations.ProductsActivationsFormsResModel activationsForms) {
            showOrderDetails.value = true;
            selectedOrderItem.value = null;
            selectedCustomerItem.value = null;
            selectedProductsActivationsItem.value = activationsForms;
            lastScreen.value = ProductsActivationsFormsDetails(
              ActivationsId: activationsForms.id ?? '',
              ActivationsData: activationsForms,
              scaffoldKey: scaffoldKey,
            );
            update();
          },
        );
      } else if (selectedNav.value == 'Projects' && selectedSubNav.value == 'List') {
        lastScreen.value = ProjectListScreen(
          scaffoldKey: scaffoldKey,
          onOrderSelected: (projectModel.Item project) {
            showOrderDetails.value = true;
            selectedProjectItem.value = project;
            lastScreen.value = ProjectDetailsScreen(
              projectId: project.id ?? '',
              scaffoldKey: scaffoldKey,
            );
            update();
          },
        );
      } else if (selectedNav.value == 'Users' && selectedSubNav.value == 'Activities') {
        lastScreen.value = UserActivityScreen(
          scaffoldKey: scaffoldKey,
          onOrderSelected: (userActivities.Items activity) {
            showOrderDetails.value = true;
            selectedActivityItem.value = activity;
            lastScreen.value = MapScreen(
              latitude: double.tryParse(activity.lat ?? '0.0') ?? 0.0,
              longitude: double.tryParse(activity.lng ?? '0.0') ?? 0.0,
              username: '${activity.user?.firstName ?? ''} ${activity.user?.lastName ?? ''}',
            );
            update();
          },
        );
      } else if (selectedNav.value == 'Tasks' && selectedSubNav.value == 'List') {
        lastScreen.value = TaskListScreen(
          scaffoldKey: scaffoldKey,
          onOrderSelected: (taskModel.Item task) {
            showOrderDetails.value = true;
            selectedOrderItem.value = null;
            selectedCustomerItem.value = null;
            selectedTaskItem.value = task;
            lastScreen.value = TaskDetailsScreen(
              taskItem: {
                'id': task.id ?? '',
                'subject': task.subject ?? 'No Subject',
                'status': task.status?.name ?? 'N/A',
                'endOn': task.updatedAt != null
                    ? formatDateToLongMonth2(task.updatedAt!)
                    : 'N/A',
                'startOn': task.startDate != null
                    ? formatDateToLongMonth2(task.startDate!)
                    : 'N/A',
                'taskType': task.taskType?.name ?? 'N/A',
                'deadline': task.deadline != null
                    ? formatDateToLongMonth2(task.deadline!)
                    : 'N/A',
                'priority': task.priority ?? 'N/A',
                'assignedTo': task.assigned.isNotEmpty
                    ? '${task.assigned[0].assignedTo?.firstName ?? ''} ${task.assigned[0].assignedTo?.lastName ?? ''}'
                    : 'N/A',
                'createdBy': task.createdBy != null
                    ? '${task.createdBy!.firstName ?? ''} ${task.createdBy!.lastName ?? ''}'
                    : 'N/A',
                'projectId': task.project?.id ?? '',
                'projectName': task.project?.projectName ?? 'N/A',
              },
            );
            update();
          },
        );
      } else {
        lastScreen.value =  HomeScreen(scaffoldKey: scaffoldKey);
      }
    }

    update();
  }

  void toggleCollapse(bool collapsed) {
    isLocalCollapsed.value = collapsed;
    update();
  }
}

class HomeManagerScreen extends GetView<HomeManagerController> {
  const HomeManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeManagerController());
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: AllColors.backgroundGreyWhite,
      drawer: isMobile ? controller.buildDrawer() : null,
      body: Row(
        children: [
          if (!isMobile)
            Obx(() => Container(
              width: controller.isLocalCollapsed.value ? 97 : 250,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: DarkMode.backgroundColor(context),
                border: Border(
                  right: BorderSide(color: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Colors.grey[800]!
                      : Colors.grey[200]!),
                ),
              ),
              child:
              CustomDrawerManager(
                onNavigation: (nav, subNav) {
                  controller.updateNavigation(nav, subNav);
                },
                isLocalCollapsed: controller.isLocalCollapsed.value,
                onCollapseToggle: controller.toggleCollapse, scaffoldKey: controller.scaffoldKey, // Pass scaffoldKey,
              ),
            )),
          Expanded(
            child: Obx(() => controller.lastScreen.value),
          ),
        ],
      ),
    );
  }
}
