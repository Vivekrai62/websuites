import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:websuites/data/models/responseModels/notification/delete/notification_delete_res_model.dart';
import 'package:websuites/data/models/responseModels/notification/notification_res_model.dart';
import '../../../../data/models/responseModels/userList/list/update/RolesListUpdateResponseModel.dart';
import 'package:websuites/data/models/responseModels/company_profile/company_profile.dart';
import 'package:websuites/data/models/responseModels/customers/activities/activities_list/activities_list.dart';
import 'package:websuites/data/models/responseModels/customers/activities/daily_reports/customer_activity_reports.dart';
import 'package:websuites/data/models/responseModels/customers/activities/no_activities/customer_activity_no_activities.dart';
import 'package:websuites/data/models/responseModels/customers/activities/status_reports/status_reports.dart';
import 'package:websuites/data/models/responseModels/customers/companies/customer_companies_response_model.dart';
import 'package:websuites/data/models/responseModels/customers/list/customer_detail_view/assigned_history/customer_detail_view_assigned_history_response_model.dart';
import 'package:websuites/data/models/responseModels/customers/list/customer_detail_view/order/customer_detail_view_order_response_model.dart';
import 'package:websuites/data/models/responseModels/customers/list/customer_detail_view/services/customer_detail_view_services_response_model.dart';
import 'package:websuites/data/models/responseModels/customers/list/customers_list_response_model.dart';
import 'package:websuites/data/models/responseModels/customers/master/companyCredentials/update/customer_master_company_credential_update_response_model.dart';
import 'package:websuites/data/models/responseModels/customers/master/customer_types/customer_master_customer_type_response_model.dart';
import 'package:websuites/data/models/responseModels/customers/orderProducts/renew/customer_order_product_renew_response_model.dart';
import 'package:websuites/data/models/responseModels/customers/payment_reminder/customer_payment_reminder_response_model.dart';
import 'package:websuites/data/models/responseModels/customers/service_area/allot_product/customer_allot_product_response_model.dart';
import 'package:websuites/data/models/responseModels/customers/settings/field_setting/list/customer_setting_field_list_response_model.dart';
import 'package:websuites/data/models/responseModels/leads/createNewLead/city/city_search.dart';
import 'package:websuites/data/models/responseModels/leads/createNewLead/import/status/lead_import_status_response_model.dart';
import 'package:websuites/data/models/responseModels/leads/leadMasters/status/lead_masters_status_response_model.dart';
import 'package:websuites/data/models/responseModels/leads/lead_activity/lead_reports/lead_reports.dart';
import 'package:websuites/data/models/responseModels/leads/list/lead_assign/lead_assign.dart';
import 'package:websuites/data/models/responseModels/leads/list/lead_list.dart';
import 'package:websuites/data/models/responseModels/leads/list/lead_list_bulk/delete/lead_list_bulk_delete.dart';
import 'package:websuites/data/models/responseModels/leads/setting/setting_userprofile/setting_user_profile.dart';
import 'package:websuites/data/models/responseModels/leads/trashLeads/deleteList/delete_list_response_model.dart';
import 'package:websuites/data/models/responseModels/leads/trashLeads/leadTypes/lead_types_response_model.dart';
import 'package:websuites/data/models/responseModels/order/list/order_delete/order_list_delete_response_model.dart';
import 'package:websuites/data/models/responseModels/reports/task_report/project_overview/project_overview_list/task_report_project_overview_response_model.dart';
import 'package:websuites/data/models/responseModels/reports/task_report/project_overview/project_tags/project_tag_response_model.dart';
import 'package:websuites/data/models/responseModels/reports/task_report/project_overview/update_project_overview/update_poject_overview_response_model.dart';
import 'package:websuites/data/models/responseModels/reports/task_report/task/filter/assign/report_task_filter_assign_response_model.dart';
import 'package:websuites/data/models/responseModels/reports/task_report/task/filter/task_type/report_task_type_response_model.dart';
import 'package:websuites/data/models/responseModels/sales/sales_detail_target/sales_detail_target_response_model.dart';
import '../../resources/appUrls/app_urls.dart';
import '../../views/customerScreens/customerList/customerdetails/activities/visit/customer_details_visit_only_res_model.dart';

import '../../views/reports/taskdetails/TaskDetailsResponseModel.dart';
import '../../views/reports/taskdetails/project_overview/task/ProjectOverViewTaskListResponseModel.dart';
import '../../views/reports/taskdetails/start_stop/StartStopResponseModels.dart';
import '../models/requestModels/customer/details/attachments/customer_details_upload_attachments_req_model.dart';
import '../models/requestModels/dashboardScreen/main_dashboard_screen/customer-reminders-chart/DashCusRemReqModel.dart';
import '../models/requestModels/dashboardScreen/main_dashboard_screen/get-user-effectivetime/DbTaskPerformanceReqModel.dart';
import '../models/requestModels/dashboardScreen/main_dashboard_screen/lead-reminders-chart/MainDashLeadRemindReqModel.dart';
import '../models/requestModels/dashboardScreen/main_dashboard_screen/lead_type/MainLeadTypeReqModel.dart';
import '../models/requestModels/dashboardScreen/main_dashboard_screen/leads-by-source-count/MainDashLeadSourceReqModel.dart';
import '../models/requestModels/dashboardScreen/main_dashboard_screen/payments-reminders-chart/DbPaymentReminderReqModel.dart';
import '../models/requestModels/dashboardScreen/main_dashboard_screen/project_reminder/ProjectReminderReqModel.dart';
import '../models/requestModels/dashboardScreen/main_dashboard_screen/project_status/ProjectStatusReqModel.dart';
import '../models/requestModels/dashboardScreen/main_dashboard_screen/sales_charts/SalesChartReqModel.dart';
import '../models/requestModels/dashboardScreen/main_dashboard_screen/task-status-chart/DashTaskStatusReqModel.dart';
import '../models/requestModels/dashboardScreen/main_dashboard_screen/transactions-chart/DbTransactionReqModel.dart';
import '../models/requestModels/lead/lead_list/details/activities/LeadDetailsActivitiesAllResModel.dart';
import '../models/requestModels/lead/lead_list/filter/state/StateFilterResponseModel.dart';

import '../models/requestModels/master/dashboard/save_changes/SettingDashSaveChangesRequestModel.dart';
import '../models/requestModels/project_reminder_setting/ProjectReminderSettingRequestModel.dart';

import '../models/requestModels/report/task_report/project_overview/task/ProjectOverViewTaskListRequestModel.dart';
import '../models/responseModels/HRM/attendance/hrm_attendance_response_model.dart';
import '../models/responseModels/analytics/sale_analytics/DailyAnalyticsResponseModel.dart';
import '../models/responseModels/callDetails/CallDetailsResModel.dart';
import '../models/responseModels/campaign/list/campaign_list_response_model.dart';
import '../models/responseModels/campaign/mailLogs/mail_logs_response_model.dart';
import '../models/responseModels/customers/activationList/customer_activation_list_response_model.dart';
import '../models/responseModels/customers/activities/assigned/customer_details_activities_assigned_res_model.dart';
import '../models/responseModels/customers/activities/call/customer_activities_calls_res_model.dart';
import '../models/responseModels/customers/activities/customer_reports/customer_activity_customer_reports.dart';
import '../models/responseModels/customers/activities/meeting/customer_details_meeting_res_model.dart';
import '../models/responseModels/customers/activities/notes/customer_details_notes_res_model.dart';
import '../models/responseModels/customers/activities/reminder/customer_details_activities_reminder_res_model.dart';
import '../models/responseModels/customers/create/customer_create_response_model.dart';
import '../models/responseModels/customers/crendentials/CustomerCredentialsResModel.dart';
import '../models/responseModels/customers/list/assign_search/assign_search.dart';
import '../models/responseModels/customers/list/customer_city/customer_city.dart';
import '../models/responseModels/customers/list/customer_detail_view/activities/customer_detail_view_activities_response_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/attachements/customer_details_attachemets_res_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/attachements/upload/customer_details_upload_attachments_res_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/call_type/customer_detail_view_call_type_response_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/company_list/customer_detail_view_company_list_response_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/create_company/customer_view_create_company_reesponse_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/credit_debit/customer_detail_credit_debit_response_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/customer_assigned/customer_assigned_res_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/lead/customer_detail_lead_response_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/list/customer_list_detail_view_list_response_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/merge/cust_to_cust_merge_cust_list_res_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/service_categories/customer_detail_view_service_categories_response_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/update_company/customer_detail_update_company_response_model.dart';
import '../models/responseModels/customers/list/customer_type/customer_type.dart';
import '../models/responseModels/customers/list/details/customer_details-services_res_model.dart'
    hide CustomerDetailsPaymentResModel;
import '../models/responseModels/customers/list/details/payments/customer_details_payment_res_model.dart';
import '../models/responseModels/customers/list/customer_detail_view/projects/customer_details_projects_res_model.dart';
import '../models/responseModels/customers/list/details/services_area/customer_details_services_area_res_model.dart';
import '../models/responseModels/customers/list/filter/customer_division.dart';
import '../models/responseModels/customers/list/filter/customer_source.dart';
import '../models/responseModels/customers/master/activation/available_field/activation_available_field_response_model.dart';
import '../models/responseModels/customers/master/activation/customer_activation_response_model.dart';
import '../models/responseModels/customers/master/activation_setting/create/customer_master_activation_setting__create-response_model.dart';
import '../models/responseModels/customers/master/activation_setting/customer_master_activtaion_setting_response_model.dart';
import '../models/responseModels/customers/master/activation_setting/update/customer_master_activation_setting_update_response_model.dart';
import '../models/responseModels/customers/master/activity_purpose/activity_purpose_response_model.dart';
import '../models/responseModels/customers/master/activity_purpose/create/customer_master_activity_purpose_create_response_model.dart';
import '../models/responseModels/customers/master/companyCredentials/list/customer_company_credential_response_model.dart';
import '../models/responseModels/customers/master/customer_types/create/customer_type_create_response_model.dart';
import '../models/responseModels/customers/master/customer_types/update/customer_type_update_response_model.dart';
import '../models/responseModels/customers/master/fields/create/customer_master_field_create_response_model.dart';
import '../models/responseModels/customers/master/fields/customer_master_fields_response_model.dart';
import '../models/responseModels/customers/orderProducts/customer_order_products_response_model.dart';
import '../models/responseModels/customers/orderProducts/order_product_search/customer_order_product_search_response_model.dart';
import '../models/responseModels/customers/orderProducts/services/order_product_services.dart';
import '../models/responseModels/customers/orderless_services/create/customer_orderless_services_create_response_model.dart';
import '../models/responseModels/customers/orderless_services/list/customer_orderless_services_response_model.dart';
import '../models/responseModels/customers/orderless_services/quit/customer_orderless_service_response_model.dart';
import '../models/responseModels/customers/orderless_services/renew/customer_orderless_service_renew_response_model.dart';
import '../models/responseModels/customers/proformas/CustomerProformasResModel.dart';
import '../models/responseModels/customers/proformas/view/proforma_view_res_model.dart';
import '../models/responseModels/customers/service_area/city/customer_service_area_city_response_model.dart';
import '../models/responseModels/customers/service_area/pincode/customer_service_area_pinCode_response_model.dart';
import '../models/responseModels/customers/service_area/product/customer_service_area_product_response_model.dart';
import '../models/responseModels/customers/service_area/state/customer_service_area_response_model.dart';
import '../models/responseModels/customers/services/customer_services_response_model.dart';
import '../models/responseModels/customers/settings/column_setting/column_list/customer_setting_column_list_response_model.dart';
import '../models/responseModels/customers/settings/column_setting/save_changes/column_setting_save_changes_response_model.dart';
import '../models/responseModels/customers/trash/customer_trash_list_response_model.dart';
import '../models/responseModels/dashboard/db_count_response_model.dart';
import '../models/responseModels/dashboard/db_latest_customer_response_model.dart';
import '../models/responseModels/dashboard/db_lead_by_type_count_response_model.dart';

import '../models/responseModels/dashboard/db_transactions_response_model.dart';
import '../models/responseModels/dashboard/main_dashboard/List/MainDashboardChartsList.dart';
import '../models/responseModels/dashboard/main_dashboard/charts/customer-status-chart/MainDashCustomerStatusResModel.dart';

import '../models/responseModels/forgotPassword/forgot_password_response_model.dart';
import '../models/responseModels/globalSetting/GlobalSettingResModel.dart';
import '../models/responseModels/globalSetting/update/GlobalSettingCheckUpdateResModel.dart';
import '../models/responseModels/hrm/leave/plans/HrmLeavePlanResponseModel.dart';
import '../models/responseModels/hrm/leave/type/add/AddLeaveTypeResponseModel.dart';
import '../models/responseModels/hrm/leave/type/hrm_leave_type_response_model.dart';
import '../models/responseModels/hrm/leave/type/update/UpdateLeaveTypeRsponseModel.dart';
import '../models/responseModels/inventory/refillStocks/inventory_refill_stocks_response_model.dart';
import '../models/responseModels/inventory/request/inventory_request_response_model.dart';
import '../models/responseModels/inventory/stock/inventory_stock_response_model.dart';
import '../models/responseModels/inventory/transactions/inventory_transactions_response_model.dart';
import '../models/responseModels/inventory/vendors/inventory_vendors_response_model.dart';
import '../models/responseModels/leads/createNewLead/assignedLeadTo/assigned_lead_to_response_model.dart';
import '../models/responseModels/leads/createNewLead/create_lead/create_lead.dart';
import '../models/responseModels/leads/createNewLead/divisions/divisions_response_model.dart';
import '../models/responseModels/leads/createNewLead/leadCustomFields/lead_custom_fields.dart';
import '../models/responseModels/leads/createNewLead/pincode/pincode.dart';
import '../models/responseModels/leads/createNewLead/product_category/product_category.dart';
import '../models/responseModels/leads/createNewLead/source/source_response_model.dart';
import '../models/responseModels/leads/leadMasters/source/source_response_model.dart';
import '../models/responseModels/leads/leadMasters/types/ReportTeamLeadHotColdResModel.dart';
import '../models/responseModels/leads/lead_activity/daily_sales_reports/daily_sales_reports.dart';
import '../models/responseModels/leads/lead_activity/lead_activity_lead_type/lead_type.dart';
import '../models/responseModels/leads/lead_activity/lead_activity_list/lead_activity_list.dart';
import '../models/responseModels/leads/lead_activity/no_activities/no_activities.dart';
import '../models/responseModels/leads/list/column_list/edit/Lead_Column_Setting_Edit_Update_ResModel.dart';
import '../models/responseModels/leads/list/delete/LeadDeleteResponseModel.dart';
import '../models/responseModels/leads/list/details/LeadDetails.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/actionCreate/LeadActionCreateResModel.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/actionCreate/leadAssignedToSales/LeadAssignedToSalesResModel.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/actionCreate/leadType/LeadDetailLeadTypeCreateResModel.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/actionCreate/service/LeadDetailActionServiceResModel.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/activities/assigned/LeadDetailsActiAssignedResModel.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/activities/call/LeadDetailsActiCallResModel.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/activities/meeting/LeadDetailsActiMeetingResModel.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/activities/notes/LeadDetailsActiNotesResModel.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/activities/notes/create/LeadDetailsNoteCreateResMode.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/activities/reminder/LeadDetailsActiReminderResModel.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/assign_history/lead_detail_assign_history.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/attachment/lead_detail_attachment_response_model.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/call_create/lead_detail_call_create_response_model.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/call_type/lead_detail_call_type_response_model.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/currency/lead_detail_currency_response_model.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/generate_proforma/lead_detail_generate_proforma_response_model.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/history/lead_detail_history_response_model.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/leadPropducts/LeadProductsResModel.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/lead_detail/lead_details_response_model.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/meeting_type/lead_detail_meeting_type_response_model.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/projection/create/LeadProjectionCreateResModel.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/projection/lead_detail_projection_response_model.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/proposal/lead_detail_proposal_response_model.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/task_status/lead_detail_task_status_response_model.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/task_type/lead_detail_task_type_response_model.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/update_status/dead_reason/LeadDetailsDeadStatusReason.dart';
import '../models/responseModels/leads/list/details/lead_detail_view/update_status/lead_update_status_response_model.dart';
import '../models/responseModels/leads/list/filter/userlist/LeadUserFilterResModel.dart';
import '../models/responseModels/leads/list/column_list/lead_list_column_list_response_model.dart';
import '../models/responseModels/leads/list/filter/country_code/country_code.dart';
import '../models/responseModels/leads/list/lead_list_bulk/assign/lead_list_bulk_assign_response_model.dart';
import '../models/responseModels/leads/list/lead_list_bulk/un_assign/lead_list_un_assign_response_model.dart';
import '../models/responseModels/leads/list/pin_code_city_search/PinCodeCityResModel.dart';
import '../models/responseModels/leads/proformas/LeadProformasResModel.dart';
import '../models/responseModels/leads/setting/custom_field/custom_fields.dart';
import '../models/responseModels/leads/setting/custom_field/lead_label/lead_setting_column_lead_label_res_model.dart';
import '../models/responseModels/leads/setting/dead/create/lead_dead_create_res_model.dart';
import '../models/responseModels/leads/setting/dead/update/lead_dead_update_res_model.dart';
import '../models/responseModels/leads/setting/dead_reasons/delete/dead_reason_delete_response_model.dart';
import '../models/responseModels/leads/setting/dead_reasons/lead_setting_dead_reason_res_model.dart';
import '../models/responseModels/leads/setting/field_setting/create_update/lead_column_setting_edit_update_res_model.dart';
import '../models/responseModels/leads/setting/field_setting/field_setting.dart';
import '../models/responseModels/leads/setting/lead_source/create/lead_source_create_res_model.dart';
import '../models/responseModels/leads/setting/lead_source/lead_source_list_res_model.dart';
import '../models/responseModels/leads/setting/lead_source/status/lead_source_status_list_res_model.dart';

