import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:websuites/data/models/responseModels/leads/createNewLead/pincode/pincode.dart'
    show Country, District, PinCodeModelResponseModel, StateModel;
import 'package:websuites/utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import 'package:websuites/data/models/responseModels/leads/list/lead_list.dart';
import 'package:websuites/resources/strings/strings.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/button/section_divider/SectionDivider.dart';
import 'package:websuites/utils/components/widgets/appBar/custom_appBar.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/textfield/multipleCategoriesCreate/MultipleCategoriesCreate.dart'
    as custom;
import 'package:websuites/viewModels/leadScreens/createNewLead/assignedLeadTo/assigned_lead_to_viewModel.dart';
import 'package:websuites/viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import 'package:websuites/viewModels/leadScreens/createNewLead/pincode/pincode_view_model.dart';
import 'package:websuites/viewModels/leadScreens/createNewLead/product_category/product_category_controller.dart';
import 'package:websuites/viewModels/leadScreens/lead_list/pin_code_city_search/PinCodeCityViewModel.dart';
import 'package:websuites/viewModels/leadScreens/trashLeads/leadTypes/lead_type_viewModel.dart';

import '../../../data/models/requestModels/customer/create/customer_create_req_model.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../resources/svg/svg_string.dart';
import '../../../resources/textStyles/responsive/test_responsive.dart';
import '../../../resources/textStyles/text_styles.dart';
import '../../../utils/common_responsive_list/common_responsive_list.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/responsive/responsive_utils.dart';
import '../../../utils/reusable_validation/RequiredLabel.dart';
import '../../../viewModels/customerScreens/create/customer_create_view_model.dart';
import '../../../viewModels/leadScreens/setting/lead_source/lead_source_view_model.dart';
import '../../customerScreens/customerList/customerdetails/customer_to_customer_merge/customer_to_customer_merge_screen.dart';
import '../../homeScreen/home_manager/HomeManagerScreen.dart';
import 'dart:async';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kGoogleApiKey = "AIzaSyDxwry1lYYabQCLUPego1qSNPtDafKjWMg";

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

class CustomerCreateController extends GetxController {
  final TextEditingController gstinController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController otherInformationController = TextEditingController();
  final TextEditingController aboutClientController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();

  // Non-Indian controllers
  final TextEditingController nonIndiaAddressController =
      TextEditingController();
  final TextEditingController nonIndiaPincodeController =
      TextEditingController();
  final TextEditingController nonIndiaCityController = TextEditingController();
  final TextEditingController nonIndiaDistrictController =
      TextEditingController();
  final TextEditingController nonIndiaStateController = TextEditingController();
  final TextEditingController nonIndiaCountryController =
      TextEditingController();

  RxList<PhoneNumberEntry> phoneEntries = <PhoneNumberEntry>[].obs;
  RxList<EmailEntry> emailEntries = <EmailEntry>[].obs;
  RxDouble? lat = RxDouble(30.6353881);
  RxDouble? lng = RxDouble(76.80029069999999);

  Timer? _debounceTimer;
  bool _isAdding = false;

  CustomerCreateController() {
    // Initialize with one phone entry
    phoneEntries.add(PhoneNumberEntry(
      controller: TextEditingController(),
      countryCode: '+91',
      countryFlag: 'IN',
    ));

    // Initialize with one email entry
    emailEntries.add(EmailEntry(
      controller: TextEditingController(),
    ));
    print('Initialized with 1 phone entry and 1 email entry.');
  }

  void addPhoneEntry() {
    if (_isAdding || (_debounceTimer?.isActive ?? false)) return;
    _isAdding = true;

    _debounceTimer = Timer(const Duration(milliseconds: 50), () {
      phoneEntries.add(PhoneNumberEntry(
        controller: TextEditingController(),
        countryCode: '+91',
        countryFlag: 'IN',
      ));
      print('Added phone entry. Total: ${phoneEntries.length}');
      phoneEntries.refresh();
      _isAdding = false;
    });
  }

  void removePhoneEntry(int index) {
    if (_isAdding || (_debounceTimer?.isActive ?? false)) return;
    if (phoneEntries.length > 1 && index >= 0 && index < phoneEntries.length) {
      _isAdding = true;
      _debounceTimer = Timer(const Duration(milliseconds: 50), () {
        final entry = phoneEntries.removeAt(index);
        entry.controller.dispose();
        print(
            'Removed phone entry at index $index. Total: ${phoneEntries.length}');
        phoneEntries.refresh();
        _isAdding = false;
      });
    } else {
      Get.snackbar('Error', 'At least one phone number is required');
    }
  }

  void addEmailEntry() {
    if (_isAdding || (_debounceTimer?.isActive ?? false)) return;
    _isAdding = true;

    _debounceTimer = Timer(const Duration(milliseconds: 50), () {
      emailEntries.add(EmailEntry(
        controller: TextEditingController(),
      ));
      print('Added email entry. Total: ${emailEntries.length}');
      emailEntries.refresh();
      _isAdding = false;
    });
  }

  void removeEmailEntry(int index) {
    if (_isAdding || (_debounceTimer?.isActive ?? false)) return;
    if (emailEntries.length > 1 && index >= 0 && index < emailEntries.length) {
      _isAdding = true;
      final entry = emailEntries[index];
      emailEntries.removeAt(index);
      entry.controller.dispose();
      print(
          'Removed email entry at index $index. Total: ${emailEntries.length}');
      emailEntries.refresh();
      _isAdding = false;
    } else {
      Get.snackbar('Error', 'At least one email is required');
    }
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    gstinController.dispose();
    dobController.dispose();
    otherInformationController.dispose();
    aboutClientController.dispose();
    organizationController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    districtController.dispose();
    stateController.dispose();
    countryController.dispose();
    addressController.dispose();
    sourceController.dispose();
    nonIndiaAddressController.dispose();
    nonIndiaPincodeController.dispose();
    nonIndiaCityController.dispose();
    nonIndiaDistrictController.dispose();
    nonIndiaStateController.dispose();
    nonIndiaCountryController.dispose();
    for (var entry in phoneEntries) {
      entry.controller.dispose();
    }
    for (var entry in emailEntries) {
      entry.controller.dispose();
    }
    super.onClose();
  }
}

class CustomerCreateScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isCompact;

  const CustomerCreateScreen({
    Key? key,
    required this.scaffoldKey,
    this.isCompact = false,
  }) : super(key: key);

  @override
  _CustomerCreateScreenState createState() => _CustomerCreateScreenState();
}

class _CustomerCreateScreenState extends State<CustomerCreateScreen> {
  final List<Map<String, dynamic>> fieldItems = List.generate(
    20,
    (index) => {
      "hint": "hello",
      "categories": ["hello 1", "hello 2", "hello 3", "hello 4"],
    },
  );

  bool isFloatingButtonClicked = false;
  File? selectedFile;
  String? fileName;
  final RxMap<String, bool> fieldTouched = <String, bool>{
    'first_name': false,
    'email': false,
    'source': false,
    'mobileNo': false,
    'divisions': false,
  }.obs;
  late final custom.SearchController searchController;

  void markFieldTouched(String field) {
    fieldTouched[field] = true;
    fieldTouched.refresh();
  }

  void resetTouchedFields() {
    fieldTouched.updateAll((key, value) => false);
  }

  final Map<String, String?> _validationErrors = {
    'first_name': null,
    'mobileNo': null,
    'leadStatus': null,
    'remark': null,
    'reminderTo': null,
    'notifiedOn': null,
    'productCategory': null,
    'leadSubType': null,
  };

  final _formKey = GlobalKey<FormState>(); // Add form key for validation
  late final CustomerCreateController controller;
  int _selectedIndex = 0;
  bool isStepperVisible = true;
  int _currentStep = 0;
  bool isListView = true;
  late TextEditingController pincodeController; // Added for pincode

