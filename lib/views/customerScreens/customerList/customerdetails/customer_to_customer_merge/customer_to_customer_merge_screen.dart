import 'dart:async';
import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/data/models/responseModels/customers/list/customer_detail_view/merge/cust_to_cust_merge_cust_list_res_model.dart';
import 'package:websuites/data/models/responseModels/leads/list/lead_list.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/components/widgets/appBar/custom_appBar.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/viewModels/customerScreens/customerMaster/types/customer_master_types_viewModel.dart';
import 'package:websuites/viewModels/customerScreens/customer_list/filters/customer_division/customer_division.dart';
import 'package:websuites/viewModels/leadScreens/createNewLead/product_category/product_category_controller.dart';
import 'package:websuites/viewModels/leadScreens/lead_list/lead_detail_view/leadProductsViewModel/LeadProductsViewModel.dart';
import 'package:websuites/viewModels/leadScreens/lead_list/lead_detail_view/projection/create/ProjetionViewModel.dart';
import 'package:websuites/viewModels/leadScreens/setting/lead_source/lead_source_view_model.dart';
import 'package:websuites/views/homeScreen/home_manager/HomeManagerScreen.dart';
import 'package:websuites/utils/components/widgets/sizedBoxes/sized_box_components.dart';
import 'package:websuites/utils/reusable_validation/RequiredLabel.dart';
import 'package:websuites/utils/textfield/multipleCategoriesCreate/MultipleCategoriesCreate.dart'
    as custom;
import '../../../../../data/models/requestModels/customer/customer_list/customer_detail_view/merge/cus_to_cus_merge_req_model.dart';
import '../../../../../data/models/responseModels/customers/list/customer_detail_view/list/customer_list_detail_view_list_response_model.dart'
    hide SecondaryMobile;
import '../../../../../data/models/responseModels/customers/list/customer_detail_view/merge/after_merge/cus_to_cus_merge_res_model.dart';
import '../../../../../resources/iconStrings/icon_strings.dart';
import '../../../../../resources/strings/strings.dart';
import '../../../../../resources/svg/svg_string.dart';
import '../../../../../resources/textStyles/responsive/test_responsive.dart';
import '../../../../../resources/textStyles/text_styles.dart';
import '../../../../../utils/button/CustomButton.dart';
import '../../../../../utils/button/section_divider/SectionDivider.dart';
import '../../../../../utils/dark_mode/dark_mode.dart';
import '../../../../../utils/responsive/responsive_utils.dart';
import '../../../../../viewModels/customerScreens/customer_list/customer_detail_view/merge/cust_to_cust_merge_cust_list_view_model.dart';
import '../../../../../viewModels/leadScreens/createNewLead/assignedLeadTo/assigned_lead_to_viewModel.dart';
import '../../../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../CustomerDetailsScreen.dart';
import 'package:websuites/viewModels/leadScreens/createNewLead/pincode/pincode_view_model.dart';
import 'package:websuites/viewModels/leadScreens/lead_list/pin_code_city_search/PinCodeCityViewModel.dart';
import 'package:websuites/viewModels/customerScreens/customer_list/customer_detail_view/merge/cust_to_cust_merge_cust_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

const kGoogleApiKey =
    "AIzaSyDxwry1lYYabQCLUPego1qSNPtDafKjWMg"; // Replace with your Google API key

class PhoneNumberEntry {
  final TextEditingController controller;
  String countryCode;
  String countryFlag;

  PhoneNumberEntry({
    required this.controller,
    required this.countryCode,
    required this.countryFlag,
  });
}

class EmailEntry {
  final TextEditingController controller;

  EmailEntry({
    required this.controller,
  });
}

class CustomerToCustomerMergeController extends GetxController {
  RxList<PhoneNumberEntry> phoneEntries = <PhoneNumberEntry>[].obs;
  RxList<EmailEntry> emailEntries = <EmailEntry>[].obs;
  final RxList<Map<String, dynamic>> fieldSets = <Map<String, dynamic>>[].obs;
  final RxBool autoValidate = false.obs;
  final RxList<Map<String, String?>> errors = <Map<String, String?>>[].obs;

  final ProjectionViewModel projectionViewModel =
      Get.put(ProjectionViewModel());
  final PinCodeViewModel _pincodeViewModel = Get.put(PinCodeViewModel());
  final PinCodeCityViewModel _cityViewModel = Get.put(PinCodeCityViewModel());
  final CustToCustMergCustViewModel custToCustMergCustViewModel =
      Get.put(CustToCustMergCustViewModel());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController assignedLeadController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController divisionController = TextEditingController();
  final TextEditingController customerTypeController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController requirementController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController countryCode = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();

  Timer? _debounceTimer;
  bool _isAdding = false;
  RxDouble? lat = RxDouble(30.6353881);
  RxDouble? lng = RxDouble(76.80029069999999);
  RxString selectedStateId = ''.obs;
  RxString selectedCityId = ''.obs;

  Rx<CustToCustMergCustListResponseModel?> selectedCustomer =
      Rx<CustToCustMergCustListResponseModel?>(null);

  RxString searchQuery = ''.obs;

  RxList<CustToCustMergCustListResponseModel> filteredCustomers =
      <CustToCustMergCustListResponseModel>[].obs;

  RxString selectedCustomerId = ''.obs; // <-- Use RxString for GetX reactivity

  RxBool isLoading = false.obs;
  RxInt selectedIndex = 0.obs;
  RxBool isListView = true.obs;
  RxMap<String, String?> validationErrors = <String, String?>{
    'first_name': null,
    'mobileNo': null,
    'leadStatus': null,
    'remark': null,
    'reminderTo': null,
    'notifiedOn': null,
    'productCategory': null,
    'leadSubType': null,
    'email': null,
  }.obs;

  final String customerId;

  CustomerToCustomerMergeController({required this.customerId});

  @override
  void onInit() {
    super.onInit();
    resetForm();
    final divisionViewModel = Get.put(CustomerDivisionViewModel());
    divisionViewModel.customerListDivision();

    pincodeController.addListener(() {
      final query = pincodeController.text.trim();
      print('✍️ [Controller] Pincode input: "$query"');
      if (query.isEmpty) {
        _clearFields();
        _pincodeViewModel.clear();
        _cityViewModel.clear();
        cityController.clear();
        return;
      }
      if (query.length < 6) {
        _pincodeViewModel.searchPartialPincode(query);
      } else if (query.length == 6 && RegExp(r'^\d{6}$').hasMatch(query)) {
        _pincodeViewModel.searchPincode(query);
      }
    });

    cityController.addListener(() {
      final query = cityController.text.trim();
      _onCitySearch(query);
    });

    ever(_pincodeViewModel.searchResults, (List results) {
      if (results.isNotEmpty) {
        _updateFields(results.first);
      }
    });

    ever(_pincodeViewModel.errorMessage, (String error) {
      if (error.isNotEmpty) {
        _clearFields();
        cityController.clear();
      }
    });

    ever(custToCustMergCustViewModel.custToCustMergeList,
        (_) => filterCustomers());
    ever(searchQuery, (_) => filterCustomers());
    filterCustomers();
  }

  void _updateFields(dynamic pincodeData) {
    if (pincodeData.district != null) {
      districtController.text = pincodeData.district.name ?? '';
      if (pincodeData.district.state != null) {
        stateController.text = pincodeData.district.state.name ?? '';
        selectedStateId.value = pincodeData.district.state.id ?? '';
        if (pincodeData.district.state.country != null) {
          countryController.text =
              pincodeData.district.state.country.name ?? '';
        }
      }
    }
    _cityViewModel.clear();
    cityController.clear();
    selectedCityId.value = '';
  }

  void _clearFields() {
    districtController.clear();
    stateController.clear();
    countryController.text = '';
    streetAddressController.clear();
    selectedStateId.value = '';
    selectedCityId.value = '';
  }

  void _onCitySearch(String query) {
    print('🔍 [Controller] Triggering city search with query: "$query"');
    if (query.isNotEmpty && selectedStateId.value.isNotEmpty) {
      _cityViewModel.searchCities(selectedStateId.value, query);
    } else {
      _cityViewModel.clear();
    }
  }

  void onCitySelected(String? cityId, String? cityName) {
    if (cityId != null && cityName != null) {
      selectedCityId.value = cityId;
      cityController.text = cityName;
    }
  }