import '../models/responseModels/leads/setting/lead_type/add_create/lead_type/lead_type_res_model.dart';
import '../models/responseModels/leads/setting/lead_type/add_create/lead_type/update/lead_type_update_res_model.dart';
import '../models/responseModels/leads/setting/lead_type/add_create/sub_type/lead_subtype_add_res_model.dart';
import '../models/responseModels/leads/setting/lead_type/add_create/sub_type/update_lead/sub_tyep_update_res_model.dart';
import '../models/responseModels/leads/setting/roles/roles.dart';
import '../models/responseModels/leads/setting/setting.dart';
import '../models/responseModels/leads/trashLeads/delete_permanent/TrashLeadPermanentResModel.dart';
import '../models/responseModels/leads/trashLeads/restore/LeadTrashRestoreResModel.dart';
import '../models/responseModels/login/login_response_model.dart';
import '../models/responseModels/master/cities/master_cities_response_model.dart';
import '../models/responseModels/master/cityStateAndCountry/country/master_country_response_model.dart';
import '../models/responseModels/master/customizeLabel/customize/customize_response_model.dart';
import '../models/responseModels/master/customizeLabel/customize_lead_source/customize_lead_source.dart';
import '../models/responseModels/master/customizeLabel/customize_type/customize_type.dart';
import '../models/responseModels/master/dashboard/SettingDashboardResponseModel.dart';
import '../models/responseModels/master/dashboard/save_changes/SettingDashSaveChangesResponseModel.dart';
import '../models/responseModels/master/departments/master_departments_response_model.dart';
import '../models/responseModels/master/departments/update/UserDepartmentUpdateResponseModel.dart';
import '../models/responseModels/master/divisions/add_division/AddDivisionResponseModels.dart';
import '../models/responseModels/master/divisions/master_divisions_response_model.dart';
import '../models/responseModels/master/divisions/update/UpdateDivisionListResponseModel.dart';
import '../models/responseModels/master/divisions/update/UpdateDivisionResponseModels.dart';
import '../models/responseModels/master/proposals/master_proposals_resposne_model.dart';
import '../models/responseModels/order/list/company_list/order_company_list_response_model.dart';
import '../models/responseModels/order/list/credit_debit/credit_debit_response_model.dart';
import '../models/responseModels/order/list/detail/order_detail_response_model.dart';
import '../models/responseModels/order/list/export/order_export_response_model.dart';
import '../models/responseModels/order/list/order_list_response_model.dart';
import '../models/responseModels/order/list/search_customer/order_search_customer_response_model.dart';
import '../models/responseModels/order/list/search_product/order_search_product_response_model.dart';
import '../models/responseModels/order/master/order_master_response_model.dart';
import '../models/responseModels/order/onetime_services/OrderOneTimeServiceResModel.dart';
import '../models/responseModels/order/payments/order_payment_update/order_payment_update_response_model.dart';
import '../models/responseModels/order/payments/order_payments_response_model.dart';
import '../models/responseModels/order/proformaList/order_proforma_list_response_model.dart';
import '../models/responseModels/products/activation_forms/ProductsActivationsFormsResModel.dart';
import '../models/responseModels/products/brand/add_brand/add_product_brand_response_model.dart';
import '../models/responseModels/products/brand/product_brand_response_model.dart';
import '../models/responseModels/products/category/product_category_response_model.dart';
import '../models/responseModels/products/gst_list/product_add_gst_response_model.dart';
import '../models/responseModels/products/gst_list/product_gstList_response_model.dart';
import '../models/responseModels/products/list/add_product/add_product_response_model.dart';
import '../models/responseModels/products/list/products_list_response_model.dart';
import '../models/responseModels/products/list/updat_product/update_product_response_model.dart';
import '../models/responseModels/products/master/master_add_product_response_model.dart';
import '../models/responseModels/products/master/product_master_response_model.dart';
import '../models/responseModels/products/services/ProductsServicesResModel.dart';
import '../models/responseModels/projects/list/details/ProjectDetailsResponseModels.dart';
import '../models/responseModels/projects/list/projects_list_response_model.dart';
import '../models/responseModels/projects/master/ProjectMasterListResModel.dart';
import '../models/responseModels/reports/employeeReport/ReportEmployeeResModel.dart';
import '../models/responseModels/reports/leadReport/Activities/ReportActivitiesResModel.dart';
import '../models/responseModels/reports/leadReport/team_leads/TeamLeadResponseModel.dart';
import '../models/responseModels/reports/leadReport/uniqueMetting/ReportUniqueResModel.dart';
import '../models/responseModels/reports/products_wise_sale_reports/ReportProductWiseResModel.dart';
import '../models/responseModels/reports/recurringServices/ReportRecurrigServicesResModel.dart';
import '../models/responseModels/reports/task_report/project_overview/create_report_list/task_create_report_list_response_model.dart';
import '../models/responseModels/reports/task_report/project_overview/report_list/task_report_list_response_model.dart';
import '../models/responseModels/reports/task_report/remove_attachment/task_report_remove_attachment_response_model.dart';
import '../models/responseModels/reports/task_report/task/filter/task_status/report_task_status_response_model.dart';
import '../models/responseModels/reports/task_report/task_description/task_description_response_model.dart';
import '../models/responseModels/reports/task_report/task_report_response_model.dart';
import '../models/responseModels/reports/task_report/task_start/task_start_response_model.dart';
import '../models/responseModels/reports/task_report/task_tracker_event/task_tracker_event_response_model.dart';
import '../models/responseModels/reports/task_report/task_update/task_update_response_model.dart';
import '../models/responseModels/roles/edit_role/RoleListEditResponseModel.dart';
import '../models/responseModels/roles/edit_role/check_box_permission/RoleCheckEditResponseModel.dart';
import '../models/responseModels/roles/roles_response_model.dart';
import '../models/responseModels/sales/add_target/sales_add_target_response_model.dart';
import '../models/responseModels/sales/projection/SalesProjectionsListResponseModel.dart';
import '../models/responseModels/sales/projection/update/SalesUpdateProjectionListResponseModel.dart';
import '../models/responseModels/sales/projection/update/SalesUpdateProjectionResModel.dart';
import '../models/responseModels/sales/sales_detail_target/add_product_incentive/add_product_incentive_response_model.dart';
import '../models/responseModels/sales/sales_detail_target/delete/delete_breakdown_incentive_response_model.dart';
import '../models/responseModels/sales/sales_detail_target/delete/delete_product_incentive_response_model.dart';
import '../models/responseModels/sales/sales_detail_target/delete/delete_product_response_model.dart';
import '../models/responseModels/sales/sales_detail_target/incentive_breakdown/incentive_breakdown_add_response_model.dart';
import '../models/responseModels/sales/sales_detail_target/sale_add_product/sales_add_product_response_model.dart';
import '../models/responseModels/sales/sales_detail_target/update/update_product_incentive_response_model.dart';
import '../models/responseModels/sales/sales_response_model.dart';
import '../models/responseModels/tasks/list/new_board/task_list_new_board_response_model.dart';
import '../models/responseModels/tasks/list/project_search/task_list_project_search_response_model.dart';
import '../models/responseModels/tasks/list/tasks_list_response_model.dart';
import '../models/responseModels/tasks/master/task_master_list/task_master_response_model.dart';
import '../models/responseModels/userList/activity/UserActivitiesResponseModel.dart';
import '../models/responseModels/userList/add/UserDepartmentAddResponsetModel.dart';
import '../models/responseModels/userList/list/add_role/UserAddRoleResponseModel.dart';
import '../models/responseModels/userList/status/UserStatusResponseModel.dart';
import '../models/responseModels/userList/list/UserListResponseModels.dart';
import '../models/responseModels/userList/user_update/UserUpdateResponseModel.dart';
import '../models/responseModels/users/users_response_model.dart';
import '../network/network_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websuites/data/models/requestModels/customer/customer_list/customer_detail_view/merge/cus_to_cus_merge_req_model.dart';
import 'package:websuites/data/models/responseModels/customers/list/customer_detail_view/merge/after_merge/cus_to_cus_merge_res_model.dart';

class Repositories {
  final _apiService = NetworkApiServices();
  static const String userDepartmentUpdate =
      'https://dev.whsuites.com/api/departments/search?q='; // Define the constant here
  static const String baseurl = 'https://dev.whsuites.com/api';

  static const String masterUpdateDivision =
      '$baseurl/divisions'; // Define the constant here

  //============================================================================
  // LOGIN SCREEN API

  Future<LoginResponseModel> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.loginApi, data);
      print("Response Login$response");
      return response = LoginResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //============================================================================
  //FORGOT SCREEN API

  Future<ForgotPasswordResponseModel> forgotApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.forgotApi, data);
      return response = ForgotPasswordResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //============================================================================
  // HOME SCREEN API

  Future<DashboardCountResponseModel> dashboardCountApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.getDashboardCountApi, null);
      return response = DashboardCountResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Notification  List Api

  Future<NotificationResModel> notificationListApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.notification);
      print("Notification Response $response");
      return response = NotificationResModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Notification Update (Delete Api)
  Future<NotificationDeleteResModel> notificationDeleteApi(
      dynamic data, String notificationId) async {
    try {
      dynamic response = await _apiService.patchApi(
          AppUrls.notificationDelete(notificationId), data);
      print("Notification Delete  Response $response");
      return NotificationDeleteResModel.fromJson(response);
    } catch (e) {
      // print("Lead Detail Update Status Error $e");
      rethrow;
    }
  }

  // Main  Dashboard List Api

  // Main  Dashboard List Api

  Future<MainDashboardChartsListResponseModel> MainDashBoardListApi() async {
    try {
      // print("🔍 Repository: Making API call to ${AppUrls.dashboard}");
      // print("🔍 Repository: Full URL: ${AppUrls.dashboard}");

      // Check if we have a token before making the call
      final sp = await SharedPreferences.getInstance();
      String? token = sp.getString('accessToken');
      // print("🔍 Repository: Token present: ${token != null ? "Yes" : "No"}");
      if (token != null) {
        // print("🔍 Repository: Token length: ${token.length}");
        // print("🔍 Repository: Token starts with: ${token.substring(0, 10)}...");
      }

      dynamic response = await _apiService.getApi(AppUrls.dashboard);
      // print("🔍 Repository: Raw API response received: $response");
      // print("🔍 Repository: Response type: ${response.runtimeType}");

      final parsedResponse =
          MainDashboardChartsListResponseModel.fromJson(response);
      // print("🔍 Repository: Successfully parsed response");
      return parsedResponse;
    } catch (e) {
      // print("❌ Repository: Error in MainDashBoardListApi: $e");
      // print("❌ Repository: Error type: ${e.runtimeType}");
      // print("❌ Repository: Error stack trace: ${StackTrace.current}");
      rethrow;
    }
  }

// dashboard Lead Type

  Future<dynamic> dbLeadTypeApi(DbLeadTypeReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dashboardLeadType,
        requestModel.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> dbLeadCardApi(MainDashLeadSourceReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dashboardLeadCard,
        requestModel.toJson(),
      );
      return response; // Expecting a List<dynamic> in the response body
    } catch (e) {
      rethrow;
    }
  }

  // dashboard  lead reminder

  Future<dynamic> dbLeadReminderApi(
      MainDashLeadRemindReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dashboardLeadReminder,
        requestModel.toJson(),
      );
      return response; // Expecting a List<dynamic> in the response body
    } catch (e) {
      rethrow;
    }
  }

// Dashboard Customer Status
  Future<dynamic> dbCustomerApi(
      MainDashCustomerStatusReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dashboardCustomerStatus,
        requestModel.toJson(),
      );
      return response; // Expecting a List<dynamic> in the response body
    } catch (e) {
      rethrow;
    }
  }

  // dashboard task status
  Future<dynamic> dbTaskStatusApi(DashTaskStatusReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dbTaskStatus,
        requestModel.toJson(),
      );

      debugPrint('API Response: $response');

      return response;
    } catch (e) {
      debugPrint('API Error: $e');
      rethrow;
    }
  }

  // dashboard project status

  Future<dynamic> dbProjectStatusApi(
      DbProjecStatusReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dashboardProjectStatus,
        requestModel.toJson(),
      );
      return response; // Expecting a List<dynamic> in the response body
    } catch (e) {
      rethrow;
    }
  }

  // dashboard payment reminder

  Future<dynamic> dbPaymentReminderApi(
      DbPaymentReminderReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dashboardPaymentReminder,
        requestModel.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // dashboard project reminder

  //
  //
  // Future<DbProjectReminderResModel> dbProjectReminderApi() async {
  //   try {
  //     dynamic response =
  //     await _apiService.postApiResponse(AppUrls.dashboardProjectReminder, null);
  //     return response = DbProjectReminderResModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<dynamic> dbProjectReminderApi(
      ProjectReminderReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dashboardProjectReminder,
        requestModel.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> dbSalesChartApi(SalesChartReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dashboardSalesChart,
        requestModel.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

// Dashboard Transaction
  Future<dynamic> dbTransactionChartApi(
      DbTransactionReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dashboardSalesTransaction,
        requestModel.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> dbTaskPerformanceApi(
      DbTaskPerformanceReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dashboardTaskPerformance,
        requestModel.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Dashboard  user effective and task performance

// Dashboard Customer Reminder

  Future<dynamic> dbCustomerReminderApi(DashCusRemReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dashboardCustomerReminder,
        requestModel.toJson(), // This will now work
      );
      return response; // Expecting a List<dynamic> in the response body
    } catch (e) {
      rethrow;
    }
  }

// Lead Sources

  Future<dynamic> dbLeadsSourceApi(
      MainDashLeadSourceReqModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.dashLeadSource,
        requestModel.toJson(),
      );
      return response; // Expecting a List<dynamic> in the response body
    } catch (e) {
      rethrow;
    }
  }

  //
  // Future<List<MainDashLeadSourceResModel>> dashboardLeadSourceApi(MainDashLeadSourceReqModel requestModel) async {
  //   try {
  //     dynamic response = await _apiService.postApiResponse(
  //       AppUrls.dashboardLeadSource,
  //       requestModel.toJson(),
  //     );
  //
  //     if (response is List) {
  //       return response
  //           .map((item) => MainDashLeadSourceResModel.fromJson(item))
  //           .toList();
  //     }
  //     return [];
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //----------------------------------------------------
  // Analytics Screen ____________________________________////////////////

  Future<List<DailyAnalyticsResponseModel>> dailyAnalyticsListApi(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.dailyAnalyticsList, data);
      print("daily AnalyticsList  $response");

      // Assuming response is a List of JSON objects
      if (response is List) {
        // Convert each item in the customer_list to DailyAnalyticsResponseModel
        return response
            .map((item) => DailyAnalyticsResponseModel.fromJson(item))
            .toList();
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      rethrow;
    }
  }

  //Setting (Master Dashboard)
  Future<List<SettingDashboardListResponseModel>> masterSettingListApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.masterDashboardList);
      if (response is List) {
        return response
            .map((item) => SettingDashboardListResponseModel.fromJson(item))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow; // Handle exceptions as needed
    }
  }

  Future<SettingDashSaveChangesMessageResponseModel> settingSaveChangesApi(
      SettingDashSaveChangesRequestModel requestModel) async {
    try {
      dynamic response = await _apiService.patchApi(
        AppUrls.masterDashboardSaveChanges,
        requestModel.toJson(),
      );

      // Ensure response is a Map
      if (response is Map<String, dynamic>) {
        return SettingDashSaveChangesMessageResponseModel.fromJson(response);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print("Error in settingSaveChangesApi: $e");
      rethrow;
    }
  }

// // In repositories.dart or your respective repository class
//   Future<List<LeadProductCategoryList>> createLeadProductCategory() async {
//     try {
//       final response = await _apiService.getApi(AppUrls.createNewLeadProductCategory);
//
//       if (kDebugMode) {
//         print("Raw API Response: $response"); // Log the raw response
//       }
//
//       if (response is List) {
//         List<LeadProductCategoryList> categoryList = response
//             .map((item) => LeadProductCategoryList.fromJson(item))
//             .toList();
//
//         if (kDebugMode) {
//           print("Fetched Lead Product Categories: $categoryList");
//         }
//
//         return categoryList;
//       } else {
//         throw Exception("Unexpected response format. Expected a List.");
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error in createLeadProductCategory: $e");
//       }
//       rethrow; // Let the caller handle the error
//     }
//   }
//

  Future<List<LeadProductCategoryList>> createLeadProductCategory() async {
    try {
      dynamic response =
          await _apiService.getApi(AppUrls.createNewLeadProductCategory);
      if (kDebugMode) {
        print("API Response received successfully");
      }
      return LeadProductCategoryList.fromJsonList(response);
    } catch (e) {
      if (kDebugMode) {
        print("Error in createLeadProductCategory: $e");
      }
      // Convert generic errors to more specific ones for better handling
      if (e.toString().contains('internet') ||
          e.toString().contains('network')) {
        throw Exception('No internet connection');
      }
      rethrow;
    }
  }

  // Lead Detail ( projection  create )

  Future<LeadProjectionCreateResModel> projectionCreate(
      dynamic data, String) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrls.projectionCreate,
        data.toJson(), // Ensure data is serialized
      );
      print("Lead Projection Create $response");
      return LeadProjectionCreateResModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  ////// Lead Products
  Future<LeadProductsRes> leadProducts(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadProducts, data);
      if (response is! Map<String, dynamic>) {
        throw FormatException("Expected a Map, got ${response.runtimeType}");
      }
      print("product category $response");
      return LeadProductsRes.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