  final LeadTypeViewModel leadTypeViewModel = Get.put(LeadTypeViewModel());
  final AssignedLeadToViewModel _assignedLeadToController =
      Get.put(AssignedLeadToViewModel());
  final LeadSourceListViewModel _assignedSourceController =
      Get.put(LeadSourceListViewModel());
  final DivisionsViewModel divisionsController = Get.put(DivisionsViewModel());
  final ProductCategoryController productCategoryController =
      Get.put(ProductCategoryController());
  final PinCodeCityViewModel pinCodeCityViewModel =
      Get.put(PinCodeCityViewModel());

  final PinCodeViewModel _pincodeViewModel = Get.put(PinCodeViewModel());
  final PinCodeCityViewModel _cityViewModel = Get.put(PinCodeCityViewModel());

  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  String selectedStateId = '';
  String selectedCityId = '';

  @override
  void initState() {
    searchController = Get.put(custom.SearchController());
    controller = Get.put(CustomerCreateController());
    _assignedLeadToController.fetchAssignedLeads(context);
    _assignedSourceController.fetchLeadSourceList(context);
    productCategoryController.createLeadProductCategory(context);
    Get.put(CustomerCreateViewModel());
    super.initState();
    divisionsController.fetchDivisions(); // Pass context
    ever(divisionsController.divisionsList, (List divisions) {
      print('Divisions List: $divisions');
    });

    _pincodeController.addListener(() {
      final query = _pincodeController.text.trim();
      print('✍️ [UI] Pincode input: "$query"');

      if (query.isEmpty) {
        _clearFields();
        _pincodeViewModel.clear();
        _cityViewModel.clear();
        _cityController.clear();
        return;
      }

      if (query.length < 6) {
        _pincodeViewModel.searchPartialPincode(query);
      } else if (query.length == 6 && RegExp(r'^\d{6}$').hasMatch(query)) {
        _pincodeViewModel.searchPincode(query);
      }
    });

    _cityController.addListener(() {
      final query = _cityController.text.trim();
      print('✍️ [UI] City input: "$query"');
      _onCitySearch(query);
    });

    ever(_pincodeViewModel.searchResults, (List results) {
      if (results.isNotEmpty) {
        _updateFields(results.first);
      }
    });

    ever(_pincodeViewModel.matchingCity, (String city) {
      if (city.isNotEmpty && city != 'No City') {
        _districtController.text = city;
      }
    });

    ever(_pincodeViewModel.matchingState, (String state) {
      if (state.isNotEmpty && state != 'No State') {
        _stateController.text = state;
      }
    });

    ever(_pincodeViewModel.errorMessage, (String error) {
      if (error.isNotEmpty) {
        _clearFields();
        _cityController.clear();
      }
    });
  }

  bool _validateFields({bool validateAll = false}) {
    print('=== Starting _validateFields ===');
    bool isValid = true;
    setState(() {
      _validationErrors.updateAll((key, value) => null);

      // First Name
      if (validateAll || fieldTouched['first_name']!) {
        print('Validating First Name: ${controller.firstNameController.text}');
        if (controller.firstNameController.text.trim().isEmpty) {
          _validationErrors['first_name'] = 'First Name is required';
          print("Validation failed: First Name is empty");
          isValid = false;
        }
      }

      // Primary Email
      if (validateAll || fieldTouched['email']!) {
        final primaryEmail = controller.emailEntries[0].controller.text.trim();
        print('Validating Primary Email: $primaryEmail');
        if (primaryEmail.isEmpty) {
          _validationErrors['email'] = 'Primary Email is required';
          print("Validation failed: Primary Email is empty");
          isValid = false;
        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(primaryEmail)) {
          _validationErrors['email'] = 'Enter a valid email address';
          print("Validation failed: Invalid Primary Email format");
          isValid = false;
        }
      }

      // Source
      if (validateAll || fieldTouched['source']!) {
        print('Validating Source: ${controller.sourceController.text}');
        if (controller.sourceController.text.trim().isEmpty) {
          _validationErrors['source'] = 'Source is required';
          print("Validation failed: Source is empty");
          isValid = false;
        }
      }

      // Mobile Number
      if (validateAll || fieldTouched['mobileNo']!) {
        final primaryPhone = controller.phoneEntries[0].controller.text.trim();
        print('Validating Mobile Number: $primaryPhone');
        if (primaryPhone.isEmpty) {
          _validationErrors['mobileNo'] = 'Mobile Number is required';
          print("Validation failed: Mobile Number is empty");
          isValid = false;
        } else if (!RegExp(r'^\d{10}$').hasMatch(primaryPhone)) {
          _validationErrors['mobileNo'] =
              'Enter a valid 10-digit mobile number';
          print("Validation failed: Invalid Mobile Number format");
          isValid = false;
        }
      }

      // Divisions
      // Divisions
      if (validateAll || fieldTouched['divisions']!) {
        print('Validating Divisions: ${divisionsController.selectedDivisions}');
        if (divisionsController.selectedDivisions.isEmpty) {
          _validationErrors['divisions'] = 'At least one division is required';
          print("Validation failed: No divisions selected");
          isValid = false;
        }
      }

      print("Validation result: $isValid, Errors: $_validationErrors");
    });
    print('=== End of _validateFields ===');
    return isValid;
  }

  void _updateFields(dynamic pincodeData) {
    if (pincodeData.district != null) {
      _districtController.text = pincodeData.district.name ?? '';
      if (pincodeData.district.state != null) {
        _stateController.text = pincodeData.district.state.name ?? '';
        selectedStateId = pincodeData.district.state.id ?? '';
        String? countryName = pincodeData.district.state.country?.name;
        if (countryName == null || countryName
            .trim()
            .isEmpty || countryName.trim().toLowerCase().contains('india')) {
          _countryController.text = 'India';
        } else {
          _countryController.text = countryName;
      }
      } else {
        // Fallback for missing state data
        _countryController.text = 'India';
      }
    } else {
      // Fallback for missing district data
      _countryController.text = 'India';
    }
    _cityViewModel.clear();
    _cityController.clear();
    selectedCityId = '';
  }

  void _clearFields() {
    _districtController.clear();
    _stateController.clear();
    _countryController.clear();
    controller.addressController.clear(); // Add this line
    selectedStateId = '';
    selectedCityId = '';
  }

  void _onCitySearch(String query) {
    print('🔍 [UI] Triggering city search with query: "$query"');
    if (query.isNotEmpty && selectedStateId.isNotEmpty) {
      _cityViewModel.searchCities(selectedStateId, query);
    } else {
      print(
          '⚠️ [UI] Cannot search: Query="$query", StateId="$selectedStateId"');
      _cityViewModel.clear();
    }
  }

  void _onCitySelected(String? cityId, String? cityName) {
    if (cityId != null && cityName != null) {
      selectedCityId = cityId;
      _cityController.text = cityName;
      print('✅ [UI] Selected city: $cityName (ID: $cityId)');
    }
  }

  void _validateAndNext() {
    markFieldTouched('first_name');
    markFieldTouched('email');
    markFieldTouched('source');
    markFieldTouched('mobileNo');
    markFieldTouched('divisions');

    if (_validateFields(validateAll: true)) {
      _nextStep();
    } else {
      setState(() {});
      String errorMessage = 'Please correct the following errors:\n';
      _validationErrors.forEach((key, value) {
        if (value != null) {
          errorMessage += '- $value\n';
        }
      });
      Get.snackbar(
        'Validation Error',
        errorMessage,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        maxWidth: 400,
      );
    }
  }

  @override
  void dispose() {
    for (var entry in controller.phoneEntries) {
      entry.controller.dispose();
    }
    for (var entry in controller.emailEntries) {
      entry.controller.dispose();
    }
    controller.phoneEntries.clear();
    controller.emailEntries.clear();
    super.dispose();
  }

  void _toggleStepperVisibility() {
    setState(() {
      isStepperVisible = !isStepperVisible;
    });
  }

