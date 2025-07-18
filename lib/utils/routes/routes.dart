import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/Utils/Routes/routes_name.dart';
import 'package:websuites/views/customerScreens/create/CustomerCreateScreen.dart';
import 'package:websuites/views/customerScreens/proformas/CustomerProformasScreen.dart';
import 'package:websuites/views/dummy_screen/SalesTargetScreen.dart';
import 'package:websuites/views/homeScreen/home_manager/HomeManagerScreen.dart';
import 'package:websuites/views/homeScreen/home_manager/dumy/practicescreen.dart';
import 'package:websuites/views/orderScreen/create/OrderCreateScreen.dart';
import 'package:websuites/views/orderScreen/orderListScreen/orderList_screen.dart';
import 'package:websuites/views/products/brands/ProductBrandScreen.dart';
import 'package:websuites/views/products/productlist/ProductsScreen.dart';
import 'package:websuites/views/project/ProjectListScreen.dart';
import 'package:websuites/views/usersScreen/activity/UserActivityScreen.dart';
import '../../PraticeScreen.dart';

import '../../views/HRM/hrm/HrmAttendanceSceen.dart';
import '../../views/HRM/leave/HrmLeaveScreen.dart';
import '../../views/Master/Division.dart';
import '../../views/Master/ProposalScreen.dart';
import '../../views/Master/cities/SettingCitiesScreen.dart';
import '../../views/Master/dashboard/SettingDashboardScreen.dart';

import '../../views/analytics/customer/CustomerAnalyticsScreen.dart';
import '../../views/analytics/lead/LeadAnalyticsScreen.dart';
import '../../views/analytics/ph/PHAnalyticsScreen.dart';
import '../../views/analytics/sale/SaleAnalyticsScreen.dart';
import '../../views/bottomNavBarScreen/bottom_navBar_screen.dart';
import '../../views/bottomNavBarScreen/profile_Screen/bottom__nav_profile_screen.dart';
import '../../views/customerScreens/Setting/CustomerSettingScreen.dart';
import '../../views/customerScreens/activationListScreen/activation_list_screen.dart';
import '../../views/customerScreens/activitiesScreen/activities_screen.dart';
import '../../views/customerScreens/companiesScreen/all_companies_screen.dart';
import '../../views/customerScreens/credential/CustomerCredentialScreen.dart';
import '../../views/customerScreens/customerList/CustomerListScreen.dart';
import '../../views/customerScreens/customerPaymentReminder/payment_reminder.dart';
import '../../views/customerScreens/customerServices/services_screen.dart';
import '../../views/customerScreens/myTeam/my_team_screen.dart';
import '../../views/customerScreens/orderProducts/order_products_screen.dart';
import '../../views/customerScreens/search_sevices_areas/CustomerServicesAreas.dart';
import '../../views/forgotPasswordScreen/forgot_password_screen.dart';
import '../../views/homeScreen/home_screen.dart';
import '../../views/inventory/request/InventoryRequestListScreen.dart';
import '../../views/inventory/rifilstock/InventoryRifilStockListScreen.dart';
import '../../views/inventory/rifilstock/InventoryRifilStockListScreen.dart';
import '../../views/inventory/rifilstock/InventoryRifilStockListScreen.dart';
import '../../views/inventory/stock/InventoryStockListScreen.dart';
import '../../views/inventory/transactions/InventoryTransactionsListScreen.dart';
import '../../views/inventory/vendors/InventoryVendorsListScreen.dart';
import '../../views/leadScreens/createNewLead/new_create_newLead_screen.dart';
import '../../views/leadScreens/leadActivities/leadActivities/lead_activities_screen.dart';
import '../../views/leadScreens/leadActivities/lead_activities_screen.dart';
import '../../views/leadScreens/leadList/lead_deatils/actionUpdate/LeadActionUpdateCreate.dart';
import '../../views/leadScreens/leadList/leadlist_screen.dart';
import '../../views/leadScreens/leadMaster/lead_master_screen.dart';
import '../../views/leadScreens/proformas/LeadProformasScreen.dart';
import '../../views/leadScreens/searchGoogleLeads/search_google_leads.dart';
import '../../views/leadScreens/teamLead/team_lead_screen.dart';
import '../../views/leadScreens/trashLead/trash_lead_screen.dart';
import '../../views/loginScreen/login_screen.dart';
import '../../views/notification/NotificationScreen.dart';
import '../../views/orderScreen/orderActivityScreen/order_activity_screen.dart';
import '../../views/orderScreen/orderPaymentsScreen/order_payments_screen.dart';