// User Main Screen List and activity

  Future<UsersListResponseModel> userListApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.userListApi, null);
      return response = UsersListResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<DashboardLeadsByTypeCountResponseModel> dbLeadsTypeCountApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.dashLeadsByTypeCount, null);
      return response =
          DashboardLeadsByTypeCountResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<DBLatestCustomersResponseModel> dbLatestCustomersApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.dashLatestCustomers, null);
      return response = DBLatestCustomersResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Future<DbLatestTaskResponseModel> dbLatestTaskApi() async {
  //   try {
  //     dynamic response =  await _apiService.postApiResponse(AppUrls.dashLatestTask, null);
  //     return response = DbLatestTaskResponseModel.fromJson(response);
  //   } catch(e){
  //     rethrow;
  //   }
  // }

  Future<DBLatestTransactionResponseModel> dbTransactionApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.dashTransactions, null);
      return response = DBLatestTransactionResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //============================================================================
  // LEAD SCREEN API
  // CREATE NEW LEAD API-----------

  Future<List<AssignedLeadToResponseModel>> assignedLeadApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.assignedLeadTo, null);

      if (response is List) {
        List<AssignedLeadToResponseModel> leadList = [];
        for (var item in response) {
          if (item is Map<String, dynamic>) {
            leadList.add(AssignedLeadToResponseModel.fromJson(item));
          }
        }
        return leadList;
      } else {
        throw Exception('Unexpected response type');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SourceResponseModel>> createNewLeadSourceApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.createNewLeadSource);
      // Assuming response is a List
      return (response as List)
          .map((item) => SourceResponseModel.fromJson(item))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DivisionsResponseModel>> createNewLeadDivisionsApi() async {
    try {
      dynamic response =
          await _apiService.getApi(AppUrls.createNewLeadDivisions);
      List<DivisionsResponseModel> divisionsList = (response as List)
          .map((division) => DivisionsResponseModel.fromJson(division))
          .toList();
      return divisionsList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CityResponseModel>> createNewLeadCityApi(String query) async {
    try {
      String url = '${AppUrls.createNewLeadCity}${Uri.encodeComponent(query)}';
      dynamic response = await _apiService.getApi(url);
      print("City api Response $response");
      List<CityResponseModel> citySearchList = (response as List)
          .map((json) => CityResponseModel.fromJson(json))
          .toList();
      return citySearchList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PinCodeModelResponseModel>> createLeadPinCode(String query,
      {String? stateId}) async {
    try {
      if (query.length != 6 || !RegExp(r'^\d{6}$').hasMatch(query)) {
        print('❌ [Repositories] createLeadPinCode: Invalid pincode: "$query"');
        throw Exception('Invalid pincode: Must be a 6-digit number');
      }

      // Build URL with proper query parameters
      String url =
          '${AppUrls.leadEditPinCode}?search=${Uri.encodeComponent(query)}';

      // Add stateId parameter if provided
      if (stateId != null && stateId.isNotEmpty) {
        url += '&stateId=${Uri.encodeComponent(stateId)}';
      }

      print('📡 [Repositories] Hitting API: $url');
      final response = await _apiService.getApi(url);

      if (response == null) {
        print('❌ [Repositories] createLeadPinCode: API returned null response');
        throw Exception('API returned null response');
      }

      print('✅ [Repositories] createLeadPinCode: Raw API response = $response');
      final responseData = response is List
          ? response
          : response is Map
              ? [response]
              : [];
      if (responseData.isEmpty) {
        print(
            '❌ [Repositories] createLeadPinCode: No data returned for pincode "$query"');
        return [];
      }

      final results = responseData
          .map((json) {
            try {
              return PinCodeModelResponseModel.fromJson(json);
            } catch (e) {
              print(
                  '💥 [Repositories] Error parsing PinCodeModelResponseModel: $e');
              return null;
            }
          })
          .where((element) => element != null)
          .cast<PinCodeModelResponseModel>()
          .toList();

      print(
          '✅ [Repositories] createLeadPinCode: Parsed results = ${results.map((e) => e.code).toList()}');
      return results;
    } catch (e) {
      print(
          '💥 [Repositories] createLeadPinCode: Error fetching pincode data: $e');
      rethrow;
    }

  }

  // city search by state id

  Future<List<PinCodeCityModelResModel>> leadPinCodeCitySearch(
      String stateId, String searchQuery) async {
    try {
      final url =
          'https://dev.whsuites.com/api/cities/search?search=$searchQuery&stateId=$stateId';
      // print('🌐city [Repository] API URL: $url');
      // print('📤city [Repository] Making API call...');

      final response = await _apiService.getApi(url);

      // print('📥city [Repository] Raw API Response:');
      // print('📄city Response Type: ${response.runtimeType}');
      // print('📄city Response Data: $response');

      if (response == null) {
        // print('❌city [Repository] API returned null response');
        throw Exception('city API returned null response');
      }

      final responseData = response is List
          ? response
          : response is Map
              ? [response]
              : [];

      // print('📊city [Repository] Processed Response Data:');
      // print('📊city Response Data Type: ${responseData.runtimeType}');
      // print('📊 city Response Data Length: ${responseData.length}');
      // print('📊city  Response Data Content: $responseData');

      if (responseData.isEmpty) {
        // print(
        //     '⚠️ city [Repository] No data returned for stateId: $stateId, searchQuery: $searchQuery');
        return [];
      }

      final cities = responseData
          .map((json) {
            try {
              // print('🏙️ city [Repository] Parsing city data: $json');
              final city = PinCodeCityModelResModel.fromJson(json);
              // print(
              //     '✅ city [Repository] Successfully parsed city: ${city.name} (ID: ${city.id})');
              return city;
            } catch (e) {
              // print('❌ city [Repository] Error parsing city data: $e');
              // print('❌ city [Repository] Failed JSON: $json');
              return null;
            }
          })
          .where((element) => element != null)
          .cast<PinCodeCityModelResModel>()
          .toList();

      // print('🎯  city[Repository] Final parsed cities:');
      for (int i = 0; i < cities.length; i++) {
        print('   ${i + 1}. ${cities[i].name} (ID: ${cities[i].id})');
      }
      // print('📈 city [Repository] Total cities parsed: ${cities.length}');

      return cities;
    } catch (e, stackTrace) {
      // print('💥 city [Repository] Error fetching city data: $e');
      // print('📍city  [Repository] StackTrace: $stackTrace');
      rethrow;
    }
  }

  //Create LEAD
  Future<CreateLeadResponseModel> createLead(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.createLead, data);
      print("Create Lead Response $response");
      // Parse the JSON into a customer_list of PinCodeModelResponseModel objects
      return CreateLeadResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Lead import---------

  Future<List<LeadImportStatusResponseModel>> leadImportStatus() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadImportStatus);
      print("Create Import Lead Status  Response $response");
      return LeadImportStatusResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Lead

  // Lead  import
  // Future<CreateLeadResponseModel> leadImport(dynamic data) async {
  //   try {
  //     dynamic response = await _apiService.postApiResponseRequest(AppUrls.createLead,data,);
  //     print("Create Lead Response $response");
  //     Parse the JSON into a customer_list of PinCodeModelResponseModel objects
  //     return CreateLeadResponseModel.fromJson(response);
  // } catch (e) {
  //   rethrow;
  // }
  // }

  //Lead import
  // Future<CreateLeadResponseModel> leadImport(Map<String, dynamic> data, File file, String token) async {
  //   try {
  //     // Create a multipart request
  //     var request = http.MultipartRequest('POST', Uri.parse(AppUrls.createLead))
  //     data.forEach((key, value) {
  //       request.fields[key] = value.toString(); // Ensure all values are strings
  //     });
  //
  //     // Add file to the request if provided
  //     if (file.existsSync()) {
  //       request.files.add(await http.MultipartFile.fromPath(
  //         'file', // The key for the file parameter
  //         file.path,
  //         filename: file.path.split('/').last,
  //       ));
  //     }
  //
  //     // Call the postApiResponseRequest method
  //     dynamic response = await _apiService.postApiResponseRequest(AppUrls.createLead, request, token);
  //     if (kDebugMode) {
  //       print("Create Lead Response: $response");
  //     }
  //
  //     // Parse the response into the model
  //     return CreateLeadResponseModel.fromJson(response);
  //   } catch (e) {
  //     print("Error in leadImport: $e");
  //     rethrow; // Propagate the error
  //   }
  // }

  //LEAD LIST------

//LIST
  Future<LeadListResponseModel> leadList(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadList, data);
      print("Lead List Response: ${jsonEncode(response)}");
      return LeadListResponseModel.fromJson(response);
    } catch (e) {
      debugPrint('Error in Proformas leadList: $e');
      rethrow;
    }
  }

  // Lead Delete

  Future<LeadDetailsResponseModel> leadDetailsApi(String leadId) async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadDetails(leadId));
      print("Lead Details Response: ${jsonEncode(response)}");
      return LeadDetailsResponseModel.fromJson(response);
    } catch (e) {
      debugPrint('Error in leadDetailsApi: $e');
      rethrow;
    }
  }

  // Lead Delete

  Future<LeadDeleteResponseModel> leadDeleteApi(String leadId) async {
    try {
      dynamic response =
          await _apiService.deleteApi(AppUrls.leadDelete(leadId));
      print("Lead Delete Response: ${jsonEncode(response)}");
      return LeadDeleteResponseModel.fromJson(response);
    } catch (e) {
      debugPrint('Error in leadDetailsApi: $e');
      rethrow;
    }
  }

  // Lead Proformas *****************************************

  Future<LeadProformasResModel> leadProformasApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadProformasList, data);
      print("Proformas Lead List Response: $response");
      return LeadProformasResModel.fromJson(response);
    } catch (e) {
      debugPrint('Error in Proformas leadList: $e'); // Log the error
      rethrow;
    }
  }

  //Lead List Column List-----------
  //
  // ---

  Future<List<LeadListColumnListResponseModel>> leadListColumnList() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadListColumnList);

      print("Lead Detail Column List Response: $response");

      if (response is List) {
        return LeadListColumnListResponseModel.fromJsonList(response);
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      rethrow;
    }
  }

  //Lead List Bulk Delete
  Future<LeadListBulkDeleteResponseModel> leadListBulkDelete(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadListBulkDelete, data);
      print("Lead  Detail Bulk Delete Response  $response");
      return response = LeadListBulkDeleteResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Lead List  Bulk Assign
  Future<LeadListBulkAssignResponseModel> leadListBulkAssign(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadListBulkAssign, data);
      print("Lead  Detail Bulk Assign Response  $response");
      return response = LeadListBulkAssignResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Lead customer_list Bulk un- assign
  Future<LeadListBulkUnAssignResponseModel> leadListBulkUnAssign(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadListBulkUnAssign, data);
      print("Lead  Detail Bulk Un- Assign Response  $response");
      return response = LeadListBulkUnAssignResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Lead Detail View---------

//List
  Future<LeadDetailResponseModel> leadDetailViewList() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadDetailView);
      print("Lead  Detail View Response $response");
      return response = LeadDetailResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

//Lead Activity Purpose

  //call TYpe--

  Future<List<LeadDetailCallTypeResponseModel>>
      leadDetailActivityCallType() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadDetailCallType);
      print("Lead  Detail View Response  call Type$response");
      return response = LeadDetailCallTypeResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

//Meeting Type
  Future<List<LeadDetailMeetingTypeResponseModel>>
      leadDetailMeetingType() async {
    try {
      dynamic response =
          await _apiService.getApi(AppUrls.leadDetailMeetingType);
      print("Lead  Detail View Response  Meeting Type$response");
      return response =
          LeadDetailMeetingTypeResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //task type
  Future<List<LeadDetailTaskTypeResponseModel>> leadDetailTaskType() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadDetailTaskType);
      print("Lead  Detail View Response  task Type$response");
      return response = LeadDetailTaskTypeResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Task Status
  Future<List<LeadDetailTaskStatusResponseModel>> leadDetailTaskStatus() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadDetailTaskStatus);
      print("Lead  Detail View Response  task Status $response");
      return response =
          LeadDetailTaskStatusResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Proposal
  Future<List<LeadDetailProposalResponseModel>> leadDetailProposal() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadDetailProposal);
      print("Lead  Detail View Response  Proposal Response $response");
      return response = LeadDetailProposalResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Attachment
  Future<List<LeadDetailAttachmentListResponseModel>>
      leadDetailAttachment() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadDetailAttachment);
      print("Lead  Detail View Response  Attachment Response $response");
      return response =
          LeadDetailAttachmentListResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  // Activity call Create
  Future<LeadDetailActivityCallCreateResponseModel>
      leadDetailActivityCallCreate(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.leadDetailActivityCallCreate, data);
      print("Lead  Detail View Response  Activity Call Create $response");
      return response =
          LeadDetailActivityCallCreateResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Activity Meeting Create
  Future<LeadDetailActivityCallCreateResponseModel>
      leadDetailActivityMeetingCreate(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.leadDetailActivityCallCreate, data);
      print("Lead  Detail View Response  Activity Meeting Create $response");
      return response =
          LeadDetailActivityCallCreateResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Lead Detail Assign History--

  Future<LeadAssignedToSalesResModel> leadAssignedToSales(
      dynamic data, String url) async {
    try {
      // Use the provided URL (already constructed with AppConfig in ViewModel)
      dynamic response = await _apiService.postApiResponse(url, data);
      return LeadAssignedToSalesResModel.fromJson(response);
    } catch (e) {
      // print("API Error in leadAssignedToSales: $e");
      rethrow;
    }
  }

  //Lead Action
  Future<List<LeadActionCreateResModel>> leadDetailActionLead(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadDetailActionLead, data);

      return (response as List)
          .map((e) => LeadActionCreateResModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // same things

  // Lead Assigned To (Sales)

  // Future<LeadAssignedToSalesResModel> leadAssignedToSales(dynamic data, String url) async {
  //   try {
  //     // // Print the complete request info for debugging
  //     // print("Requested Data Post: >>>>>>$data");
  //     // Make sure we're using the correct API endpoint
  //     dynamic response = await _apiService.postApiResponse(url, data);
  //     // print("Lead Detail Action Assigned create $response");
  //     return LeadAssignedToSalesResModel.fromJson(response);
  //   } catch (e) {
  //     // print("API Error in leadAssignedToSales: $e");
  //     rethrow;
  //   }
  // }

  // Lead Type To Sales

  Future<LeadDetailLeadTypeCreateResModel> leadTypeToSalesUpdate(
      dynamic data, String url) async {
    try {
      dynamic response = await _apiService.postApiResponse(url, data);
      return LeadDetailLeadTypeCreateResModel.fromJson(response);
    } catch (e) {
      // print("API Error in leaType: $e");
      rethrow;
    }
  }

  // Service

  Future<LeadDetailActionServiceResModel> leadDetailActionCreateService(
      dynamic data, String url) async {
    try {
      dynamic response = await _apiService.postApiResponse(url, data);
      return LeadDetailActionServiceResModel.fromJson(response);
    } catch (e) {
      // print("API Error in service update: $e");
      rethrow;
    }
  }

//  Lead Details Activities All

  Future<List<LeadDetailsActivitiesAllResModel>> leadDetailsActivitiesAll(
      String leadId) async {
    try {
      final response = await _apiService
          .getApi(AppUrls.leadDetailsActivitiesAll(leadId))
          .timeout(const Duration(seconds: 10));

      return response is List && response.isNotEmpty
          ? LeadDetailsActivitiesAllResModel.fromJsonList(response)
          : [];
    } catch (e) {
      rethrow;
    }
  }

//  Lead Details Activities Call

  Future<List<LeadDetailsActiReminderResModel>> leadDetailsActivitiesReminder(
      String leadId) async {
    try {
      final String url = "https://dev.whsuites.com/api/leads/$leadId/reminders";

      // Add timeout to prevent hanging
      dynamic response = await _apiService.getApi(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print("Repository: API call timed out");
          throw TimeoutException("API call timed out after 10 seconds");
        },
      );

      print("Repository: Raw API Response: $response");
      print("Repository: Response Type: ${response.runtimeType}");

      if (response is List) {
        print("Repository: Response is a list with ${response.length} items");
        return LeadDetailsActiReminderResModel.fromJsonList(response);
      } else {
        print(
            "Repository: Unexpected response format: ${response.runtimeType}");
        throw Exception("Unexpected response format: ${response.runtimeType}");
      }
    } catch (e, stackTrace) {
      print("Repository: Error fetching activities: $e");
      print("Repository: Stack trace: $stackTrace");
      rethrow;
    }
  }

