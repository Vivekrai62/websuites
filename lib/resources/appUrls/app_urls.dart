import 'package:pinput/pinput.dart';

class AppUrls {
  // Base URL for the development environment

  // Demo
  static const String baseurl = 'https://dev.whsuites.com';

   // Live

  // static const String baseurl = 'https://webhopers.whsuites.com';

  // =============================================================================
  // AUTHENTICATION APIs
  // API for user login
  static const String loginApi = '$baseurl/api/auth/signin';


  // API for forgot password functionality
  static const String forgotApi = '$baseurl/api/auth/forgot-password';

  // =============================================================================
  // HOME SCREEN APIs
  // Global settings for the application
  static const String globalSetting = '$baseurl/api/public/global-settings';



  // Notification List
  static const String notification = '$baseurl/api/notifications?limit=20&page=1';

  //  Notification Delete
  static  String notificationDelete (String notificationId) => '$baseurl/api/notifications/$notificationId/archive';


  // Update global settings
  static const String globalUpdateSetting = '$baseurl/api/activities';

  // Daily sales analytics
  static const String dailyAnalyticsList = '$baseurl/api/analytics/sales/daily';

  // Dashboard counts and statistics
  static const String getDashboardCountApi = '$baseurl/api/dashboard/dashboard-count';

  // Dashboard lead type counts
  static const String dashboardLeadType = '$baseurl/api/dashboard/leads-by-type-count';

  // Dashboard lead cards
  static const String dashboardLeadCard = '$baseurl/api/dashboard/lead-cards';

  // Dashboard lead reminders chart
  static const String dashboardLeadReminder = '$baseurl/api/dashboard/lead-reminders-chart';

  // Dashboard customer status chart
  static const String dashboardCustomerStatus = '$baseurl/api/dashboard/customer-status-chart';

  // Dashboard project statistics chart
  static const String dashboardProjectStatus = '$baseurl/api/dashboard/project-statistics-chart';

  // Dashboard payment reminders chart
  static const String dashboardPaymentReminder = '$baseurl/api/dashboard/payments-reminders-chart';

  // Dashboard project reminders chart
  static const String dashboardProjectReminder = '$baseurl/api/dashboard/projects-reminders-chart';

  // Dashboard sales chart
  static const String dashboardSalesChart = '$baseurl/api/dashboard/sales-chart';

  // Dashboard transactions chart
  static const String dashboardSalesTransaction = '$baseurl/api/dashboard/transactions-chart';

  // Dashboard task performance
  static const String dashboardTaskPerformance = '$baseurl/api/tasks/get-user-effectivetime';

  // Dashboard task status chart
  static const String dbTaskStatus = '$baseurl/api/dashboard/task-statistics-chart';

  // Dashboard customer reminders (corrected to avoid duplication)
  static const String dashboardCustomerReminder = '$baseurl/api/dashboard/customer-reminders-chart';

  // Dashboard lead source counts
  static const String dashboardLeadSource = '$baseurl/api/dashboard/leads-by-source-count';

  // Dashboard API with specific UUID
  static const String dashboard = '$baseurl/api/auth/b6b85996-dd46-4bad-99e9-52a54069ab81';

  // User list API
  static const String userListApi = '$baseurl/api/auth/user-list';

  // Update user department
  static const String userDepartmentUpdate = '$baseurl/api/departments';

  // Leads by type count (corrected to avoid duplication)
  static const String dashLeadsByTypeCount = '$baseurl/api/dashboard/leads-by-type-count';

  // Leads by source count (corrected to avoid duplication)
  static const String dashLeadSource = '$baseurl/api/dashboard/leads-by-source-count';

  // Leads list
  static const String dashLeadsList = '$baseurl/api/leads/customer_list';

  // Latest customers list
  static const String dashLatestCustomers = '$baseurl/api/customers/customer_list';

  // Latest tasks list
  static const String dashLatestTask = '$baseurl/api/tasks/customer_list';

  // Transactions list
  static const String dashTransactions = '$baseurl/api/customer-payments/customer_list';

  // =============================================================================
  // LEAD SCREEN APIs
  // Assigned lead to users
  // static const String assignedLeadTo = '$baseurl/api/auth/get-descendants'; // here i am doing  changes in url
  static const String assignedLeadTo = '$baseurl/api/auth/userlist';

  // Create new lead source
  static const String createNewLeadSource = '$baseurl/api/lead-sources';

  // Create new lead product category
  static const String createNewLeadProductCategory = '$baseurl/api/product-categories/list';

  // Create new lead divisions
  static const String createNewLeadDivisions = '$baseurl/api/divisions';