  void _printAllFields() {
    print('--- Customer Create Form Fields ---');
    print('First Name: ${controller.firstNameController.text}');
    print('Last Name: ${controller.lastNameController.text}');
    print('Primary Email: ${controller.emailEntries[0].controller.text}');
    print('All Emails: ${controller.emailEntries.map((e) => e.controller.text).toList()}');
    print('Primary Phone: ${controller.phoneEntries[0].controller.text}');
    print('All Phones: ${controller.phoneEntries.map((e) => e.controller.text).toList()}');
    print('Source: ${controller.sourceController.text}');
    print('Divisions: ${divisionsController.selectedDivisions}');
    print('Organization: ${controller.organizationController.text}');
    print('DOB: ${controller.dobController.text}');
    print('GSTIN: ${controller.gstinController.text}');
    print('Address: ${controller.addressController.text}');
    print('Pincode: ${_pincodeController.text}');
    print('City: ${_cityController.text}');
    print('District: ${_districtController.text}');
    print('State: ${_stateController.text}');
    print('Country: ${_countryController.text}');
    print('Non-India Address: ${controller.nonIndiaAddressController.text}');
    print('Non-India Pincode: ${controller.nonIndiaPincodeController.text}');
    print('Non-India City: ${controller.nonIndiaCityController.text}');
    print('Non-India District: ${controller.nonIndiaDistrictController.text}');
    print('Non-India State: ${controller.nonIndiaStateController.text}');
    print('Non-India Country: ${controller.nonIndiaCountryController.text}');
    print('Websites: ${searchController.textEntries}');
    print('--- End of Fields ---');
  }
  void _nextStep() {
    if (_currentStep < 1) {
      setState(() {
        _currentStep += 1;
        print('Navigated to step: $_currentStep'); // Debug print
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void _submitForm() {
    print('Submitting form...');
    if (_validateFields(validateAll: true)) {
      // Prepare the file for upload, if selected
      File? initialPaymentAttachment = selectedFile; // Assign File? directly
      if (selectedFile != null) {
        print('Selected file path: ${selectedFile!.path}');
      }

      final model = CustomerCreateRequestModel(
        websites: searchController.textEntries,
        divisions: divisionsController.selectedDivisions,
        source: _assignedSourceController.selectedSourceId.value,
        addressType: _selectedIndex == 0 ? 'indian' : 'non_indian',
        gstin: controller.gstinController.text.isEmpty
            ? ''
            : controller.gstinController.text,
        organization: controller.organizationController.text,
        dob: controller.dobController.text.isEmpty ? '' : controller.dobController.text,
        assignedTo: _assignedLeadToController.selectedLeadId.value,
        customerType: leadTypeViewModel.selectedLeadTypeId.value,
        country: _selectedIndex == 0 ? _countryController.text : controller.nonIndiaCountryController.text,
        state: _selectedIndex == 0
            ? _stateController.text
            : controller.nonIndiaStateController.text,
        district: _selectedIndex == 0
            ? _districtController.text
            : controller.nonIndiaDistrictController.text,
        pincode: _selectedIndex == 0
            ? _pincodeController.text
            : controller.nonIndiaPincodeController.text,
        city: _selectedIndex == 0
            ? _cityController.text
            : controller.nonIndiaCityController.text,
        otherInformation: controller.otherInformationController.text.isEmpty
            ? ''
            : controller.otherInformationController.text,
        aboutClient: controller.aboutClientController.text,
        primaryAddress: _selectedIndex == 0
            ? controller.addressController.text
            : controller.nonIndiaAddressController.text,
        primaryContact: controller.phoneEntries[0].controller.text,
        primaryEmail: controller.emailEntries[0].controller.text,
        lastName: controller.lastNameController.text,
        firstName: controller.firstNameController.text,
        type: leadTypeViewModel.selectedLeadTypeId.value,
        countryCode: controller.phoneEntries[0].countryCode,
        lat: controller.lat?.value ?? 30.6353881,
        lng: controller.lng?.value ?? 76.80029069999999,
        order: null,
        orderPerformaInvoice: null,
        initialPaymentAttachment: initialPaymentAttachment, // Pass File? object
        serviceArea: null,
      );

      // Print the payload
      print('--- Customer Create Payload ---');
      print('First Name: ${model.firstName}');
      print('Last Name: ${model.lastName}');
      print('Primary Email: ${model.primaryEmail}');
      print('Primary Contact: ${model.primaryContact}');
      print('Country Code: ${model.countryCode}');
      print('Websites: ${model.websites}');
      print('Divisions: ${model.divisions}');
      print('Source: ${model.source}');
      print('Address Type: ${model.addressType}');
      print('GSTIN: ${model.gstin}');
      print('Organization: ${model.organization}');
      print('DOB: ${model.dob}');
      print('Assigned To: ${model.assignedTo}');
      print('Customer Type: ${model.customerType}');
      print('Country: ${model.country}');
      print('State: ${model.state}');
      print('District: ${model.district}');
      print('Pincode: ${model.pincode}');
      print('City: ${model.city}');
      print('Other Information: ${model.otherInformation}');
      print('About Client: ${model.aboutClient}');
      print('Primary Address: ${model.primaryAddress}');
      print('Latitude: ${model.lat}');
      print('Longitude: ${model.lng}');
      print('Initial Payment Attachment: ${model.initialPaymentAttachment?.path ?? 'null'}');
      print('--- End of Payload ---');

      final viewModel = Get.find<CustomerCreateViewModel>();
      viewModel.createCustomer(model, context).then((_) {
        Get.snackbar("Success", "Customer created successfully!");
        Get.off(() => HomeManagerScreen());
      }).catchError((e) {
        // Print the error with status code
        String errorMessage = e.toString().replaceFirst('Exception: ', '');
        print('Submission Error: $errorMessage');
        Get.snackbar(
          "Error",
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
          maxWidth: 400,
        );
      });
    } else {
      String errorMessage = 'Please correct the following errors:\n';
      _validationErrors.forEach((key, value) {
        if (value != null) {
          errorMessage += '- $value\n';
        }
      });
      print('Validation Errors: $errorMessage');
      Get.snackbar(
        'Validation Error',
        errorMessage,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        maxWidth: 400,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double fieldWidth = ResponsiveUtilsScreenSize.getFieldWidth(context);
    final double wrapSpacing =
        ResponsiveUtilsScreenSize.getWrapSpacing(context);

    if (widget.isCompact) {
      return Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border(
                  right: BorderSide(color: Colors.grey[400]!),
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      setState(() {
                        selectedFile = File(image.path);
                        fileName = image.name;
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Center(
                      child: Text(
                        'Choose file',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  fileName ?? 'No file chosen',
                  style: TextStyle(
                    color: fileName != null ? Colors.black87 : Colors.grey[600],
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      );
    }
    final homeController = Get.find<HomeManagerController>();

    final custom.SearchController searchController =
        Get.put(custom.SearchController());

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          setState(() {
            isFloatingButtonClicked = !isFloatingButtonClicked;
          });
        },
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: DarkMode.backgroundColor(context),
      body: Column(
        children: [

          CustomAppBar(
            child: Row(
              children: [
                if (ResponsiveUtilsScreenSize.isMobile(context))
                  GestureDetector(
                    onTap: () {
                      widget.scaffoldKey.currentState?.openDrawer();
                    },
                    child: SvgIcon(
                      assetPath: IconStrings.drawer,
                      color: DarkMode.backgroundColor2(context),
                      // size: 22.0,
                    ),
                  ),
                if (ResponsiveUtilsScreenSize.isMobile(context))
                  SizedBox(
                    width: 10,

                  ),
                ResponsiveText.getAppBarTextSize(context, Strings.customers),
                const Spacer(),

                ResponsiveText.getAppBarTextSize(context, Strings.create),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: ContainerUtils(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isCompact = constraints.maxWidth < 400;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStepperHeader(isCompact),
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _currentStep,
              children: [
                SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                           Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Wrap(
                              spacing: wrapSpacing,
                              runSpacing: 16,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: _printAllFields,
                                  child: Text('Print All Fields'),
                                ),
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(label: Strings.firstName),
                                      const SizedBox(height: 5),
                                      CommonTextField(
                                        hintText: "Enter First Name",
                                        prefixIcon: Icon(Icons.person,
                                            color: Colors.grey, size: 19),
                                        controller:
                                            controller.firstNameController,
                                        hasError:
                                            _validationErrors['first_name'] !=
                                                null,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            setState(() {
                                              _validationErrors['first_name'] =
                                                  'First Name is required';
                                            });
                                            return null;
                                          }
                                          setState(() {
                                            _validationErrors['first_name'] =
                                                null;
                                          });
                                          return null;
                                        },
                                        onChanged: (value) {
                                          markFieldTouched(
                                              'first_name'); // Mark field as touched
                                          setState(() {
                                            if (value.trim().isEmpty) {
                                              _validationErrors['first_name'] =
                                                  'First Name is required';
                                            } else {
                                              _validationErrors['first_name'] =
                                                  null;
                                            }
                                          });
                                        },
                                      ),
                                      _buildErrorText(
                                          _validationErrors['first_name']),
                                    ],
                                  ),
                                ),

                                //    name
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(
                                        label: Strings.lastName,
                                        isRequired: false,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextField(
                                        hintText: "Enter Last Name",
                                        controller:
                                        controller.lastNameController,
                                        onChanged: (value) {
                                          print("Last Name input: $value");
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                //   email
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(
                                          label: Strings.primaryEmailCode),
                                      const SizedBox(height: 5),
                                      Obx(() {
                                        final emailEntries =
                                            controller.emailEntries;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (emailEntries.isNotEmpty)
                                              Padding(
                                                key: const ValueKey(
                                                    'email_entry_0'),
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: CommonTextField(
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value
                                                                  .trim()
                                                                  .isEmpty) {
                                                            setState(() {
                                                              _validationErrors[
                                                                      'email'] =
                                                                  'Primary Email is required';
                                                            });
                                                            return null;
                                                          }
                                                          if (!RegExp(
                                                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                              .hasMatch(value
                                                                  .trim())) {
                                                            setState(() {
                                                              _validationErrors[
                                                                      'email'] =
                                                                  'Enter a valid email address';
                                                            });
                                                            return null;
                                                          }
                                                          setState(() {
                                                            _validationErrors[
                                                                'email'] = null;
                                                          });
                                                          return null;
                                                        },
                                                        hintText: 'Enter Email',
                                                        controller:
                                                            emailEntries[0]
                                                                .controller,
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        prefixIcon: Icon(
                                                            Icons
                                                                .email_outlined,
                                                            color: Colors.grey,
                                                            size: 19),
                                                        hasError:
                                                            _validationErrors[
                                                                    'email'] !=
                                                                null,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            if (value
                                                                .trim()
                                                                .isEmpty) {
                                                              _validationErrors[
                                                                      'email'] =
                                                                  'Primary Email is required';
                                                            } else if (!RegExp(
                                                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                                .hasMatch(value
                                                                    .trim())) {
                                                              _validationErrors[
                                                                      'email'] =
                                                                  'Enter a valid email address';
                                                            } else {
                                                              _validationErrors[
                                                                      'email'] =
                                                                  null;
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    OutlinedButton.icon(
                                                      key: const ValueKey(
                                                          'add_email_button'),
                                                      onPressed: controller
                                                          .addEmailEntry,
                                                      icon: const Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                          size: 19),
                                                      label: const Text(
                                                        "Email",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AllColors
                                                                .mediumPurple,
                                                        side: BorderSide(
                                                            color: AllColors
                                                                .mediumPurple),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 16,
                                                                vertical: 8),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            _buildErrorText(
                                                _validationErrors['email']),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              itemCount: emailEntries.length > 1
                                                  ? emailEntries.length - 1
                                                  : 0,
                                              itemBuilder: (context, index) {
                                                final actualIndex = index + 1;
                                                final entry =
                                                    emailEntries[actualIndex];
                                                return Padding(
                                                  key: ValueKey(
                                                      'email_entry_${entry.controller.hashCode}'),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: CommonTextField(
                                                          key: ValueKey(
                                                              'email_field_${entry.controller.hashCode}'),
                                                          hintText:
                                                              'Enter Email',
                                                          controller:
                                                              entry.controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          validator: (value) {
                                                            if (value != null &&
                                                                value
                                                                    .isNotEmpty) {
                                                              if (!RegExp(
                                                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                                  .hasMatch(
                                                                      value)) {
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
                                                        icon: const Icon(
                                                            Icons.remove_circle,
                                                            color: Colors.red,
                                                            size: 22),
                                                        onPressed: () => controller
                                                            .removeEmailEntry(
                                                                actualIndex),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                                ),

                                //   source
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(label: 'Source'),
                                      const SizedBox(height: 5),
                                      Obx(() => CommonTextField(
                                            categories:
                                                _assignedSourceController
                                                    .sourceList
                                                    .map((source) =>
                                                        source.name ?? '')
                                                    .toList(),
                                            hintText: "Enter Source",
                                            controller:
                                                controller.sourceController,
                                            hasError:
                                                _validationErrors['source'] !=
                                                    null,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                setState(() {
                                                  _validationErrors['source'] =
                                                      'Source is required';
                                                });
                                                return null;
                                              }
                                              setState(() {
                                                _validationErrors['source'] =
                                                    null;
                                              });
                                              return null;
                                            },
                                            onChanged: (value) {
                                              markFieldTouched('source');
                                              setState(() {
                                                if (value.trim().isEmpty) {
                                                  _validationErrors['source'] =
                                                      'Source is required';
                                                } else {
                                                  _validationErrors['source'] =
                                                      null;
                                                }
                                              });
                                            },
                                            onCategoryChanged:
                                                (selectedSource) {
                                              final selectedModel =
                                                  _assignedSourceController
                                                      .sourceList
                                                      .firstWhereOrNull(
                                                          (source) =>
                                                              source.name ==
                                                              selectedSource);
                                              if (selectedModel != null) {
                                                _assignedSourceController
                                                        .selectedSourceId
                                                        .value =
                                                    selectedModel.id ?? '';
                                                _assignedSourceController
                                                    .fetchLeadSourceStatus(
                                                        selectedModel.id ?? '');
                                              }
                                            },
                                          )),
                                      _buildErrorText(
                                          _validationErrors['source']),
                                    ],
                                  ),
                                ),

                                //   dob
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(
                                        label: Strings.dob,
                                        isRequired: false,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextField(
                                      controller: controller.dobController,
                                        hintText: 'dd/mm/yyyy',
                                        isDateField: true,
                                        prefixIcon: Icon(
                                          Icons.date_range_sharp,
                                          size: 16,
                                          color: AllColors.figmaGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // phone
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(label: Strings.mobile),
                                      const SizedBox(height: 5),
                                      Obx(() => Column(
                                            children: controller.phoneEntries
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              int index = entry.key;
                                              PhoneNumberEntry phoneEntry =
                                                  entry.value;

                                              const TextStyle commonTextStyle =
                                                  TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                height: 1.2,
                                              );

                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 130,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child:
                                                            CountryCodePicker(
                                                          onChanged:
                                                              (CountryCode
                                                                  code) {
                                                            phoneEntry
                                                                    .countryCode =
                                                                code.dialCode ??
                                                                    '+91';
                                                            phoneEntry
                                                                    .countryFlag =
                                                                code.code ??
                                                                    'IN';
                                                            String
                                                                currentNumber =
                                                                phoneEntry
                                                                    .controller
                                                                    .text;
                                                            currentNumber =
                                                                currentNumber
                                                                    .replaceAll(
                                                                        RegExp(
                                                                            r'^\+\d+\s*'),
                                                                        '')
                                                                    .trim();
                                                            phoneEntry
                                                                    .controller
                                                                    .text =
                                                                currentNumber;
                                                            controller
                                                                .phoneEntries
                                                                .refresh();
                                                          },
                                                          initialSelection:
                                                              phoneEntry
                                                                  .countryFlag,
                                                          showCountryOnly:
                                                              false,
                                                          showOnlyCountryWhenClosed:
                                                              false,
                                                          alignLeft: true,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          flagWidth: 25,
                                                          textStyle:
                                                              commonTextStyle,
                                                          favorite: const [
                                                            'IN'
                                                          ],
                                                          showDropDownButton:
                                                              true,
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 48,
                                                        width: 1,
                                                        color: Colors
                                                            .grey.shade300,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 0),
                                                      ),
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller: phoneEntry
                                                              .controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .phone,
                                                          style:
                                                              commonTextStyle,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        12),
                                                            hintText:
                                                                'Enter mobile number',
                                                            hintStyle:
                                                                TextStyle(
                                                              color: Colors.grey
                                                                  .shade500,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                            ),
                                                            prefixText:
                                                                '${phoneEntry.countryCode} ',
                                                            prefixStyle:
                                                                commonTextStyle,
                                                          ),
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly,
                                                            LengthLimitingTextInputFormatter(
                                                                10),
                                                          ],
                                                          onChanged: (value) {
                                                            if (value.startsWith(
                                                                phoneEntry
                                                                    .countryCode)) {
                                                              String cleanedValue = value
                                                                  .replaceFirst(
                                                                      phoneEntry
                                                                          .countryCode,
                                                                      '')
                                                                  .trim();
                                                              phoneEntry
                                                                      .controller
                                                                      .text =
                                                                  cleanedValue;
                                                              phoneEntry
                                                                      .controller
                                                                      .selection =
                                                                  TextSelection
                                                                      .fromPosition(
                                                                TextPosition(
                                                                    offset: phoneEntry
                                                                        .controller
                                                                        .text
                                                                        .length),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      if (controller
                                                              .phoneEntries
                                                              .length >
                                                          1)
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons
                                                                  .remove_circle_outline,
                                                              color:
                                                                  Colors.red),
                                                          onPressed: () =>
                                                              controller
                                                                  .removePhoneEntry(
                                                                      index),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          OutlinedButton.icon(
                                            onPressed: () =>
                                                controller.addPhoneEntry(),
                                            icon: Icon(Icons.add,
                                                color: AllColors.greenJungle),
                                            label: Text(
                                              "Mobiles",
                                              style: TextStyle(
                                                color: AllColors.greenJungle,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                  color: AllColors.greenJungle),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // assigned to
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(
                                        label: Strings.assignedLeadTo,
                                        isRequired: false,
                                      ),
                                      const SizedBox(height: 5),
                                      Obx(() {

                                        if (divisionsController.isLoading.value) {
                                          return const Center(
                                              child: CircularProgressIndicator());
                                        } else if (divisionsController
                                            .divisionsList.isEmpty) {
                                          return const Text(
                                            'No divisions available',
                                            style: TextStyle(color: Colors.red, fontSize: 14),
                                          );
                                        } else {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              CommonTextField(
                                                hintText: divisionsController
                                                    .selectedDivisions.isEmpty
                                                    ? Strings.select
                                                    : divisionsController.selectedDivisions
                                                    .join(', '),
                                                categories: divisionsController.divisionsList
                                                    .map((division) => division.name ?? '')
                                                    .toList(),
                                                onCategoryChanged: (selectedDivision) {
                                                  divisionsController.toggleDivisionSelection(
                                                      selectedDivision);
                                                  setState(() {
                                                    _validationErrors[
                                                    'divisions'] = divisionsController
                                                        .selectedDivisions.isEmpty
                                                        ? 'At least one division is required'
                                                        : null;
                                                  });
                                                },
                                                isForDivisions: true,
                                                hasError:
                                                _validationErrors['divisions'] != null,
                                              ),
                                              _buildErrorText(_validationErrors['divisions']),
                                              // // Display selected divisions
                                              // if (divisionsController
                                              //     .selectedDivisions.isNotEmpty)
                                              //   Padding(
                                              //     padding: const EdgeInsets.only(top: 8.0),
                                              //     child: Wrap(
                                              //       spacing: 8.0,
                                              //       runSpacing: 4.0,
                                              //       children:
                                              //       divisionsController.selectedDivisions
                                              //           .map((division) => Chip(
                                              //         label: Text(division),
                                              //         onDeleted: () {
                                              //           divisionsController
                                              //               .toggleDivisionSelection(
                                              //               division);
                                              //           setState(() {
                                              //             _validationErrors[
                                              //             'divisions'] =
                                              //             divisionsController
                                              //                 .selectedDivisions
                                              //                 .isEmpty
                                              //                 ? 'At least one division is required'
                                              //                 : null;
                                              //           });
                                              //         },
                                              //       ))
                                              //           .toList(),
                                              //     ),
                                              //   ),
                                            ],
                                          );
                                        }
                                      }),

                                    ],
                                  ),
                                ),

                                //  division
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(label: Strings.divisions),
                                      const SizedBox(height: 5),
                                      Obx(() {
                                        if (divisionsController
                                            .isLoading.value) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (divisionsController
                                            .divisionsList.isEmpty) {
                                          return const Text(
                                            'No divisions available',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14),
                                          );
                                        } else {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonTextField(
                                                allowCustomBorderInput:
                                                    BorderRadius.circular(12),
                                                isMultiSelect: true,
                                                isForDivisions: true,
                                                hintText: divisionsController
                                                        .selectedDivisions
                                                        .isEmpty
                                                    ? Strings.select
                                                    : divisionsController
                                                        .selectedDivisions
                                                        .join(', '),
                                                categories: divisionsController
                                                    .divisionsList
                                                    .map((division) =>
                                                        division.name ?? '')
                                                    .toList(),
                                                onCategoryChanged:
                                                    (selectedDivision) {
                                                  divisionsController
                                                      .toggleDivisionSelection(
                                                          selectedDivision);
                                                  setState(() {
                                                    _validationErrors[
                                                            'divisions'] =
                                                        divisionsController
                                                                .selectedDivisions
                                                                .isEmpty
                                                            ? 'At least one division is required'
                                                            : null;
                                                  });
                                                },
                                                hasError: _validationErrors[
                                                        'divisions'] != null,
                                              ),
                                              _buildErrorText(_validationErrors[
                                                  'divisions']),
                                              // // Display selected divisions
                                              // if (divisionsController
                                              //     .selectedDivisions.isNotEmpty)
                                              //   Padding(
                                              //     padding: const EdgeInsets.only(top: 8.0),
                                              //     child: Wrap(
                                              //       spacing: 8.0,
                                              //       runSpacing: 4.0,
                                              //       children:
                                              //       divisionsController.selectedDivisions
                                              //           .map((division) => Chip(
                                              //         label: Text(division),
                                              //         onDeleted: () {
                                              //           divisionsController
                                              //               .toggleDivisionSelection(
                                              //               division);
                                              //           setState(() {
                                              //             _validationErrors[
                                              //             'divisions'] =
                                              //             divisionsController
                                              //                 .selectedDivisions
                                              //                 .isEmpty
                                              //                 ? 'At least one division is required'
                                              //                 : null;
                                              //           });
                                              //         },
                                              //       ))
                                              //           .toList(),
                                              //     ),
                                              //   ),
                                            ],
                                          );
                                        }
                                      }),
                                    ],
                                  ),
                                ),

                                //  organisation
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(
                                        label: Strings.organisation,
                                        isRequired: false,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextField(hintText: "Select",controller: controller.organizationController
                                        ),
                                    ],
                                  ),
                                ),

                                //  customer type
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(
                                        label: Strings.customerType,
                                        isRequired: false,
                                      ),
                                      const SizedBox(height: 5),
                                      Obx(() {
                                        return CommonTextField(
                                          hintText: "Select Type",
                                          categories: leadTypeViewModel
                                              .getLeadTypeNames(),
                                          onCategoryChanged: (selectedType) {
                                            print(
                                                "Selected Lead Type: $selectedType");
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                ),

                                // website
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(
                                        label: Strings.website,
                                        isRequired: false,
                                      ),
                                      const SizedBox(height: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 5),
                                          Obx(() => custom.SearchComponents
                                                  .buildSearchBox(
                                                isTextFieldFocused:
                                                    searchController
                                                        .isTextFieldFocused
                                                        .value,
                                                textController: searchController
                                                    .textController,
                                                focusNode:
                                                    searchController.focusNode,
                                                textEntries: searchController
                                                    .textEntries,
                                                searchText: searchController
                                                    .searchText.value,
                                                showCreateButton:
                                                    searchController
                                                        .showCreateButton.value,
                                                onAddEntry: searchController
                                                    .addTextEntry,
                                                onRemoveEntry: searchController
                                                    .removeEntry,
                                                onClearSearch: searchController
                                                    .clearSearch,
                                                onClearAll: searchController
                                                    .clearAllEntries,
                                              )),
                                          Obx(() => custom.SearchComponents
                                                  .buildCreateButton(
                                                showCreateButton:
                                                    searchController
                                                        .showCreateButton.value,
                                                searchText: searchController
                                                    .searchText.value,
                                                onCreate: searchController
                                                    .addTextEntry,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                //  gst

                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(
                                        label: Strings.gst,
                                        isRequired: false,
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextField(hintText: "Enter GST",controller: controller.gstinController,),
                                    ],
                                  ),
                                ),

                                //  file upload
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(
                                        label: Strings.fileUpload,
                                        isRequired: false,
                                      ),
                                      const SizedBox(height: 5),
                                      InkWell(
                                        onTap: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          final XFile? image =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);

                                          if (image != null) {
                                            setState(() {
                                              selectedFile = File(image.path);
                                              fileName = image.name;
                                              print(
                                                  'Selected file path: ${image.path}'); // Print the file path
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x1A000000),
                                                // Soft black with low opacity
                                                blurRadius: 16,
                                                // More blur for a soft shadow
                                                spreadRadius: 2,
                                                // Slightly spread out
                                                offset: Offset(0,
                                                    8), // Slope shadow downward for floating effect
                                              ),
                                              BoxShadow(
                                                color: Color(0x0F000000),
                                                // Even softer, wider shadow for depth
                                                blurRadius: 32,
                                                spreadRadius: 8,
                                                offset: Offset(0,
                                                    16), // Slope further for a layered look
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              // Choose file button
                                              Container(
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border(
                                                    right: BorderSide(
                                                        color:
                                                            Colors.grey[300]!),
                                                  ),
                                                ),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 22,
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Choose file',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Icon(Icons.image,
                                                                color:
                                                                    Colors.grey,
                                                                size: 20),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // File name display
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12),
                                                  child: Text(
                                                    fileName ??
                                                        'No file chosen',
                                                    style: TextStyle(
                                                      color: fileName != null
                                                          ? Colors.black87
                                                          : Colors.grey[600],
                                                      fontSize: 14,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //   requirement
                                SizedBox(
                                  width: fieldWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(
                                        label: Strings.requirement,
                                        isRequired: false,
                                      ),
                                      const SizedBox(height: 5),
                                      const CommonTextField(
                                        allowCustomBorderInput:
                                            BorderRadius.all(
                                                Radius.circular(13)),
                                        maxLines: 4,
                                        hintText: "Write something here",
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Address Information",
                                          style: TextStyle(
                                            fontSize: 17.5,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: FontFamily.sfPro,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(""),
                                      ],
                                    ),
                                    const SizedBox(height: 10),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Toggle Button for Indian/Non-India
                                                CustomToggleButtonGroup(
                                                  initialSelectedIndex:
                                                      _selectedIndex,
                                                  onIndexChanged: (index) {
                                                    setState(() {
                                                      _selectedIndex = index;
                                                      isListView = index == 0;
                                                      // Clear fields of the inactive section
                                                      if (index == 0) {
                                                        // Clear Non-India fields
                                                        controller
                                                            .nonIndiaAddressController
                                                            .clear();
                                                        controller
                                                            .nonIndiaPincodeController
                                                            .clear();
                                                        controller
                                                            .nonIndiaCityController
                                                            .clear();
                                                        controller
                                                            .nonIndiaDistrictController
                                                            .clear();
                                                        controller
                                                            .nonIndiaStateController
                                                            .clear();
                                                        controller
                                                            .nonIndiaCountryController
                                                            .clear();
                                                      } else {
                                                        // Clear Indian fields
                                                        _pincodeController
                                                            .clear();
                                                        _cityController.clear();
                                                        _districtController
                                                            .clear();
                                                        _stateController
                                                            .clear();
                                                        _countryController
                                                            .clear();
                                                        controller
                                                            .addressController
                                                            .clear();
                                                        _pincodeViewModel
                                                            .clear();
                                                        _cityViewModel.clear();
                                                        selectedStateId = '';
                                                        selectedCityId = '';
                                                      }
                                                    });
                                                  },
                                                  options: [
                                                    ToggleButtonUtils
                                                        .createIconTextOption(
                                                      selectedTextColor:
                                                          AllColors.whiteColor,
                                                      text: 'Indian',
                                                      selectedColor: AllColors
                                                          .mediumPurple,
                                                    ),
                                                    ToggleButtonUtils
                                                        .createIconTextOption(
                                                      selectedTextColor:
                                                          AllColors.whiteColor,
                                                      text: 'Non-India',
                                                      selectedColor: AllColors
                                                          .mediumPurple,
                                                    ),
                                                  ],
                                                ),
                                                // Indian Address Fields
                                                if (_selectedIndex == 0)
                                                  Wrap(
                                                    spacing: wrapSpacing,
                                                    runSpacing: 16,
                                                    alignment: WrapAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(height: 11),
                                                            RequiredLabel(
                                                              label: Strings
                                                                  .pincode,
                                                              isRequired: false,
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            CommonTextField(
                                                              key: const ValueKey(
                                                                  'indian_pincode'),
                                                              hintText:
                                                                  'Enter Pincode',
                                                              controller:
                                                                  _pincodeController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              isEditable: true,
                                                              prefixIcon: const Icon(
                                                                  Icons
                                                                      .location_pin,
                                                                  color: Colors
                                                                      .grey),
                                                              onChanged:
                                                                  (value) {
                                                                print(
                                                                    "Indian Pincode input: $value, Controller: ${_pincodeController.hashCode}");
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            RequiredLabel(
                                                              label:
                                                                  Strings.city,
                                                              isRequired: false,
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            Obx(() =>
                                                                CommonTextField(
                                                                  key: const ValueKey(
                                                                      'indian_city'),
                                                                  hintText:
                                                                      'Choose City',
                                                                  controller:
                                                                      _cityController,
                                                                  categories: _cityViewModel
                                                                      .leadPinCodeSearch
                                                                      .where((city) =>
                                                                          city.name !=
                                                                          null)
                                                                      .map((city) =>
                                                                          city.name!)
                                                                      .toList(),
                                                                  onCategoryChanged:
                                                                      (selectedCityName) {
                                                                    if (selectedCityName
                                                                        .isNotEmpty) {
                                                                      final selectedCity = _cityViewModel
                                                                          .leadPinCodeSearch
                                                                          .firstWhereOrNull((city) =>
                                                                              city.name ==
                                                                              selectedCityName);
                                                                      if (selectedCity !=
                                                                          null) {
                                                                        _onCitySelected(
                                                                            selectedCity.id,
                                                                            selectedCity.name);
                                                                      }
                                                                    }
                                                                  },
                                                                  onSearch:
                                                                      _onCitySearch,
                                                                  isLoading:
                                                                      _cityViewModel
                                                                          .loading
                                                                          .value,
                                                                  isEditable:
                                                                      selectedStateId
                                                                          .isNotEmpty,
                                                                  hasError: _cityViewModel
                                                                      .errorMessage
                                                                      .value
                                                                      .isNotEmpty,
                                                                  errorMessage:
                                                                      _cityViewModel
                                                                          .errorMessage
                                                                          .value,
                                                                  allowCustomInput:
                                                                      true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  prefixIcon: const Icon(
                                                                      Icons
                                                                          .location_city,
                                                                      color: Colors
                                                                          .grey),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                                "District"),
                                                            CommonTextField(
                                                              key: const ValueKey(
                                                                  'indian_district'),
                                                              hintText:
                                                                  'District',
                                                              controller:
                                                                  _districtController,
                                                              isEditable: false,
                                                              prefixIcon:
                                                                  const Icon(
                                                                      Icons.map,
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text("State"),
                                                            CommonTextField(
                                                              key: const ValueKey(
                                                                  'indian_state'),
                                                              hintText: 'State',
                                                              controller:
                                                                  _stateController,
                                                              isEditable: false,
                                                              prefixIcon: const Icon(
                                                                  Icons.public,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                                "Country"),
                                                            CommonTextField(
                                                              key: const ValueKey(
                                                                  'indian_country'),
                                                              hintText:
                                                                  'Country',
                                                              controller:
                                                                  _countryController,
                                                              isEditable: false,
                                                              prefixIcon:
                                                                  const Icon(
                                                                      Icons
                                                                          .flag,
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                                "Address"),
                                                            CommonTextField(
                                                              key: const ValueKey(
                                                                  'indian_address'),
                                                              controller: controller
                                                                  .addressController,
                                                              hintText:
                                                                  "Enter Address",
                                                              isEditable: true,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              prefixIcon: const Icon(
                                                                  Icons
                                                                      .location_pin,
                                                                  color: Colors
                                                                      .grey),
                                                              validator: null,
                                                              // Make address optional
                                                              onChanged:
                                                                  (value) {
                                                                print(
                                                                    "Indian Address input: $value, Controller: ${controller.addressController.hashCode}");
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Obx(() =>
                                                          AnimatedCrossFade(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        300),
                                                            crossFadeState: _pincodeViewModel
                                                                    .errorMessage
                                                                    .value
                                                                    .isNotEmpty
                                                                ? CrossFadeState
                                                                    .showFirst
                                                                : CrossFadeState
                                                                    .showSecond,
                                                            firstChild:
                                                                Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          16),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(12),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .red
                                                                    .shade50,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red
                                                                        .shade200),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .error_outline,
                                                                      color: Colors
                                                                          .red
                                                                          .shade600),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  Expanded(
                                                                    child: Text(
                                                                      _pincodeViewModel
                                                                          .errorMessage
                                                                          .value,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .red
                                                                            .shade700,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            secondChild:
                                                                const SizedBox
                                                                    .shrink(),
                                                          )),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              _pincodeController
                                                                  .clear();
                                                              _cityController
                                                                  .clear();
                                                              _districtController
                                                                  .clear();
                                                              _stateController
                                                                  .clear();
                                                              _countryController
                                                                  .clear();
                                                              controller
                                                                  .addressController
                                                                  .clear();
                                                              _pincodeViewModel
                                                                  .clear();
                                                              _cityViewModel
                                                                  .clear();
                                                              selectedStateId =
                                                                  '';
                                                              selectedCityId =
                                                                  '';
                                                            },
                                                            child: Text(
                                                              "Clear All",
                                                              style: TextStyle(
                                                                  color: AllColors
                                                                      .mediumPurple),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                else if (_selectedIndex == 1)
                                                  Wrap(
                                                    spacing: wrapSpacing,
                                                    runSpacing: 16,
                                                    alignment: WrapAlignment.spaceBetween,
                                                    children: [

                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child:
                                                        Column(
                                                          crossAxisAlignment:CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            TextStyles.commonTextFieldSubHead(
                                                                context, Strings.address),
                                                            GooglePlaceAutoCompleteTextField(
                                                              textEditingController: controller.nonIndiaAddressController,
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
                                                              // getPlaceDetailWithLatLng: _onPlaceSelected,
                                                              itemClick: (Prediction prediction) {
                                                                controller.nonIndiaAddressController.text =
                                                                    prediction.description ?? '';
                                                                controller.nonIndiaAddressController.selection =
                                                                    TextSelection.fromPosition(
                                                                      TextPosition(
                                                                          offset: controller
                                                                              .nonIndiaAddressController.text.length),
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
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [

                                                            TextStyles.commonTextFieldSubHead(
                                                                context, Strings.pincode),

                                                            CommonTextField(
                                                              key: const ValueKey('non_india_pincode'),
                                                              hintText: Strings.pincode,
                                                              controller: controller.nonIndiaPincodeController,
                                                              isEditable: true,
                                                              keyboardType: TextInputType.number,
                                                              prefixIcon: const Icon(Icons.location_pin,
                                                                  color: Colors.grey),
                                                              validator: null,
                                                              onChanged: (value) {
                                                                print("Non-India Pincode input: $value, Controller: "+controller.nonIndiaPincodeController.hashCode.toString());
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            TextStyles.commonTextFieldSubHead(
                                                                context, Strings.city),
                                                            CommonTextField(
                                                              key: const ValueKey('non_india_city'),
                                                              hintText: Strings.city,
                                                              controller: controller.nonIndiaCityController,
                                                              isEditable: true,
                                                              keyboardType: TextInputType.text,
                                                              prefixIcon: const Icon(Icons.location_city,
                                                                  color: Colors.grey),
                                                              validator: null,
                                                              onChanged: (value) {
                                                                print("Non-India City input: $value, Controller: "+controller.nonIndiaCityController.hashCode.toString());
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            TextStyles.commonTextFieldSubHead(
                                                                context, Strings.district),
                                                            CommonTextField(
                                                              key: const ValueKey('non_india_district'),
                                                              hintText: Strings.district,
                                                              controller: controller.nonIndiaDistrictController,
                                                              isEditable: true,
                                                              keyboardType: TextInputType.text,
                                                              prefixIcon:
                                                              const Icon(Icons.map, color: Colors.grey),
                                                              validator: null,
                                                              onChanged: (value) {
                                                                print("Non-India District input: $value, Controller: "+controller.nonIndiaDistrictController.hashCode.toString());
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            TextStyles.commonTextFieldSubHead(
                                                                context, Strings.state),
                                                            CommonTextField(
                                                              key: const ValueKey('non_india_state'),
                                                              hintText: Strings.state,
                                                              controller: controller.nonIndiaStateController,
                                                              isEditable: true,
                                                              keyboardType: TextInputType.text,
                                                              prefixIcon:
                                                              const Icon(Icons.public, color: Colors.grey),
                                                              validator: null,
                                                              onChanged: (value) {
                                                                print("Non-India State input: $value, Controller: "+controller.nonIndiaStateController.hashCode.toString());
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            TextStyles.commonTextFieldSubHead(
                                                                context, Strings.country),
                                                            CommonTextField(
                                                              key: const ValueKey('non_india_country'),
                                                              hintText: Strings.country,
                                                              controller: controller.nonIndiaCountryController,
                                                              isEditable: true,
                                                              keyboardType: TextInputType.text,
                                                              prefixIcon:
                                                              const Icon(Icons.flag, color: Colors.grey),
                                                              validator: null,
                                                              onChanged: (value) {
                                                                print("Non-India Country input: $value, Controller: "+controller.nonIndiaCountryController.hashCode.toString());
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: fieldWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                                "Address"),
                                                            CommonTextField(
                                                              key: const ValueKey(
                                                                  'non_india_address'),
                                                              controller: controller
                                                                  .nonIndiaAddressController,
                                                              hintText:
                                                                  "Enter Address",
                                                              isEditable: true,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              prefixIcon: const Icon(
                                                                  Icons
                                                                      .location_pin,
                                                                  color: Colors
                                                                      .grey),
                                                              validator: null,
                                                              // Make address optional
                                                              onChanged:
                                                                  (value) {
                                                                print(
                                                                    "Non-India Address input: $value, Controller: ${controller.nonIndiaAddressController.hashCode}");
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Obx(() =>
                                                          AnimatedCrossFade(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        300),
                                                            crossFadeState: _pincodeViewModel
                                                                    .errorMessage
                                                                    .value
                                                                    .isNotEmpty
                                                                ? CrossFadeState
                                                                    .showFirst
                                                                : CrossFadeState
                                                                    .showSecond,
                                                            firstChild:
                                                                Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          16),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(12),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .red
                                                                    .shade50,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red
                                                                        .shade200),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .error_outline,
                                                                      color: Colors
                                                                          .red
                                                                          .shade600),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  Expanded(
                                                                    child: Text(
                                                                      _pincodeViewModel
                                                                          .errorMessage
                                                                          .value,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .red
                                                                            .shade700,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            secondChild:
                                                                const SizedBox
                                                                    .shrink(),
                                                          )),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              controller.nonIndiaPincodeController.clear();
                                                              controller.nonIndiaCityController.clear();
                                                              controller.nonIndiaDistrictController.clear();
                                                              controller.nonIndiaStateController.clear();
                                                              controller.nonIndiaCountryController.clear();
                                                              // controller.streetAddressController.clear();
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
                                                  )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // const SizedBox(height: 20),
                                    // Text(
                                    //   "Custom Fields",
                                    //   style: TextStyle(
                                    //     fontSize: 17.5,
                                    //     fontWeight: FontWeight.w600,
                                    //     fontFamily: FontFamily.sfPro,
                                    //   ),
                                    // ),
                                    // const SizedBox(height: 8),
                                    // Text("Age Group"),
                                    // CreateNewLeadScreenCard(
                                    //   hintText: "Age Group",
                                    // ),
                                    // const SizedBox(height: 8),
                                    // Text("Aadhar Card Number"),
                                    // CreateNewLeadScreenCard(
                                    //   hintText: "Aadhar Card Number",
                                    // ),
                                    const SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: CommonButton(
                                              borderRadius: 30,
                                              width: 130,
                                              height: 40,
                                              color: AllColors.textField2,
                                              textColor: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              title: 'Reset',
                                              onPress: () {}),
                                        ),
                                        SizedBox(width: 20),
                                        Flexible(
                                            child: CommonButton(
                                          borderRadius: 30,
                                          height: 40,
                                          width: 130,
                                          color: AllColors.mediumPurple,
                                          textColor: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          title: 'Next',
                                          onPress: () => _nextStep(),
                                        ))
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Note: Before submitting your form, please ensure that all information is accurate and complete. Double-check for any errors or missing details. Once you are certain, go ahead and submit. Good luck!",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontFamily: FontFamily.sfPro,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: _previousStep,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_back,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 5),
                                  Text(
                                    "Previous",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AllColors.mediumPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              icon: Icon(Icons.check,
                                  color: AllColors.whiteColor, size: 16),
                              label: Text(
                                "Final Submit",
                                style: TextStyle(
                                  color: AllColors.whiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: FontFamily.sfPro,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperHeader(bool isCompact) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Create Customer",
              style: TextStyle(
                fontSize: isCompact ? 16 : 16,
                fontWeight: FontWeight.w600,
                color: DarkMode.backgroundColor2(context),
                fontFamily: FontFamily.sfPro,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: _toggleStepperVisibility,
              child: Icon(Icons.arrow_drop_down, color: AllColors.figmaGrey),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          "Step ${_currentStep + 1} of 2",
          style: TextStyle(
            fontSize: isCompact ? 12 : 14,
            color: DarkMode.backgroundColor2(context),
            fontFamily: FontFamily.sfPro,
          ),
        ),
        if (isStepperVisible) ...[
          const SizedBox(height: 12),
          isCompact ? _buildCompactSteps() : _buildFullSteps(),
        ],
      ],
    );
  }

  Widget _buildFullSteps() {
    return Row(
      children: [
        _buildEnhancedStep(
          stepNumber: 1,
          title: "Details",
          subtitle: "Basic Information",
          isActive: _currentStep == 0,
          isCompleted: _currentStep > 0,
        ),
        _buildConnector(),
        _buildEnhancedStep(
          stepNumber: 2,
          title: "Final Submission",
          subtitle: "Review & Submit",
          isActive: _currentStep == 1,
          isCompleted: false,
        ),
      ],
    );
  }

  Widget _buildCompactSteps() {
    return Column(
      children: [
        Row(
          children: [
            _buildStepCircle(_currentStep + 1, true, false),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentStep == 0 ? "Customer Details" : "Final Submission",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: DarkMode.backgroundColor2(context),
                      fontFamily: FontFamily.sfPro,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _currentStep == 0
                        ? "Enter basic information"
                        : "Review and submit",
                    style: TextStyle(
                      fontSize: 12,
                      color: DarkMode.backgroundColor2(context),
                      fontFamily: FontFamily.sfPro,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMiniStep(0),
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 2,
              decoration: BoxDecoration(
                color: _currentStep > 0
                    ? AllColors.mediumPurple
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            const SizedBox(width: 8),
            _buildMiniStep(1),
          ],
        ),
      ],
    );
  }

  Widget _buildMiniStep(int index) {
    bool isActive = _currentStep == index;
    bool isCompleted = _currentStep > index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.green
            : isActive
                ? AllColors.mediumPurple
                : Colors.grey[300],
        borderRadius: BorderRadius.circular(6),
      ),
      child: isCompleted
          ? Icon(
              Icons.check,
              color: DarkMode.backgroundColor2(context),
              size: 8,
            )
          : null,
    );
  }

  Widget _buildEnhancedStep({
    required int stepNumber,
    required String title,
    required String subtitle,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool hasEnoughSpace = constraints.maxWidth > 120;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: hasEnoughSpace
                ? _buildHorizontalStep(
                    stepNumber, title, subtitle, isActive, isCompleted)
                : _buildVerticalStep(
                    stepNumber, title, subtitle, isActive, isCompleted),
          );
        },
      ),
    );
  }

  Widget _buildHorizontalStep(int stepNumber, String title, String subtitle,
      bool isActive, bool isCompleted) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepCircle(stepNumber, isActive, isCompleted),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: isActive || isCompleted
                      ? DarkMode.backgroundColor2(context)
                      : Colors.grey[600],
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 14,
                  fontFamily: FontFamily.sfPro,
                ),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: isActive || isCompleted
                      ? Colors.grey[700]
                      : Colors.grey[500],
                  fontSize: 11,
                  fontFamily: FontFamily.sfPro,
                ),
                child: Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalStep(int stepNumber, String title, String subtitle,
      bool isActive, bool isCompleted) {
    return Column(
      children: [
        _buildStepCircle(stepNumber, isActive, isCompleted),
        const SizedBox(height: 8),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: isActive || isCompleted
                ? AllColors.blackColor
                : Colors.grey[600],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            fontSize: 12,
            fontFamily: FontFamily.sfPro,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 2),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color:
                isActive || isCompleted ? Colors.grey[700] : Colors.grey[500],
            fontSize: 10,
            fontFamily: FontFamily.sfPro,
          ),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStepCircle(int stepNumber, bool isActive, bool isCompleted) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.green
            : isActive
                ? AllColors.mediumPurple
                : Colors.grey[200],
        borderRadius: BorderRadius.circular(18),
        boxShadow: isActive || isCompleted
            ? [
                BoxShadow(
                  color: (isCompleted ? Colors.green : AllColors.mediumPurple)
                      .withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isCompleted
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 18,
                key: ValueKey('check'),
              )
            : Text(
                "$stepNumber",
                key: ValueKey('number_$stepNumber'),
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: FontFamily.sfPro,
                ),
              ),
      ),
    );
  }

  Widget _buildConnector() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double connectorWidth = (constraints.maxWidth * 0.15).clamp(20.0, 60.0);
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: 2,
                width: connectorWidth,
                decoration: BoxDecoration(
                  color: _currentStep > 0
                      ? AllColors.mediumPurple
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  Icons.chevron_right,
                  color: _currentStep > 0
                      ? AllColors.mediumPurple
                      : Colors.grey[400],
                  size: 16,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: 2,
                width: connectorWidth,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              const SizedBox(width: 4),
            ],
          ),
        );
      },
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
        ),
      ),
    );
  }
}
