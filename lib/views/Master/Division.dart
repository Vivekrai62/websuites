import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import '../../../../../viewModels/master/divisions/master_divisions_viewModel.dart';
import '../../Utils/utils.dart';
import '../../data/models/requestModels/master/division/add_division/AddDivisionRequestModels.dart';
import '../../data/models/requestModels/master/division/update/UpdateDivisionRequestModels.dart';
import '../../data/models/responseModels/master/divisions/add_division/AddDivisionResponseModels.dart';
import '../../data/models/responseModels/master/divisions/master_divisions_response_model.dart';
import '../../data/models/responseModels/master/divisions/update/UpdateDivisionListResponseModel.dart';
import '../../utils/appColors/app_colors.dart';
import '../../utils/button/CustomButton.dart';
import '../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../utils/dark_mode/dark_mode.dart';
import '../../utils/fontfamily/FontFamily.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:file_picker/file_picker.dart';
import '../../viewModels/master/divisions/add_Divisions/AddDivisionViewModels.dart';
import '../../viewModels/master/divisions/update_division/UpdateDivisionListViewModel.dart';
import '../../viewModels/master/divisions/update_division/UpdateDivisionViewModel.dart';
import '../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class MasterDivisionScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const MasterDivisionScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _MasterDivisionScreenState createState() => _MasterDivisionScreenState();
}

class _MasterDivisionScreenState extends State<MasterDivisionScreen> {
  final AddDivisionViewModels _userAddDepartmentViewModel =
      Get.put(AddDivisionViewModels());

  final MasterDivisionsViewModel divisionViewModel =
      Get.put(MasterDivisionsViewModel());

  final UpdateDivisionViewModel _userUpdateDivisionViewModel =
      Get.put(UpdateDivisionViewModel());

  final UpdateDivisionListViewModel _divisionUpdateListViewModel =
      Get.put(UpdateDivisionListViewModel());