  void initializeWithCustomerData(
      CustomerListDetailViewListResponseModel? customerData) {
    final searchController = Get.find<custom.SearchController>();
    if (customerData != null) {
      firstNameController.text = customerData.firstName ?? '';
      lastNameController.text = customerData.lastName ?? '';
      assignedLeadController.text = (customerData.customerAssigned.isNotEmpty &&
              customerData.customerAssigned.first.user != null)
          ? customerData.customerAssigned.first.user!.firstName ?? ''
          : '';
      dobController.text = customerData.dob != null
          ? DateFormat('yyyy-MM-dd').format(customerData.dob!)
          : '';
      sourceController.text = customerData.source?.name ?? '';
      divisionController.text = customerData.divisions.isNotEmpty
          ? customerData.divisions.first.name ?? ''
          : '';
      customerTypeController.text = customerData.customerType ?? '';
      websiteController.text =
          customerData.websites != null && customerData.websites.isNotEmpty
              ? customerData.websites.join(', ')
              : '';
      searchController.textEntries.clear();
      if (customerData.websites != null && customerData.websites.isNotEmpty) {
        searchController.textEntries.addAll(customerData.websites);
      }

      gstController.text =
          customerData.gstin != null ? customerData.gstin ?? '' : '';
      requirementController.text = customerData.otherInformation ?? '';
      streetAddressController.text = customerData.primaryAddress ?? '';
      pincodeController.text =
          '${customerData.pincode?.code ?? ''}${customerData.pincode?.code != null && customerData.district?.name != null ? ' ' : ''}${customerData.district?.name ?? ''}';
      cityController.text =
          '${customerData.city?.name ?? ''}${customerData.city?.name != null && customerData.state?.name != null ? ' ' : ''}${customerData.state?.name ?? ''}';
      districtController.text = customerData.district?.name ?? '';
      stateController.text = customerData.state?.name ?? '';
      countryController.text = customerData.country?.name ?? '';
      countryCode.text = customerData.companies.isNotEmpty
          ? '+${customerData.companies.first.countryCode?.toString() ?? ''}'
          : '';

      emailEntries.clear();
      if (customerData.primaryEmail != null &&
          customerData.primaryEmail!.isNotEmpty) {
        emailEntries.add(EmailEntry(
            controller:
                TextEditingController(text: customerData.primaryEmail)));
      } else {
        addEmailEntry();
      }

      if (customerData.secondaryEmails != null &&
          customerData.secondaryEmails.isNotEmpty) {
        for (var secondary in customerData.secondaryEmails) {
          if (secondary.email != null && secondary.email!.isNotEmpty) {
            emailEntries.add(EmailEntry(
                controller: TextEditingController(text: secondary.email)));
          }
        }
      }

// Initialize phone entries
      phoneEntries.clear();
      if (customerData.primaryContact != null &&
          customerData.primaryContact!.isNotEmpty) {
        String countryCodeValue = customerData.companies.isNotEmpty
            ? customerData.companies.first.countryCode?.toString() ?? '91'
            : customerData.countryCode?.toString() ?? '91';
        String formattedCountryCode = countryCodeValue.startsWith('+')
            ? countryCodeValue
            : '+$countryCodeValue';
        String countryFlag = formattedCountryCode == '+1' ? 'US' : 'IN';

        phoneEntries.add(PhoneNumberEntry(
          controller: TextEditingController(text: customerData.primaryContact),
          countryCode: formattedCountryCode,
          countryFlag: countryFlag,
        ));
      } else {
        addPhoneEntry();
      }

// Add secondary mobiles
      if (customerData.secondaryMobiles != null &&
          customerData.secondaryMobiles.isNotEmpty) {
        for (var secondary in customerData.secondaryMobiles) {
          if (secondary.mobile != null && secondary.mobile!.isNotEmpty) {
            String code = secondary.countryCode != null &&
                    secondary.countryCode!.isNotEmpty
                ? (secondary.countryCode!.startsWith('+')
                    ? secondary.countryCode!
                    : '+${secondary.countryCode!}')
                : '+91';
            String flag = code == '+1' ? 'US' : 'IN';
            phoneEntries.add(PhoneNumberEntry(
              controller: TextEditingController(text: secondary.mobile),
              countryCode: code,
              countryFlag: flag,
            ));
          }
        }
      }
    } else {
      addEmailEntry();
      addPhoneEntry();
      searchController.textEntries.clear();
    }

// Sync website controller with search controller
    websiteController.addListener(() {
      final websites = websiteController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
      if (websites.join(', ') != searchController.textEntries.join(', ')) {
        searchController.textEntries.clear();
        searchController.textEntries.addAll(websites);
      }
    });
  }

// Add a phone entry
  void addPhoneEntry() {
    if (_isAdding || (_debounceTimer?.isActive ?? false)) return;
    _isAdding = true;
    _debounceTimer = Timer(const Duration(milliseconds: 50), () {
      phoneEntries.add(PhoneNumberEntry(
        controller: TextEditingController(),
        countryCode: '+91',
        countryFlag: 'IN',
      ));
      phoneEntries.refresh();
      _isAdding = false;
    });
  }

// Remove a phone entry
  void removePhoneEntry(int index) {
    if (_isAdding || (_debounceTimer?.isActive ?? false)) return;
    if (phoneEntries.length > 1 && index >= 0 && index < phoneEntries.length) {
      _isAdding = true;
      _debounceTimer = Timer(const Duration(milliseconds: 50), () {
        final entry = phoneEntries.removeAt(index);
        entry.controller.dispose();
        phoneEntries.refresh();
        _isAdding = false;
      });
    } else {
      Get.snackbar('Error', 'At least one phone number is required');
    }
  }

// Add an email entry
  void addEmailEntry() {
    if (_isAdding || (_debounceTimer?.isActive ?? false)) return;
    _isAdding = true;
    _debounceTimer = Timer(const Duration(milliseconds: 50), () {
      emailEntries.add(EmailEntry(controller: TextEditingController()));
      emailEntries.refresh();
      _isAdding = false;
    });
  }

// Remove an email entry
  void removeEmailEntry(int index) {
    if (_isAdding || (_debounceTimer?.isActive ?? false)) return;
    if (emailEntries.length > 1 && index >= 0 && index < emailEntries.length) {
      _isAdding = true;
      final entry = emailEntries[index];
      emailEntries.removeAt(index);
      entry.controller.dispose();
      emailEntries.refresh();
      _isAdding = false;
    } else {
      Get.snackbar('Error', 'At least one email is required');
    }
  }

// Reset the form
  void resetForm() {
    for (var fieldSet in fieldSets) {
      (fieldSet['category'] as TextEditingController?)?.dispose();
      (fieldSet['product'] as TextEditingController?)?.dispose();
      (fieldSet['amount'] as TextEditingController?)?.dispose();
      (fieldSet['date'] as TextEditingController?)?.dispose();
    }
    fieldSets.clear();
    errors.clear();
    for (var entry in emailEntries) {
      entry.controller.dispose();
    }
    emailEntries.clear();
    for (var entry in phoneEntries) {
      entry.controller.dispose();
    }
    phoneEntries.clear();
    firstNameController.clear();
    lastNameController.clear();
    assignedLeadController.clear();
    sourceController.clear();
    dobController.clear();
    divisionController.clear();
    customerTypeController.clear();
    websiteController.clear();
    gstController.clear();
    requirementController.clear();
    pincodeController.clear();
    cityController.clear();
    districtController.clear();
    stateController.clear();
    countryController.clear();
    streetAddressController.clear();
    autoValidate.value = false;
    _pincodeViewModel.clear();
    _cityViewModel.clear();
    selectedStateId.value = '';
    selectedCityId.value = '';
    fieldSets.refresh();
    errors.refresh();
    emailEntries.refresh();
    phoneEntries.refresh();
  }

// Navigate to customer details screen
  void navigateToCustomerDetails(String customerId) {
    resetForm();
    final homeController = Get.find<HomeManagerController>();
    homeController.lastScreen.value = CustomerDetailsScreen(
      customerId: customerId,
      customerData: homeController.selectedCustomerDetail.value,
      scaffoldKey: GlobalKey<ScaffoldState>(),
    );
    homeController.showOrderDetails.value = true;
    homeController.update();
    Get.back();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    for (var fieldSet in fieldSets) {
      (fieldSet['category'] as TextEditingController?)?.dispose();
      (fieldSet['product'] as TextEditingController?)?.dispose();
      (fieldSet['amount'] as TextEditingController?)?.dispose();
      (fieldSet['date'] as TextEditingController?)?.dispose();
    }
    firstNameController.dispose();
    lastNameController.dispose();
    assignedLeadController.dispose();
    sourceController.dispose();
    dobController.dispose();
    divisionController.dispose();
    customerTypeController.dispose();
    websiteController.dispose();
    gstController.dispose();
    requirementController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    districtController.dispose();
    stateController.dispose();
    countryController.dispose();
    countryCode.dispose();
    streetAddressController.dispose();
    selectedCustomer.value = null;
    searchQuery.value = '';
    filteredCustomers.clear();
    super.onClose();
  }

// Select a customer
  void selectCustomer(CustToCustMergCustListResponseModel customer) {
    selectedCustomer.value = customer;
    Get.back(); // Close the dialog after selection
  }

// Remove selected customer
  void removeSelectedCustomer() {
    selectedCustomer.value = null;
  }

// Filter customers based on search query
  void filterCustomers() {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      filteredCustomers
          .assignAll(custToCustMergCustViewModel.custToCustMergeList);
    } else {
      filteredCustomers.assignAll(
          custToCustMergCustViewModel.custToCustMergeList.where((customer) {
        return (customer.companyName?.toLowerCase().contains(query) ?? false) ||
            (customer.contactPersonName?.toLowerCase().contains(query) ??
                false) ||
            (customer.companyEmail?.toLowerCase().contains(query) ?? false) ||
            (customer.companyPhone?.toLowerCase().contains(query) ?? false);
      }).toList());
    }
  }