import '../../views/otpScreen/otp_screen.dart';

import '../../views/products/category/CategoryListScreen.dart';
import '../../views/products/gst/ProductGstListScreen.dart';
import '../../views/products/master/ProductMasterListScreen.dart';
import '../../views/purchase_now_screen/purchase_now_screen.dart';
import '../../views/reports/leadReports/ReportsLeadReportsScreen.dart';
import '../../views/rolesScreen/roles_screen.dart';
import '../../views/salesTargetScreen/projection/SaleProjectionScreen.dart';
import '../../views/salesTargetScreen/sales_target_screen.dart';
import '../../views/splashScreen/splash_screen.dart';
import '../../views/upcomingScreen/upcoming_screen.dart';
import '../../views/usersScreen/departments/usersDepartmentsScreen.dart';
import '../../views/usersScreen/userlist/users_screen.dart';
import '../../views/welcomeToCompanyScreen/welcome_to_company_screen.dart';

class AllRoutes {
  static appRoutes() => [
        GetPage(
          name: RoutesName.splash_screen,
          page: () => const SplashScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RoutesName.login_screen,
          page: () => const LoginScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        // GetPage(
        //   name: RoutesName.createLead,
        //   page: () => CreateNewLeadScreen(),
        //   transitionDuration : const Duration(milliseconds: 450),
        //   transition :Transition.leftToRightWithFade,
        // ),
        GetPage(
          name: RoutesName.project_list_screen,
          page: () =>
              ProjectListScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
        ),

        GetPage(
          name: RoutesName.sales_target_screens,
          page: () =>
              SalesTargetScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
        ),

        GetPage(
          name: RoutesName.sales_projections_screens,
          page: () =>
              SaleProjectionScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
        ),

        //WELCOME COMPANY SCREEN
        GetPage(
          name: RoutesName.welcome_company_screen,
          page: () => const WelcomeToCompany(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        //OTP SCREEN
        GetPage(
          name: RoutesName.otp_screen,
          page: () => const OtpScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        //FORGOT PASSWORD SCREEN
        GetPage(
          name: RoutesName.forgot_password_screen,
          page: () => const ForgotPasswordScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        //PURCHASE NOW SCREEN
        GetPage(
          name: RoutesName.purchase_now_screen,
          page: () => const PurchaseNowScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        //     GetPage(
        //   name: RoutesName.home_screen,
        //   page: () => HomeScreen(),
        //   transitionDuration : Duration(milliseconds: 450),
        //   // transition :Transition.leftToRightWithFade,
        // ),

        GetPage(
          name: RoutesName.practice_screen,
          page: () =>  PracticeScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RoutesName.home_screen,
          page: () => HomeScreen(
              scaffoldKey: GlobalKey<
                  ScaffoldState>()), // Create a new GlobalKey instance
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RoutesName.home_manager,
          page: () => HomeManagerScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.login_screen,
          page: () => const LoginScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.bottomNavBar_screen,
          page: () =>  BottomNavBarScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        //======================================================================
        // Lead Screen

        // GetPage(
        //   name: RoutesName.lead_list_screen,
        //   page: () => LeadListScreen(),
        //   transitionDuration: Duration(milliseconds: 450),
        //   // transition :Transition.leftToRightWithFade,
        // ),

        GetPage(
          name: RoutesName.upcoming_screen,
          page: () => const UpcomingScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.createNewLead_screen,
          page: () =>
              CustomerCreateNewLeadScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        // GetPage(
        //   name: RoutesName.createNewLead_screen,
        //   page: () => LeadProformasScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
        //   transitionDuration: Duration(milliseconds: 450),
        //   // transition :Transition.leftToRightWithFade,
        // ),

        GetPage(
          name: RoutesName.leadProformas_Screen,
          page: () => LeadProformaList(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.search_google_leads_screen,
          page: () => const SearchGoogleLeads(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.LeadActivities_screen,
          page: () =>
              ReportsLeadReportsScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.my_teamLead_screen,
          page: () => const TeamLeadScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.trashLead_screen,
          page: () => TrashLeadScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.leadMaster_screen,
          page: () => const LeadMasterScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        //======================================================================
        // Customer Screen

        GetPage(
          name: RoutesName.customer_list_screen,
          page: () =>
              CustomersListScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customerProformas_Screen,
          page: () =>
              CustomerProformaList(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customerCredential_Screen,
          page: () =>
              CustomerCredentialScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customer_services_areas_screen,
          page: () =>
              CustomerServicesAreas(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customerSetting_Screen,
          page: () =>
              CustomerSettingScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customerTrash_Screen,
          page: () =>
              CustomerSettingScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customer_activities_screen,
          page: () => const CustomersActivitiesScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customer_companies_screen,
          page: () => const CustomerCompaniesScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customer_services_screen,
          page: () => const CustomerServicesScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customer_orderProducts_screen,
          page: () => const CustomerOrderProductsScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customer_payment_reminder,
          page: () => const CustomerPaymentReminders(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customer_myTeam_screen,
          page: () => const CustomerMyTeamScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customer_activation_list,
          page: () => const CustomerActivationListScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        //======================================================================
        // Order Screens

        GetPage(
          name: RoutesName.order_create_screen,
          page: () =>
              OrderCreateScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RoutesName.order_list_screen,
          page: () => OrderListScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.order_activity_screen,
          page: () => const OrderActivityScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        // GetPage(
        //   name: RoutesName.order_proformaList_screen,
        //   page: () => OrderProformaList(),
        //   transitionDuration: Duration(milliseconds: 450),
        //   // transition :Transition.leftToRightWithFade,
        // ),

        GetPage(
          name: RoutesName.order_payments_screen,
          page: () =>
              OrderPaymentsScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        //======================================================================
        //SALES TARGET
        //
        // GetPage(
        //   name: RoutesName.sales_target_screen,
        //   page: () => SalesTargetScreen(),
        //   transitionDuration: Duration(milliseconds: 450),
        //   // transition :Transition.leftToRightWithFade,
        // ),

        //======================================================================
        //ROLES SCREEN

        GetPage(
          name: RoutesName.roles_screen,
          page: () => RolesScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        //======================================================================
        //PRODUCT SCREEN
        GetPage(
          name: RoutesName.products_list_screen,
          page: () =>
              ProductsListScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
        ),

        GetPage(
          name: RoutesName.products_category_screen,
          page: () =>
              CategoryListScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
        ),
        GetPage(
          name: RoutesName.products_brand_screen,
          page: () =>
              ProductBrandScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        //======================================================================
        //Analytics Screen

        GetPage(
          name: RoutesName.sale_analytics,
          page: () =>
              SaleAnalyticsScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.lead_analytics,
          page: () => const LeadAnalyticsScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.customer_analytics,
          page: () => const CustomerAnalyticsScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.ph_analytics,
          page: () => const PHAnalyticsScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        //======================================================================
        //USERS

        GetPage(
          name: RoutesName.products_gst_screen,
          page: () =>
              ProductGstListScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.products_master_screen,
          page: () =>
              ProductMasterListScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        /////////      INVENTORY

        GetPage(
          name: RoutesName.stock_list_screen,
          page: () =>
              InventoryStockListScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RoutesName.request_list_screen,
          page: () => InventoryRequestListScreen(
              scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RoutesName.transactions_list_screen,
          page: () => InventoryTransactionsListScreen(
              scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RoutesName.vendors_list_screen,
          page: () => InventoryVendorsListScreen(
              scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RoutesName.rifil_stock_screen,
          page: () => InventoryRifilStockListScreen(
              scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.users_screen,
          page: () => UsersScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.master_dashboard,
          page: () =>
              SettingDashboardScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.users_activity,
          page: () =>
              UserActivityScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.users_departments,
          page: () =>
              UsersDepartmentsScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RoutesName.master_division,
          page: () =>
              MasterDivisionScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.master_proposal,
          page: () =>
              MasterProposalScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.master_cities,
          page: () =>
              SettingCitiesScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.hrm_attendance,
          page: () =>
              HrmAttendanceScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RoutesName.hrm_leave,
          page: () => HrmLeaveScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
          transitionDuration: const Duration(milliseconds: 450),
          // transition :Transition.leftToRightWithFade,
        ),

    GetPage(
      name: RoutesName.notification_screen,
      page: () => NotificationScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
      transitionDuration: const Duration(milliseconds: 450),
      // transition :Transition.leftToRightWithFade,
    ),

    GetPage(
      name: RoutesName.profile_screen,
      page: () => BottomNavProfileScreen(scaffoldKey: GlobalKey<ScaffoldState>()),
      transitionDuration: const Duration(milliseconds: 450),
      // transition :Transition.leftToRightWithFade,
    ),

    // GetPage(
    //   name: RoutesName.pin_code,
    //   page: () => PaginationDemo(),
    //   transitionDuration: const Duration(milliseconds: 450),
    //   // transition :Transition.leftToRightWithFade,
    // ),
      ];
}