  String? _fileName;
  Country? _selectedCountry;
  TextEditingController phoneController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedCountry = Country(
      countryCode: 'IN',
      e164Sc: 91,
      geographic: true,
      level: 1,
      example: '91 12345 67890',
      displayName: 'India',
      displayNameNoCountryCode: 'India',
      e164Key: 'IN',
      phoneCode: '91',
      name: 'India',
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    final MasterDivisionsViewModel divisionViewModel =
        Get.put(MasterDivisionsViewModel());

    divisionViewModel.masterDivisions(context);

    return Scaffold(
      backgroundColor: DarkMode.backgroundColor(context),
      body: Center(
        child: Obx(() {
          final divisions = divisionViewModel.divisions;

          if (divisionViewModel.loading.value && divisions.isEmpty) {
            return const CircularProgressIndicator();
          }

          if (divisions.isEmpty) {
            return const Text('No divisions available');
          }

          return RefreshIndicator(
            onRefresh: () => divisionViewModel.refreshData(context),
            child: Column(
              children: [
                CustomAppBar(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
                    child: Row(
                      children: [
                        if (!isTablet)
                          IconButton(
                            icon: const Icon(Icons.menu, color: Colors.black),
                            onPressed: () {
                              widget.scaffoldKey.currentState?.openDrawer();
                            },
                          ),
                        if (isTablet) const SizedBox(width: 10),
                        Text(
                          'Division',
                          style: TextStyle(
                            color: DarkMode.backgroundColor2(context),
                            fontWeight: FontWeight.w700,
                            fontSize: 17.5,
                          ),
                        ),
                        const Spacer(),
                        CustomButton(
                          width: 70,
                          height: 22,
                          borderRadius: 54,
                          onPressed: () {
                            AddDivisionResponseModels addDivision =
                                AddDivisionResponseModels();
                            _showDialog(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add,
                                  color: AllColors.whiteColor, size: 18),
                              const SizedBox(width: 5),
                              const Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Corrected condition: Use divisionViewModel.loading instead of divisions.loading
                      if (divisions.isEmpty &&
                          !divisionViewModel.loading.value) {
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: constraints.maxHeight,
                            child: const Center(
                              child: Text("No projects available"),
                            ),
                          ),
                        );
                      }

                      final double screenWidth = constraints.maxWidth;
                      int crossAxisCount = screenWidth < 600
                          ? 1
                          : screenWidth < 1200
                              ? 2
                              : 3;
                      final double itemWidth =
                          (screenWidth - (crossAxisCount - 1) * 16) /
                              crossAxisCount;
                      const double itemHeight = 100;
                      final double childAspectRatio = itemWidth / itemHeight;

                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: childAspectRatio,
                                  ),
                                  itemCount: divisions.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == divisions.length) {
                                      return const Center(
                                        child: Text("Pagination Placeholder"),
                                      );
                                    }

                                    final division = divisions[index];
                                    return GestureDetector(
                                      onTap: () {},
                                      child: ContainerUtils(
                                        paddingBottom: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    division.name ?? 'No Date',
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            FontFamily.sfPro,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize:
                                                            16 // Aspect ratio-based font size
                                                        ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: division.status ==
                                                            'InActive'
                                                        ? AllColors.lightRed
                                                        : AllColors
                                                            .background_green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Text(
                                                    division.status ?? 'N/A',
                                                    style: TextStyle(
                                                      color: division.status ==
                                                              'InActive'
                                                          ? Colors.red[800]
                                                          : AllColors
                                                              .text__green,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  ImageStrings.date,
                                                  height: 13,
                                                  width: 13,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  formatDateWithDay(
                                                      division.createdAt ??
                                                          'N/A'),
                                                  style: TextStyle(
                                                      color: AllColors
                                                          .mediumPurple),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                  onPressed: () async {
                                                    await _divisionUpdateListViewModel
                                                        .updateDivisionList(
                                                            context,
                                                            division.id
                                                                .toString());

                                                    if (_divisionUpdateListViewModel
                                                        .division
                                                        .value
                                                        .isNotEmpty) {
                                                      final UpdateDivisionListResponseModel
                                                          updateDivision =
                                                          _divisionUpdateListViewModel
                                                              .division
                                                              .value
                                                              .first;
                                                      _showDialog2(
                                                          division.id
                                                              .toString(),
                                                          updateDivision);
                                                    }
                                                  },
                                                  icon: Image.asset(
                                                    ImageStrings.edit,
                                                    width: 16,
                                                    height: 16,
                                                    color: AllColors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                if (divisionViewModel.loading.value)
                                  const Positioned.fill(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _showDialog2(
      String divisionId, UpdateDivisionListResponseModel division) {
    if (divisionId.isEmpty) return; // Check if divisionId is not empty

    String? selectedStatus = division.status;

    Country? tempSelectedCountry = _selectedCountry;
    final TextEditingController nameController =
        TextEditingController(text: division.name);
    final TextEditingController contactPersonName =
        TextEditingController(text: division.contactPerson);
    final TextEditingController email =
        TextEditingController(text: division.email);
    final TextEditingController address =
        TextEditingController(text: division.address);
    final TextEditingController phoneController =
        TextEditingController(text: division.mobileNo);
    TextEditingController fileNameController =
        TextEditingController(text: division.logo);
    String? filePath; // Variable to hold the file path

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Text(
                              'Edit Division',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: FontFamily.sfPro,
                                color: AllColors.blackColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Name'),
                          const SizedBox(height: 5),
                          CommonTextField(
                            hintText: 'Enter Name',
                            controller: nameController,
                          ),
                          const SizedBox(height: 5),
                          const Text('Contact Person Name'),
                          const SizedBox(height: 5),
                          CommonTextField(
                            hintText: 'Enter Contact Person Name',
                            controller: contactPersonName,
                          ),
                          const SizedBox(height: 5),
                          const Text('Email'),
                          const SizedBox(height: 5),
                          CommonTextField(
                            hintText: 'Enter Email',
                            controller: email,
                          ),
                          const SizedBox(height: 5),
                          const Text('Status'),
                          const SizedBox(height: 5),
                          //
                          // DropdownButton<String>(
                          //   value: selectedStatus,
                          //   hint: Text('Select Status'),
                          //   items: <String>['Active', 'InActive']
                          //       .map((String value) {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(value),
                          //     );
                          //   }).toList(),
                          //   onChanged: (String? newValue) {
                          //     setState(() {
                          //       selectedStatus =
                          //           newValue; // Update the selected status
                          //     });
                          //   },
                          // ),

                          CommonTextField(
                            hintText: 'Status',
                            categories: const [
                              'Active',
                              'Inactive'
                            ], // Populate categories
                            value: selectedStatus, // Pass the selected value
                            onCategoryChanged: (String? newValue) {
                              setState(() {
                                selectedStatus =
                                    newValue; // Update the selected status
                              });
                            },
                          ),
                          const SizedBox(height: 5),
                          const Text('Mobile Number'),
                          const SizedBox(height: 5),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        onSelect: (Country country) {
                                          setState(() {
                                            tempSelectedCountry = country;
                                            _selectedCountry =
                                                country; // Update the selected country
                                          });
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        if (tempSelectedCountry != null) ...[
                                          Text(
                                            tempSelectedCountry!.flagEmoji,
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                          const Icon(Icons.arrow_drop_up),
                                        ] else
                                          const Text('Select'),
                                        Container(
                                          width: 1,
                                          height: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    style:
                                        TextStyle(color: AllColors.figmaGrey),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter mobile number',
                                      hintStyle:
                                          TextStyle(color: AllColors.figmaGrey),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 9),
                                      prefix: tempSelectedCountry != null
                                          ? Text(
                                              '+${tempSelectedCountry!.phoneCode} ',
                                              style: TextStyle(
                                                  color: AllColors.figmaGrey),
                                            )
                                          : Text(
                                              '+91 ',
                                              style: TextStyle(
                                                  color: AllColors.figmaGrey),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('Address'),
                          const SizedBox(height: 5),
                          CommonTextField(
                            hintText: 'Enter Address',
                            controller: address,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              CustomButton(
                                height: Get.height / 28,
                                width: 100,
                                backgroundColor: AllColors.greyGoogleForm,
                                child: Text(
                                  'Choose files',
                                  style: TextStyle(
                                    color: AllColors.blackColor,
                                    height: 40,
                                    fontSize: 12,
                                  ),
                                ),
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles();
                                  if (result != null) {
                                    setState(() {
                                      filePath = result.files.first
                                          .path; // Store the file path
                                      fileNameController.text = result
                                          .files
                                          .first
                                          .name; // Update the controller's text
                                    });
                                  }
                                },
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 9.0),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    fileNameController.text.isNotEmpty
                                        ? fileNameController.text
                                        : 'No file selected',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                backgroundColor: Colors.grey,
                                width: 80,
                                height: 30,
                                borderRadius: 25,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.sfPro,
                                  ),
                                ),
                              ),
                              CustomButton(
                                width: 80,
                                height: 30,
                                borderRadius: 25,
                                onPressed: () async {
                                  if (tempSelectedCountry != null &&
                                      phoneController.text.isNotEmpty) {
                                    String fullPhoneNumber =
                                        '+${tempSelectedCountry!.phoneCode}${phoneController.text}';

                                    // Create the update model
                                    UpdateDivisionRequestModels updateDivision =
                                        UpdateDivisionRequestModels(
                                      name: nameController.text,
                                      mobileNo: fullPhoneNumber,
                                      contactPerson: contactPersonName.text,
                                      email: email.text,
                                      status: selectedStatus,
                                      // Use the selected status from the dropdown
                                      address: address.text,
                                      logo:
                                          filePath, // Use the actual file path for the logo
                                    );

                                    // Call the update API
                                    await _userUpdateDivisionViewModel
                                        .updateDivisionSettingApi(
                                            context,
                                            divisionId,
                                            updateDivision,
                                            filePath);

                                    Navigator.of(context).pop();
                                  } else {
                                    Utils.snackbarFailed(
                                        'Please enter a valid phone number and select a file if needed');
                                  }
                                },
                                child: const Text(
                                  'Update',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.sfPro,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 1,
                    top: -10,
                    child: Container(
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showDialog(BuildContext context) {
    Country? tempSelectedCountry = _selectedCountry;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController contactPersonName = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController address = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController fileNameController =
        TextEditingController(); // Controller for the file name
    String? filePath; // Variable to hold the file path

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Add New Division',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontFamily.sfPro,
                        color: AllColors.blackColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Name Field
                  const Text('Name'),
                  const SizedBox(height: 5),
                  CommonTextField(
                    hintText: 'Enter Name',
                    controller: nameController,
                  ),
                  const SizedBox(height: 5),
                  // Contact Person Name Field
                  const Text('Contact Person Name'),
                  const SizedBox(height: 5),
                  CommonTextField(
                    hintText: 'Enter Contact Person Name',
                    controller: contactPersonName,
                  ),
                  const SizedBox(height: 5),
                  // Email Field
                  const Text('Email'),
                  const SizedBox(height: 5),
                  CommonTextField(
                    hintText: 'Enter Email',
                    controller: email,
                  ),
                  const SizedBox(height: 5),
                  // Mobile Number Field
                  const Text('Mobile Number'),
                  const SizedBox(height: 5),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              onSelect: (Country country) {
                                setState(() {
                                  tempSelectedCountry = country;
                                  _selectedCountry =
                                      country; // Update the selected country
                                });
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                if (tempSelectedCountry != null) ...[
                                  Text(tempSelectedCountry!.flagEmoji,
                                      style: const TextStyle(fontSize: 24)),
                                  const Icon(Icons.arrow_drop_up),
                                ] else
                                  const Text('Select'),
                                Container(
                                  width: 1,
                                  height: double.infinity,
                                  color: Colors.grey,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(color: AllColors.figmaGrey),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter mobile number',
                              hintStyle: TextStyle(color: AllColors.figmaGrey),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 9),
                              prefix: tempSelectedCountry != null
                                  ? Text('+ ${tempSelectedCountry!.phoneCode} ',
                                      style:
                                          TextStyle(color: AllColors.figmaGrey))
                                  : Text('+91 ',
                                      style: TextStyle(
                                          color: AllColors.figmaGrey)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Address Field
                  const Text('Address'),
                  const SizedBox(height: 5),
                  CommonTextField(
                    hintText: 'Enter Address',
                    controller: address,
                  ),
                  const SizedBox(height: 20),
                  // File Picker
                  Row(
                    children: [
                      CustomButton(
                        height: Get.height / 28,
                        width: 100,
                        backgroundColor: AllColors.greyGoogleForm,
                        child: Text(
                          'Choose files',
                          style: TextStyle(
                              color: AllColors.blackColor, fontSize: 12),
                        ),
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          if (result != null) {
                            setState(() {
                              fileNameController.text = result.files.first
                                  .name; // Update the controller's text
                              filePath = result
                                  .files.first.path; // Store the file path
                            });
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 9.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            fileNameController.text.isNotEmpty
                                ? fileNameController.text
                                : 'No file selected',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        backgroundColor: Colors.grey,
                        width: 80,
                        height: 30,
                        borderRadius: 25,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.sfPro),
                        ),
                      ),
                      CustomButton(
                        width: 80,
                        height: 30,
                        borderRadius: 25,
                        onPressed: () async {
                          if (tempSelectedCountry != null &&
                              phoneController.text.isNotEmpty) {
                            String fullPhoneNumber =
                                '+${tempSelectedCountry!.phoneCode}${phoneController.text}';

                            // Create an instance of AddDivisionRequestModels
                            AddDivisionRequestModels newDivision =
                                AddDivisionRequestModels(
                              name: nameController.text,
                              mobileNo: fullPhoneNumber,
                              contactPerson: contactPersonName.text,
                              email: email.text,
                              address: address.text,
                              logo: filePath, // Use the file path for the logo
                            );

                            // Call the API to add the division
                            await _userAddDepartmentViewModel
                                .addDivisionSettingApi(
                                    context, newDivision, filePath);

                            // Close the dialog
                            Navigator.of(context).pop();
                          } else {
                            // Show an error message if the phone number is not valid
                            Utils.snackbarFailed(
                                'Please enter a valid phone number');
                          }
                        },
                        child: const Text(
                          'Create',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.sfPro),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
