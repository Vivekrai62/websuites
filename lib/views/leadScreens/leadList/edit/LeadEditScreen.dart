import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:websuites/data/models/responseModels/leads/createNewLead/pincode/pincode.dart'
    show Country, District, PinCodeModelResponseModel, StateModel;
import 'package:websuites/utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import '../../../../data/models/responseModels/leads/list/lead_list.dart';
import '../../../../resources/strings/strings.dart';
import '../../../../utils/appColors/app_colors.dart';
import '../../../../utils/button/section_divider/SectionDivider.dart';
import '../../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../../utils/components/buttons/common_button.dart';
import '../../../../utils/textfield/multipleCategoriesCreate/MultipleCategoriesCreate.dart'
    as custom;
import '../../../../viewModels/leadScreens/createNewLead/assignedLeadTo/assigned_lead_to_viewModel.dart';
import '../../../../viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import '../../../../viewModels/leadScreens/createNewLead/pincode/pincode_view_model.dart';
import '../../../../viewModels/leadScreens/createNewLead/product_category/product_category_controller.dart';
import '../../../../viewModels/leadScreens/lead_list/pin_code_city_search/PinCodeCityViewModel.dart';
import '../../../../viewModels/leadScreens/trashLeads/leadTypes/lead_type_viewModel.dart';
import '../../../homeScreen/home_manager/HomeManagerScreen.dart';
import '../../createNewLead/widgets/createNewLeadCard/common_text_field.dart';

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

class LeadEditController extends GetxController {
  final Item orderItem;

  // Indian
  late TextEditingController organizationController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController pincodeController; // Added for pincode
  late TextEditingController cityController; // Added for city
  late TextEditingController districtController; // Added for district
  late TextEditingController stateController; // Added for state
  late TextEditingController countryController; // Added for country
  late TextEditingController addressController; // Added for address

  // Non indian
  late TextEditingController nonIndiaAddressController;
  late TextEditingController nonIndiaPincodeController;
  late TextEditingController nonIndiaCityController;
  late TextEditingController nonIndiaDistrictController;
  late TextEditingController nonIndiaStateController;
  late TextEditingController nonIndiaCountryController;

  RxList<TextEditingController> emailControllers =
      <TextEditingController>[].obs;
  RxList<PhoneNumberEntry> phoneEntries = <PhoneNumberEntry>[].obs;

  LeadEditController({required this.orderItem}) {
    // Indian
    organizationController =
        TextEditingController(text: orderItem.organization ?? '');
    firstNameController =
        TextEditingController(text: orderItem.firstName ?? '');
    lastNameController = TextEditingController(text: orderItem.lastName ?? '');
    pincodeController =
        TextEditingController(); // Initialize pincode controller
    cityController = TextEditingController(); // Initialize city controller
    districtController =
        TextEditingController(); // Initialize district controller
    stateController = TextEditingController(); // Initialize state controller
    countryController =
        TextEditingController(); // Initialize country controller
    addressController =
        TextEditingController(); // Initialize address controller

    // Non indian
    nonIndiaAddressController = TextEditingController();
    nonIndiaPincodeController = TextEditingController();
    nonIndiaCityController = TextEditingController();
    nonIndiaDistrictController = TextEditingController();
    nonIndiaStateController = TextEditingController();
    nonIndiaCountryController = TextEditingController();

    emailControllers.add(TextEditingController(text: orderItem.email ?? ''));

    phoneEntries.add(PhoneNumberEntry(
        controller: TextEditingController(text: orderItem.mobile ?? ''),
        countryCode: '+91',
        countryFlag: 'IN'));
  }

  void addEmailField() {
    emailControllers.add(TextEditingController());
  }