// Lead Details Activities Call

  Future<List<LeadDetailsActiCallResModel>> leadDetailsActivitiesCall(
      String leadId) async {
    try {
      final String url = "https://dev.whsuites.com/api/leads/$leadId/calls";
      dynamic response = await _apiService.getApi(url).timeout(
        const Duration(seconds: 1),
        onTimeout: () {
          throw TimeoutException("API call timed out after 10 seconds");
        },
      );
      if (response is List) {
        return LeadDetailsActiCallResModel.fromJsonList(response);
      } else {
        throw Exception("Unexpected response format: ${response.runtimeType}");
      }
    } catch (e, stackTrace) {
      rethrow;
    }
  }

  // Lead Details Meeting
  Future<List<LeadDetailsActiMeetingResModel>> leadDetailsActivitiesMeeting(
      String leadId) async {
    try {
      final String url = "https://dev.whsuites.com/api/leads/$leadId/meetings";
      dynamic response = await _apiService.getApi(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print("Repository: API call timed out");
          throw TimeoutException("API call timed out after 10 seconds");
        },
      );

      print("Repository: Raw API Response: $response");
      print("Repository: Response Type: ${response.runtimeType}");

      if (response is List) {
        print("Repository: Response is a list with ${response.length} items");
        return LeadDetailsActiMeetingResModel.fromJsonList(response);
      } else {
        print(
            "Repository: Unexpected response format: ${response.runtimeType}");
        throw Exception("Unexpected response format: ${response.runtimeType}");
      }
    } catch (e, stackTrace) {
      print("Repository: Error fetching activities: $e");
      print("Repository: Stack trace: $stackTrace");
      rethrow;
    }
  }

  // Lead Details Notes

  Future<List<LeadDetailsActiNotesResModel>> leadDetailsActivitiesNotes(
      String leadId) async {
    try {
      final String url = "https://dev.whsuites.com/api/leads/$leadId/notes";
      dynamic response = await _apiService.getApi(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print("Repository: API call timed out");
          throw TimeoutException("API call timed out after 10 seconds");
        },
      );

      print("Repository: Raw API Response: $response");
      print("Repository: Response Type: ${response.runtimeType}");

      if (response is List) {
        print("Repository: Response is a list with ${response.length} items");
        return LeadDetailsActiNotesResModel.fromJsonList(response);
      } else {
        print(
            "Repository: Unexpected response format: ${response.runtimeType}");
        throw Exception("Unexpected response format: ${response.runtimeType}");
      }
    } catch (e, stackTrace) {
      print("Repository: Error fetching activities: $e");
      print("Repository: Stack trace: $stackTrace");
      rethrow;
    }
  }

  // Lead Details Notes Create
  Future<LeadDetailsNoteCreateResMode> leadDetailsActivitiesNotesCreate(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.globalUpdateSetting, data);

      if (kDebugMode) {
        print("Lead Note Create update response: $response");
      }

      // Handle the response as a single Map
      return LeadDetailsNoteCreateResMode.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print("Error in Lead Note Create: $e");
      }
      rethrow;
    }
  }

  // Lead Details Assigned
  Future<List<LeadDetailsActiAssignedResModel>> leadDetailsActivitiesAssigned(
      String leadId) async {
    try {
      final String url =
          "https://dev.whsuites.com/api/leads/$leadId/assigned-history";
      dynamic response = await _apiService.getApi(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print("Repository: API call timed out");
          throw TimeoutException("API call timed out after 10 seconds");
        },
      );

      print("Repository: Raw API Response: $response");
      print("Repository: Response Type: ${response.runtimeType}");

      if (response is List) {
        print("Repository: Response is a list with ${response.length} items");
        return LeadDetailsActiAssignedResModel.fromJsonList(response);
      } else {
        print(
            "Repository: Unexpected response format: ${response.runtimeType}");
        throw Exception("Unexpected response format: ${response.runtimeType}");
      }
    } catch (e, stackTrace) {
      print("Repository: Error fetching activities: $e");
      print("Repository: Stack trace: $stackTrace");
      rethrow;
    }
  }

  //Lead History
  Future<List<LeadDetailHistoryResponseModel>> leadDetailHistory(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadDetailHistory, data);
      print("Lead  Detail View Response  History $response");
      return response = LeadDetailHistoryResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Lead Detail Projection
  Future<LeadDetailProjectionResponseModel> leadDetailProjection(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadDetailProjection, data);
      print("Lead  Detail  Projection Create Response  $response");
      return response = LeadDetailProjectionResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //lead Detail Update Status
  Future<LeadDetailUpdateStatusResponseModel> leadDetailUpdateStatus(
      dynamic data, String leadId) async {
    try {
      dynamic response = await _apiService.patchApi(
          AppUrls.leadDetailUpdateStatus(leadId), data);
      print("Lead Detail update Status Response $response");
      return LeadDetailUpdateStatusResponseModel.fromJson(response);
    } catch (e) {
      print("Lead Detail Update Status Error $e");
      rethrow;
    }
  }

//  dead  reason
  Future<List<LeadDetailsDeadStatusReason>> leadDetailDeadReasonApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadDetailDeadReason);
      print("Lead  Detail  Dead  Response  $response");
      return response = LeadDetailsDeadStatusReason.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Currency
  Future<List<LeadDetailCurrencyResponseModel>> leadDetailCurrency() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadDetailCurrency);
      print("Lead  Detail  Currency  Response  $response");
      return response = LeadDetailCurrencyResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  // Generate Proforma

  Future<LeadDetailGenerateProformaResponseModel> leadDetailGenerateProforma(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadDetailProforma, data);
      print("Lead  Detail  Generate Proforma Response  $response");
      return response =
          LeadDetailGenerateProformaResponseModel.fromJson(response);
    } catch (e) {
      print("Lead Detail Generate performa Response$e");
      rethrow;
    }
  }

  //LEAD TYPE
  Future<List<LeadTypesResponseModel>> leadListLeadType() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadType);
      // print("Lead LeadType API Response: $response");
      if (response is List) {
        return LeadTypesResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a List from the API but received something else: ${response.runtimeType}");
      }
    } catch (e, stacktrace) {
      // print("Error occurred while fetching lead types: $e");
      // print("Stacktrace: $stacktrace");
      rethrow;
    }
  }

  // Update Lead
  Future<LeadTypeUpdateResModel> updateLeadTypeApi(
      String leadTypeId, Map<String, dynamic> data) async {
    try {
      final url = AppUrls.updateLeadType(leadTypeId);
      final response = await _apiService.patchApi(url, data);

      if (response is Map<String, dynamic>) {
        return LeadTypeUpdateResModel.fromJson(response);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print("Error updating leave type: $e");
      rethrow;
    }
  }

// update lead sub type
  // Update LEAVE TYPE

  Future<LeadSubtypeUpdateResModel> updateSubLeaveTypeApi(
      String leadSubTypeId, Map<String, dynamic> data) async {
    try {
      final url = AppUrls.updateSubLeadType(
          leadSubTypeId); // Construct the URL with the ID
      final response = await _apiService.patchApi(url, data);

      if (response is Map<String, dynamic>) {
        return LeadSubtypeUpdateResModel.fromJson(response);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print("Error updating leave type: $e");
      rethrow;
    }
  }

  //LEAD ASSIGN
  Future<List<LeadAssignResponseModel>> leadListLeadAssign(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadAssign, data);
      // print("lead add karo $response");
      return LeadAssignResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<GlobalSettingResModel?> globalSetting() async {
    try {
      final response = await _apiService.getApi(AppUrls.globalSetting);
      print('Global Setting Response: $response');
      return GlobalSettingResModel.fromJson(response);
    } catch (e) {
      print('Error fetching global settings: $e');
      rethrow;
    }
  }

  ///   Global Setting Update

// Update this in your repositories.dart file

  Future<List<GlobalSettingUpdateResModel>> globalSettingUpdate(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.globalUpdateSetting, data);

      if (kDebugMode) {
        print("Global setting update response: $response");
      }

      // Handle the response which might be either a Map or a List
      return GlobalSettingUpdateResModel.fromJsonList(response);
    } catch (e) {
      if (kDebugMode) {
        print("Error in globalSettingUpdate: $e");
      }
      rethrow;
    }
  }

  /// call details
  ///
  Future<CallDetailsResModel?> callDetails() async {
    try {
      final response = await _apiService.getApi(AppUrls.callDetails);
      print('vivek Call Details  Response: $response');
      return CallDetailsResModel.fromJson(response);
    } catch (e) {
      print('Error fetching vivek call details : $e');
      rethrow;
    }
  }

  Future<LeadListCountryCodeResponseModel> countryCodeApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadListPhoneCode);
      // print("Lead List Country code$response");
      return LeadListCountryCodeResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<StateFilterResponseModel>> stateFilter(String countryId) async {
    // Construct the URL with the country ID
    final url = "${AppUrls.stateName}/$countryId"; // Use the passed countryId
    print(
        "Fetching states for country ID: $countryId"); // Print the country ID being used

    dynamic response = await _apiService.getApi(url);

    if (response is List) {
      return response.map((e) => StateFilterResponseModel.fromJson(e)).toList();
    }

    throw Exception("Unexpected response format");
  }

  Future<ReportActivityResModel> leadActivityList(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadActivityList, data);
      return response = ReportActivityResModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

// report lead unique meeting

  Future<ReportUniqueResModel> leadUniqueMeetingList(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadUniqueList, data);
      return response = ReportUniqueResModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //LEAD TYPE

  Future<List<LeadActivityLeadTypeResponseModel>> leadActivityLeadType() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.leadActivityLeadType,
      );
      print("Lead activity Lead Type Response data$response");
      return response =
          LeadActivityLeadTypeResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //DAILY SALES REPORTS---------

  Future<DailySalesReportsResponseModel> dailySalesReportList(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.leadActivityDailySaleReports, data);
      print("Lead activity Daily Sales Reports$response");
      return response = DailySalesReportsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //NO ACTIVITIES
  Future<LeadNoActivitiesResponseModel> leadNoActivities(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.leadActivityNoActivities, data);
      print("Lead activity No Activities $response");
      return response = LeadNoActivitiesResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //LEAD REPORTS

  Future<LeadReportsResponseModel> leadActivityLeadReports(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.leadActivityLeadReports, data);
      print("Lead activity Lead Reports $response");
      return response = LeadReportsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //TEAM LEADS

  Future<List<dynamic>> leadTeamLead(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.leadActivityTeamLeads, data);
      print("Lead Team Leads $response");
      return response; // Return raw JSON response
    } catch (e) {
      rethrow;
    }
  }

  //LEAD SETTING
  //// Column Setting
  Future<List<LeadSettingResponseModel>> leadColumnSettingListApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadSetting);
      // print("Lead Column Setting List Response$response");
      if (response is List) {
        return LeadSettingResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a Column from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  //// Lead Column Setting Edit Update

  Future<LeadColumnSettingEditUpdateResModel> leadColumnSettingEditListApi(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.leadColumnSettingEdit, data);
      print("Lead  Detail GenerateColumn  Edit Response  $response");
      return response = LeadColumnSettingEditUpdateResModel.fromJson(response);
    } catch (e) {
      print("Lead  Detail GenerateColumn  Edit Response$e");
      rethrow;
    }
  }

  // Lead Column Setting Lead Label
  Future<List<LeadSettingCustomLeadLabel>> columnSettingLeadLabel() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadColumnLabel);
      print("Field SettingList Response: $response");
      if (response is List) {
        return LeadSettingCustomLeadLabel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  // setting USER PROFILE
  Future<UserModel> settingUserProfile() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.settingUserProfile);
      print("Setting User Profile Response: $response");
      if (response != null) {
        // Convert the response to a UserModel object
        return UserModel.fromJson(response);
      } else {
        throw Exception('Null response from API');
      }
    } catch (e) {
      print("Error catch$e");
      rethrow;
    }
  }

  //Field Setting
  Future<List<FieldSettingResponseModel>> fieldSettingListApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.fieldSetting);
      print("Field SettingList Response$response");
      if (response is List) {
        return FieldSettingResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  //Field Setting Update Edit

  Future<LeadFieldSettingEditUpdateResModel> leadFieldSettingEditListApi(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadFieldSettingEdit, data);
      print("Lead  Field  Edit Response  $response");
      return response = LeadFieldSettingEditUpdateResModel.fromJson(response);
    } catch (e) {
      print("Lead Fieldn  Edit Response$e");
      rethrow;
    }
  }

  //Setting Custom Field
  Future<List<SettingCustomFieldsResponseModel>> settingCustomFields() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.settingCustomFields);
      print("Setting Custom Field Response$response");
      if (response is List) {
        return SettingCustomFieldsResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  //Setting Roles

  Future<List<SettingRolesResponseModel>> settingRoleApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.settingRoles);
      print("Setting Roles Response$response");
      if (response is List) {
        return SettingRolesResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RolesResponseModel>> rolesApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.rolesApi);
      // Assuming response is a List
      return (response as List)
          .map((role) => RolesResponseModel.fromJson(role))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

//LEAD MASTER

  //SOURCE
  Future<List<LeadMasterSourceResponseModel>> leadMasterSource() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadMasterSource);
      print("Lead Master Source Response$response");
      if (response is List) {
        return LeadMasterSourceResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Lead Source  List
  Future<List<LeadSourceListResModel>> leadSourceListApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadSource);
      print("Lead Source Response$response");
      if (response is List) {
        return LeadSourceListResModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a Source from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Lead Source Details
  Future<List<LeadSourceStatusListResModel>> leadSourceListStatusApi(
      String sourceId) async {
    try {
      dynamic response =
          await _apiService.getApi(AppUrls.leadSourceStatus(sourceId));
      // print("Lead Source Status Response: $response");
      // print("Response Type: ${response.runtimeType}");

      return [
        LeadSourceStatusListResModel.fromJson(response as Map<String, dynamic>)
      ];
    } catch (e) {
      // print("Error in leadSourceListStatusApi: $e");
      rethrow;
    }
  }

// Lead Source update

  Future<LeadSourceCreateResModel> leadSourceUpdateApi(
      dynamic data, String sourceId) async {
    try {
      dynamic response =
          await _apiService.patchApi(AppUrls.leadSourceCreate(sourceId), data);
      print('Lead Source update API response: $response');
      return LeadSourceCreateResModel.fromJson(response);
    } catch (e) {
      print('Lead Source error: $e');
      rethrow;
    }
  }

  // Lead Source Create
  Future<LeadSourceCreateResModel> leadSourceCreateApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.customerSource, data);
      print("Lead Source create Response: $response");
      return LeadSourceCreateResModel.fromJson(response);
    } catch (e) {
      debugPrint('Error in Lead Source create: $e'); // Log the error
      rethrow;
    }
  }

  // Lead Setting Dead Reason List
  Future<List<LeadSettingDeadReasonList>> leadDeadReasonListApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadDeadReason);
      print("Lead dead reason Response$response");
      if (response is List) {
        return LeadSettingDeadReasonList.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a Source from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

// Lead Setting  Dead Reason Create

  Future<LeadSettingDeadCreateResModel> leadDeadCreateApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadDetailDeadReason, data);
      print("Lead Dead create Response: $response");
      return LeadSettingDeadCreateResModel.fromJson(response);
    } catch (e) {
      debugPrint('Error in Lead Dead create: $e'); // Log the error
      rethrow;
    }
  }

// Lead Setting Dead Edit

  Future<LeadSettingDeadUpdateResModel> leadDeadUpdateApi(
      dynamic data, String deadReasonId) async {
    try {
      dynamic response = await _apiService.patchApi(
          AppUrls.deleteLeadDeadReason(deadReasonId), data);
      print('Lead Dead update API response: $response');
      return LeadSettingDeadUpdateResModel.fromJson(response);
    } catch (e) {
      print('Lead Dead error: $e');
      rethrow;
    }
  }

  // Lead Setting Delete
  Future<LeadSettingDeadReasonListDelete> deleteLeadDeadReasonApi(
      String sourceId) async {
    try {
      dynamic response =
          await _apiService.deleteApi(AppUrls.deleteLeadDeadReason(sourceId));
      print("delete dead reason $response");
      return LeadSettingDeadReasonListDelete.fromJson(response);
    } catch (e) {
      print("delete dead reason Error $e");
      rethrow;
    }
  }

  //TYPE
  Future<List<LeadMasterTypeResponseModel>> leadMasterType() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadMasterType);
      print("Lead Master Type Response: $response");

      // Check if response is a List
      if (response is List) {
        print("Response is List Type");
        // Ensure the list contains Map<String, dynamic> (raw JSON), not pre-parsed objects
        return LeadMasterTypeResponseModel.fromJsonList(
            response.cast<Map<String, dynamic>>());
      } else {
        throw Exception("Expected a list from the API but got something else.");
      }
    } catch (e) {
      print("Error in leadMasterType: $e");
      rethrow;
    }
  }

  //CUSTOMER List----------

  // create
  Future<dynamic> customersCreateApi(Map<String, dynamic> formData) async {
    try {
      final response = await _apiService.postApiResponseRequest(
        AppUrls.customerListDetailViewList,
        formData,
      );
      return response;
    } catch (e) {
      print('Customer create API error: $e');
      rethrow;
    }
  }

  // LIST----
  Future<CustomersListResponseModel> customersListApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.customersList, data);
      // print("Raw Customer List Api Response: $response");
      return CustomersListResponseModel.fromJson(response);
    } catch (e) {
      // print("Error in customersListApi: $e");
      rethrow;
    }
  }

  //Customer List Customer Detail View----------

  //CUSTOMER Detail customer_list

  // Future<CustomerListDetailViewListResponseModel> customersListCustomerDetailViewList(String id) async {
  //   try {
  //     dynamic response = await _apiService.getApi("${AppUrls.baseurl}api/customers/$id");
  //     print("Customer List Detail View List Api $response");
  //     return CustomerListDetailViewListResponseModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<CustomerListDetailViewListResponseModel>
      customersListCustomerDetailViewList(String id) async {
    try {
      dynamic response =
          await _apiService.getApi("${AppUrls.customerListDetailViewList}/$id");
      print("Customer List Detail View List Api $response");
      if (response is Map<String, dynamic>) {
        return CustomerListDetailViewListResponseModel.fromJson(response);
      } else {
        print(
            'Unexpected response type: ${response.runtimeType}, value: $response');
        throw Exception('Invalid API response format');
      }
    } catch (e) {
      print('Error in customersListCustomerDetailViewList: $e');
      rethrow;
    }
  }

  // customer merge
  Future<Map<String, dynamic>> customerToCustomerMerge(CustomerToCustomerMergeReqModel reqModel) async {
    try {
      if (kDebugMode) {
        print('🔄 Starting customer merge...');
        print('📤 Request payload: ${reqModel.toJson()}');
      }

      final response = await _apiService.putApi(AppUrls.customerMerge, reqModel);

      if (kDebugMode) {
        print('📥 Raw API response: $response');
        print('🔍 Status code: ${response['statusCode']}');
        print('📊 Response body: ${response['body']}');
      }

      // Validate response structure
      if (response['body'] == null) {
        throw Exception('Empty response body received');
      }

      final model = CustomerToCustomerMergeResModel.fromJson(response['body']);
      final statusCode = response['statusCode'] ?? 200;

      if (kDebugMode) {
        print('✅ Successfully parsed response model');
        print('📋 Model data: ${model.toJson()}');
      }

      return {
        'model': model,
        'statusCode': statusCode,
      };
    } catch (e) {
      if (kDebugMode) {
        print('❌ Repository error in customerToCustomerMerge: $e');
        print('📝 Request model that failed: ${reqModel.toJson()}');
      }
      rethrow;
    }
  }