  // Create new lead custom fields
  static const String createNewLeadCustomFields = '$baseurl/api/lead-custom-fields';

  // Search city for leads
  static const String createNewLeadCity = '$baseurl/api/cities/search';
  // Lead pincode search
  static const String leadPinCodeSearch = '$baseurl/api/city-pincodes/search';

  // Lead pincode city search with specific pincode
  static const String leadPinCodeCitySearch = '$baseurl/api/city-pincodes/search?search=';

  // Lead edit pincode search
  static const String leadEditPinCode = '$baseurl/api/city-pincodes/search';


  // Create new lead status
  static const String createNewLeadStatus = '$baseurl/api/lead-status';

  // Create a new lead
  static const String createLead = '$baseurl/api/leads';

  // Lead import status
  static const String leadImportStatus = '$baseurl/api/lead-status';

  // Lead settings
  static const String leadSetting = '$baseurl/api/lead-fields-management';
  static const String leadColumnSettingEdit = '$baseurl/api/hide-lead-columns-from-role/create';
  static const String leadFieldSettingEdit = '$baseurl/api/lead-field-edit-restriction/create';

  // User profile settings
  static const String settingUserProfile = '$baseurl/api/auth/52fd0c63-4a9b-4047-8736-0cace72393d6';

  // Lead field settings
  static const String fieldSetting = '$baseurl/api/lead-fields';

  // Lead label
  static const String leadColumnLabel = '$baseurl/api/lead-custom-fields';

  // Custom fields for settings
  static const String settingCustomFields = '$baseurl/api/lead-custom-fields';

  // Roles settings
  static const String settingRoles = '$baseurl/api/roles';

  // Lead list
  static const String leadList = '$baseurl/api/leads/list';

  // Dynamic lead details based on lead ID
  static String leadDetails(String leadId) => '$baseurl/api/leads/$leadId';

  // Lead proformas list
  static const String leadProformasList = '$baseurl/api/performa/lead';

  // Soft delete lead
  static String leadDelete(String leadId) => '$baseurl/api/leads/$leadId/soft-delete';

  // Permanent delete lead
  static String leadDeletePermanent(String leadId) => '$baseurl/api/leads/$leadId/permanent-delete';

  // Restore permanently deleted lead
  static String leadRestorePermanent(String leadId) => '$baseurl/api/leads/$leadId';

  // Bulk delete leads
  static const String leadListBulkDelete = '$baseurl/api/leads/delete';

  // Bulk assign leads
  static const String leadListBulkAssign = '$baseurl/api/lead-assigned/multiple/4ab12ff3-77c3-4bb0-a2da-d5b2600bf9b5';

  // Bulk unassign leads
  static const String leadListBulkUnAssign = '$baseurl/api/lead-assigned/unassigned?userId=4ab12ff3-77c3-4bb0-a2da-d5b2600bf9b5';

  // Lead list column permissions
  static const String leadListColumnList = '$baseurl/api/lead-fields-management/view-permissions';

  // Update lead list columns
  static const String leadListColumnUpdate = '$baseurl/api/lead-fields-management/user-lead-fields';

  // Lead detail view with specific UUID
  static const String leadDetailView = '$baseurl/api/leads/7c8bf173-a6d4-4383-8a2d-a3c948b9c298';



  // Lead detail call type
  static const String leadDetailCallType = '$baseurl/api/lead-activity-purposes?type=Call';

  // Lead detail meeting type
  static const String leadDetailMeetingType = '$baseurl/api/lead-activity-purposes?type=Meeting';

  // Lead detail task type
  static const String leadDetailTaskType = '$baseurl/api/task-type';

  // Lead detail task status
  static const String leadDetailTaskStatus = '$baseurl/api/task-status/customer_list';

  // Lead detail proposal
  static const String leadDetailProposal = '$baseurl/api/proposals';

  // Lead products list
  static const String leadProducts = '$baseurl/api/products/list';

  // Lead detail action for lead assignment
  static const String leadDetailActionLead = '$baseurl/api/auth/get-descendants';

  // Lead detail action for services
  static const String leadDetailActionService = '$baseurl/api/lead-activities';

  // Lead detail attachment
  static const String leadDetailAttachment = '$baseurl/api/leads/lead-attachments/ca661553-d140-4a22-8c09-e96a2b330adf';

  // Create call activity for lead
  static const String leadDetailActivityCallCreate = '$baseurl/api/lead-activities/2c165cd5-2987-4255-b4dc-0df64fef5985';