  void removeEmailField(int index) {
    if (index >= 0 && index < emailControllers.length) {
      final controller = emailControllers.removeAt(index);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.dispose();
      });
    }
  }

  void addPhoneEntry() {
    phoneEntries.add(PhoneNumberEntry(
        controller: TextEditingController(),
        countryCode: '+91',
        countryFlag: 'IN'));
  }

  void removePhoneEntry(int index) {
    if (phoneEntries.length > 1 && index < phoneEntries.length) {
      final entryToRemove = phoneEntries.removeAt(index);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        entryToRemove.controller.dispose();
      });
    }
  }

  @override
  void onClose() {
    // indian
    organizationController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    districtController.dispose();
    stateController.dispose();
    countryController.dispose();
    addressController.dispose();

    //  Non - indian
    nonIndiaAddressController.dispose();
    nonIndiaPincodeController.dispose();
    nonIndiaCityController.dispose();
    nonIndiaDistrictController.dispose();
    nonIndiaStateController.dispose();
    nonIndiaCountryController.dispose();

    for (var controller in emailControllers) {
      controller.dispose();
    }
    for (var entry in phoneEntries) {
      entry.controller.dispose();
    }
    super.onClose();
  }
}

class LeadEditScreen extends StatefulWidget {
  final Item orderItem;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const LeadEditScreen({
    Key? key,
    required this.orderItem,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  _LeadEditScreenState createState() => _LeadEditScreenState();
}

class _LeadEditScreenState extends State<LeadEditScreen> {
  int _selectedIndex = 0;
  bool isListView = true;

  final LeadTypeViewModel leadTypeViewModel = Get.put(LeadTypeViewModel());
  final AssignedLeadToViewModel _assignedLeadToController =
      Get.put(AssignedLeadToViewModel());
  final DivisionsViewModel divisionsController = Get.put(DivisionsViewModel());
  final ProductCategoryController productCategoryController =
      Get.put(ProductCategoryController());
  final PinCodeViewModel pinCodeViewModel = Get.put(PinCodeViewModel());
  final PinCodeCityViewModel pinCodeCityViewModel =
      Get.put(PinCodeCityViewModel());

  @override
  void initState() {
    super.initState();
    _assignedLeadToController.fetchAssignedLeads(context);
    productCategoryController.createLeadProductCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeadEditController(orderItem: widget.orderItem));
    final homeController = Get.find<HomeManagerController>();
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    final custom.SearchController searchController =
        Get.put(custom.SearchController());

    return Container(
      color: AllColors.whiteColor,
      child: Column(
        children: [
          CustomAppBar(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
              child: Row(
                children: [
                  if (!isTablet)
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        widget.scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  Text(
                    "Edit Lead",
                    style: TextStyle(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 18.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        homeController.resetOrderDetails();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back, color: Colors.black),
                            const SizedBox(width: 8),
                            Text(
                              "Back to Lead List",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: AllColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    ContainerUtils(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lead Information",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.sfPro,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text("First Name"),
                          const SizedBox(height: 5),
                          CommonTextField(
                            controller: controller.firstNameController,
                            hintText: "Enter First Name",
                          ),
                          const SizedBox(height: 10),
                          Text("Last Name"),
                          const SizedBox(height: 5),
                          CommonTextField(
                            controller: controller.lastNameController,
                            hintText: "Enter Last Name",
                          ),
                          const SizedBox(height: 10),
                          Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: controller.emailControllers
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  int index = entry.key;
                                  TextEditingController emailController =
                                      entry.value;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(index == 0
                                          ? "Email"
                                          : "Email ${index + 1}"),
                                      const SizedBox(height: 5),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: CommonTextField(
                                              controller: emailController,
                                              hintText: "Enter Email",
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (index == 0) {
                                                  controller.addEmailField();
                                                } else {
                                                  controller
                                                      .removeEmailField(index);
                                                }
                                              },
                                              child: Container(
                                                height: 37,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: index == 0
                                                        ? AllColors.darkGreen
                                                        : Colors.red,
                                                    width: 0.9,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: index == 0
                                                      ? const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.green,
                                                              size: 22,
                                                            ),
                                                            Text(
                                                              'Emails',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                          size: 22,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                }).toList(),
                              )),
                          const Row(
                            children: [
                              Text(
                                "Mobile ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
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
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 130,
                                            alignment: Alignment.centerLeft,
                                            padding:
                                                const EdgeInsets.only(left: 8),
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
                                                        RegExp(r'^\+\d+\s*'),
                                                        '')
                                                    .trim();
                                                phoneEntry.controller.text =
                                                    currentNumber;
                                                controller.phoneEntries
                                                    .refresh();
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
                                            height: 30,
                                            width: 1,
                                            color: Colors.grey.shade300,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4),
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
                                                        horizontal: 12,
                                                        vertical: 12),
                                                hintText: 'Enter mobile number',
                                                hintStyle: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                                prefixText:
                                                    '${phoneEntry.countryCode} ',
                                                prefixStyle: commonTextStyle,
                                              ),
                                              onChanged: (value) {
                                                if (value.startsWith(
                                                    phoneEntry.countryCode)) {
                                                  String cleanedValue = value
                                                      .replaceFirst(
                                                          phoneEntry
                                                              .countryCode,
                                                          '')
                                                      .trim();
                                                  phoneEntry.controller.text =
                                                      cleanedValue;
                                                  phoneEntry.controller
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
                                          if (controller.phoneEntries.length >
                                              1)
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.remove_circle_outline,
                                                  color: Colors.red),
                                              onPressed: () => controller
                                                  .removePhoneEntry(index),
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
                                  side:
                                      BorderSide(color: AllColors.greenJungle),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text("Source"),
                          const CommonTextField(
                            hintText: "Enter Source",
                          ),
                          const SizedBox(height: 8),
                          const Text("Type"),
                          Obx(() {
                            return CommonTextField(
                              hintText: "Select Type",
                              categories: leadTypeViewModel.getLeadTypeNames(),
                              onCategoryChanged: (selectedType) {
                                print("Selected Lead Type: $selectedType");
                              },
                            );
                          }),
                          const SizedBox(height: 8),
                          const Text("Assigned Lead to"),
                          Obx(() {
                            if (_assignedLeadToController.loading.value) {
                              return Center();
                            } else {
                              return CommonTextField(
                                hintText: _assignedLeadToController
                                        .selectedLeadName.value.isEmpty
                                    ? Strings.select
                                    : _assignedLeadToController
                                        .selectedLeadName.value,
                                categories: _assignedLeadToController
                                    .fullCategoriesRxList,
                                onCategoryChanged: (selectedCategory) {
                                  final names = selectedCategory
                                      .split('\n')[0]
                                      .split(' ');
                                  if (names.length >= 2) {
                                    final firstName = names[0];
                                    final lastName = names[1];
                                    _assignedLeadToController.selectedLeadName
                                        .value = '$firstName $lastName';
                                  }
                                },
                              );
                            }
                          }),
                          const SizedBox(height: 8),
                          const Text("Organization Name"),
                          CommonTextField(
                            controller: controller.organizationController,
                            hintText: "Select",
                          ),
                          const SizedBox(height: 8),
                          const Text("Divisions *"),
                          Obx(() {
                            if (divisionsController.isLoading.value) {
                              return const CircularProgressIndicator();
                            } else {
                              return CreateNewLeadScreenCard2(
                                hintText: Strings.select,
                                categories: divisionsController.divisionsList
                                    .map((division) => division.name ?? '')
                                    .toList(),
                                onCategoryChanged: (selectedDivision) {
                                  divisionsController.updateSelectedDivisions(
                                      [selectedDivision]);
                                },
                                isMultiSelect: true,
                                isForDivisions: true,
                              );
                            }
                          }),
                          const SizedBox(height: 8),
                          const Text("Services"),
                          Obx(() {
                            if (productCategoryController.isLoading.value) {
                              return const CircularProgressIndicator();
                            } else if (productCategoryController
                                .errorMessage.isNotEmpty) {
                              return Text(
                                  productCategoryController.errorMessage.value);
                            } else if (productCategoryController
                                .leadProductCategories.isEmpty) {
                              return const Text(
                                  'No product categories available');
                            }

                            return CommonTextField(
                              hintText: Strings.select,
                              categories: productCategoryController
                                  .leadProductCategories
                                  .map((category) => category.name ?? 'Unknown')
                                  .toList(),
                              onCategoriesChanged: (selectedCategories) {
                                productCategoryController
                                    .updateSelectedCategories(
                                        selectedCategories);
                              },
                              isMultiSelect: false,
                            );
                          }),
                          const SizedBox(height: 8),
                          Text("Website"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Obx(() => custom.SearchComponents.buildSearchBox(
                                    isTextFieldFocused: searchController
                                        .isTextFieldFocused.value,
                                    textController:
                                        searchController.textController,
                                    focusNode: searchController.focusNode,
                                    textEntries: searchController.textEntries,
                                    searchText:
                                        searchController.searchText.value,
                                    showCreateButton:
                                        searchController.showCreateButton.value,
                                    onAddEntry: searchController.addTextEntry,
                                    onRemoveEntry: searchController.removeEntry,
                                    onClearSearch: searchController.clearSearch,
                                    onClearAll:
                                        searchController.clearAllEntries,
                                  )),
                              const SizedBox(height: 20),
                              Obx(() =>
                                  custom.SearchComponents.buildCreateButton(
                                    showCreateButton:
                                        searchController.showCreateButton.value,
                                    searchText:
                                        searchController.searchText.value,
                                    onCreate: searchController.addTextEntry,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text("Description"),
                          const CommonTextField(
                            textFieldHeight: 80.0,
                            maxLines: 4,
                            hintText: "Write Description",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ContainerUtils(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Address Information",
                                style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                              // Spacer(),
                              // Text(""),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CustomToggleButtonGroup(
                              initialSelectedIndex: _selectedIndex,
                              onIndexChanged: (index) {
                                setState(() {
                                  _selectedIndex = index;
                                  isListView = index == 0;
                                });
                              },
                              options: [
                                ToggleButtonUtils.createIconTextOption(
                                  selectedTextColor: AllColors.whiteColor,
                                  text: 'Indian',
                                  selectedColor: AllColors.practiceColor,
                                ),
                                ToggleButtonUtils.createIconTextOption(
                                  selectedTextColor: AllColors.whiteColor,
                                  text: 'Non-India',
                                  selectedColor: AllColors.practiceColor,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Indian Address Fields
                                      if (_selectedIndex == 0)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 8),
                                            const Text("Pincode"),
                                            Obx(() {


                                              return CommonTextField(
                                                categories: pinCodeViewModel
                                                        .filteredPincodeList
                                                        .isNotEmpty
                                                    ? pinCodeViewModel
                                                        .filteredPincodeList
                                                        .map((pincode) {
                                                          final districtName =
                                                              pincode.district
                                                                      ?.name
                                                                      ?.toString() ??
                                                                  '';
                                                          print(
                                                              '  Mapping pincode: ${pincode.code}, district: $districtName');
                                                          return districtName;
                                                        })
                                                        .where((name) =>
                                                            name.isNotEmpty)
                                                        .toList()
                                                    : [],
                                                controller: controller
                                                    .pincodeController,
                                                errorMessage: pinCodeViewModel
                                                        .errorMessage
                                                        .value
                                                        .isEmpty
                                                    ? null
                                                    : pinCodeViewModel
                                                        .errorMessage.value,
                                                hintText: 'Enter Pincode',
                                                validator: (value) {
                                                  // print('✅ [LeadEditScreen] Validator called with value: "$value"');
                                                  if (pinCodeViewModel
                                                          .searchResults
                                                          .isNotEmpty &&
                                                      pinCodeViewModel
                                                          .errorMessage
                                                          .value
                                                          .isEmpty) {
                                                    print(
                                                        '  Validation passed: searchResults available');
                                                    return null;
                                                  }
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    print(
                                                        '  Validation failed: Empty pincode');
                                                    return 'Please enter a pincode';
                                                  }
                                                  if (!RegExp(r'^\d{6}$')
                                                      .hasMatch(value)) {
                                                    print(
                                                        '  Validation failed: Invalid 6-digit pincode');
                                                    return 'Please enter a valid 6-digit pincode';
                                                  }
                                                  return null;
                                                },
                                                onSearch: (query) {
                                                  // print('🔍 [LeadEditScreen] onSearch triggered with query: "$query"');
                                                  // print('  Query length: ${query.length}');
                                                  if (query.isNotEmpty &&
                                                      query.length == 6) {
                                                    print(
                                                        '  Calling pinCodeViewModel.searchPincode("$query")');
                                                    pinCodeViewModel
                                                        .searchPincode(query);
                                                  } else {
                                                    // print('  Skipping search: Query too short or empty');
                                                  }
                                                },
                                                onChanged: (value) {
                                                  // print('🔥 [LeadEditScreen] onChanged triggered with value: "$value"');
                                                  // print('  Value length: ${value?.length ?? 0}');
                                                  // print('  Current pincodeController text: "${controller.pincodeController.text}"');

                                                  if (value == null) {
                                                    // print('❌ Value is null');
                                                    return;
                                                  }

                                                  controller.pincodeController
                                                      .text = value;
                                                  // print('  Updated pincodeController text to: "${controller.pincodeController.text}"');

                                                  if (value.isEmpty) {
                                                    // print('🧹 Clearing all fields due to empty input');
                                                    controller.cityController
                                                        .clear();
                                                    controller
                                                        .districtController
                                                        .clear();
                                                    controller.stateController
                                                        .clear();
                                                    controller.countryController
                                                        .clear();
                                                    pinCodeViewModel.clear();
                                                    pinCodeViewModel
                                                        .errorMessage
                                                        .value = '';
                                                  } else {
                                                    // print('🔍 Processing pincode input: "$value"');
                                                    // print('  Calling searchPartialPincode("$value")');
                                                    pinCodeViewModel
                                                        .searchPartialPincode(
                                                            value);

                                                    if (value.length == 6 &&
                                                        RegExp(r'^\d{6}$')
                                                            .hasMatch(value)) {
                                                      // print('🎯 VALID 6-DIGIT PINCODE DETECTED: "$value"');
                                                      // print('  Performing full search');
                                                      pinCodeViewModel
                                                          .searchPincode(value)
                                                          .then((_) {
                                                        // print('✅ Search completed, results count: ${pinCodeViewModel.searchResults.length}');
                                                        if (pinCodeViewModel
                                                            .searchResults
                                                            .isNotEmpty) {
                                                          final selectedPincode =
                                                              pinCodeViewModel
                                                                  .searchResults
                                                                  .first;


                                                          controller
                                                                  .cityController
                                                                  .text =
                                                              selectedPincode
                                                                      .district
                                                                      ?.name ??
                                                                  '';
                                                          controller
                                                                  .districtController
                                                                  .text =
                                                              selectedPincode
                                                                      .district
                                                                      ?.name ??
                                                                  '';
                                                          controller
                                                                  .stateController
                                                                  .text =
                                                              selectedPincode
                                                                      .district
                                                                      ?.state
                                                                      ?.name ??
                                                                  '';
                                                          controller
                                                                  .countryController
                                                                  .text =
                                                              selectedPincode
                                                                      .district
                                                                      ?.state
                                                                      ?.country
                                                                      ?.name ??
                                                                  'India';
                                                        } else {

                                                        }
                                                      }).catchError((error) {

                                                      });
                                                    } else {

                                                    }
                                                  }
                                                },
                                                onCategoriesChanged:
                                                    (selectedCategories) {

                                                  if (selectedCategories
                                                      .isNotEmpty) {

                                                    try {
                                                      final selectedPincode =
                                                          pinCodeViewModel
                                                              .filteredPincodeList
                                                              .firstWhere(
                                                        (pincode) =>
                                                            pincode.district
                                                                ?.name ==
                                                            selectedCategories[
                                                                0],
                                                        orElse: () {

                                                          return PinCodeModelResponseModel(
                                                            code: '',
                                                            district: District(
                                                              name: '',
                                                              state: StateModel(
                                                                  name: '',
                                                                  country: Country(
                                                                      name:
                                                                          '')),
                                                            ),
                                                          );
                                                        },
                                                      );

                                                      if (selectedPincode
                                                                  .code !=
                                                              null &&
                                                          selectedPincode.code!
                                                              .isNotEmpty) {

                                                        controller
                                                                .pincodeController
                                                                .text =
                                                            selectedPincode
                                                                .code!;
                                                        controller
                                                                .cityController
                                                                .text =
                                                            selectedPincode
                                                                    .district
                                                                    ?.name ??
                                                                '';
                                                        controller
                                                            .districtController
                                                            .text = selectedPincode
                                                                .district
                                                                ?.name ??
                                                            '';
                                                        controller
                                                                .stateController
                                                                .text =
                                                            selectedPincode
                                                                    .district
                                                                    ?.state
                                                                    ?.name ??
                                                                '';
                                                        controller
                                                                .countryController
                                                                .text =
                                                            selectedPincode
                                                                    .district
                                                                    ?.state
                                                                    ?.country
                                                                    ?.name ??
                                                                'India';
                                                      } else {

                                                      }
                                                    } catch (e, stackTrace) {

                                                    }
                                                  }
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      6),
                                                ],
                                              );
                                            }),
                                            const SizedBox(height: 8),
                                            const Text("City"),
                                            CommonTextField(
                                                hintText: 'Select City'),
                                            const SizedBox(height: 8),
                                            const Text("District"),
                                            CommonTextField(
                                              readonly: true,
                                              controller:
                                                  controller.districtController,
                                              hintText: "Enter District",
                                              categories: [],
                                            ),
                                            const SizedBox(height: 8),
                                            const Text("State"),
                                            CommonTextField(
                                              readonly: true,
                                              controller:
                                                  controller.stateController,
                                              hintText: "Enter State",
                                              categories: [],
                                            ),
                                            const SizedBox(height: 8),
                                            const Text("Country"),
                                            CommonTextField(
                                              readonly: true,
                                              controller:
                                                  controller.countryController,
                                              hintText: "Enter Country",
                                              categories: [],
                                            ),
                                            const SizedBox(height: 8),
                                            const Text("Address"),
                                            CommonTextField(
                                              controller:
                                                  controller.addressController,
                                              hintText: "Enter Address",
                                            ),
                                          ],
                                        )
                                      else if (_selectedIndex == 1)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 8),
                                            const Text("Address"),
                                            CommonTextField(
                                              controller: controller
                                                  .nonIndiaAddressController,
                                              hintText: "Enter Address",
                                              readonly: false,
                                            ),
                                            const SizedBox(height: 8),
                                            const Text("Pincode"),
                                            Obx(() {


                                              return CommonTextField(
                                                categories: pinCodeViewModel
                                                        .filteredPincodeList
                                                        .isNotEmpty
                                                    ? pinCodeViewModel
                                                        .filteredPincodeList
                                                        .map((pincode) =>
                                                            pincode
                                                                .district?.name
                                                                ?.toString() ??
                                                            '')
                                                        .where((name) =>
                                                            name.isNotEmpty)
                                                        .toList()
                                                    : [],
                                                controller: controller
                                                    .nonIndiaPincodeController,
                                                // Note: Different controller
                                                errorMessage: pinCodeViewModel
                                                        .errorMessage
                                                        .value
                                                        .isEmpty
                                                    ? null
                                                    : pinCodeViewModel
                                                        .errorMessage.value,
                                                hintText: 'Enter Pincode',
                                                validator: (value) {

                                                  if (pinCodeViewModel
                                                          .searchResults
                                                          .isNotEmpty &&
                                                      pinCodeViewModel
                                                          .errorMessage
                                                          .value
                                                          .isEmpty) {
                                                    return null;
                                                  }
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter a pincode';
                                                  }
                                                  if (!RegExp(r'^\d{6}$')
                                                      .hasMatch(value)) {
                                                    return 'Please enter a valid 6-digit pincode';
                                                  }
                                                  return null;
                                                },
                                                onSearch: (query) {

                                                  print('Query: $query');
                                                  if (query.isNotEmpty &&
                                                      query.length == 6) {

                                                    pinCodeViewModel
                                                        .searchPincode(query);
                                                  }
                                                },
                                                onChanged: (value) {


                                                  if (value != null) {
                                                    controller
                                                        .nonIndiaPincodeController
                                                        .text = value;
                                                  }

                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    print(
                                                        'Clearing Non-Indian fields');
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
                                                    pinCodeViewModel.clear();
                                                    pinCodeCityViewModel
                                                        .clear();
                                                  } else {
                                                    print(
                                                        'Processing Non-Indian pincode: $value');
                                                    pinCodeViewModel
                                                        .searchPartialPincode(
                                                            value);

                                                    if (value.length == 6 &&
                                                        RegExp(r'^\d{6}$')
                                                            .hasMatch(value)) {
                                                      print(
                                                          'Valid 6-digit Non-Indian pincode detected');
                                                      pinCodeViewModel
                                                          .searchPincode(value)
                                                          .then((_) {
                                                        if (pinCodeViewModel
                                                            .searchResults
                                                            .isNotEmpty) {
                                                          final selectedPincode =
                                                              pinCodeViewModel
                                                                  .searchResults
                                                                  .first;
                                                          print(
                                                              'Auto-filling Non-Indian fields');
                                                          controller
                                                                  .nonIndiaCityController
                                                                  .text =
                                                              selectedPincode
                                                                      .district
                                                                      ?.name ??
                                                                  '';
                                                          controller
                                                                  .nonIndiaDistrictController
                                                                  .text =
                                                              selectedPincode
                                                                      .district
                                                                      ?.name ??
                                                                  '';
                                                          controller
                                                                  .nonIndiaStateController
                                                                  .text =
                                                              selectedPincode
                                                                      .district
                                                                      ?.state
                                                                      ?.name ??
                                                                  '';
                                                          controller
                                                                  .nonIndiaCountryController
                                                                  .text =
                                                              selectedPincode
                                                                      .district
                                                                      ?.state
                                                                      ?.country
                                                                      ?.name ??
                                                                  'India';
                                                        }
                                                      }).catchError((error) {
                                                        print(
                                                            'Error during Non-Indian pincode search: $error');
                                                      });
                                                    }
                                                  }
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      6),
                                                ],
                                              );
                                            }),
                                            const SizedBox(height: 8),
                                            const Text("City"),
                                            CommonTextField(
                                              controller: controller
                                                  .nonIndiaCityController,
                                              hintText: "Enter City",
                                              readonly: false,
                                            ),
                                            const SizedBox(height: 8),
                                            const Text("District"),
                                            CommonTextField(
                                              controller: controller
                                                  .nonIndiaDistrictController,
                                              hintText: "Enter District",
                                              readonly: false,
                                            ),
                                            const SizedBox(height: 8),
                                            const Text("State"),
                                            CommonTextField(
                                              controller: controller
                                                  .nonIndiaStateController,
                                              hintText: "Enter State",
                                              readonly: false,
                                            ),
                                            const SizedBox(height: 8),
                                            const Text("Country"),
                                            CommonTextField(
                                              controller: controller
                                                  .nonIndiaCountryController,
                                              hintText: "Enter Country",
                                              readonly: false,
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Custom Fields",
                            style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.sfPro,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("Age Group"),
                          CommonTextField(
                            hintText: "Age Group",
                          ),
                          const SizedBox(height: 8),
                          Text("Aadhar Card Number"),
                          CommonTextField(
                            hintText: "Aadhar Card Number",
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: CommonButton(
                                    borderRadius: 5,
                                    width: 130,
                                    height: 45,
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
                                    borderRadius: 5,
                                    height: 45,
                                    width: 130,
                                    color: AllColors.practiceColor,
                                    textColor: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    title: 'Submit',
                                    onPress: () {}),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