// Customer Activities All

  Future<List<CustomerActivityListResponseModel>> customerDetailsActivitiesAll(
      String id) async {
    final String url = AppUrls.customerDetailsActivitiesAll(id);
    try {
      final response = await _apiService.getApi(url);
      if (response is List) {
        final activities =
            CustomerActivityListResponseModel.fromJsonList(response);
        return activities;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  // customer activities call
  Future<List<CustomerDetailsActivitiesCallResModel>>
      customerDetailsActivitiesCall(String id) async {
    final String url = AppUrls.customerDetailsActivitiesCalls(id);
    try {
      final response = await _apiService.getApi(url);
      if (response is List) {
        final call =
            CustomerDetailsActivitiesCallResModel.fromJsonList(response);
        return call;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  // customer details activities meeting

  Future<List<CustomerDetailsActivitiesMeetingResModel>>
      customerDetailsActivitiesMeeting(String id) async {
    final String url = AppUrls.customerDetailsActivitiesMeeting(id);
    try {
      final response = await _apiService.getApi(url);
      if (response is List) {
        final meeting =
            CustomerDetailsActivitiesMeetingResModel.fromJsonList(response);
        return meeting;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  // customer details activities  visit only

  Future<List<LeadDetailsActiVisitOnlyResModel>>
      customerDetailsActivitiesVisitOnly(String id) async {
    final String url = AppUrls.customerDetailsActivitiesVisitOnly(id);
    try {
      final response = await _apiService.getApi(url);
      if (response is List) {
        final visit = LeadDetailsActiVisitOnlyResModel.fromJsonList(response);
        return visit;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  // customer details activities  reminders

  Future<List<CustomerDetailsActiReminderResModel>>
      customerDetailsActivitiesReminder(String id) async {
    final String url = AppUrls.customerDetailsActivitiesReminder(id);
    try {
      final response = await _apiService.getApi(url);

      if (response is List) {
        final reminders =
            CustomerDetailsActiReminderResModel.fromJsonList(response);

        return reminders;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  // customer details activities  notes

  Future<List<CustomerDetailsActiNotesResModel>> customerDetailsActivitiesNotes(
      String id) async {
    final String url = AppUrls.customerDetailsActivitiesNotes(id);
    try {
      final response = await _apiService.getApi(url);

      if (response is List) {
        final notes = CustomerDetailsActiNotesResModel.fromJsonList(response);

        return notes;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  // customer details activities assigned history

  Future<List<CustomerDetailsActiAssignedResModel>>
      customerDetailsActivitiesAssigned(String id) async {
    final String url = AppUrls.customerDetailsActivitiesAssigned(id);
    try {
      final response = await _apiService.getApi(url);

      if (response is List) {
        final assigned =
            CustomerDetailsActiAssignedResModel.fromJsonList(response);

        return assigned;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  // customer details activities service

  Future<List<CustomerDetailsActiServicesResModel>>
      customerDetailsActivitiesServices(String id) async {
    final String url = AppUrls.customerDetailsActivitiesServices(id);
    try {
      final response = await _apiService.getApi(url);
      if (response is List) {
        final service =
            CustomerDetailsActiServicesResModel.fromJsonList(response);
        return service;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  // customer details serviced area
  Future<List<CustomerDetailsServiceAreaResModel>> customerDetailsServiceArea(
      String id) async {
    final String url = AppUrls.customerDetailsServicesArea(id);
    try {
      final response = await _apiService.getApi(url);
      if (response is List) {
        final service_area =
            CustomerDetailsServiceAreaResModel.fromJsonList(response);
        return service_area;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  //  customer details payment

  Future<List<CustomerDetailsPaymentResModel>> customerDetailsPayments(
      String id) async {
    final String url = AppUrls.customerDetailsPayments(id);
    try {
      final response = await _apiService.getApi(url);
      if (response is List) {
        final payments = CustomerDetailsPaymentResModel.fromJsonList(response);
        return payments;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  //  customer details projects

  Future<List<CustomerDetailsProjectsResModel>> customerDetailsProject(
      String id) async {
    final String url = AppUrls.customerDetailsProjects(id);
    try {
      final response = await _apiService.getApi(url);
      if (response is List) {
        final project = CustomerDetailsProjectsResModel.fromJsonList(response);
        return project;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  //  customer details Lead

  Future<List<CustomerDetailsLeadsResModel>> customerDetailViewLead(
      String id) async {
    final String url = AppUrls.customerDetailsLeads(id);
    try {
      final response = await _apiService.getApi(url);
      if (response is List) {
        final project = CustomerDetailsLeadsResModel.fromJsonList(response);
        return project;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  //  customer details  orders

  Future<List<CustomerDetailsOrdersResModel>> customerDetailViewOrders(
      String id) async {
    final String url = AppUrls.customerDetailsOrders(id);
    try {
      final response = await _apiService.getApi(url);
      if (response is List) {
        final project = CustomerDetailsOrdersResModel.fromJsonList(response);
        return project;
      }
      throw Exception(
          "Unexpected response format: Expected List but got ${response.runtimeType}");
    } catch (e) {
      rethrow;
    }
  }

  //  customer details   credit - debit notes'

  // Future<List<CustomerViewCreditDebitResponseModel>> customerDetailViewCreDeb(String id) async {
  //   final String url = AppUrls.customerDetailsLeads(id);
  //   try {
  //     final response = await _apiService.getApi(url);
  //     if (response is List) {
  //       final project = CustomerViewCreditDebitResponseModel.fromJsonList(response);
  //       return project;
  //     }
  //     throw Exception("Unexpected response format: Expected List but got ${response.runtimeType}");
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //  customer details  attachments

  Future<List<CustomerDetailsAttachments>> customerDetailsAttachments(
      String id) async {
    final String url = AppUrls.customerDetailsAttachments(id);
    try {
      final response = await _apiService.getApi(url);
      if (response is List) {
        final attachments = CustomerDetailsAttachments.fromJsonList(response);
        return attachments;
      }
      throw Exception(
          "Unexpected response format : Expected List but got ${response.runtimeType} ");
    } catch (e) {
      rethrow;
    }
  }

  //  customer upload   attachments

  Future<List<CustomerDetailsAttachmentsUploadResModel>>
      uploadCustomerAttachment(
    String customerId,
    CustomerDetailsAttachmentsUploadReqModel requestModel,
    Uint8List fileBytes,
    String fileName,
  ) async {
    final String url = AppUrls.customerDetailsUploadAttachments(customerId);
    print('Hitting API with URL: $url'); // Log the URL
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['type'] = requestModel.type;
      request.fields['type_name'] = requestModel.typeName;
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          fileBytes,
          filename: fileName,
        ),
      );

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      if (responseBody.statusCode == 200) {
        final responseData = jsonDecode(responseBody.body);
        if (responseData is List) {
          return CustomerDetailsAttachmentsUploadResModel.fromJsonList(
              responseData);
        }
        throw Exception(
            'Unexpected response format: Expected List but got ${responseData.runtimeType}');
      } else {
        throw Exception(
            'Failed to upload attachment: ${responseBody.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<CustomerDetailsLeadsResModel> customerDetailViewLead() async {
  //   try {
  //     dynamic response = await _apiService.getApi(
  //       AppUrls.customerDetailViewLead,
  //     );
  //     print("Customer List Detail View Lead $response");
  //     return response = CustomerDetailsLeadsResModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Customer to Customer List Merge Customer List

  Future<List<CustToCustMergCustListResponseModel>> CustToCustMergCustListApi({
    required String id,
    String searchQuery = '',
    int skip = 0,
  }) async {
    try {
      // Construct the API URL with search query and skip parameters
      String apiUrl =
          '${AppUrls.custToCusMerCustomerList}?search=$searchQuery&skip=$id';
      // if (id.isNotEmpty) {
      //   apiUrl += '&id=$id'; // Append id if provided
      // }

      // print('Calling API: $apiUrl');

      // Make API call
      dynamic response = await _apiService.getApi(apiUrl);
      // print("Customer to Customer Merge List API Response: $response");
      // print("Response Type Code: ${response.runtimeType}");

      // Check if response is null
      if (response == null) {
        // print('API returned null response');
        throw Exception('API returned null response');
      }

      // Check if response is a List
      if (response is List) {
        // Handle empty list
        if (response.isEmpty) {
          // print('API returned empty list');
          return [];
        }

        try {
          return response.map((item) {
            if (item is Map<String, dynamic>) {
              return CustToCustMergCustListResponseModel.fromJson(item);
            } else {
              // print('Invalid item type in response: ${item.runtimeType}');
              throw Exception(
                  'Invalid item type in response array: ${item.runtimeType}');
            }
          }).toList();
        } catch (mappingError) {
          // print('Error mapping response items: $mappingError');
          throw Exception('Failed to parse response data: $mappingError');
        }
      }
      // Check if response is a Map with a 'data' field
      else if (response is Map<String, dynamic> &&
          response.containsKey('data')) {
        if (response['data'] is List) {
          // Cast the 'data' field to a List and process it
          List<dynamic> dataList = response['data'] as List<dynamic>;
          if (dataList.isEmpty) {
            print('API returned empty data list');
            return [];
          }

          try {
            return dataList.map((item) {
              if (item is Map<String, dynamic>) {
                return CustToCustMergCustListResponseModel.fromJson(item);
              } else {
                // print('Invalid item type in data array: ${item.runtimeType}');
                throw Exception(
                    'Invalid item type in data array: ${item.runtimeType}');
              }
            }).toList();
          } catch (mappingError) {
            // print('Error mapping data items: $mappingError');
            throw Exception('Failed to parse data array: $mappingError');
          }
        } else {
          // print('Data field is not a List: ${response['data'].runtimeType}');
          throw Exception(
              'Invalid data field format: Expected a List but got ${response['data'].runtimeType}');
        }
      }
      // Handle unexpected response types
      else {
        // print('Unexpected response type: ${response.runtimeType}, value: $response');
        throw Exception(
            'Invalid API response format: Expected a List or Map with data field but got ${response.runtimeType}');
      }
    } catch (e) {
      // print('Error in CustToCustMergCustListApi: $e');
      rethrow;
    }
  }

  /// proforma
  ///
  Future<CustomerProformasResModel> customerProformasApi(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerProformasList, data);
      // print("Proformas Customer List Response: $response");
      return CustomerProformasResModel.fromJson(response);
    } catch (e) {
      // debugPrint('Error in Proformas leadList: $e'); // Log the error
      rethrow;
    }
  }




  Future<CustomerPerformaPdfResModel> fetchInvoicePdf(String invoiceId) async {
    try {
      final response = await http.get(
        Uri.parse('https://dev.whsuites.com/api/performa/$invoiceId/performa-invoice'),
        headers: {'Authorization': 'Bearer ${await _apiService.postApiResponseToken()}'},
      );
      debugPrint('Raw API response status: ${response.statusCode}');
      debugPrint('Raw API response headers: ${response.headers}');

      if (response.statusCode == 200) {
        // Check if response is JSON or raw bytes
        final contentType = response.headers['content-type']?.toLowerCase();
        if (contentType?.contains('application/json') == true) {
          final json = jsonDecode(response.body);
          debugPrint('JSON response: $json');
          return CustomerPerformaPdfResModel.fromJson(json);
        } else if (contentType?.contains('application/pdf') == true) {
          final bytes = response.bodyBytes;
          final dir = await getTemporaryDirectory();
          final file = File('${dir.path}/invoice_$invoiceId.pdf');
          await file.writeAsBytes(bytes);
          return CustomerPerformaPdfResModel(
            status: 'success',
            contentType: 'application/pdf',
            pdfData: null,
            pdfUrl: null,
            file: file,
          );
        } else {
          throw Exception('Unsupported content type: $contentType');
        }
      } else {
        throw Exception('API failed with status ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      debugPrint('FetchInvoicePdf error: $e');
      throw Exception('Failed to fetch invoice PDF: $e');
    }
  }

  Future<File> savePdfFromBase64(String base64, String fileName) async {
    try {
      final bytes = base64Decode(base64);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      debugPrint('SavePdfFromBase64 error: $e');
      throw Exception('Failed to save PDF from Base64: $e');
    }
  }

  Future<File> downloadPdfFromUrl(String url, String fileName) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/$fileName');
        await file.writeAsBytes(bytes);
        return file;
      } else {
        throw Exception('Failed to download PDF from URL: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('DownloadPdfFromUrl error: $e');
      throw Exception('Failed to download PDF from URL: $e');
    }
  }



// Updated repository method to handle lead ID in URL
  Future<CustomerAssignedResModel> customerCreateAssigned({
    required String leadId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final url = '${AppUrls.customerAssigned}/$leadId';
      final response = await _apiService.postApiResponse(url, data);
      return CustomerAssignedResModel.fromJson(response);
    } catch (e) {
      // debugPrint('Error assigning customers: $e');
      rethrow;
    }
  }

  Future<CustomerCredentialsResModel> customerCredentialsApi(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerCredentialList, data);
      print("Proformas Customer  credential List Response: $response");
      return CustomerCredentialsResModel.fromJson(response);
    } catch (e) {
      debugPrint('Error in credential role : $e'); // Log the error
      rethrow;
    }
  }

  //Service Categories

  Future<List<CustomerListServiceCategoriesResponseModel>>
      customerDetailViewServiceCategories() async {
    try {
      dynamic response =
          await _apiService.getApi(AppUrls.customerListServiceCategories);
      print("Customer List Detail View Service Categories $response");
      return response =
          CustomerListServiceCategoriesResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Company List

  Future<List<CustomerDetailViewCompanyListResponseModel>>
      customerDetailViewCompanyList(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerDetailViewCompanyList, data);
      print("Customer List Detail View Company List $response");
      return response =
          CustomerDetailViewCompanyListResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Activities

  Future<CustomerDetailViewActivitiesResponseModel>
      customerDetailViewActivities(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerDetailViewActivities, data);
      print("Customer List Detail View Activities $response");
      return response =
          CustomerDetailViewActivitiesResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Assigned History

  Future<List<CustomerDetailViewAssignedHistoryResponseModel>>
      customerDetailViewAssignHistory() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.customerDetailViewServices,
      );
      print("Customer List Detail View Assign History $response");
      return response =
          CustomerDetailViewAssignedHistoryResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Services
  Future<List<CustomerDetailViewServicesResponseModel>>
      customerDetailViewServices() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.customerDetailViewServices,
      );
      print("Customer List Detail View Services $response");
      return response =
          CustomerDetailViewServicesResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Payments
  Future<List<CustomerDetailsPaymentResModel>>
      customerDetailViewPaymentList() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.customerDetailViewPaymentList,
      );
      print("Customer List Detail View payments $response");
      return response = CustomerDetailsPaymentResModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Activity Purpose call Type
  Future<List<CustomerDetailCallTypeResponseModel>>
      customerDetailViewActivityCallType() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.customerDetailViewCallType,
      );
      print("Customer List Detail View calling Type $response");
      return response =
          CustomerDetailCallTypeResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

//Create Company

  Future<List<CustomerViewCreateCompanyResponseModel>>
      customerDetailViewCreateCompany(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerDetailCreateCompany, data);
      print("Customer List Detail View Create Company $response");
      return response =
          CustomerViewCreateCompanyResponseModel.fromJsonList(response);
    } catch (e) {
      print("Create Company Error $e");

      rethrow;
    }
  }

  //Update Company Api

  Future<CustomerDetailUpdateResponseModel> customerDetailViewUpdateCompany(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.patchApi(AppUrls.customerDetailUpdateCompany, data);
      print("Customer Detail update Company api$response");
      return response = CustomerDetailUpdateResponseModel.fromJson(response);
    } catch (e) {
      print("Customer Detail Update company $e");
      rethrow;
    }
  }

  //Customer TYPE
  Future<List<CustomerTypeResponseModel>> customerType() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.customerType);
      // print("Customer TYpe Response$response");
      if (response is List) {
        return CustomerTypeResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  //CUSTOMER SOURCE
  Future<List<CustomerSourceResponseModel>> customerSourceApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.customerSource);
      print("Customer Source Response$response");
      if (response is List) {
        return CustomerSourceResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  //ASSIGN SEARCH

  Future<List<CustomerAssignResponseModel>> customerAssignSearch(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerListSearchAssign, data);
      print("Customer Assign Search$response");
      if (response is List) {
        return CustomerAssignResponseModel.fromJsonList(response);
      } else {
        throw Exception("Expected customer assigned  something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  //Customer DIVISION

  Future<List<CustomerDivisionResponseModel>> customerDivision() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.customerListDivision);
      print("Customer Division Api Search$response");
      if (response is List) {
        return CustomerDivisionResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  //CUSTOMER ACTIVITY ----------

  //LIST
  Future<CustomerActivityListResponseModel> customerActivityListApi(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.customerActivityList, data);
      if (kDebugMode) {
        print("Response Customer Activity List data $response");
      }
      return CustomerActivityListResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //DAILY REPORTS
  Future<CustomerActivityReportResponseModel> customerActivityReports(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerActivityReports, data);
      if (kDebugMode) {
        print("Response Customer Activity Reports List$response");
      }
      return CustomerActivityReportResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //CUSTOMER NO ACTIVITY

  Future<CustomerActivityNoActivityResponseModel> customerNoActivitiesList(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerActivityNoActivities, data);
      if (kDebugMode) {
        print("Response Customer No Activities List$response");
      }
      return CustomerActivityNoActivityResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //CUSTOMER REPORTS
  Future<ActivityCustomerReportResponseModel> customerReports(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerActivityCustomerReports, data);
      if (kDebugMode) {
        print("Response Customer Reports $response");
      }
      return ActivityCustomerReportResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //CUSTOMER STATUS REPORT
  Future<CustomerActivityStatusReportsResponseModel>
      customerActivityStatusReport(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerActivityStatusReport, data);
      if (kDebugMode) {
        print("Response Customer Status Reports $response");
      }
      return CustomerActivityStatusReportsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //CUSTOMER---------------------
  // PAYMENT REMINDER------------

  Future<CustomerPaymentsReminderResponseModel> customerPaymentReminderList(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customersPaymentReminder, data);
      if (kDebugMode) {
        print("Response Customer payments Reminders $response");
      }
      return CustomerPaymentsReminderResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //CUSTOMER COMPANIES

  Future<CustomerCompaniesResponseModel> customerCompaniesList(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.customerCompanies, data);
      if (kDebugMode) {
        print("Response Customer Companies List $response");
      }
      return CustomerCompaniesResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //SERVICES-----------

  Future<CustomerServiceResponseModel> customerServices(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.customerServices, data);
      if (kDebugMode) {
        print("Response Customer Services$response");
      }
      return CustomerServiceResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //SERVICES AREA--

  //STATE
  Future<List<CustomerServiceAreaResponseModel>> safeAreaState(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.safeAreaState, data);
      if (kDebugMode) {
        print("Response Customer SafeArea State$response");
      }
      return CustomerServiceAreaResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

//CITY
  Future<List<CustomerServiceAreaCityResponseModel>> safeAreaCity(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.safeAreaCity, data);
      if (kDebugMode) {
        print("Response Customer SafeArea City$response");
      }
      return CustomerServiceAreaCityResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //PINCODE
  Future<List<CustomerServiceAreaPinCodeResponseModel>> safeAreaPincode(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.safeAreaPincode, data);
      if (kDebugMode) {
        print("Response Customer SafeArea Pincode $response");
      }
      return CustomerServiceAreaPinCodeResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //PRODUCT
  Future<List<CustomerServiceAreaProductResponseModel>> safeAreaProduct(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.safeAreaProduct, data);
      if (kDebugMode) {
        print("Response Customer SafeArea Product $response");
      }
      return CustomerServiceAreaProductResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //SELECT COMPANY
  Future<CustomerCompaniesResponseModel> serviceAreaSelectCompany(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.customerCompanies, data);
      if (kDebugMode) {
        print("Response Customer Safe Area Select Company $response");
      }
      return CustomerCompaniesResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //ALLOT PRODUCT

  Future<CustomerAllotProductResponseModel> serviceAreaAllotProduct(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.safeAreaAllotProduct, data);
      if (kDebugMode) {
        print("Response Customer Safe Area Allot Product $response");
      }
      return CustomerAllotProductResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //ORDER PRODUCT
  Future<CustomerOrderProductResponseModel> customerOrderProduct(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderProductList, data);
      if (kDebugMode) {
        print("Response Customer Order Products $response");
      }
      return CustomerOrderProductResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //ORDER PRODUCT SEARCH
  Future<List<CustomerOrderProductSearchResponseModel>>
      customerOrderProductSearch() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.orderProductSearch);
      if (kDebugMode) {
        print("Response Customer Order Product Search$response");
      }
      return CustomerOrderProductSearchResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //ORDER PRODUCT SERVICE
  //dev url
  Future<CustomerOrderProductServiceResponseModel> customerOrderProductService(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderProductService, data);
      if (kDebugMode) {
        print("Response Customer Order Product Services$response");
      }
      return CustomerOrderProductServiceResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Order PRODUCT QUIT

  Future<CustomerOrderProductServiceResponseModel> customerOrderProductQuit(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderProductQuit, data);
      if (kDebugMode) {
        print("Response Customer Order Product Quits$response");
      }
      return CustomerOrderProductServiceResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //ORDER PRODUCT RENEW

  Future<CustomerOrderProductRenewResponseModel> customerOrderProductRenew(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderProductRenew, data);
      if (kDebugMode) {
        print("Response Customer Order Product Renew $response");
      }
      return CustomerOrderProductRenewResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //CUSTOMER  ORDERLESS SERVICES------

  Future<CustomerOrderlessServiceResponseModel> customerOrderlessServicesList(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.orderlessServicesList, data);
      if (kDebugMode) {
        print("API Calling orderless Services ");
        print("Response Customer Orderless Services customer_list $response");
      }
      return CustomerOrderlessServiceResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //ORDERLESS SERVICE CREATE
  Future<CustomerOrderlessServiceCreateResponseModel>
      customerOrderlessServicesCreate(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.orderlessServiceCreate, data);
      if (kDebugMode) {
        print("Response Customer Orderless Services Create $response");
      }
      return CustomerOrderlessServiceCreateResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

//ORDERLESS Service QUIT

  Future<CustomerOrderlessServiceQuitResponseModel>
      customerOrderlessServicesQuit(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderlessServiceQuit, data);
      if (kDebugMode) {
        print("Response Customer Orderless Services Quit $response");
      }
      return CustomerOrderlessServiceQuitResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //ORDERLESS SERVICE RENEW

  Future<CustomerOrderlessServiceRenewResponseModel>
      customerOrderlessServicesRenew(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.orderlessServiceRenew, data);
      if (kDebugMode) {
        print("Customer Orderless Services  Renew Api hit SuccessFully ");
        print("Response Customer Orderless Services Renew $response");
      }
      return CustomerOrderlessServiceRenewResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Customer Trash-------
  //List
  Future<CustomerTrashResponseModel> customersTrashApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.customersTrashList, data);
      print("Customer Trash List Api Response $response ");
      return response = CustomerTrashResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //ACTIVATION LIST
  Future<CustomerActivationListResponseModel> customerActivationList(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customersActivationList, data);
      print("Customer Activation List  $response ");
      return response = CustomerActivationListResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Customer Master--------
  //COMPANY CREDENTIAL

  Future<List<CustomerMasterCompanyCredentialResponseModel>>
      customerMasterCompanyCredential() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.customerMasterCompanyCredential,
      );
      print("Customer Activation Response List  $response ");
      return response =
          CustomerMasterCompanyCredentialResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  // COMPANY CREDENTIAL CREATE

  Future<CustomerMasterCompanyCredentialResponseModel>
      customerMasterCompanyCredentialCreate(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerMasterCompanyCredentialCreate, data);
      // print("Customer Master Company Credential Response Create  $response ");
      return response =
          CustomerMasterCompanyCredentialResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // COMPANY CREDENTIAL Update
  Future<CompanyCredentialUpdateResponseModel>
      customerMasterCompanyCredentialUpdate(dynamic data) async {
    try {
      dynamic response = await _apiService.patchApi(
          AppUrls.customerMasterCompanyCredentialUpdate, data);
      // print("Customer Master Company Credential  Update Response $response ");
      return response = CompanyCredentialUpdateResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //CUSTOMER TYPES

  Future<List<CustomerMasterCustomerTypeResponseModel>>
      customerMasterCustomerType() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.customerMasterCustomerType,
      );
      // print("Customer Master Customer Type Response  $response ");
      return response =
          CustomerMasterCustomerTypeResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //CUSTOMER TYPES Create
  Future<CustomerTypeCreateResponseModel> customerMasterCustomerTypeCreate(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.customerTypeCreate, data);
      // print("Customer Master Customer Type  Created Response  $response ");
      return response = CustomerTypeCreateResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //CUSTOMER TYPES UPDATE
  Future<CustomerTypeUpdateResponseModel> customerMasterCustomerTypeUpdate(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.patchApi(AppUrls.customerTypeUpdate, data);
      // print("Customer Master Customer Type  updated Response  $response ");
      return response = CustomerTypeUpdateResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

//ACTIVITY PURPOSE
  Future<List<CustomerMasterActivityPurposeResponseModel>>
      customerMasterActivityPurpose() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.customerMasterActivityPurpose,
      );
      // print("Customer Master Activity Purpose  $response ");
      return response =
          CustomerMasterActivityPurposeResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Activity PURPOSE Create
  Future<ActivityPurposeCreateResponseModel>
      customerMasterActivityPurposeCreate(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerMasterActivityPurposeCreate, data);
      // print("Customer Master Activity Purpose  Created $response ");
      return response = ActivityPurposeCreateResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //ACTIVATION SERVICE-----

  Future<List<CustomerMasterActivationServicesResponseModel>>
      customerMasterActivationServices() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.customerMasterActivationServices,
      );
      // print("Customer Master Activity Services$response ");
      return response =
          CustomerMasterActivationServicesResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Activation AVAILABLE FIELD
  Future<ActivationAvailableFieldResponseModel>
      customerMasterActivationAvailableField(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerMasterActivationAvailableField, data);
      // if (kDebugMode) {
      //   print("Customer Master Activity Available Fields $response ");
      // }
      return response =
          ActivationAvailableFieldResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Activation Update
  Future<ActivationAvailableFieldResponseModel> customerMasterActivationUpdate(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerMasterActivationUpdate, data);
      if (kDebugMode) {
        // print("Customer Master Activation Update  $response ");
      }
      return response =
          ActivationAvailableFieldResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //ACTIVATION  FIELDS

  Future<CustomerMasterFieldResponseModel> customerMasterActivationField(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerMasterActivationField, data);
      // print("Customer Master Activation Fields  $response ");
      return response = CustomerMasterFieldResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CustomerMasterFieldCreateResponseModel>
      customerMasterActivationFieldCreate(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerMasterActivationFieldCreate, data);
      // print("Customer Master Activation Fields CREATE  $response ");
      return response =
          CustomerMasterFieldCreateResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Activation Settings
  Future<CustomerMasterActivationSettingResponseModel>
      customerMasterActivationSetting(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerMasterActivationSetting, data);
      // print("Customer Master Activation Setting Api successfully call");
      // print("Customer Master Activation Setting response  $response ");
      return response =
          CustomerMasterActivationSettingResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Activation Setting Create
  Future<ActivationSettingCreateResponseModel>
      customerMasterActivationSettingCreate(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerMasterActivationSettingCreate, data);
      print("Customer Master Activation Setting Create api");
      print(
          "Customer Master Activation Setting Create api response  $response ");
      return response = ActivationSettingCreateResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Activation Setting Update
  Future<ActivationSettingUpdateResponseModel>
      customerMasterActivationSettingUpdate(dynamic data) async {
    try {
      dynamic response = await _apiService.patchApi(
          AppUrls.customerMasterActivationSettingUpdate, data);
      print("Customer Master Activation Setting Update api");
      print(
          "Customer Master Activation Setting Update api response  $response ");
      return response = ActivationSettingUpdateResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Customer Setting -----------

  // Column Setting List
  Future<List<CustomerSettingColumnListResponseModel>>
      customerSettingColumnList() async {
    try {
      dynamic response =
          await _apiService.getApi(AppUrls.customerSettingColumnList);
      print("Customer Setting Column customer_list $response ");
      return response =
          CustomerSettingColumnListResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Column Setting Save Changes payloadIssue Pending issue
  //Update pending Response not received from backend issue

  //Column Setting Save Changes
  Future<List<ColumnSettingSaveChangesResponseModel>>
      customerSettingColumnSaveChanges(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerSettingColumnSaveChange, data);
      print("Customer Setting Column Save Changes $response ");
      return response =
          ColumnSettingSaveChangesResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Column Setting Update
  Future<dynamic> customerSettingColumnUpdate(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.customerSettingColumnUpdate, data);
      print("Customer Setting Column Update $response ");
      return response;
    } catch (e) {
      print("Customer Setting Error $e");
      rethrow;
    }
  }

  //Field Setting
  Future<List<CustomerSettingFieldListResponseModel>>
      customerSettingFieldList() async {
    try {
      dynamic response =
          await _apiService.getApi(AppUrls.customerSettingFieldList);
      print("Customer Setting field customer_list");
      print("Customer Setting field customer_list $response ");
      return response =
          CustomerSettingFieldListResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //ORDER_________-----

  //Order List
  Future<OrderListResponseModel> orderList(
      Map<String, dynamic> requestData) async {
    try {
      final response =
          await _apiService.postApiResponse(AppUrls.orderList, requestData);
      return OrderListResponseModel.fromJson(response);
    } catch (e) {
      rethrow; // Propagate the error to the caller
    }
  }

  Future<OrderOneTimeServiceResModel> orderOneTimeServices(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderOneTimeSer, data);
      print("Order payment Response $response ");
      return OrderOneTimeServiceResModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Order Company
  Future<OrderCompanyResponseModel> orderCompany(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderCompany, data);
      print("Order List company  Response $response ");
      return response = OrderCompanyResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Order Filter ----

  //Search Product
  Future<List<OrderSearchProductResponseModel>> searchProduct() async {
    try {
      dynamic response =
          await _apiService.getApi(AppUrls.orderSearchProductTerm);
      print("Order Search Product  Response $response ");
      return response = OrderSearchProductResponseModel.fromJsonList(response);
    } catch (e) {
      print("SEARCH product Error $e");
      rethrow;
    }
  }

  //search customer
  Future<OrderSearchCustomerResponseModel> searchCustomer(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderSearchCustomer, data);
      print("Order Search Customer  Response $response ");
      return response = OrderSearchCustomerResponseModel.fromJson(response);
    } catch (e) {
      print("Order Search Customer $e");
      rethrow;
    }
  }

  //Order Detail List

  Future<OrderDetailsResponseModel> orderDetailList() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.orderDetailList,
      );
      print("Order Detail List Response  $response ");
      return response = OrderDetailsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Generate Receipt Pending
  Future<OrderCompanyResponseModel> orderGenerateReceipt(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderGenerateList, data);
      print("Order Generate Receipt  Response $response ");
      return response = OrderCompanyResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //order-----
  // Payment----

  Future<OrderPaymentsResponseModel> orderPaymentList(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderPayment, data);
      print("Order payment Response $response ");
      return response = OrderPaymentsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Order delete -----
  Future<OrderDeleteResponseModel> orderDeleteList(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderDeleteList, data);
      print("Order Delete List Response $response ");
      return response = OrderDeleteResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Export Order
  Future<OrderExportResponseModel> orderExport(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderExport, data);
      print("Order Export  Response value $response ");
      return response = OrderExportResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

//Credit Debit Notes
  Future<OrderCreditDebitNoteResponseModel> orderCreditDebitNote(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderCreditDebit, data);
      print("Order Credit Debit  Response value $response ");
      return response = OrderCreditDebitNoteResponseModel.fromJson(response);
    } catch (e) {
      print("Order credit Debit $e");
      rethrow;
    }
  }

  //Payment update

  Future<OrderPaymentUpdateResponseModel> orderPaymentUpdate(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.patchApi(AppUrls.orderPaymentUpdate, data);
      print("Order Payments Update amount $response ");
      return response = OrderPaymentUpdateResponseModel.fromJson(response);
    } catch (e) {
      print("Order update Order update $e");
      rethrow;
    }
  }

  //Payment status change
  Future<OrderPaymentUpdateResponseModel> paymentStatusChange(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.orderPaymentStatus, data);
      print("Order Payments Status Change $response ");
      return response = OrderPaymentUpdateResponseModel.fromJson(response);
    } catch (e) {
      print("Order Status Change Error $e");
      rethrow;
    }
  }

//Report -----------------

  //Task Report-----
  Future<TaskReportResponseModel> taskReportList(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.taskReport, data);
      print(" task reports successfully  $response ");
      return response = TaskReportResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskDetailsResponseModel> fetchTaskDetails(String taskId) async {
    try {
      dynamic response = await _apiService
          .getApi('https://dev.whsuites.com/api/tasks/$taskId/');
      print("Raw response type: ${response.runtimeType}");
      print("Raw response: $response");

      // If the response is a list, and you want the first item
      if (response is List) {
        response = response.isNotEmpty ? response[0] : {};
      }

      return TaskDetailsResponseModel.fromJson(response);
    } catch (e) {
      print('Error fetching task details: $e');
      rethrow;
    }
  }

  Future<StartStopResponseModels> taskStartStop(dynamic data) async {
    try {
      // Make the POST request
      final response =
          await _apiService.postApiResponse(AppUrls.taskStartStop, data);
      print("Start and stop task response: $response");

      // Parse the response
      return StartStopResponseModels.fromJson(response);
    } catch (e) {
      print("Error in taskStartStop: $e");
      rethrow; // Rethrow the error for handling in the ViewModel
    }
  }

  //Task List -----

  Future<ReportTaskStartResponseModel> taskStartApi() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.reportStart,
      );
      print("Report Task Start api Response $response ");
      return response = ReportTaskStartResponseModel.fromJson(response);
    } catch (e) {
      print("Report Task Start Error$e");
      rethrow;
    }
  }

  //Task Descriptions------

  Future<List<TaskDescriptionResponseModel>> taskDescription() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.reportTaskDescription,
      );
      print("Report Task Description api Response $response ");
      return response = TaskDescriptionResponseModel.fromJsonList(response);
    } catch (e) {
      print("Report Task Description Error$e");
      rethrow;
    }
  }

  //Add Description------
  Future<List<TaskDescriptionResponseModel>> addDescription(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.reportTaskDescription, data);
      print("Add Description api Response $response");
      return response = TaskDescriptionResponseModel.fromJsonList(response);
    } catch (e) {
      print("Add Description Error$e");
      rethrow;
    }
  }

//Report task Attachment Remove

  Future<TaskReportRemoveAttachmentResponseModel>
      taskReportRemoveAttachment() async {
    try {
      dynamic response = await _apiService.deleteApi(
        AppUrls.reportTaskRemoveAttachment,
      );
      print("Report Task Remove Attachment Response $response ");
      return response =
          TaskReportRemoveAttachmentResponseModel.fromJson(response);
    } catch (e) {
      print("Report Remove Attachment Error$e");
      rethrow;
    }
  }

//Task tracker Event------
  Future<TaskTrackerEventResponseModel> taskTrackerEvent(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.reportTaskTrackerEvent, data);
      print("Report Task Tracker Event $response ");
      return response = TaskTrackerEventResponseModel.fromJson(response);
    } catch (e) {
      print("Report Task Tracker Event Error$e");
      rethrow;
    }
  }

//Update Task

  Future<ReportTaskUpdateResponseModel> taskUpdate(dynamic data) async {
    try {
      dynamic response = await _apiService.patchApi(AppUrls.taskUpdate, data);
      print("Task Update Response value $response ");
      return response = ReportTaskUpdateResponseModel.fromJson(response);
    } catch (e) {
      print("Report  Update Error$e");
      rethrow;
    }
  }

  //Project OverView List -------

  Future<ProjectOverViewResponseModel> taskProjectOverview(
      String listId) async {
    try {
      dynamic response = await _apiService
          .getApi('https://webhopers.whsuites.com/api/projects/$listId');
      print("Fetching data for listId: $listId");

      print("Raw response type: ${response.runtimeType}");
      print("Task Project Overview Response $response");

      // Return the parsed response model
      return ProjectOverViewResponseModel.fromJson(response);
    } catch (e) {
      print("Project Overview Error: $e");
      rethrow; // Rethrow the error to handle it in the view model
    }
  }

  //Report List----

  Future<List<TaskReportListResponseModel>> taskProjectReportList(
      Map<String, dynamic> data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.taskProjectReportList, data);
      print("Task Project Report List Overview Response $response ");
      return TaskReportListResponseModel.fromJsonList(
          response); // Ensure this method is accessible
    } catch (e) {
      rethrow;
    }
  }

  Future<ProjectOverViewTaskListResponseModel> ProjectOverViewTasksListApi(
      ProjectOverviewTaskRequestModel requestModel) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.taskListApi, requestModel.toJson());
      return ProjectOverViewTaskListResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Create Report -------
  Future<List<TaskReportListResponseModel>> taskCreateReportList(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.taskProjectReportList, data);
      print("Task create Project Report Response $response ");
      return response = TaskReportListResponseModel.fromJsonList(response);
    } catch (e) {
      print("Project Create Report list overView Error $e");
      rethrow;
    }
  }

  //Employee Report -------
  Future<ReportEmployeeReportResModel> reportEmployee(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.reportEmployee, data);
      print("Task create Project Report Response $response");

      if (response is Map<String, dynamic>) {
        return ReportEmployeeReportResModel.fromJson(response);
      } else {
        throw Exception(
            "Unexpected response format: Expected Map, got ${response.runtimeType}");
      }
    } catch (e) {
      print("Project Create Report list overView Error $e");
      rethrow;
    }
  }

  // REPORT PRODUCT WISE SALE

  Future<ReportProductWiseResModel> reportProductWiseSale(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.reportProductWiseSale, data);
      print("Product Wise Sale List Response: $response");
      return ReportProductWiseResModel.fromJson(response);
    } catch (e) {
      debugPrint('Error in Wise Sale List Response : $e'); // Log the error
      rethrow;
    }
  }

  // REPORT RECURRING SERVICES WISE SALE

  Future<ReportRecurringServicesResModel> reportRecurringServices(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.reportRecurringServices, data);
      print("Recurring Services List Response: $response");
      return ReportRecurringServicesResModel.fromJson(response);
    } catch (e) {
      debugPrint('Error in Recurring Services List : $e'); // Log the error
      rethrow;
    }
  }

  //Update Project OverView-----

  Future<UpdateProjectOverViewResponseModel> updateProjectOverView(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.patchApi(AppUrls.updateProjectOverView, data);
      print("Task Update Project Overview Response $response");
      return response = UpdateProjectOverViewResponseModel.fromJson(response);
    } catch (e) {
      print("Task Error");
      rethrow;
    }
  }

//Project tags

  Future<List<ProjectTagResponseModel>> projectTag() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.projectTags,
      );
      print("Project Tag Response $response");
      return response = ProjectTagResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  //Create project Reminder

  Future<dynamic> createProjectReminder(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.projectReminder, data);
      print("Create Project Reminder Response $response");
      return response;
    } catch (e) {
      print("Create  bvhvnjhjyj   Project Reminder Error $e");
      rethrow;
    }
  }

  //Report Task  Assign Filter------
  Future<List<ReportTaskFilterAssignResponseModel>> taskFilterAssign(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.reportTaskFilterAssign, data);
      print("Task Assign Response  $response");
      return response =
          ReportTaskFilterAssignResponseModel.fromJsonList(response);
    } catch (e) {
      print("Create  bvhvnjhjyj   Project Reminder Error $e");
      rethrow;
    }
  }

  //Task Type----

  Future<List<ReportTaskTypeResponseModel>> taskType() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.reportTaskType,
      );
      print("Task Type Response  $response");
      return response = ReportTaskTypeResponseModel.fromJsonList(response);
    } catch (e) {
      print("Task Type error   $e");
      rethrow;
    }
  }