  // Lead detail assign history
  static const String leadDetailAssignHistory = '$baseurl/api/leads/9e231960-6448-4beb-93a5-c0b0a834c4b4/assigned-history';

  // Lead detail history
  static const String leadDetailHistory = '$baseurl/api/lead-activities/history/8192bb2a-72d0-4958-9937-f622a948d867';

  // Lead detail projection
  static const String leadDetailProjection = '$baseurl/api/projection';

  // Lead assigned endpoint
  static const String leadAssignedEndpoint = '$baseurl/api/lead-assigned/multiple';

  // Lead activities endpoint
  static const String leadDetailsLeadTypeEndpoint = '$baseurl/api/lead-activities';

  // Update lead status
  static String leadDetailUpdateStatus(String leadId) => '$baseurl/api/leads/$leadId/status';

  // Currency details
  static const String leadDetailCurrency = '$baseurl/api/currencies';

  // Lead dead reason
  static const String leadDetailDeadReason = '$baseurl/api/lead-dead-reason';

  // All activities for a lead
  static String leadDetailsActivitiesAll(String leadId) => '$baseurl/api/leads/$leadId/activities';


  // Lead reminders
  static String leadDetailsActivitiesReminder(String leadId) => '$baseurl/api/leads/$leadId/reminders';

  // Generate proforma for lead
  static const String leadDetailProforma = '$baseurl/api/performa';

  // Lead type
  static const String leadType = '$baseurl/api/lead-types';

  static const String addSubLeadType = '$baseurl/api/lead-types/sub-type';

  static String updateSubLeadType(String leadSubTypeId) {
    return '$leadType/$leadSubTypeId';
  }


  static String updateLeadType(String leadTypeId) {
    return '$leadType/$leadTypeId';
  }
  // static const String updateSubLeadType = '$baseurl/api/lead-types';

  // Lead assign
  static const String leadAssign = '$baseurl/api/auth/users-list-and-search';

  // Lead phone code
  static const String leadListPhoneCode = '$baseurl/api/countries/phonecode';

  // State names by country
  static String get stateName => '$baseurl/api/states/country';

  // Lead activity list
  static const String leadActivityList = '$baseurl/api/lead-activities/history';

  // Unique lead activities
  static const String leadUniqueList = '$baseurl/api/lead-activities/unique-activities';

  // Lead activity lead type
  static const String leadActivityLeadType = '$baseurl/api/lead-types';

  // Lead activity daily sales reports
  static const String leadActivityDailySaleReports = '$baseurl/api/lead-activities/reports';

  // Lead activity no activities report
  static const String leadActivityNoActivities = '$baseurl/api/lead-activities/no-activity-reports';

  // Lead activity lead-wise reports
  static const String leadActivityLeadReports = '$baseurl/api/lead-activities/reports-leadwise';

  // Team leads type count
  static const String leadActivityTeamLeads = '$baseurl/api/dashboard/team-lead-type-count';

  // Lead master source
  static const String leadMasterSource = '$baseurl/api/lead-sources';

  // Lead Source
  static const String leadSource = '$baseurl/api/lead-sources?q=';

  // Lead Source Status in details
  static String leadSourceStatus(String sourceId) => '$baseurl/api/lead-sources/$sourceId';


  // Lead Source create
  static String leadSourceCreate(String sourceId) => '$baseurl/api/lead-sources/$sourceId';


  // Lead dead Reason
  static const String leadMasterType = '$baseurl/api/lead-types';

  // Lead master type
  static const String leadDeadReason = '$baseurl/api/lead-dead-reason?q=';

  // Delete Lead Reason
  static  String deleteLeadDeadReason(String deadReasonId) => '$baseurl/api/lead-dead-reason/$deadReasonId';

  // Company profile
  static const String companyProfile = '$baseurl/api/company-profile';

  // =============================================================================
  // TRASH LEADS
  // Deleted leads list
  static const String deleteList = '$baseurl/api/leads/delete_list';

  // =============================================================================
  // STATUS
  // Lead master status
  static const String leadMastersStatus = '$baseurl/api/lead-status';

  // =============================================================================
  // CUSTOMER APIs
  // Customer list
  static const String customersList = '$baseurl/api/customers/customer-list';

  // Customer type
  static const String customerType = '$baseurl/api/customer-types';

  // Customer source
  static const String customerSource = '$baseurl/api/lead-sources';

  // Customer search assign
  static const String customerListSearchAssign = '$baseurl/api/auth/users-list-and-search';

  // Customer divisions
  static const String customerListDivision = '$baseurl/api/divisions';

  // Filter city for customers
  static const String filterCity = '$baseurl/api/cities/role';