// Update search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void selectCustomerById(String id) {
    selectedCustomerId.value = id;
  }

  void setValidationError(String key, String? value) {
    validationErrors[key] = value;
    validationErrors.refresh();
  }

  void clearValidationError(String key) {
    validationErrors[key] = null;
    validationErrors.refresh();
  }

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
    isListView.value = index == 0;
  }

  String get primaryCustomerId {
    return selectedCustomerId.value.isNotEmpty
        ? selectedCustomerId.value
        : customerId; // ✅ Use the field, not widget
  }

  String get secondaryCustomerId {
    return selectedCustomerId.value.isNotEmpty
        ? (selectedCustomerId.value == customerId
            ? selectedCustomer.value?.id ?? ''
            : customerId)
        : selectedCustomer.value?.id ?? '';
  }
}

class CustomerToCustomerMerge extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Item? orderItem;
  final String customerId;
  final CustomerListDetailViewListResponseModel? customerData;

  const CustomerToCustomerMerge({
    Key? key,
    required this.scaffoldKey,
    this.orderItem,
    required this.customerId,
    this.customerData,
  }) : super(key: key);

  @override
  _CustomerToCustomerMergeState createState() =>
      _CustomerToCustomerMergeState();
}

class _CustomerToCustomerMergeState extends State<CustomerToCustomerMerge> {
  @override
  void initState() {
    super.initState();
    final controller = Get.put(
        CustomerToCustomerMergeController(customerId: widget.customerId));
    final assignedLeadViewModel = Get.put(AssignedLeadToViewModel());
    final leadSourceViewModel = Get.put(LeadSourceListViewModel());
    final customerTypeViewModel = Get.put(CustomerMasterTypesViewModels());
    final mergeViewModel =
        Get.put(CustToCustMergCustViewModel()); // Initialize ViewModel
    final searchController = Get.put(custom.SearchController());

    controller.initializeWithCustomerData(widget.customerData);
    searchController.textController.text = controller.websiteController.text;

    assignedLeadViewModel.fetchAssignedLeads(context);
    leadSourceViewModel.fetchLeadSourceList(context);
    customerTypeViewModel.customerMasterTypes(context);
    mergeViewModel
        .fetchCustToCustMergeList(widget.customerId); // Fetch merge list data
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerToCustomerMergeController>();
    final custom.SearchController searchController =
        Get.put(custom.SearchController());
    final productCategoryController = Get.put(ProductCategoryController());
    final leadProductsViewModel = Get.put(LeadProductsViewModel());
    final mergeViewModel = Get.find<CustToCustMergCustViewModel>();
    final homeController = Get.find<HomeManagerController>();
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    final assignedLeadViewModel = Get.find<AssignedLeadToViewModel>();
    final customerTypeViewModel = Get.find<CustomerMasterTypesViewModels>();
    final CustToCustMergCustViewModel custToCustMergCustViewModel =
        Get.put(CustToCustMergCustViewModel());
    productCategoryController.createLeadProductCategory(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      productCategoryController.createLeadProductCategory(context);
      leadProductsViewModel.fetchLeadProducts(context);
    });

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.navigateToCustomerDetails(widget.customerId);
                  },
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.back,
                        color: DarkMode.backgroundColor2(context),
                      ),
                      const SizedBox(width: 8),
                      ResponsiveText.getAppBarTextSize(context, Strings.back),
                    ],
                  ),
                ),
                Spacer(),
                CustomButton(
                  width: ResponsiveUtilsScreenSize.isMobile(context) ? 70 : 85,
                  height: ResponsiveUtilsScreenSize.isMobile(context) ? 28 : 28,
                  borderRadius: 54,
                  onPressed: () async {
                    await _onMergePressed(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.merge,
                        style: TextStyle(
                          fontSize: ResponsiveUtilsScreenSize.isMobile(context)
                              ? 11
                              : 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.sfPro,
                          color: AllColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyles.commonTextFieldTextHeading(
                      context,
                      Strings.customerMerge,
                      color: AllColors.mediumPurple,
                    ),
                    CommonSizedBox.height(context, 2.5),
                    RequiredLabel(label: Strings.firstName),
                    SizedBox(
                      height: 0,
                    ),
                    Obx(() => CommonTextField(
                          hintText: Strings.enterFirstName,
                          controller: controller.firstNameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              controller.setValidationError(
                                  'first_name', 'First name is required');
                              return null;
                            }
                            controller.clearValidationError('first_name');
                            return null;
                          },
                          hasError:
                              controller.validationErrors['first_name'] != null,
                          onChanged: (value) {
                            if (value.trim().isEmpty) {
                              controller.setValidationError(
                                  'first_name', 'First name is required');
                            } else {
                              controller.clearValidationError('first_name');
                            }
                          },
                        )),
                    Obx(() => _buildErrorText(
                        controller.validationErrors['first_name'])),
                    SizedBox(
                      height: 15,
                    ),
                    TextStyles.commonTextFieldSubHead(
                        context, Strings.lastName),
                    CommonTextField(
                      hintText: Strings.enterLastName,
                      controller: controller.lastNameController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RequiredLabel(label: Strings.primaryEmailCode),
                    Obx(() {
                      final emailEntries = controller.emailEntries;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (emailEntries.isNotEmpty)
                            Padding(
                              key: const ValueKey('email_entry_0'),
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          controller.setValidationError('email',
                                              'Primary Email is required');
                                          return null;
                                        }
                                        if (!RegExp(
                                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                            .hasMatch(value.trim())) {
                                          controller.setValidationError('email',
                                              'Enter a valid email address');
                                          return null;
                                        }
                                        controller
                                            .clearValidationError('email');
                                        return null;
                                      },
                                      hintText: 'Enter Email',
                                      controller: emailEntries[0].controller,
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon: Icon(Icons.email_outlined,
                                          color: Colors.grey, size: 19),
                                      hasError: controller
                                              .validationErrors['email'] !=
                                          null,
                                      onChanged: (value) {
                                        if (value.trim().isEmpty) {
                                          controller.setValidationError('email',
                                              'Primary Email is required');
                                        } else if (!RegExp(
                                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                            .hasMatch(value.trim())) {
                                          controller.setValidationError('email',
                                              'Enter a valid email address');
                                        } else {
                                          controller
                                              .clearValidationError('email');
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  OutlinedButton.icon(
                                    key: const ValueKey('add_email_button'),
                                    onPressed: controller.addEmailEntry,
                                    icon: const Icon(Icons.add,
                                        color: Colors.white, size: 19),
                                    label: const Text(
                                      "Email",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: FontFamily.sfPro,
                                        fontSize: 15,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: AllColors.mediumPurple,
                                      side: BorderSide(
                                          color: AllColors.mediumPurple),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Obx(() => _buildErrorText(
                              controller.validationErrors['email'])),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: emailEntries.length > 1
                                ? emailEntries.length - 1
                                : 0,
                            itemBuilder: (context, index) {
                              final actualIndex = index + 1;
                              final entry = emailEntries[actualIndex];
                              return Padding(
                                key: ValueKey(
                                    'email_entry_${entry.controller.hashCode}'),
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CommonTextField(
                                        key: ValueKey(
                                            'email_field_${entry.controller.hashCode}'),
                                        hintText: 'Enter Email',
                                        controller: entry.controller,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value != null &&
                                              value.isNotEmpty) {
                                            if (!RegExp(
                                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                .hasMatch(value)) {
                                              return 'Enter a valid email address';
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      key: ValueKey(
                                          'remove_button_email_${entry.controller.hashCode}'),
                                      icon: const Icon(Icons.remove_circle,
                                          color: Colors.red, size: 22),
                                      onPressed: () => controller
                                          .removeEmailEntry(actualIndex),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    RequiredLabel(label: Strings.primaryNumberCode),
                    CommonSizedBox.height(context, 1),
                    Obx(() => Column(
                          children: controller.phoneEntries
                              .asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key;
                            PhoneNumberEntry phoneEntry = entry.value;
                            const TextStyle commonTextStyle = TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              height: 1.2,
                            );
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 130,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(left: 8),
                                      child: CountryCodePicker(
                                        onChanged: (CountryCode code) {
                                          phoneEntry.countryCode =
                                              code.dialCode ?? '+91';
                                          phoneEntry.countryFlag =
                                              code.code ?? 'IN';
                                          String currentNumber =
                                              phoneEntry.controller.text;
                                          currentNumber = currentNumber
                                              .replaceAll(
                                                  RegExp(r'^\+\d+\s*'), '')
                                              .trim();
                                          phoneEntry.controller.text =
                                              currentNumber;
                                          controller.phoneEntries.refresh();
                                        },
                                        initialSelection:
                                            phoneEntry.countryFlag,
                                        showCountryOnly: false,
                                        showOnlyCountryWhenClosed: false,
                                        alignLeft: true,
                                        padding: EdgeInsets.zero,
                                        flagWidth: 25,
                                        textStyle: commonTextStyle,
                                        favorite: const ['IN'],
                                        showDropDownButton: true,
                                      ),
                                    ),
                                    Container(
                                      height: 48,
                                      width: 1,
                                      color: Colors.grey.shade300,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: phoneEntry.controller,
                                        keyboardType: TextInputType.phone,
                                        style: commonTextStyle,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 12),
                                          hintText: 'Enter mobile number',
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                          prefixText:
                                              phoneEntry.countryCode.isNotEmpty
                                                  ? '${phoneEntry.countryCode} '
                                                  : '+91 ',
                                          prefixStyle: commonTextStyle,
                                        ),
                                        validator: (value) {
                                          if (index == 0 &&
                                              (value == null ||
                                                  value.trim().isEmpty)) {
                                            controller.setValidationError(
                                                'mobileNo',
                                                'Primary mobile number is required');
                                            return null;
                                          }
                                          if (value != null &&
                                              value.isNotEmpty) {
                                            if (!RegExp(r'^\d{6,15}$')
                                                .hasMatch(value.trim())) {
                                              controller.setValidationError(
                                                  'mobileNo',
                                                  'Enter a valid mobile number');
                                              return null;
                                            }
                                          }
                                          controller
                                              .clearValidationError('mobileNo');
                                          return null;
                                        },
                                        onChanged: (value) {
                                          if (value.startsWith(
                                              phoneEntry.countryCode)) {
                                            String cleanedValue = value
                                                .replaceFirst(
                                                    phoneEntry.countryCode, '')
                                                .trim();
                                            phoneEntry.controller.text =
                                                cleanedValue;
                                            phoneEntry.controller.selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        offset: phoneEntry
                                                            .controller
                                                            .text
                                                            .length));
                                          }
                                          if (index == 0 &&
                                              value.trim().isEmpty) {
                                            controller.setValidationError(
                                                'mobileNo',
                                                'Primary mobile number is required');
                                          } else if (!RegExp(r'^\d{6,15}$')
                                              .hasMatch(value.trim())) {
                                            controller.setValidationError(
                                                'mobileNo',
                                                'Enter a valid mobile number');
                                          } else {
                                            controller.clearValidationError(
                                                'mobileNo');
                                          }
                                        },
                                      ),
                                    ),
                                    if (controller.phoneEntries.length > 1)
                                      IconButton(
                                        icon: const Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.red),
                                        onPressed: () =>
                                            controller.removePhoneEntry(index),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => controller.addPhoneEntry(),
                          icon: Icon(Icons.add, color: AllColors.greenJungle),
                          label: Text(
                            "Mobiles",
                            style: TextStyle(
                                color: AllColors.greenJungle,
                                fontWeight: FontWeight.w500),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AllColors.greenJungle),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                    TextStyles.commonTextFieldSubHead(
                        context, Strings.assignedLeadTo),
                    Obx(() {
                      final categories = List<String>.from(
                          assignedLeadViewModel.namesOnlyRxList);
                      return CommonTextField(
                        allowCustomBorderInput: BorderRadius.circular(19),
                        isForDivisions: true,
                        isMultiSelect: true,
                        hintText:
                            assignedLeadViewModel.selectedLeadId.value.isEmpty
                                ? Strings.select
                                : assignedLeadViewModel.selectedLeadName.value,
                        controller: controller.assignedLeadController,
                        categories: categories,
                        onCategoryChanged: (selectedCategory) {
                          final index = assignedLeadViewModel.namesOnlyRxList
                              .indexOf(selectedCategory);
                          if (index != -1) {
                            final id = assignedLeadViewModel
                                .fullCategoriesRxList[index]
                                .split('\n')[1];
                            assignedLeadViewModel.selectedLeadId.value = id;
                            assignedLeadViewModel.selectedLeadName.value =
                                selectedCategory;
                            controller.assignedLeadController.text =
                                selectedCategory;
                          }
                        },
                        suffixIcon: assignedLeadViewModel.loading.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2))
                            : null,
                      );
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    TextStyles.commonTextFieldSubHead(context, Strings.source),
                    Obx(() {
                      final leadSourceViewModel =
                          Get.find<LeadSourceListViewModel>();
                      final sourceNames = leadSourceViewModel.sourceList
                          .map((e) => e.name ?? '')
                          .toList();
                      return CommonTextField(
                        hintText: Strings.select,
                        controller: controller.sourceController,
                        categories: sourceNames,
                        onCategoryChanged: (selectedSource) {
                          final index = sourceNames.indexOf(selectedSource);
                          if (index != -1) {
                            leadSourceViewModel.selectedSourceId.value =
                                leadSourceViewModel.sourceList[index].id ?? '';
                            controller.sourceController.text = selectedSource;
                          }
                        },
                        suffixIcon: leadSourceViewModel.loading.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2))
                            : null,
                      );
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    TextStyles.commonTextFieldSubHead(context, Strings.dob),
                    CommonTextField(
                      hintText: Strings.select,
                      controller: controller.dobController,
                      isDateField: true,
                      prefixIcon: const Icon(Icons.date_range,
                          color: Colors.grey, size: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextStyles.commonTextFieldSubHead(
                        context, Strings.division),
                    Obx(() {
                      final divisionViewModel =
                          Get.find<CustomerDivisionViewModel>();
                      if (divisionViewModel.loading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final divisionNames = divisionViewModel.divisionList
                          .map((e) => e.name ?? '')
                          .toList();
                      return CommonTextField(
                        allowCustomBorderInput: BorderRadius.circular(19),
                        isForDivisions: true,
                        hintText: Strings.select,
                        isMultiSelect: true,
                        controller: controller.divisionController,
                        categories: divisionNames,
                        onCategoryChanged: (selectedDivision) {
                          final index = divisionNames.indexOf(selectedDivision);
                          if (index != -1) {
                            controller.divisionController.text =
                                selectedDivision;
                          }
                        },
                      );
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    TextStyles.commonTextFieldSubHead(
                        context, Strings.customerType),
                    Obx(() {
                      final customerTypeNames = customerTypeViewModel
                          .customerTypeList
                          .map((e) => e.name ?? '')
                          .toList();
                      return CommonTextField(
                        hintText: Strings.select,
                        controller: controller.customerTypeController,
                        categories: customerTypeNames,
                        onCategoryChanged: (selectedType) {
                          final index = customerTypeNames.indexOf(selectedType);
                          if (index != -1) {
                            controller.customerTypeController.text =
                                selectedType;
                          }
                        },
                        suffixIcon: customerTypeViewModel.loading.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2))
                            : null,
                      );
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    TextStyles.commonTextFieldSubHead(context, Strings.website),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonSizedBox.height(context, 1),
                        Obx(() {
                          final searchController =
                              Get.find<custom.SearchController>();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              custom.SearchComponents.buildSearchBox(
                                hintText:
                                    controller.websiteController.text.isEmpty
                                        ? Strings.enterWebsite
                                        : controller.websiteController.text,
                                isTextFieldFocused:
                                    searchController.isTextFieldFocused.value,
                                textController: searchController.textController,
                                focusNode: searchController.focusNode,
                                textEntries: searchController.textEntries,
                                searchText: searchController.searchText.value,
                                showCreateButton:
                                    searchController.showCreateButton.value,
                                onAddEntry: () {
                                  searchController.addTextEntry();
                                  controller.websiteController.text =
                                      searchController.textEntries.join(', ');
                                },
                                onRemoveEntry: (entry) {
                                  searchController.removeEntry(entry);
                                  controller.websiteController.text =
                                      searchController.textEntries.join(', ');
                                },
                                onClearSearch: () {
                                  searchController.clearSearch();
                                  controller.websiteController.text = '';
                                },
                                onClearAll: () {
                                  searchController.clearAllEntries();
                                  controller.websiteController.text = '';
                                },
                              ),
                              CommonSizedBox.height(context, 1),
                              custom.SearchComponents.buildCreateButton(
                                showCreateButton:
                                    searchController.showCreateButton.value,
                                searchText: searchController.searchText.value,
                                onCreate: () {
                                  searchController.addTextEntry();
                                  controller.websiteController.text =
                                      searchController.textEntries.join(', ');
                                },
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                    CommonSizedBox.height(context, 1),
                    TextStyles.commonTextFieldSubHead(context, Strings.gst),
                    CommonTextField(
                      hintText: Strings.select,
                      controller: controller.gstController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextStyles.commonTextFieldSubHead(
                        context, Strings.requirement),
                    CommonTextField(
                      hintText: Strings.enterDescription,
                      controller: controller.requirementController,
                      maxLines: 4,
                      allowCustomBorderInput: BorderRadius.circular(25),
                    ),
                    CommonSizedBox.height(context, 3),
                    TextStyles.commonTextFieldTextHeading(
                      context,
                      Strings.addressInformation,
                      color: AllColors.mediumPurple,
                    ),
                    CommonSizedBox.height(context, 2),
                    Obx(() => controller.isLoading.value
                        ? const LinearProgressIndicator()
                        : const SizedBox.shrink()),
                    CustomToggleButtonGroup(
                      initialSelectedIndex: controller.selectedIndex.value,
                      onIndexChanged: (index) {
                        controller.setSelectedIndex(index);
                        if (index == 0) {
                          controller.streetAddressController.clear();
                          controller.pincodeController.clear();
                          controller.cityController.clear();
                          controller.districtController.clear();
                          controller.stateController.clear();
                          controller.countryController.clear();
                        } else {
                          controller.pincodeController.clear();
                          controller.cityController.clear();
                          controller.districtController.clear();
                          controller.stateController.clear();
                          controller.countryController.clear();
                          controller.streetAddressController.clear();
                          controller._pincodeViewModel.clear();
                          controller._cityViewModel.clear();
                          controller.selectedStateId.value = '';
                          controller.selectedCityId.value = '';
                        }
                      },
                      options: [
                        ToggleButtonUtils.createIconTextOption(
                          selectedTextColor: AllColors.whiteColor,
                          text: 'Indian',
                          selectedColor: AllColors.mediumPurple,
                        ),
                        ToggleButtonUtils.createIconTextOption(
                          selectedTextColor: AllColors.whiteColor,
                          text: 'Non-India',
                          selectedColor: AllColors.mediumPurple,
                        ),
                      ],
                    ),
                    if (controller.selectedIndex.value == 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonSizedBox.height(context, 2),
                          TextStyles.commonTextFieldSubHead(
                              context, Strings.pincode),
                          CommonTextField(
                            key: const ValueKey('indian_pincode'),
                            hintText: Strings.pincode,
                            controller: controller.pincodeController,
                            keyboardType: TextInputType.number,
                            isEditable: true,
                            prefixIcon: const Icon(Icons.location_pin,
                                color: Colors.grey),
                            onChanged: (value) {
                              print(
                                  "Indian Pincode input: $value, Controller: ${controller.pincodeController.hashCode}");
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextStyles.commonTextFieldSubHead(
                              context, Strings.city),
                          Obx(() => CommonTextField(
                                key: const ValueKey('indian_city'),
                                hintText: Strings.city,
                                controller: controller.cityController,
                                categories: controller
                                    ._cityViewModel.leadPinCodeSearch
                                    .where((city) => city.name != null)
                                    .map((city) => city.name!)
                                    .toList(),
                                onCategoryChanged: (selectedCityName) {
                                  if (selectedCityName.isNotEmpty) {
                                    final selectedCity = controller
                                        ._cityViewModel.leadPinCodeSearch
                                        .firstWhereOrNull((city) =>
                                            city.name == selectedCityName);
                                    if (selectedCity != null) {
                                      controller.onCitySelected(
                                          selectedCity.id, selectedCity.name);
                                    }
                                  }
                                },
                                onSearch: controller._onCitySearch,
                                isLoading:
                                    controller._cityViewModel.loading.value,
                                isEditable:
                                    controller.selectedStateId.value.isNotEmpty,
                                hasError: controller._cityViewModel.errorMessage
                                    .value.isNotEmpty,
                                errorMessage: controller
                                    ._cityViewModel.errorMessage.value,
                                allowCustomInput: true,
                                keyboardType: TextInputType.text,
                                prefixIcon: const Icon(Icons.location_city,
                                    color: Colors.grey),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          TextStyles.commonTextFieldSubHead(
                              context, Strings.district),
                          CommonTextField(
                            key: const ValueKey('indian_district'),
                            hintText: Strings.district,
                            controller: controller.districtController,
                            isEditable: false,
                            prefixIcon:
                                const Icon(Icons.map, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextStyles.commonTextFieldSubHead(
                              context, Strings.state),
                          CommonTextField(
                            key: const ValueKey('indian_state'),
                            hintText: Strings.state,
                            controller: controller.stateController,
                            isEditable: false,
                            prefixIcon:
                                const Icon(Icons.public, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextStyles.commonTextFieldSubHead(
                              context, Strings.country),
                          CommonTextField(
                            key: const ValueKey('indian_country'),
                            hintText: Strings.country,
                            controller: controller.countryController,
                            isEditable: false,
                            prefixIcon:
                                const Icon(Icons.flag, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextStyles.commonTextFieldSubHead(
                              context, Strings.streetAddress),
                          CommonTextField(
                            key: const ValueKey('indian_address'),
                            hintText: Strings.enterAddressIndia,
                            controller: controller.streetAddressController,
                            isEditable: true,
                            keyboardType: TextInputType.text,
                            prefixIcon: const Icon(Icons.location_pin,
                                color: Colors.grey),
                            validator: null,
                            onChanged: (value) {
                              print(
                                  "Indian Address input: $value, Controller: ${controller.streetAddressController.hashCode}");
                            },
                          ),
                          Obx(() => AnimatedCrossFade(
                                duration: const Duration(milliseconds: 300),
                                crossFadeState: controller._pincodeViewModel
                                        .errorMessage.value.isNotEmpty
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                firstChild: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    border:
                                        Border.all(color: Colors.red.shade200),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.error_outline,
                                          color: Colors.red.shade600),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          controller._pincodeViewModel
                                              .errorMessage.value,
                                          style: TextStyle(
                                              color: Colors.red.shade700,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                secondChild: const SizedBox.shrink(),
                              )),
                          CommonSizedBox.height(context, 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.pincodeController.clear();
                                  controller.cityController.clear();
                                  controller.districtController.clear();
                                  controller.stateController.clear();
                                  controller.countryController.clear();
                                  controller.streetAddressController.clear();
                                  controller._pincodeViewModel.clear();
                                  controller._cityViewModel.clear();
                                  controller.selectedStateId.value = '';
                                  controller.selectedCityId.value = '';
                                },
                                child: Text(
                                  "Clear All",
                                  style:
                                      TextStyle(color: AllColors.mediumPurple),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    if (controller.selectedIndex.value == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonSizedBox.height(context, 2),
                          TextStyles.commonTextFieldSubHead(
                              context, Strings.address),
                          SizedBox(
                            height: 5,
                          ),
                          GooglePlaceAutoCompleteTextField(
                            textEditingController:
                                controller.streetAddressController,
                            googleAPIKey: kGoogleApiKey,
                            inputDecoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                    color: AllColors.commonTextFiledColor,
                                    width: 1), // GREEN default
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                    color: AllColors.mediumPurple,
                                    width: 1), // PURPLE on focus
                              ),
                              hintText: "Search for an address",
                              hintStyle: TextStyle(
                                color: AllColors.commonTextFiledColor,
                                fontSize: 15,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 10),
                                child: Icon(
                                  Icons.search,
                                  size: 23,
                                  color: AllColors.commonTextFiledColor,
                                ),
                              ),
                              prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                              isDense: true,
                            ),
                            debounceTime: 100,
                            isLatLngRequired: true,
                            getPlaceDetailWithLatLng: _onPlaceSelected,
                            itemClick: (Prediction prediction) {
                              controller.streetAddressController.text =
                                  prediction.description ?? '';
                              controller.streetAddressController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: controller
                                        .streetAddressController.text.length),
                              );
                            },
                            itemBuilder:
                                (context, index, Prediction prediction) {
                              return Container(
                                constraints:
                                    const BoxConstraints(minHeight: 36),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.grey.shade600,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          prediction.description ?? "",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            isCrossBtnShown: true,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextStyles.commonTextFieldSubHead(
                              context, Strings.pincode),
                          CommonTextField(
                            key: const ValueKey('non_india_pincode'),
                            hintText: Strings.pincode,
                            controller: controller.pincodeController,
                            isEditable: true,
                            keyboardType: TextInputType.number,
                            prefixIcon: const Icon(Icons.location_pin,
                                color: Colors.grey),
                            validator: null,
                            onChanged: (value) {
                              print(
                                  "Non-India Pincode input: $value, Controller: ${controller.pincodeController.hashCode}");
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextStyles.commonTextFieldSubHead(
                              context, Strings.city),
                          CommonTextField(
                            key: const ValueKey('non_india_city'),
                            hintText: Strings.city,
                            controller: controller.cityController,
                            isEditable: true,
                            keyboardType: TextInputType.text,
                            prefixIcon: const Icon(Icons.location_city,
                                color: Colors.grey),
                            validator: null,
                            onChanged: (value) {
                              print(
                                  "Non-India City input: $value, Controller: ${controller.cityController.hashCode}");
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextStyles.commonTextFieldSubHead(
                              context, Strings.district),
                          CommonTextField(
                            key: const ValueKey('non_india_district'),
                            hintText: Strings.district,
                            controller: controller.districtController,
                            isEditable: true,
                            keyboardType: TextInputType.text,
                            prefixIcon:
                                const Icon(Icons.map, color: Colors.grey),
                            validator: null,
                            onChanged: (value) {
                              print(
                                  "Non-India District input: $value, Controller: ${controller.districtController.hashCode}");
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextStyles.commonTextFieldSubHead(
                              context, Strings.state),
                          CommonTextField(
                            key: const ValueKey('non_india_state'),
                            hintText: Strings.state,
                            controller: controller.stateController,
                            isEditable: true,
                            keyboardType: TextInputType.text,
                            prefixIcon:
                                const Icon(Icons.public, color: Colors.grey),
                            validator: null,
                            onChanged: (value) {
                              print(
                                  "Non-India State input: $value, Controller: ${controller.stateController.hashCode}");
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextStyles.commonTextFieldSubHead(
                              context, Strings.country),
                          CommonTextField(
                            key: const ValueKey('non_india_country'),
                            hintText: Strings.country,
                            controller: controller.countryController,
                            isEditable: true,
                            keyboardType: TextInputType.text,
                            prefixIcon:
                                const Icon(Icons.flag, color: Colors.grey),
                            validator: null,
                            onChanged: (value) {
                              print(
                                  "Non-India Country input: $value, Controller: ${controller.countryController.hashCode}");
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.pincodeController.clear();
                                  controller.cityController.clear();
                                  controller.districtController.clear();
                                  controller.stateController.clear();
                                  controller.countryController.clear();
                                  controller.streetAddressController.clear();
                                },
                                child: Text(
                                  "Clear All",
                                  style:
                                      TextStyle(color: AllColors.mediumPurple),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(() {
                      final controller =
                          Get.find<CustomerToCustomerMergeController>();
                      final selected = controller.selectedCustomer.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AllColors.mediumPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            icon: const Icon(Icons.search, size: 20),
                            label: const Text(
                              'Search & Select Customer',
                              style: TextStyle(
                                  fontFamily: FontFamily.sfPro,
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight
                                      .w500), // Fallback for FontFamily.sfPro
                            ),
                            onPressed: () => _showCustomerSearchDialog(context),
                          ),
                          const SizedBox(height: 10),
                          if (selected != null)
                            ContainerUtils(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ResponsiveText.getSubTitle(
                                              context,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: DarkMode.filter(context),
                                              selected.companyName ??
                                                  'Unnamed Company',
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  final selected = controller
                                                      .selectedCustomer.value;
                                                  if (selected != null) {
                                                    _showCustomerDetailsBottomSheet(
                                                        context, selected);
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.remove_red_eye_outlined,
                                                  color: AllColors.figmaGrey,
                                                )),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                controller.selectCustomerById(
                                                    selected?.id ?? '');
                                              },
                                              child: Obx(() => Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: controller
                                                                  .selectedCustomerId
                                                                  .value ==
                                                              (selected?.id ??
                                                                  '')
                                                          ? AllColors
                                                              .mediumPurple
                                                          : Colors.transparent,
                                                      border: Border.all(
                                                        color: controller
                                                                    .selectedCustomerId
                                                                    .value ==
                                                                (selected?.id ??
                                                                    '')
                                                            ? AllColors
                                                                .mediumPurple
                                                            : Colors.grey,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: controller
                                                                .selectedCustomerId
                                                                .value ==
                                                            (selected?.id ?? '')
                                                        ? Icon(Icons.check,
                                                            color: Colors.white,
                                                            size: 16)
                                                        : null,
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 0),
                                        if (selected.contactPersonName
                                                ?.isNotEmpty ==
                                            true)
                                          Row(
                                            children: [
                                              SvgIcon(
                                                assetPath:
                                                    IconStrings.navAccount3,
                                                size: 15.0,
                                                color: AllColors.figmaGrey,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child:
                                                    ResponsiveText.getSubTitle(
                                                        context,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AllColors.figmaGrey,
                                                        selected
                                                            .contactPersonName!),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 11),
                                        if (selected.companyEmail?.isNotEmpty ==
                                            true)
                                          Row(
                                            children: [
                                              SvgIcon(
                                                assetPath: IconStrings.email,
                                                size: 15.0,
                                                color: AllColors.figmaGrey,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: ResponsiveText
                                                    .getEmailTitle(context,
                                                        selected.companyEmail!,
                                                        fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 11),
                                        if (selected.companyPhone?.isNotEmpty ==
                                            true)
                                          Row(
                                            children: [
                                              SvgIcon(
                                                assetPath: IconStrings.phone,
                                                size: 15.0,
                                                color: AllColors.figmaGrey,
                                              ),
                                              const SizedBox(width: 6),
                                              ResponsiveText.getEmailTitle(
                                                  context,
                                                  selected.companyPhone!,
                                                  fontSize: 13),
                                            ],
                                          ),
                                        const SizedBox(height: 11),
                                        if (selected.address?.isNotEmpty ==
                                                true ||
                                            selected.city?.name?.isNotEmpty ==
                                                true)
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SvgIcon(
                                                assetPath: IconStrings.location,
                                                size: 15.0,
                                                color: AllColors.figmaGrey,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  [
                                                    selected.address,
                                                    selected.city?.name,
                                                    selected.state?.name,
                                                  ]
                                                      .where((e) =>
                                                          e != null &&
                                                          e.isNotEmpty)
                                                      .join(', '),
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey[600]),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 6),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 40, // Slightly larger for prominence
                                    height: 40,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.green[300]!,
                                          Colors.green[500]!
                                        ], // Green gradient for consistency
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(28),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[300]!,
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      image: selected.logo != null &&
                                              selected.logo!.isNotEmpty
                                          ? DecorationImage(
                                              image: NetworkImage(selected
                                                  .logo!), // Use logo if available
                                              fit: BoxFit.cover,
                                              onError: (exception,
                                                      stackTrace) =>
                                                  const AssetImage(
                                                      'assets/placeholder.png'),
                                            )
                                          : null,
                                    ),
                                    child: selected.logo == null ||
                                            selected.logo!.isEmpty
                                        ? Center(
                                            child: Text(
                                              selected.companyName
                                                          ?.isNotEmpty ==
                                                      true
                                                  ? selected.companyName!
                                                      .substring(0, 1)
                                                      .toUpperCase()
                                                  : 'C',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                                fontFamily: FontFamily.sfPro,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 16),
                                  Material(
                                    color:
                                        Colors.red[50], // Softer red background
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(30),
                                      onTap: controller.removeSelectedCustomer,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red[600],
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    }),
                    SizedBox(
                      height: 11,
                    ),
                    ContainerUtils(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ResponsiveText.getSubTitle(
                                      context,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: DarkMode.filter(context),
                                      widget.customerData?.firstName ??
                                          'Unknown',
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: AllColors.figmaGrey,
                                        )),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        controller.selectCustomerById(
                                            widget.customerData?.id ?? '');
                                      },
                                      child: Obx(() => Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: controller
                                                          .selectedCustomerId
                                                          .value ==
                                                      (widget.customerData
                                                              ?.id ??
                                                          '')
                                                  ? AllColors.mediumPurple
                                                  : Colors.transparent,
                                              border: Border.all(
                                                color: controller
                                                            .selectedCustomerId
                                                            .value ==
                                                        (widget.customerData
                                                                ?.id ??
                                                            '')
                                                    ? AllColors.mediumPurple
                                                    : Colors.grey,
                                                width: 2,
                                              ),
                                            ),
                                            child: controller.selectedCustomerId
                                                        .value ==
                                                    (widget.customerData?.id ??
                                                        '')
                                                ? Icon(Icons.check,
                                                    color: Colors.white,
                                                    size: 16)
                                                : null,
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 0),
                                Row(
                                  children: [
                                    SvgIcon(
                                      assetPath: IconStrings.email,
                                      size: 15.0,
                                      color: AllColors.figmaGrey,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: ResponsiveText.getEmailTitle(
                                          context,
                                          widget.customerData?.primaryEmail,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 11),
                                Row(
                                  children: [
                                    SvgIcon(
                                      assetPath: IconStrings.phone,
                                      size: 15.0,
                                      color: AllColors.figmaGrey,
                                    ),
                                    const SizedBox(width: 6),
                                    ResponsiveText.getEmailTitle(context,
                                        widget.customerData?.primaryContact,
                                        fontSize: 13),
                                  ],
                                ),
                                const SizedBox(height: 11),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgIcon(
                                      assetPath: IconStrings.location,
                                      size: 15.0,
                                      color: AllColors.figmaGrey,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: ResponsiveText.getSubTitle(context,
                                          widget.customerData?.primaryAddress,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonSizedBox.height(context, 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomerDetailsBottomSheet(
      BuildContext context, CustToCustMergCustListResponseModel customer) {
    final bool isDesktop = MediaQuery.of(context).size.width > 600;

    if (isDesktop) {
      showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        builder: (context) => Align(
          alignment: Alignment.centerRight,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 400, // Adjust as needed
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    bottomLeft: Radius.circular(28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: _buildCustomerDetailsContent(context, customer),
              ),
            ),
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.80,
          minChildSize: 0.5,
          maxChildSize: 0.80,
          expand: false,
          builder: (context, scrollController) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 24,
                  offset: Offset(0, -8),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: _buildCustomerDetailsContent(
                context, customer, scrollController),
          ),
        ),
      );
    }
  }

  Widget _buildCustomerDetailsContent(
      BuildContext context, CustToCustMergCustListResponseModel customer,
      [ScrollController? scrollController]) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(
              bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1),
            ),
          ),
          child: Column(
            children: [
              if (scrollController != null)
                Container(
                  width: 48,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1D5DB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Customer Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                        fontFamily: FontFamily.sfPro,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close_rounded,
                          color: Color(0xFF6B7280), size: 22),
                      onPressed: () => Navigator.pop(context),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AllColors.mediumPurple.withOpacity(0.08),
                        AllColors.mediumPurple.withOpacity(0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AllColors.mediumPurple.withOpacity(0.12),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: customer.logo != null &&
                                      customer.logo!.isNotEmpty
                                  ? null
                                  : LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        AllColors.mediumPurple,
                                        AllColors.mediumPurple.withOpacity(0.8),
                                      ],
                                    ),
                              image: customer.logo != null &&
                                      customer.logo!.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(customer.logo!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AllColors.mediumPurple.withOpacity(0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: customer.logo == null ||
                                    customer.logo!.isEmpty
                                ? Center(
                                    child: Text(
                                      customer.companyName?.isNotEmpty == true
                                          ? customer.companyName!
                                              .substring(0, 1)
                                              .toUpperCase()
                                          : 'C',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontFamily: FontFamily.sfPro,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  customer.companyName ?? 'Unnamed Company',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xFF1F2937),
                                    fontFamily: FontFamily.sfPro,
                                    letterSpacing: 0,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _buildCompactInfoRow(
                                  SvgIcon(
                                    assetPath: IconStrings.navAccount3,
                                    size: 14.0,
                                    color: AllColors.figmaGrey,
                                  ),
                                  customer.contactPersonName ?? 'N/A',
                                ),
                                const SizedBox(height: 8),
                                _buildCompactInfoRow(
                                  SvgIcon(
                                    assetPath: IconStrings.email,
                                    size: 14.0,
                                    color: AllColors.figmaGrey,
                                  ),
                                  customer.companyEmail ?? 'N/A',
                                ),
                                const SizedBox(height: 8),
                                _buildCompactInfoRow(
                                  SvgIcon(
                                    assetPath: IconStrings.phone,
                                    size: 14.0,
                                    color: AllColors.figmaGrey,
                                  ),
                                  customer.companyPhone ?? 'N/A',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _buildSectionHeader(
                    'Address Information', Icons.location_on_rounded),
                const SizedBox(height: 16),
                _buildInfoCard([
                  _buildDetailRow(Icons.home_outlined, 'Address',
                      customer.address ?? 'N/A'),
                  _buildDetailRow(Icons.location_city_outlined, 'City',
                      customer.city?.name ?? 'N/A'),
                  _buildDetailRow(Icons.pin_drop_outlined, 'Pincode',
                      customer.pincode?.code ?? 'N/A'),
                  _buildDetailRow(Icons.map_outlined, 'District',
                      customer.address ?? 'N/A'),
                  _buildDetailRow(Icons.public_outlined, 'State',
                      customer.state?.name ?? 'N/A'),
                  _buildDetailRow(Icons.flag_outlined, 'Country',
                      customer.country?.name ?? 'N/A'),
                ]),
                const SizedBox(height: 32),
                _buildSectionHeader(
                    'Customer Information', Icons.person_rounded),
                const SizedBox(height: 16),
                _buildInfoCard([
                  _buildDetailRow(Icons.badge_outlined, 'First Name',
                      customer.customer?.firstName ?? 'N/A'),
                  _buildDetailRow(Icons.badge_outlined, 'Last Name',
                      customer.customer?.lastName ?? 'N/A'),
                  _buildDetailRow(
                      Icons.alternate_email_outlined,
                      'Primary Email',
                      customer.customer?.primaryEmail ?? 'N/A'),
                  _buildDetailRow(
                      Icons.phone_android_outlined,
                      'Primary Contact',
                      customer.customer?.primaryContact ?? 'N/A'),
                  _buildDetailRow(Icons.language_outlined, 'Country Code',
                      customer.customer?.countryCode?.toString() ?? 'N/A'),
                  _buildDetailRow(Icons.receipt_long_outlined, 'GSTIN',
                      customer.customer?.gstin ?? 'N/A'),
                  _buildDetailRow(Icons.verified_user_outlined, 'Status',
                      customer.customer?.status ?? 'N/A',
                      isStatus: true),
                ]),
                const SizedBox(height: 24),
                _buildInfoCard([
                  _buildDetailRow(Icons.location_city_outlined, 'Customer City',
                      customer.customer?.city?.name ?? 'N/A'),
                  _buildDetailRow(Icons.pin_drop_outlined, 'Customer Pincode',
                      customer.customer?.pincode?.code ?? 'N/A'),
                  _buildDetailRow(Icons.map_outlined, 'Customer District',
                      customer.customer?.district?.name ?? 'N/A'),
                  _buildDetailRow(Icons.public_outlined, 'Customer State',
                      customer.customer?.state?.name ?? 'N/A'),
                  _buildDetailRow(Icons.flag_outlined, 'Customer Country',
                      customer.customer?.country?.name ?? 'N/A'),
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AllColors.mediumPurple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: AllColors.mediumPurple,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AllColors.mediumPurple,
            fontFamily: FontFamily.sfPro,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children
            .expand((widget) => [
                  widget,
                  if (widget != children.last) const SizedBox(height: 16)
                ])
            .toList(),
      ),
    );
  }

  Widget _buildCompactInfoRow(Widget iconWidget, String value) {
    return Row(
      children: [
        iconWidget,
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4B5563),
              letterSpacing: 0,
              fontFamily: FontFamily.sfPro,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value,
      {bool isStatus = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 16,
            color: const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
              fontSize: 14,
              letterSpacing: 0,
              fontFamily: FontFamily.sfPro,
            ),
          ),
        ),
        Expanded(
          child: isStatus
              ? _buildStatusChip(value)
              : Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 14,
                    fontFamily: FontFamily.sfPro,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color statusColor;
    Color bgColor;

    switch (status.toLowerCase()) {
      case 'active':
        statusColor = const Color(0xFF059669);
        bgColor = const Color(0xFFD1FAE5);
        break;
      case 'inactive':
        statusColor = const Color(0xFFDC2626);
        bgColor = const Color(0xFFFEE2E2);
        break;
      default:
        statusColor = const Color(0xFF6B7280);
        bgColor = const Color(0xFFF3F4F6);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: statusColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: FontFamily.sfPro,
          letterSpacing: 0,
        ),
      ),
    );
  }

  Widget _buildErrorText(String? errorText) {
    if (errorText == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 4, bottom: 8),
      child: Text(
        errorText,
        style: TextStyle(
          color: AllColors.vividRed,
          fontSize: 12,
          fontFamily: FontFamily.sfPro,
          letterSpacing: 0,
        ),
      ),
    );
  }

  void _showCustomerSearchDialog(BuildContext context) {
    final controller = Get.find<CustomerToCustomerMergeController>();
    Timer? debounceTimer;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 24,
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 450,
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AllColors.mediumPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.people_alt_outlined,
                          color: AllColors.whiteColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ResponsiveText.getTitle(
                              context,
                              Strings.searchCustomer,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey.shade600,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              right: 15, left: 15, top: 11, bottom: 11),
                          border: InputBorder.none,
                          hintText: 'Type to search customers...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 16,
                          ),
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey.shade500,
                              size: 20,
                            ),
                          ),
                          suffixIcon: const SizedBox.shrink(),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (value) {
                          controller.updateSearchQuery(value);

                          if (debounceTimer?.isActive ?? false) {
                            debounceTimer!.cancel();
                          }

                          debounceTimer = Timer(
                            const Duration(milliseconds: 300),
                            () {
                              final mergeViewModel =
                                  Get.find<CustToCustMergCustViewModel>();
                              mergeViewModel.fetchCustToCustMergeList(
                                widget.customerId,
                                searchQuery: value,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      final customers = controller.filteredCustomers;

                      if (customers.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.search_off,
                                  size: 48,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No customers found',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try adjusting your search terms',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, bottom: 0, top: 10),
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          final customer = customers[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  controller.selectCustomer(customer);
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: AllColors.microPurple,
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Text(
                                            (customer.companyName ?? 'U')
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: AllColors.mediumPurple,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ResponsiveText.getTitle(
                                              fontSize: 15,
                                              context,
                                              customer.companyName ?? 'No Name',
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              [
                                                customer.contactPersonName,
                                                customer.companyEmail,
                                                customer.companyPhone
                                              ]
                                                  .where((e) =>
                                                      e != null && e.isNotEmpty)
                                                  .join(' • '),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade600,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color: Colors.grey.shade400,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onMergePressed(BuildContext context) async {
    final controller = Get.find<CustomerToCustomerMergeController>();
    final mergeViewModel = Get.find<CustToCustMergCustViewModel>();
    final assignedLeadViewModel = Get.find<AssignedLeadToViewModel>();

    if (controller.firstNameController.text.trim().isEmpty ||
        controller.emailEntries.isEmpty ||
        controller.phoneEntries.isEmpty ||
        controller.selectedCustomer.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Please fill all required fields and select a customer to merge.')),
      );
      return;
    }

    // Determine primary and secondary customer IDs
    String primaryCustomerId;
    String secondaryCustomerId;
    if (controller.selectedCustomerId.value.isNotEmpty) {
      if (controller.selectedCustomerId.value == widget.customerId) {
        primaryCustomerId = widget.customerId;
        secondaryCustomerId = controller.selectedCustomer.value?.id ?? '';
      } else {
        primaryCustomerId = controller.selectedCustomer.value?.id ?? '';
        secondaryCustomerId = widget.customerId;
      }
    } else {
      primaryCustomerId = widget.customerId;
      secondaryCustomerId = controller.selectedCustomer.value?.id ?? '';
    }

    // Prepare secondary mobiles
    List<SecondaryMobile>? secondaryMobiles = controller.phoneEntries.length > 1
        ? controller.phoneEntries
            .skip(1)
            .map((e) => SecondaryMobile(
                  countryCode: e.countryCode,
                  mobile: e.controller.text.trim(),
                ))
            .toList()
        : null;

    // Prepare divisions as a list
    List<String>? divisions = controller.divisionController.text.isNotEmpty
        ? controller.divisionController.text
            .split(',')
            .map((e) => e.trim())
            .toList()
        : null;

    // Prepare DOB as string
    String? dob = controller.dobController.text.trim().isNotEmpty
        ? controller.dobController.text.trim()
        : null;

    // Prepare assignees as an array
    List<String> assignees = [];
    if (assignedLeadViewModel.selectedLeadId.value.isNotEmpty) {
      assignees.add(assignedLeadViewModel.selectedLeadId.value);
    }

    final reqModel = CustomerToCustomerMergeReqModel(
      primaryCustomer: primaryCustomerId,
      secondaryCustomer: secondaryCustomerId,
      firstName: controller.firstNameController.text.trim(),
      lastName: controller.lastNameController.text.trim(),
      primaryEmail: controller.emailEntries[0].controller.text.trim(),
      secondaryEmails: controller.emailEntries.length > 1
          ? controller.emailEntries
              .skip(1)
              .map((e) => e.controller.text.trim())
              .toList()
          : null,
      primaryContact: controller.phoneEntries[0].controller.text.trim(),
      countryCode: controller.phoneEntries[0].countryCode,
      secondaryMobiles: secondaryMobiles,
      dob: dob,
      divisions: divisions,
      websites: controller.websiteController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      gstin: controller.gstController.text.trim(),
      otherInformation: controller.requirementController.text.trim(),
      primaryAddress: controller.streetAddressController.text.trim(),
      pincode: controller.pincodeController.text.trim(),
      city: controller.cityController.text.trim(),
      district: controller.districtController.text.trim(),
      state: controller.stateController.text.trim(),
      country: controller.countryController.text.trim(),
      assignees: assignees, // Include assignees
    );

    print('=== Merge API Request ===');
    print('Payload: ${jsonEncode(reqModel.toJson())}');
    print('=======================');

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final result = await mergeViewModel.customerToCustomerMerge(reqModel);

      Navigator.of(context).pop(); // Remove loading

      if (result != null) {
        final model = result['model'] as CustomerToCustomerMergeResModel?;
        final statusCode = result['statusCode'] as int?;

        print('=== Merge API Response ===');
        print('Status Code: $statusCode');
        print('Response Model: ${model?.toJson() ?? 'Null'}');
        if (mergeViewModel.errorMessage.value.isNotEmpty) {
          print(
              'ViewModel Error Message: ${mergeViewModel.errorMessage.value}');
        }
        print('=========================');

        if (model != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Customers merged successfully!')),
          );
          controller.navigateToCustomerDetails(primaryCustomerId);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to merge customers.')),
          );
        }
      } else {
        print('=== Merge API Response ===');
        print('Status Code: Unknown (null result)');
        print('Response: Null');
        print('ViewModel Error Message: ${mergeViewModel.errorMessage.value}');
        print('=========================');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to merge customers.')),
        );
      }
    } catch (e, stackTrace) {
      Navigator.of(context).pop(); // Remove loading
      print('=== Merge API Error ===');
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      print('ViewModel Error Message: ${mergeViewModel.errorMessage.value}');
      print('======================');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _onPlaceSelected(Prediction prediction) async {
    final controller = Get.find<CustomerToCustomerMergeController>();
    try {
      controller.setLoading(true);
      controller.streetAddressController.text = prediction.description ?? '';
      if (prediction.placeId != null) {
        await _getPlaceDetails(prediction.placeId!);
      } else {
        throw Exception("Place ID is null");
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error getting place details: $e")),
        );
      }
    } finally {
      controller.setLoading(false);
    }
  }

  Future<void> _getPlaceDetails(String placeId) async {
    final controller = Get.find<CustomerToCustomerMergeController>();
    try {
      List<Location> locations =
          await locationFromAddress(controller.streetAddressController.text);
      if (locations.isEmpty) {
        throw Exception("No location data found");
      }
      final lat = locations.first.latitude;
      final lng = locations.first.longitude;
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        List<String> addressParts = [];
        if (place.street?.isNotEmpty == true) addressParts.add(place.street!);
        if (place.locality?.isNotEmpty == true)
          addressParts.add(place.locality!);
        controller.streetAddressController.text = addressParts.isNotEmpty
            ? addressParts.join(", ")
            : "Address not available";
        controller.cityController.text = place.locality?.isNotEmpty == true
            ? place.locality!
            : "Not available";
        controller.districtController.text =
            place.subAdministrativeArea?.isNotEmpty == true
                ? place.subAdministrativeArea!
                : "Not available";
        controller.stateController.text =
            place.administrativeArea?.isNotEmpty == true
                ? place.administrativeArea!
                : "Not available";
        controller.countryController.text = place.country?.isNotEmpty == true
            ? place.country!
            : "Not available";
        controller.pincodeController.text = place.postalCode?.isNotEmpty == true
            ? place.postalCode!
            : "Not available";
      } else {
        throw Exception("No placemark data found");
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching details: $e")),
        );
      }
    }
  }
}