//task status-----
  Future<List<ReportTaskStatusResponseModel>> taskStatus() async {
    try {
      dynamic response = await _apiService.getApi(
        AppUrls.reportTaskStatus,
      );
      print("Task Status Response  $response");
      return response = ReportTaskStatusResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

//Task-----------------
  //Task List

  Future<TasksListResponseModel> taskListApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.taskList, data);
      print("Task List Response   $response");
      return response = TasksListResponseModel.fromJson(response);
    } catch (e) {
      print("Task List Error $e");
      rethrow;
    }
  }

  //Search Project------
  Future<List<TaskListProjectSearchResponseModel>> projectSearch(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.searchProject, data);
      print("Search project Response   $response");
      return response =
          TaskListProjectSearchResponseModel.fromJsonList(response);
    } catch (e) {
      print("Search Project Error $e");
      rethrow;
    }
  }

//new Board

  Future<NewBoardResponseModel> taskListNewBoard(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.newBoard, data);
      print("New Board Response   $response");
      return response = NewBoardResponseModel.fromJson(response);
    } catch (e) {
      print("New Board Error $e");
      rethrow;
    }
  }

//Master--------------------
//AddTASk----------

  Future<NewBoardResponseModel> addTaskType(dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.taskMasterAddTaskType, data);
      print("Task Master Add task Type  $response");
      return response = NewBoardResponseModel.fromJson(response);
    } catch (e) {
      print("Task Master Add TAsk Error $e");
      rethrow;
    }
  }

  //Task Master Update--------

  Future<dynamic> taskMasterUpdate(dynamic data) async {
    try {
      dynamic response =
          await _apiService.patchApi(AppUrls.taskMasterUpdate, data);
      print("Task Master Update Response $response");
      return response = NewBoardResponseModel.fromJson(response);
    } catch (e) {
      print("Task Master Update Error $e");
      rethrow;
    }
  }

  //Sales---------
  //Add Target
  Future<SaleAddTargetResponseModel> saleAddTarget(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.saleAddTarget, data);
      print("Sale Add Target Response value $response ");
      return response = SaleAddTargetResponseModel.fromJson(response);
    } catch (e) {
      print("Sale Add Target Error$e");
      rethrow;
    }
  }

  //Target Detail--------
  Future<TargetDetailResponseModel> targetDetail() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.targetDetail);
      print("Target Detail Response$response ");
      return response = TargetDetailResponseModel.fromJson(response);
    } catch (e) {
      print("Target Detail Response  Error$e");
      rethrow;
    }
  }