  // Customer details activities All
  static String customerDetailsActivitiesAll(String id) => '$baseurl/api/customers/$id/activities';

  // Customer details activities Call
  static String customerDetailsActivitiesCalls(String id) => '$baseurl/api/customers/$id/calls';

  // Customer details activities  Meetings
  static String customerDetailsActivitiesMeeting(String id) => '$baseurl/api/customers/$id/meetings';

  // Customer details activities Visit Only
  static String customerDetailsActivitiesVisitOnly(String id) => '$baseurl/api/customers/$id/visit-only';

  // Customer details activities Reminder
  static String customerDetailsActivitiesReminder(String id) => '$baseurl/api/customers/$id/reminders';

  // Customer details activities Notes
  static String customerDetailsActivitiesNotes(String id) => '$baseurl/api/customers/$id/notes';

  // Customer details activities Assigned
  static String customerDetailsActivitiesAssigned(String id) => '$baseurl/api/customers/$id/assigned-history';

  // Customer details activities  Services
  static String customerDetailsActivitiesServices(String id) => '$baseurl/api/customers/$id/services';

  // Customer details Services Areas
  static String customerDetailsServicesArea(String id) => '$baseurl/api/customers/$id/service-areas';

  // Customer details Payments
  static String customerDetailsPayments(String id) => '$baseurl/api/customers/$id/payments';

  // Customer details Projects
  static String customerDetailsProjects(String id) => '$baseurl/api/customers/$id/projects';

  // Customer details Leads
  static String customerDetailsLeads(String id) => '$baseurl/api/customers/$id/leads';

  // Customer details Orders
  static String customerDetailsOrders(String id) => '$baseurl/api/customers/$id/orders';

  // Customer details Attachments
  static String customerDetailsAttachments(String id) => '$baseurl/api/customers/$id/customer-attachments';

  // Customer details upload  Attachments
  static String customerDetailsUploadAttachments(String id) => '$baseurl/api/customers/upload-customer-attachment/$id';

  // customer assigned
  static const String  customerAssigned = '$baseurl/api/customer-assigned/multiple';

  // Customer detail view list
  static const String customerListDetailViewList = '$baseurl/api/customers';


  // Customer to Customer List Merge Customer List

  static const String custToCusMerCustomerList = '$baseurl/api/companies/lookup';

  // Customer service categories
  static const String customerListServiceCategories = '$baseurl/api/customers/8d19a603-e558-40f1-ab2c-a6ab764716d3/service-categories';

  // Customer proformas list
  static const String customerProformasList = '$baseurl/api/performa/customer';

  // customer merge
  static const String customerMerge = '$baseurl/api/customers/merge-customers';


  // Customer credential list
  static const String customerCredentialList = '$baseurl/api/companies/list-all';

  // Customer company list
  static const String customerDetailViewCompanyList = '$baseurl/api/companies/customer_list/8d19a603-e558-40f1-ab2c-a6ab764716d3';

  // Customer services
  static const String customerDetailViewServices = '$baseurl/api/customers/c5f2b49c-e836-4a1f-8e84-61eb9cd3e9b0/services';

  // Customer activities
  static const String customerDetailViewActivities = '$baseurl/api/customer-activities/history-customer-view';

  // Customer assigned history
  static const String customerDetailViewAssignedHistory = '$baseurl/api/customers/c5f2b49c-e836-4a1f-8e84-61eb9cd3e9b0/assigned-history';

  // Customer payment list
  static const String customerDetailViewPaymentList = '$baseurl/api/customers/9e47d5a5-a8f2-461d-9fdb-70a43e661d8b?option=payments';

  // Customer call type
  static const String customerDetailViewCallType = '$baseurl/api/customer-activity-purposes';

  // Create company
  static const String customerDetailCreateCompany = '$baseurl/api/companies';

  // Update company
  static const String customerDetailUpdateCompany = '$baseurl/api/companies/e09bd99f-3c6b-4013-9299-ac874b974c71';

  // Customer activity list
  static const String customerActivityList = '$baseurl/api/customer-activities/history';

  // Customer activity reports
  static const String customerActivityReports = '$baseurl/api/customer-activities/reports-userwise';

  // Customer no activity reports
  static const String customerActivityNoActivities = '$baseurl/api/customer-activities/inactive-reports';

  // Customer activity customer reports
  static const String customerActivityCustomerReports = '$baseurl/api/customer-activities/reports';

  // Customer activity unique meeting (placeholder, as original is empty)
  static const String customerActivityUniqueMeeting = '$baseurl/api/customer-activities/unique-meetings'; // Update if actual endpoint is available

