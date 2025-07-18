import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../data/models/requestModels/globalSetting/update/GlobalSettingCheckReqModel.dart';
import '../../../data/models/responseModels/globalSetting/update/GlobalSettingCheckUpdateResModel.dart';
import '../../../data/repositories/repositories.dart';
import '../../../Utils/utils.dart';

class GlobalSettingUpdateViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<GlobalSettingUpdateResModel> globalSettingUpdateList = <GlobalSettingUpdateResModel>[].obs;

  // Observables for selected data
  RxString selectedCallStatus = ''.obs;
  RxString selectedReminderTo = ''.obs;
  RxString selectedLeadType = ''.obs;
  RxString selectedLeadSubType = ''.obs;
  RxList<String> selectedProductCategories = <String>[].obs;
  RxList<ProjectionProduct> selectedProjectionProducts = <ProjectionProduct>[].obs;
  RxString selectedMobile = ''.obs;
  RxString selectedCountryCode = ''.obs;
  RxString selectedLeadStatus = ''.obs;
  RxString selectedRemark = ''.obs;
  RxBool selectedIsReminder = false.obs;
  RxBool selectedNotifyCustomer = false.obs;
  RxBool selectedIsSendSms = false.obs;
  RxBool selectedIsSendEmail = false.obs;
  RxBool selectedIsSendWhatsapp = false.obs;
  Rx<DateTime?> selectedReminderDate = Rx<DateTime?>(null);
  RxDouble selectedLat = 0.0.obs;
  RxDouble selectedLng = 0.0.obs;

  // Valid call status values
  final List<String> validCallStatuses = [
    'Answered',
    'Not Answered',
    'Rejected',
    'Not Reachable',
    'Wrong Number',
    'Busy',
    'Switched Off'
  ];

  // Request model initialized with default values
  Rx<GlobalSettingCheckReqModel> requestModel = GlobalSettingCheckReqModel(
    activity: 'call',
    callStatus: 'Answered', // Set a default valid value
    remark: '',
    lat: 0.0,
    lng: 0.0,
    lead: '',
    leadType: '',
    leadSubType: '',
    isReminder: false,
    isSendEmail: false,
    isSendSms: false,
    isSendWhatsapp: false,
    mobile: '',
    countryCode: '',
    notifyCustomer: false,
    notifyUsers: [],
    leadStatus: 'in_progress',
    deadReason: null,
    projectionProducts: [],
    productCategories: [],
    reminderDate: null,
    reminderTo: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  // Fetch initial data
  Future<void> fetchInitialData() async {
    try {
      // Default to 'Answered' to avoid validation error
      selectedCallStatus.value = 'Answered';
      // Default lead status to lowercase to match API expectations
      selectedLeadStatus.value = 'in_progress';
      updateRequestModel();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching initial data: $error');
      }
    }
  }

  // Validate call status before updating
  bool validateCallStatus(String status) {
    return validCallStatuses.contains(status);
  }

  // Update request model with selected values
  void updateRequestModel() {
    // Ensure call status is valid
    if (selectedCallStatus.value.isEmpty || !validateCallStatus(selectedCallStatus.value)) {
      selectedCallStatus.value = 'Answered'; // Default to a valid value
    }

    requestModel.value = GlobalSettingCheckReqModel(
      activity: 'call',
      callStatus: selectedCallStatus.value,
      remark: selectedRemark.value.isNotEmpty ? selectedRemark.value : 'No remark provided',
      lat: selectedLat.value,
      lng: selectedLng.value,
      lead: '', // Set dynamically in saveGlobalSetting
      leadType: selectedLeadType.value,
      leadSubType: selectedLeadSubType.value,
      isReminder: selectedIsReminder.value,
      isSendEmail: selectedIsSendEmail.value,
      isSendSms: selectedIsSendSms.value,
      isSendWhatsapp: selectedIsSendWhatsapp.value,
      mobile: selectedMobile.value,
      countryCode: selectedCountryCode.value,
      notifyCustomer: selectedNotifyCustomer.value,
      notifyUsers: selectedReminderTo.value.isNotEmpty ? [selectedReminderTo.value] : [],
      leadStatus: selectedLeadStatus.value.toLowerCase(), // Ensure lowercase
      deadReason: null,
      projectionProducts: selectedProjectionProducts.toList(),
      productCategories: selectedProductCategories.toList(),
      reminderDate: selectedReminderDate.value,
      reminderTo: selectedReminderTo.value,
    );
  }

  // Method to set call status
  void setCallStatus(String status) {
    if (validateCallStatus(status)) {
      selectedCallStatus.value = status;
      updateRequestModel();
    } else {
      if (kDebugMode) {
        print('Invalid call status: $status');
      }
      Utils.snackbarFailed('Invalid call status. Valid options are: ${validCallStatuses.join(", ")}');
    }
  }

  // Method to handle save action
  Future<void> saveGlobalSetting(BuildContext context, {required String leadId}) async {
    loading.value = true;
    try {
      // Validate call status before submitting
      if (!validateCallStatus(selectedCallStatus.value)) {
        throw Exception('Invalid call status. Must be one of: ${validCallStatuses.join(", ")}');
      }

      // Update request model before saving
      requestModel.value = requestModel.value.copyWith(lead: leadId);
      updateRequestModel();

      if (kDebugMode) {
        print('Request Data Post: ${requestModel.value.toJson()}');
      }

      final value = await _api.globalSettingUpdate(requestModel.value.toJson());
      if (value.isNotEmpty) {
        globalSettingUpdateList.assignAll(value);
        for (var responseData in value) {
          if (kDebugMode) {
            print('Global Setting Data: ${responseData.message}');
          }
        }
        Utils.snackbarSuccess('Global settings updated successfully');
      } else {
        if (kDebugMode) {
          print('No data fetched for Global Setting');
        }
        Utils.snackbarFailed('No global settings updated');
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('Error updating global setting: $error');
        print('StackTrace: $stackTrace');
      }
      Utils.snackbarFailed('Failed to update global settings: $error');
    } finally {
      loading.value = false;
    }
  }

  // Method to update selected product category
  void updateSelectedProductCategory(String categoryId) {
    if (!selectedProductCategories.contains(categoryId)) {
      selectedProductCategories.add(categoryId);
    }
    updateRequestModel();
  }

  // Method to update selected lead type
  void updateSelectedLeadType(String leadTypeId) {
    selectedLeadType.value = leadTypeId;
    updateRequestModel();
  }

  // Method to update selected lead sub-type
  void updateSelectedLeadSubType(String leadSubTypeId) {
    selectedLeadSubType.value = leadSubTypeId;
    updateRequestModel();
  }

  // Method to update selected reminder to
  void updateSelectedReminderTo(String userId) {
    selectedReminderTo.value = userId;
    updateRequestModel();
  }

  // Method to add projection product
  void addProjectionProduct(ProjectionProduct product) {
    selectedProjectionProducts.add(product);
    updateRequestModel();
  }

  // Method to access global setting list
  RxList<GlobalSettingUpdateResModel> getGlobalSettingList() {
    return globalSettingUpdateList;
  }
}