//Incentive BreakDown-------------

  Future<IncentiveBreakdownAddResponseModel> incentiveBreakdown(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.incentiveBreakDownUpdate, data);
      print("Incentive BreakDown Update ResponseModel $response");
      return response = IncentiveBreakdownAddResponseModel.fromJson(response);
    } catch (e) {
      print("Incentive Breakdown Response Error $e");
      rethrow;
    }
  }

// Add Product incentive -----------
  Future<AddProductIncentiveResponseModel> addProductIncentive(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.addProductIncentive, data);
      print("Add Product Incentive Update Response $response");
      return response = AddProductIncentiveResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //delete deleteBreakDownIncentive------------
  Future<SalesDeleteBreakDownIncentiveResponseModel>
      deleteBreakDownIncentive() async {
    try {
      dynamic response =
          await _apiService.deleteApi(AppUrls.deleteBreakDownIncentive);
      print("delete BreakDown Incentive  Response $response");
      return response =
          SalesDeleteBreakDownIncentiveResponseModel.fromJson(response);
    } catch (e) {
      print("Delete Incentive Breakdown Response Error $e");
      rethrow;
    }
  }

//delete productIncentive--------------
  Future<DeleteProductIncentiveResponseModel> deleteProductIncentive() async {
    try {
      dynamic response =
          await _apiService.deleteApi(AppUrls.deleteProductIncentive);
      print("delete Product Incentive  Response $response");
      return response = DeleteProductIncentiveResponseModel.fromJson(response);
    } catch (e) {
      print("Delete Incentive  Product Response Error $e");
      rethrow;
    }
  }

//Update Product Incentive ---------------
  Future<UpdateProductIncentiveResponseModel> updateProductIncentive(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.patchApi(AppUrls.updateProductIncentive, data);
      print("Update Product Incentive  Response $response");
      return response = UpdateProductIncentiveResponseModel.fromJson(response);
    } catch (e) {
      print("Update Product Incentive   Response Error $e");
      rethrow;
    }
  }

//Sale Add Product

  Future<SalesAddProductResponseModel> salesAddProduct(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.saleAddProduct, data);
      print("Sales Add Product  Response $response");
      return response = SalesAddProductResponseModel.fromJson(response);
    } catch (e) {
      print("Sales Add Product  Response Error $e");
      rethrow;
    }
  }

//delete product---------
  Future<DeleteProductResponseModel> deleteProduct() async {
    try {
      dynamic response = await _apiService.deleteApi(AppUrls.deleteProduct);
      print("Delete Product Response $response");
      return response = DeleteProductResponseModel.fromJson(response);
    } catch (e) {
      print("Delete Product  Response Error $e");
      rethrow;
    }
  }

  Future<FilterCityResponseModel> filterCityApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.filterCity, data);
      if (kDebugMode) {
        print("Customer city Api Search$response");
      }
      return FilterCityResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

//Master
  //division

  Future<List<MasterDivisionsResponseModel>> masterDivision() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.masterDivision);
      print("Response Master Api: $response");

      if (response is List) {
        return MasterDivisionsResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      print("Error in masterDivision: $e");
      rethrow;
    }
  }

  Future<AddDivisionResponseModels> addDivisionSettingApi(
      Map<String, dynamic> data) async {
    try {
      final response = await _apiService.postApiResponse(
        AppUrls.masterAddDivision,
        data,
      );
      return AddDivisionResponseModels.fromJson(
          response as Map<String, dynamic>);
    } catch (e) {
      print("Error fetching departments: $e");
      rethrow;
    }
  }

  Future<UpdateDivisionResponseModels> updateDivisionSettingApi(
      String id, Map<String, dynamic> data) async {
    try {
      // Ensure the URL is constructed correctly
      final response = await _apiService.patchApi(
        '$masterUpdateDivision/$id',
        // Ensure masterUpdateDivision is defined correctly
        data,
      );

      // Log the response for debugging
      print("Update Division Response: $response");

      // Check if the response is not null and parse it
      if (response != null) {
        return UpdateDivisionResponseModels.fromJson(response);
      } else {
        throw Exception("Received null response from the API");
      }
    } catch (e) {
      // Log the error for debugging
      print("Update Division Response Error: $e");
      rethrow; // Rethrow the error for further handling
    }
  }

  Future<List<UpdateDivisionListResponseModel>> updateDivisionList(
      String id) async {
    try {
      dynamic response =
          await _apiService.getApi(AppUrls.updateDivisionList(id));
      // print("Response master Proposals: $response");
      // Handle single object response
      if (response is Map<String, dynamic>) {
        // Create a single model and return it in a customer_list
        return [UpdateDivisionListResponseModel.fromJson(response)];
      }
      // Handle customer_list response (in case API changes in future)
      else if (response is List) {
        return UpdateDivisionListResponseModel.fromJsonList(response);
      }
      // Handle invalid response
      else {
        throw Exception("Invalid response format from the API");
      }
    } catch (e) {
      // print("Error in updateDivisionList: $e");
      rethrow;
    }
  }

//Proposal

//Proposal
  Future<List<MasterProposalsResponseModel>> masterProposal() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.masterProposals);
      print("Response master Proposals$response");
      if (response is List) {
        return MasterProposalsResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  //CUSTOMIZE LIST

  Future<List<MasterCustomizeResponseModel>> masterCustomizeList(
      dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.masterCustomizeList, data);
      print("Response Master Customize $response");
      if (response is List) {
        return MasterCustomizeResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

//CUSTOMIZE TYPE
  Future<List<MasterCustomizeTypeResponseModel>> masterCustomizeType() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.masterCustomizeType);
      print("Response CustomizeType$response");
      if (response is List) {
        return MasterCustomizeTypeResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

//CUSTOMIZE LEAD SOURCE
  Future<List<CustomizeLeadSourceResponseModel>> masterCustomizeLeadSource(
      dynamic data) async {
    try {
      dynamic response = await _apiService.postApiResponse(
          AppUrls.masterCustomizeLeadSource, data);
      print("Response master Customize Lead Source$response");
      if (response is List) {
        return CustomizeLeadSourceResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

//COMPANY PROFILE

  Future<List<CompanyProfileResponseModel>> companyProfile() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.companyProfile);
      print("Response master Proposals$response");
      if (response is List) {
        return CompanyProfileResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

// List<PinCodeModelResponseModel> pinCodeList = (response as List).map((json) => PinCodeModelResponseModel.fromJson(json)).toList();
//       print("PincodeList ${pinCodeList[0].code}");
//       return pinCodeList;

  Future<List<LeadCustomFieldsResponseModel>>
      createNewLeadCustomFieldsApi() async {
    try {
      dynamic response =
          await _apiService.getApi(AppUrls.createNewLeadCustomFields);
      List<LeadCustomFieldsResponseModel> customFields = (response as List)
          .map((item) => LeadCustomFieldsResponseModel.fromJson(item))
          .toList();
      return customFields;
    } catch (e) {
      rethrow;
    }
  }

  //============================================================================
  // TRASH LEADS LIST

  Future<DeleteListResponseModel> leadTrashList(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.deleteList, data);
      print("Response Trash Delete List $response");
      return DeleteListResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Trash Delete Permanently
  //  ✅ ✅ ✅ ✅✅ ✅ ✅

  Future<TrashLeadPermanent> leadTrashDeletePermApi(String leadId) async {
    try {
      dynamic response =
          await _apiService.deleteApi(AppUrls.leadDeletePermanent(leadId));
      print("Lead Delete permanent Response: ${jsonEncode(response)}");
      return TrashLeadPermanent.fromJson(response);
    } catch (e) {
      debugPrint('Error in lead delete permanent: $e');
      rethrow;
    }
  }

  // Trash Lead Restore

  Future<LeadTrashRestoreResModel> leadTrashRestoreApi(String leadId,
      {Map<String, dynamic>? requestBody}) async {
    try {
      // Use requestBody if provided, otherwise send empty object
      dynamic response = await _apiService.patchApi(
          AppUrls.leadRestorePermanent(leadId), requestBody ?? {});
      print("Lead Restore Response: ${jsonEncode(response)}");
      return LeadTrashRestoreResModel.fromJson(response);
    } catch (e) {
      debugPrint('Error in lead restore: $e');
      rethrow;
    }
  }

//LEAD TYPES
  Future<List<LeadTypesResponseModel>> leadTypeApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadType);
      if (kDebugMode) {
        print("Response Trash Lead Type $response");
      }
      return response = LeadTypesResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AddLeadTypeResModel> leadTypeAddApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.leadType, data);
      if (kDebugMode) {
        print("Lead Type Add API Response: $response");
      }
      return AddLeadTypeResModel.fromJson(response);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Lead Type Add API Error: $e");
        print("Stack Trace: $stackTrace");
      }
      rethrow;
    }
  }

  // Add Sub Lead Type

  Future<LeadSubTypeAddResModel> leadSubTypeAddApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.addSubLeadType, data);
      if (kDebugMode) {
        print("Lead  Sub Type Add API Response: $response");
      }
      return LeadSubTypeAddResModel.fromJson(response);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Lead Sub Type Add API Error: $e");
        print("Stack Sub Trace: $stackTrace");
      }
      rethrow; // Rethrow to let the view model handle it
    }
  }

  Future<LeadMastersStatusResponseModel> leadMastersStatusApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.leadMastersStatus);
      return response = LeadMastersStatusResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // SERVICES

  // Future<CustomerServicesResponseModel> customersServicesApi() async {
  //   try {
  //     dynamic response =
  //         await _apiService.postApiResponse(AppUrls.customersServices, null);
  //     return response = CustomerServicesResponseModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // SETTINGS

  Future<CustomerMasterFieldResponseModel> customerSettingsApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.customerSettings);
      return response = CustomerMasterFieldResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // ORDER

  // PROFORMA LIST

  Future<OrderProformaListResponseModel> orderProformaApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.orderProforma);
      return response = OrderProformaListResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // ORDER MASTER

  Future<OrderMasterResponseModel> orderMasterApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.orderMaster);
      return response = OrderMasterResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