  // Customer activity status report
  static const String customerActivityStatusReport = '$baseurl/api/customer-activities/customer-status';

  // Customer payment reminders
  static const String customersPaymentReminder = '$baseurl/api/customer-payment-reminders/customer_list';

  // Customer companies
  static const String customerCompanies = '$baseurl/api/companies/customer_list-all';

  // Customer services
  static const String customerServices = '$baseurl/api/customer-services/customer_list';

  // Service area states
  static const String safeAreaState = '$baseurl/api/service-areas/available/states';

  // Service area cities
  static const String safeAreaCity = '$baseurl/api/service-areas/available/districts';

  // Service area pincodes
  static const String safeAreaPincode = '$baseurl/api/service-areas/available/pincodes';

  // Service area products
  static const String safeAreaProduct = '$baseurl/api/service-areas/available/products';

  // Select company for service area
  static const String safeAreaSelectCompany = '$baseurl/api/companies/customer_list-all';

  // Allot product to service area
  static const String safeAreaAllotProduct = '$baseurl/api/service-areas/update';

  // Order product list
  static const String orderProductList = '$baseurl/api/order-products/customer_list';

  // Search products
  static const String orderProductSearch = '$baseurl/api/products';

  // Customer service for order
  static const String orderProductService = '$baseurl/api/customer-services';

  // Quit order product service
  static const String orderProductQuit = '$baseurl/api/customer-services/quit/a48a7b87-5be3-43a4-b2f4-6a2bbaf0b1a0';

  // Renew order product service
  static const String orderProductRenew = '$baseurl/api/customer-services/restart';

  // Orderless services list
  static const String orderlessServicesList = '$baseurl/api/orderless-services/customer_list';

  // Create orderless service
  static const String orderlessServiceCreate = '$baseurl/api/orderless-services';

  // Quit orderless service
  static const String orderlessServiceQuit = '$baseurl/api/orderless-services/a239af48-02c9-46e9-80c2-39b33d1752ee/quit';

  // Renew orderless service
  static const String orderlessServiceRenew = '$baseurl/api/orderless-services/a239af48-02c9-46e9-80c2-39b33d1752ee/restart';

  // Customer trash list
  static const String customersTrashList = '$baseurl/api/customers/trash';

  // Customer activation list
  static const String customersActivationList = '$baseurl/api/sent-project-activation/customer_list';

  // Customer master company credential
  static const String customerMasterCompanyCredential = '$baseurl/api/companies/credential-type';

  // Create company credential
  static const String customerMasterCompanyCredentialCreate = '$baseurl/api/companies/credential-type';

  // Update company credential
  static const String customerMasterCompanyCredentialUpdate = '$baseurl/api/companies/credential-type/218fd612-2501-4ce1-b42d-6282ed8b49b3';

  // Customer master customer type
  static const String customerMasterCustomerType = '$baseurl/api/customer-types';

  // Create customer type
  static const String customerTypeCreate = '$baseurl/api/customer-types';

  // Update customer type
  static const String customerTypeUpdate = '$baseurl/api/customer-types/08531989-ac1c-469d-bb0c-2a457b0fa858';

  // Customer master activity purpose
  static const String customerMasterActivityPurpose = '$baseurl/api/customer-activity-purposes';

  // Create activity purpose
  static const String customerMasterActivityPurposeCreate = '$baseurl/api/customer-activity-purposes';

  // Customer master activation services
  static const String customerMasterActivationServices = '$baseurl/api/product-categories/customer_list';

  // Customer master activation available fields
  static const String customerMasterActivationAvailableField = '$baseurl/api/project-activation-fields/customer_list';

  // Update activation settings
  static const String customerMasterActivationUpdate = '$baseurl/api/project-activation-managements/update-activation/0647c740-0c84-4599-9a49-cd3c88f901b9';

  // Customer master activation field
  static const String customerMasterActivationField = '$baseurl/api/project-activation-fields/customer_list';

  // Create activation field
  static const String customerMasterActivationFieldCreate = '$baseurl/api/project-activation-fields';

  // Customer master activation settings
  static const String customerMasterActivationSetting = '$baseurl/api/project-activation-settings/customer_list';

  // Create activation settings
  static const String customerMasterActivationSettingCreate = '$baseurl/api/project-activation-settings';

  // Update activation settings
  static const String customerMasterActivationSettingUpdate = '$baseurl/api/project-activation-settings/05516662-95b7-440d-bfbb-b4ecd509da52';

  // Customer setting column list
  static const String customerSettingColumnList = '$baseurl/api/customer-field-management';

