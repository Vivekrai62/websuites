import 'package:get/get.dart';
import 'package:websuites/Utils/Routes/routes_name.dart';
import 'package:websuites/data/models/responseModels/order/list/detail/order_detail_response_model.dart';

import 'package:websuites/views/bottomNavBarScreen/bottom_navBar_screen.dart';
import 'package:websuites/views/customerScreens/activitiesScreen/activities_screen.dart';
import 'package:websuites/views/customerScreens/companiesScreen/all_companies_screen.dart';
import 'package:websuites/views/customerScreens/customerPaymentReminder/payment_reminder.dart';
import 'package:websuites/views/leadScreens/Setting/SettingScreen.dart';
import 'package:websuites/views/leadScreens/leadList/leadlist_screen.dart';
import 'package:websuites/views/orderScreen/orderActivityScreen/order_activity_screen.dart';
import 'package:websuites/views/orderScreen/orderListScreen/orderList_screen.dart';
import 'package:websuites/views/orderScreen/orderPaymentsScreen/order_payments_screen.dart';
import 'package:websuites/views/orderScreen/orderProformaScreen/proforma_list_screen.dart';
import 'package:websuites/views/orderScreen/orderProjection/OrdeProjectionsScreen.dart';
import 'package:websuites/views/products/category/CategoryListScreen.dart';
import 'package:websuites/views/products/productlist/ProductsScreen.dart';
import 'package:websuites/views/project/ProjectListScreen.dart';
import 'package:websuites/views/reports/taskreport/TaskReport.dart';

import 'package:websuites/views/rolesScreen/roles_screen.dart';
import 'package:websuites/views/salesTargetScreen/sales_target_screen.dart';
import 'package:websuites/views/splashScreen/splash_screen.dart';
import 'package:websuites/views/task/master/MasterScreen.dart';

import '../../views/analytics/customer/CustomerAnalyticsScreen.dart';
import '../../views/analytics/lead/LeadAnalyticsScreen.dart';
import '../../views/analytics/ph/PHAnalyticsScreen.dart';
import '../../views/analytics/sale/SaleAnalyticsScreen.dart';
import '../../views/customerScreens/customerList/list_screen.dart';
import '../../views/customerScreens/customerServices/services_screen.dart';
import '../../views/forgotPasswordScreen/forgot_password_screen.dart';
import '../../views/homeScreen/home_screen.dart';
import '../../views/leadScreens/createNewLead/create_newLead_screen.dart';
import '../../views/leadScreens/leadActivities/lead_activities_screen.dart';
import '../../views/leadScreens/leadMaster/lead_master_screen.dart';
import '../../views/leadScreens/searchGoogleLeads/search_google_leads.dart';
import '../../views/leadScreens/teamLead/team_lead_screen.dart';
import '../../views/leadScreens/trashLead/trash_lead_screen.dart';
import '../../views/loginScreen/login_screen.dart';
import '../../views/orderScreen/ordermaster/OrderMasterListScreen.dart';
import '../../views/otpScreen/otp_screen.dart';

import '../../views/task/tasklist/TaskList.dart';

import '../../views/welcomeToCompanyScreen/welcome_to_company_screen.dart';

class AllRoutes {
  static List<GetPage> appRoutes() => [
    GetPage(name: RoutesName.splash_screen, page: () => const SplashScreen()),
    GetPage(name: RoutesName.welcome_company_screen, page: () => const WelcomeToCompany()),
    GetPage(name: RoutesName.otp_screen, page: () => const OtpScreen()),
    GetPage(name: RoutesName.forgot_password_screen, page: () => const ForgotPasswordScreen()),
    GetPage(name: RoutesName.login_screen, page: () => const LoginScreen()),
    GetPage(name: RoutesName.bottomNavBar_screen, page: () => const BottomNavBarScreen()),
    GetPage(name: RoutesName.home_screen, page: () => const HomeScreen()),
    GetPage(name: RoutesName.createNewLead_screen, page: () => const CreateNewLeadScreen()), // Unique route for CreateNewLeadScreen
    GetPage(name: RoutesName.createNewLead_screen, page: () => const SearchGoogleLeads()), // Unique route for CreateNewLeadScreen
    GetPage(name: RoutesName.lead_list_screen, page: () => const LeadListScreen()), // This should be unique as well
    GetPage(name: RoutesName.trashLead_screen, page: () => TrashLeadScreen()),
    GetPage(name: RoutesName.upcoming_screen, page: () => const LeadActivitiesScreen()),
    GetPage(name: RoutesName.search_google_leads_screen, page: () => TrashLeadScreen()),
    GetPage(name: RoutesName.search_google_leads_screen, page: () => const SettingScreen()),
    GetPage(name: RoutesName.search_google_leads_screen, page: () => LeadMasterScreen()),
    // Uncomment if you want to use this route
    // GetPage(name: RoutesName.lead_activities_screen, page: () => const LeadActivitiesScreen()),

    GetPage(name: RoutesName.my_teamLead_screen, page: () => const TeamLeadScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () => const  CustomersListScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () =>  CustomersActivitiesScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () => const  CustomerPaymentReminders()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () => const  CustomerCompaniesScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () => const  CustomerServicesScreen()),

    GetPage(name: RoutesName.my_teamLead_screen, page: () =>   OrderListScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () =>  OrderActivityScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () =>  OrderProformaList()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () =>  OrderPaymentsScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () =>  OrderProjectionScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () => OrderMasterListScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () => SalesTargetScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () => RolesScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () => TaskReportScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () => TaskListScreen()),
    GetPage(name: RoutesName.task_master_screen , page: () => TaskMasterScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () => ProjectListScreen()),
    GetPage(name: RoutesName.my_teamLead_screen, page: () =>ProductsListScreen()),

    GetPage(name: RoutesName.sale_analytics, page: () =>SaleAnalyticsScreen()),

    GetPage(name: RoutesName.lead_analytics, page: () =>LeadAnalyticsScreen()),

    GetPage(name: RoutesName.customer_analytics, page: () =>CustomerAnalyticsScreen()),

    GetPage(name: RoutesName.ph_analytics, page: () =>PHAnalyticsScreen())










  ];
}