// HRM

// ATTENDANCE
  Future<HrmAttendanceResponseModel> attendanceApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.hrmAttendance, null);
      return response = HrmAttendanceResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //LEAVE
  Future<List<HrmLeaveTypeResponseModel>> leaveApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.hrmLeaveType);
      List<HrmLeaveTypeResponseModel> leaveDataList =
          HrmLeaveTypeResponseModel.fromJsonList(
              response); // Parse the response as a customer_list
      return leaveDataList;
    } catch (e) {
      rethrow;
    }
  }

  // LEAVE TYPE

  Future<List<HrmLeavePlanResponseModel>> leavePlanApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.hrmLeavePlan);
      List<HrmLeavePlanResponseModel> leaveDataList =
          HrmLeavePlanResponseModel.fromJsonList(
              response); // Parse the response as a customer_list
      return leaveDataList;
    } catch (e) {
      rethrow;
    }
  }

  // Add LEAVE TYPE

  Future<AddLeaveTypeResponseModel> addLeaveTypeApi(
      Map<String, dynamic> data) async {
    try {
      final response = await _apiService.postApiResponse(
        AppUrls.addLeaveType,
        data,
      );
      return AddLeaveTypeResponseModel.fromJson(
          response as Map<String, dynamic>);
    } catch (e) {
      print("Error fetching : $e");
      rethrow;
    }
  }

  Future<UpdateLeaveTypeResponseModel> updateLeaveTypeApi(
      String id, Map<String, dynamic> data) async {
    try {
      final response = await _apiService.patchApi(
        AppUrls.updateLeaveType(id), // Construct the URL with the ID
        data,
      );

      // Check if the response is valid
      if (response is Map<String, dynamic>) {
        return UpdateLeaveTypeResponseModel.fromJson(response);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print("Error updating leave type: $e");

      rethrow;
    }
  }

  //CAMPAIGN
  // LIST
  Future<CampaignListResponseModel> campaignListApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.campaignList, null);
      return response = CampaignListResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // MAIL LOGS
  Future<CampaignMailLogsResponseModel> campaignMailLogsApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.campaignMailLogs, null);
      return response = CampaignMailLogsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //============================================================================
  // WHATSAPP

  Future<CampaignMailLogsResponseModel> whatsappApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.whatsappApi, null);
      return response = CampaignMailLogsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //============================================================================
  // SALES

  Future<SalesResponseModel> salesApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.salesApi, data);
      print("Sale Response  $response");
      return response = SalesResponseModel.fromJson(response);
    } catch (e) {
      print("Sale Error $e");
      rethrow;
    }
  }

  Future<List<SalesProjectionsListResponseModel>> salesProjectionApi(
      Map<String, dynamic> data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.salesProjection, data);
      print("Raw API Response: $response"); // Log the raw response
      return (response as List)
          .map((item) => SalesProjectionsListResponseModel.fromJson(item))
          .toList();
    } catch (e) {
      print("Sale Error: $e");
      rethrow;
    }
  }

  Future<List<SalesUpdateProjectionListResponseModel>>
      salesProjectionUpdateApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.projectionUpdateList);
      print("Response Master Department$response");
      if (response is List) {
        return SalesUpdateProjectionListResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<SalesUpdateProjectionResModel> salesUpdateProjection(
      String userId, Map<String, dynamic> data) async {
    try {
      String url = AppUrls.salesUptProjection(userId);

      // Ensure 'amount' is an integer and 'projection_date' is in the correct format.
      final processedData = {
        'projection_date': data['projection_date'], // Keep as is
        'amount': data['amount'], // Ensure amount is an integer
      };

      dynamic response = await _apiService.patchApi(url, processedData);

      if (response == null) {
        throw Exception('Failed to update projection: Response was null');
      }

      return SalesUpdateProjectionResModel.fromJson(response);
    } catch (e) {
      print("Error in updating sales projection: $e");
      rethrow;
    }
  }

  //============================================================================
  // ROLES
  //
  // Future<RolesResponseModel> rolesApi() async {
  //   try {
  //     dynamic response = await _apiService.getApi(AppUrls.rolesApi);
  //     return response = RolesResponseModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // ===========================================================================
  // USERS

  Future<UsersResponseModel> usersApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.usersApi, null);
      return response = UsersResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LeadUserFilterResModel>> leadUsersApi() async {
    try {
      // Make the API call
      dynamic response =
          await _apiService.postApiResponse(AppUrls.usersApi, null);

      // Check if the response is a List
      if (response is List) {
        return response
            .map((user) => LeadUserFilterResModel.fromJson(user))
            .toList();
      } else if (response is Map) {
        // Handle the case where a Map is returned
        throw const FormatException('Expected a List but got a Map');
      } else {
        throw FormatException(
            'Unexpected response type: ${response.runtimeType}');
      }
    } catch (e) {
      print('Error fetching users: $e');
      rethrow;
    }
  }

  Future<UserStatusResponseModel> userStatusUpdate(
      String userId, Map<String, dynamic> data) async {
    try {
      String url = AppUrls.usersStatusApi(userId);
      dynamic response = await _apiService.patchApi(url, data);
      return UserStatusResponseModel.fromJson(response);
    } catch (e) {
      print("Update User Status Response Error: $e");
      rethrow;
    }
  }

// user update

  Future<UserUpdateResponseModel> userUpdateApi(
      String userId, Map<String, dynamic> data) async {
    try {
      String url = AppUrls.userUpdateApi(userId);
      dynamic response = await _apiService.patchApi(url, data);
      return UserUpdateResponseModel.fromJson(response);
    } catch (e) {
      print("Update User Status Response Error: $e");
      rethrow;
    }
  }

  Future<List<MasterDepartmentsResponseModel>> masterDepartment() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.masterDepartments);
      print("Response Master Department$response");
      if (response is List) {
        return MasterDepartmentsResponseModel.fromJsonList(response);
      } else {
        throw Exception(
            "Expected a customer_list from the API but got something else.");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<UpdateProductResponseModel>updateProduct(dynamic data) async {
  //   try {
  //     dynamic response = await _apiService.patchApi(AppUrls.updateProduct,data);
  //     print("Update Product Response  $response");
  //     return response = UpdateProductResponseModel.fromJson(response);
  //   } catch (e) {
  //     print("Update product Response Error$e");
  //     rethrow;
  //   }
  // }

  Future<UserDepartmentUpdateResponseModel> updateUserDepartmentApi(
      Map<String, dynamic> data, String? departmentId) async {
    try {
      final String url = '$userDepartmentUpdate/$departmentId';
      final response = await _apiService.patchApi(url, data);
      print("Update Department Response: $response");
      return UserDepartmentUpdateResponseModel.fromJson(response);
    } catch (e) {
      print("Update Department Response Error: $e");
      rethrow;
    }
  }

  Future<UserActivitiesResponseModel> usersActivitiesApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.usersActivitiesApi, null);
      return response = UserActivitiesResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserDepartmentAddResponseModel> usersAddDepartmentApi(
      Map<String, dynamic> data) async {
    try {
      final response = await _apiService.postApiResponse(
        AppUrls.usersAddDepartment,
        data,
      );
      return UserDepartmentAddResponseModel.fromJson(
          response as Map<String, dynamic>);
    } catch (e) {
      print("Error fetching departments: $e");
      rethrow;
    }
  }

  Future<UserAddRoleResponseModel> usersAddRoleApi(
      Map<String, dynamic> data) async {
    try {
      final response = await _apiService.postApiResponse(
        AppUrls.rolesApi,
        data,
      );

      return UserAddRoleResponseModel.fromJson(
          response as Map<String, dynamic>);
    } catch (e) {
      print("Error fetching departments: $e");
      rethrow;
    }
  }

  Future<List<RolesListUpdateResponseModel>> roleUpdateListApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.roleUpdateList);
      if (response is List) {
        return response.map((item) {
          return RolesListUpdateResponseModel.fromJson(item);
        }).toList();
      } else {
        throw Exception(
            'Expected a customer_list but got ${response.runtimeType}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<RoleListEditResponseModel> roleListEditApi(
      String roleId, Map<String, dynamic> data) async {
    try {
      String url = AppUrls.roleEdit(roleId);
      dynamic response = await _apiService.patchApi(url, data);

      if (response != null) {
        return RoleListEditResponseModel.fromJson(response);
      } else {
        throw Exception("Received null response from the API");
      }
    } catch (e) {
      print("Update Role Response Error: $e");
      rethrow;
    }
  }

  Future<bool> saveRolePermissions(
      String roleId, List<Map<String, dynamic>> updatedPermissions) async {
    final url = Uri.parse(
        '$baseurl/roles/$roleId/permissions'); // Update URL based on your API endpoint

    try {
      // Send the updated permissions in the body of the request
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'permissions': updatedPermissions,
        }),
      );

      if (response.statusCode == 200) {
        return true; // Successfully updated permissions
      } else {
        return false; // Failed to update permissions
      }
    } catch (error) {
      print('Error saving permissions: $error');
      return false; // Handle network or other errors
    }
  }

  Future<RoleCheckEditResponseModel> roleCheckEditApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.taskListApi, null);
      return response = RoleCheckEditResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //============================================================================

  // MASTER
  Future<List<TaskMasterResponseModel>> tasksMasterApi() async {
    try {
      final response = await _apiService.getApi(AppUrls.leadDetailTaskType);
      if (response is List) {
        return response
            .map((json) => TaskMasterResponseModel.fromJson(json))
            .toList();
      }
      return [TaskMasterResponseModel.fromJson(response)];
    } catch (e) {
      rethrow;
    }
  }

  //============================================================================
  // PROJECT
  // LIST

  Future<ProjectListResponseModel> projectList(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.projectList, data);
      print("Project List  Response $response");
      return response = ProjectListResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProjectMasterListResponseModel>> projectMaster() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.projectMaster);
      print("Product Brand Api Response $response");
      return response = ProjectMasterListResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ProjectDetailResponseModel> projectDetailView(String projectId) async {
    try {
      // Construct the URL by appending the projectId
      final String url = "${AppUrls.projectDetailView}$projectId";

      // Make the API call
      dynamic response = await _apiService.getApi(url);
      print("Project Detail view Response: $response");

      // Parse the response into ProjectDetailResponseModel
      return ProjectDetailResponseModel.fromJson(response);
    } catch (e) {
      print("Project Detail view Response Error: $e");
      rethrow; // Rethrow the error to be handled by the caller
    }
  }

  Future<ProjectReminderSetting> projecReminderApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.projectReminder);
      return response = ProjectReminderSetting.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //product List-------------

  Future<ProductsListResponseModel> productList(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.productList, data);
      print("Product List Response $response");
      return response = ProductsListResponseModel.fromJson(response);
    } catch (e) {
      print("Product List  Response Error$e");
      rethrow;
    }
  }

  // BRAND
  Future<List<ProductBrandResponseModel>> productBrand() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.productBrand);
      print("Product Brand Api Response $response");
      return response = ProductBrandResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

// Services

  Future<ProductsServicesResModel> fetchProductServices(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.productServices, data);
      print("Product Services Api Response $response");
      return ProductsServicesResModel.fromJson(
          response); // Assuming response is a single JSON object
    } catch (e) {
      rethrow;
    }
  }

  //Add Product---
  Future<AddProductResponseModel> addProduct(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.addProduct, data);
      print("Response add  Product Response  $response");
      return response = AddProductResponseModel.fromJson(response);
    } catch (e) {
      print("Add product Response Error$e");
      rethrow;
    }
  }

  // CATEGORY
  Future<List<ProductCategoryResponseModel>> productCategoryApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.productCategory);
      List<ProductCategoryResponseModel> categories = (response as List)
          .map((category) => ProductCategoryResponseModel.fromJson(category))
          .toList();
      return categories;
    } catch (e) {
      rethrow;
    }
  }

  //update Product--------------

  Future<UpdateProductResponseModel> updateProduct(dynamic data) async {
    try {
      dynamic response =
          await _apiService.patchApi(AppUrls.updateProduct, data);
      print("Update Product Response  $response");
      return response = UpdateProductResponseModel.fromJson(response);
    } catch (e) {
      print("Update product Response Error$e");
      rethrow;
    }
  }

//Add product brand----------
  Future<AddProductBrandResponseModel> addProductBrand(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.addProductBrand, data);
      print("Add Product Brand Response  $response");
      return response = AddProductBrandResponseModel.fromJson(response);
    } catch (e) {
      print("Add Product Brand Response Error$e");
      rethrow;
    }
  }

// gst List--------------
  Future<List<ProductGstListResponseModel>> fetchProductGstList() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.productGstList);
      print("Product Gst List Response  $response");
      return response = ProductGstListResponseModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

// Activations forms

  Future<List<ProductsActivationsFormsResModel>> productActivations() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.productActivations);
      print("Product Activations forms Api Response $response");
      return response = ProductsActivationsFormsResModel.fromJsonList(response);
    } catch (e) {
      rethrow;
    }
  }

//add gst-------

  Future<AddGstResponseModel> addGstApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.productGstList, data);
      print("Product add Gst  Response  $response");
      return response = AddGstResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //master-----
  //add product----------
  Future<MasterAddProductResponseModel> masterAddProduct(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.masterAddProduct, data);
      print("Master Add Product  Response  $response");
      return response = MasterAddProductResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Product Master List-----
  Future<ProductMasterResponseModel> masterProductList(dynamic data) async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.masterProductList, data);
      print("Master Product List Response: $response");

      // Parse the response into your model
      return ProductMasterResponseModel.fromJson(response);
    } catch (e) {
      rethrow; // Rethrow the error to be handled in the calling method
    }
  }

  //============================================================================
  // INVENTORY
  // STOCK

  // Function to fetch inventory stock from API service
  Future<InventoryStocksResponseModel> inventoryStockApiFromService() async {
    try {
      dynamic response = await _apiService
          .getApi(AppUrls.inventoryStock); // Call the API method to fetch data
      return InventoryStocksResponseModel.fromJson(
          response); // Parse the response into a model
    } catch (e) {
      rethrow; // Rethrow error if the API call fails
    }
  }

  // REPEAT
  Future<InventoryRequestResponseModel> inventoryRequestApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.inventoryRequest);
      return response = InventoryRequestResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // TRANSACTIONS
  Future<InventoryTransactionsResponseModel> inventoryTransactionsApi() async {
    try {
      dynamic response =
          await _apiService.getApi(AppUrls.inventoryTransactions);
      return response = InventoryTransactionsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // VENDORS
  Future<InventoryVendorsResponseModel> inventoryVendorsApi() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.inventoryVendors);
      return response = InventoryVendorsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //REFILL STOCKS
  Future<InventoryRefillStocksResponseModel> inventoryRefillStocksApi() async {
    try {
      dynamic response =
          await _apiService.getApi(AppUrls.inventoryRefillStocks);
      return response = InventoryRefillStocksResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //============================================================================

  //============================================================================
  // CITIES, STATES AND COUNTRY
  // CITIES

  Future<MasterCitiesResponseModel> masterCitiesApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.masterCities, null);
      return response = MasterCitiesResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // COUNTRYs
  Future<MasterCountryResponseModel> masterCountryApi() async {
    try {
      dynamic response =
          await _apiService.postApiResponse(AppUrls.masterCountry, null);
      return response = MasterCountryResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

// CUSTOMIZE LABELS
//CUSTOMIZE

  // // Customer to Customer Merge (PUT)
  // Future<CustomerToCustomerMergeResModel> customerToCustomerMerge(
  //     CustomerToCustomerMergeReqModel reqModel) async {
  //   try {
  //     final response =
  //         await _apiService.putApi(AppUrls.customerMerge, reqModel);
  //     return CustomerToCustomerMergeResModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