  // Save customer setting changes
  static const String customerSettingColumnSaveChange = '$baseurl/api/customer-field-management';

  // Update customer setting columns
  static const String customerSettingColumnUpdate = '$baseurl/api/hide-customer-columns-from-role/update';

  // Customer setting field list
  static const String customerSettingFieldList = '$baseurl/api/customer-fields';

  // =============================================================================
  // ORDER APIs
  // Order list
  static const String orderList = '$baseurl/api/orders/order-list';

  // One-time services
  static const String orderOneTimeSer = '$baseurl/api/customer-services/list';

  // Search product term
  static const String orderSearchProductTerm = '$baseurl/api/products';

  // Search customers
  static const String orderSearchCustomer = '$baseurl/api/customers/customer_list';

  // Company list for orders
  static const String orderCompany = '$baseurl/api/companies/customer_list-all';

  // Generate order performa invoice
  static const String orderGenerateList = '$baseurl/api/orders/41d25a24-1dca-4e5a-ab9c-d22d5a76ad55/performa-invoice';

  // Order detail list
  static const String orderDetailList = '$baseurl/api/orders/01ecd555-6254-488d-a2c3-5a5cdc3602fa';

  // Order payment list
  static const String orderPayment = '$baseurl/api/customer-payments/list';

  // Delete order
  static const String orderDeleteList = '$baseurl/api/orders/delete';

  // Export orders
  static const String orderExport = '$baseurl/api/orders/export-orders';

  // Update credit/debit note
  static const String orderCreditDebit = '$baseurl/api/customers/update-credit-debit-note';

  // Update order payment
  static const String orderPaymentUpdate = '$baseurl/api/customer-payments/3f3bec74-c34e-484a-b194-c3df50b2b703';

  // Change order payment status
  static const String orderPaymentStatus = '$baseurl/api/customer-payments/status-change';

  // Order master
  static const String orderMaster = '$baseurl/api/customer-payments/status-change';

  // =============================================================================
  // REPORT TASK APIs
  // Team task report
  static const String reportTask = '$baseurl/api/tasks/team-task-report';

  // Start task
  static const String reportStart = '$baseurl/api/tasks/af9881ca-38cd-463e-910f-48f5664ada89';

  // Task start/stop tracker
  static const String taskStartStop = '$baseurl/api/tasks/task-tracker-event';

  // Task description
  static const String reportTaskDescription = '$baseurl/api/tasks/af9881ca-38cd-463e-910f-48f5664ada89/descriptions';

  // Remove task attachment
  static const String reportTaskRemoveAttachment = '$baseurl/api/tasks/remove-attachment/8a7f359a-2d03-4e41-b41a-98559eaf4ac2';

  // Task tracker event
  static const String reportTaskTrackerEvent = '$baseurl/api/tasks/task-tracker-event';

  // Update task
  static const String taskUpdate = '$baseurl/api/tasks/98a676ad-23b2-4f3b-8f26-33906250c10a';

  // Project overview list
  static const String taskProjectOverViewList = '$baseurl/api/projects/4e71cae5-a4ba-403f-aaf6-35ebb5295baf';

  // Project report list
  static const String taskProjectReportList = '$baseurl/api/projects/project-report-customer_list';

  // Employee daily sales report
  static const String reportEmployee = '$baseurl/api/reports/employees/daily-sales';

  // Product-wise sales report
  static const String reportProductWiseSale = '$baseurl/api/order-activity/products';

  // Recurring services report
  static const String reportRecurringServices = '$baseurl/api/reports/recurring-service-customers';

  // Create project report
  static const String taskCreateReportList = '$baseurl/api/projects/update-project-report';

  // Update project overview
  static const String updateProjectOverView = '$baseurl/api/projects/65189f4c-843e-41e6-953c-6dabcd21f4a0';

  // Project tags
  static const String projectTags = '$baseurl/api/project-tags';

  // Project reminder
  static const String projectReminder = '$baseurl/api/projects/update-report-reminder';

  // Task filter assign
  static const String reportTaskFilterAssign = '$baseurl/api/auth/get-descendants';

  // Task type
  static const String reportTaskType = '$baseurl/api/task-type';

  // Task status
  static const String reportTaskStatus = '$baseurl/api/task-status/customer_list';

  // =============================================================================
  // SALE TARGET APIs
  // Add sale target
  static const String saleAddTarget = '$baseurl/api/target-incentives';

  // Target detail view
  static const String targetDetail = '$baseurl/api/target-incentives/06e5fbfe-936a-45a6-82e2-5adc59628692';

  // Update incentive breakdown
  static const String incentiveBreakDownUpdate = '$baseurl/api/target-incentives/add-incentive-breakdown';

  // Add product incentive
  static const String addProductIncentive = '$baseurl/api/target-incentives/add-product-incentive';

  // Delete incentive breakdown
  static const String deleteBreakDownIncentive = '$baseurl/api/target-incentives/remove-incentive-breakdown/f9cb6b4c-af4e-4002-adc1-5b16bb877d14';

  // Delete product incentive
  static const String deleteProductIncentive = '$baseurl/api/target-incentives/remove-product-incentive/251025a2-a037-499f-ac85-166fe4c29713';

  // Update product incentive
  static const String updateProductIncentive = '$baseurl/api/target-incentives/edit-product-incentive/6c2a00db-27dc-4b8d-9d51-afbf12a29b7e';

  // Add product for sale
  static const String saleAddProduct = '$baseurl/api/target-incentives/add-product-require';

  // Delete product
  static const String deleteProduct = '$baseurl/api/target-incentives/remove-product-require/a99c6556-fc3e-4fa4-ae91-05d14fe79434';

  // =============================================================================
  // TASK APIs
  // Task list
  static const String taskList = '$baseurl/api/tasks/list';

  // Search project
  static const String searchProject = '$baseurl/api/projects/customer_list-and-search';

  // Create new board
  static const String newBoard = '$baseurl/api/task-status';

  // Task master list
  static const String taskMasterList = '$baseurl/api/task-type';

  // Add task type
  static const String taskMasterAddTaskType = '$baseurl/api/task-type';

  // Update task type
  static const String taskMasterUpdate = '$baseurl/api/task-type/160dc1bb-9d7a-4996-8743-9c391756cd67';

  // =============================================================================
  // COMPANY AND SERVICES APIs
  // Companies list
  static const String customersCompanies = '$baseurl/api/companies/customer_list-all';

  // Customer services
  static const String customersServices = '$baseurl/api/customer-services/customer_list';

  // Order products
  static const String customersOrderProducts = '$baseurl/api/order-products/customer_list';

  // Company credential
  static const String customersCompanyCredential = '$baseurl/api/companies/credential-type';

  // Customer master types
  static const String customersMasterTypes = '$baseurl/api/companies/credential-type';

  // Customer activity purpose
  static const String customerActivityPurpose = '$baseurl/api/customer-activity-purposes';

  // Customer activation
  static const String customerActivation = '$baseurl/api/product-categories/customer_list';

  // Customer field
  static const String customerField = '$baseurl/api/project-activation-fields/customer_list';

  // Customer settings
  static const String customerSettings = '$baseurl/api/customer-field-management';

  // =============================================================================
  // PROFORMA AND PAYMENTS APIs
  // Order proforma
  static const String orderProforma = '$baseurl/api/performa';

  // Payments list
  static const String orderPayments = '$baseurl/api/customer-payments/payment-customer_list';

  // =============================================================================
  // HRM APIs
  // Attendance holidays
  static const String hrmAttendance = '$baseurl/api/holidays/customer_list';

  // Leave type
  static const String hrmLeaveType = '$baseurl/api/hrm/leave-type';

  // Leave plan
  static const String hrmLeavePlan = '$baseurl/api/hrm/leave-plan';

  // Add leave type
  static const String addLeaveType = '$baseurl/api/hrm/leave-type';

  // Update leave type
  static String updateLeaveType(String id) => '$baseurl/api/hrm/leave-type/$id';



  // =============================================================================
  // CAMPAIGN APIs
  // Campaign list
  static const String campaignList = '$baseurl/api/marketing-campaign/customer_list';

  // Mail logs
  static const String campaignMailLogs = '$baseurl/api/mail-logs/customer_list';

  // WhatsApp API
  static const String whatsappApi = '$baseurl/api/whatsapp/chats';

  // =============================================================================
  // SALES APIs
  // Sales target incentives
  static const String salesApi = '$baseurl/api/target-incentives/list';

  // Sales projection list
  static const String salesProjection = '$baseurl/api/projection/list';

  // Create projection
  static const String projectionCreate = '$baseurl/api/projection';

  // Update projection list
  static const String projectionUpdateList = '$baseurl/api/projection/2c9e464b-73bd-4f0a-8084-2fdf2479f740';

  // Update projection by user
  static String salesUptProjection(String userId) => '$baseurl/api/projection/$userId';

  // =============================================================================
  // ROLES APIs
  // Roles list
  static const String rolesApi = '$baseurl/api/roles';

  // Role modules
  static const String roleUpdateList = '$baseurl/api/modules';

  // Edit role
  static String roleEdit(String roleId) => '$baseurl/api/roles/$roleId/update';

  // Check role permissions
  static const String roleCheckUpdate = '$baseurl/api/role-permissions/30fd8f72-9bfe-46da-9bb2-cfcf20ee42d1';

  // =============================================================================
  // USERS APIs
  // User list
  static const String usersApi = '$baseurl/api/auth/user-customer_list';

  // User activities
  static const String usersActivitiesApi = '$baseurl/api/user-activities/list';

  // Add department
  static const String usersAddDepartment = '$baseurl/api/departments';

  // Update user status
  static String usersStatusApi(String userId) => '$baseurl/api/auth/status-change/$userId';

  // Update user
  static String userUpdateApi(String userId) => '$baseurl/api/auth/update-user/$userId';

  // =============================================================================
  // TASK APIs
  // Task list API
  static const String taskListApi = '$baseurl/api/tasks/list';

  // Task report
  static const String taskReport = '$baseurl/api/tasks/team-task-report';

  // Task master
  static const String taskMaster = '$baseurl/api/task-type';

  // =============================================================================
  // PROJECT APIs
  // Project list
  static const String projectList = '$baseurl/api/projects/list';

  // Project detail view
  static const String projectDetailView = '$baseurl/api/projects';

  // =============================================================================
  // PRODUCT APIs
  // Product list
  static const String productList = '$baseurl/api/products/products/list';

  // Product brand
  static const String productBrand = '$baseurl/api/product-brand';

  // Product activations
  static const String productActivations = '$baseurl/api/product-categories/requirement-forms';

  // Product services
  static const String productServices = '$baseurl/api/products/services/list';

  // Add product
  static const String addProduct = '$baseurl/api/products';

  // Update product
  static const String updateProduct = '$baseurl/api/products/1db2ee14-aa7f-4d72-bd5a-0e27b8c7df49';

  // Product category
  static const String productCategory = '$baseurl/api/product-categories';

  // Add product brand
  static const String addProductBrand = '$baseurl/api/product-brand';

  // GST list
  static const String productGstList = '$baseurl/api/gsts?searchTerm=';

  // Add GST
  static const String productAddGst = '$baseurl/api/gsts';

  // Master add product
  static const String masterAddProduct = '$baseurl/api/incentive-products';

  // Master product list
  static const String masterProductList = '$baseurl/api/incentive-products/list';

  // =============================================================================
  // INVENTORY APIs
  // Inventory stock
  static const String inventoryStock = '$baseurl/api/inventories';

  // Inventory request
  static const String inventoryRequest = '$baseurl/api/inventory-requests';

  // Inventory transactions
  static const String inventoryTransactions = '$baseurl/api/inventory-transactions';

  // Inventory vendors
  static const String inventoryVendors = '$baseurl/api/manufacturers?page=1&limit=15';

  // Inventory refill stocks
  static const String inventoryRefillStocks = '$baseurl/api/inventory-replenishments?page=1&limit=15';

  // =============================================================================
  // MASTER APIs
  // Project master
  static const String projectMaster = '$baseurl/api/project-tags';

  // Division master
  static const String masterDivision = '$baseurl/api/divisions';

  // Add division
  static const String masterAddDivision = '$baseurl/api/divisions';

  // Update division
  static const String masterUpdateDivision = '$baseurl/api/divisions';

  // Update division by ID
  static String updateDivisionList(String id) => '$baseurl/api/divisions/$id';

  // Departments master
  static const String masterDepartments = '$baseurl/api/departments/search?q=';

  // Proposals master
  static const String masterProposals = '$baseurl/api/proposals';

  // Customize list
  static const String masterCustomizeList = '$baseurl/api/module-dictionaries';

  // Customize type
  static const String masterCustomizeType = '$baseurl/api/modules/customer_list';

  // Customize lead source
  static const String masterCustomizeLeadSource = '$baseurl/api/module-dictionaries';

  // Customize order
  static const String masterCustomizeOrder = '$baseurl/api/module-dictionaries';

  // Cities list
  static const String masterCities = '$baseurl/api/cities/list';

  // Country list
  static const String masterCountry = '$baseurl/api/countries/list';

  // Customize labels
  static const String masterCustomize = '$baseurl/api/module-dictionaries';

  // Dashboard list with charts
  static const String masterDashboardList = '$baseurl/api/roles/with-charts';

  // Save dashboard changes
  static const String masterDashboardSaveChanges = '$baseurl/api/dashboard/configure';

  // Call details
  static const String callDetails = '$baseurl/api/enums/call-status';
}