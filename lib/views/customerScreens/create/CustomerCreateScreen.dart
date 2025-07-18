import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/appUrls/app_urls.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import '../../../data/models/controller.dart';
import '../../../data/models/responseModels/leads/createNewLead/lead_source_controller.dart';
import '../../../utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import '../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';
import '../../../utils/responsive/responsive_utils.dart';
import '../../../viewModels/leadScreens/createNewLead/assignedLeadTo/assigned_lead_to_viewModel.dart';
import '../../../viewModels/leadScreens/createNewLead/constant_controller/constant_controller.dart';
import '../../../viewModels/leadScreens/createNewLead/createnewlead_button/CreateNewLeadButton.dart';
import '../../../viewModels/leadScreens/createNewLead/customFields/custom_fields_viewModels.dart';
import '../../../viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import '../../../viewModels/leadScreens/createNewLead/pincode/pincode_view_model.dart';
import '../../../viewModels/leadScreens/createNewLead/product_category/product_category_controller.dart';
import '../../../viewModels/leadScreens/trashLeads/leadTypes/lead_type_viewModel.dart';
import '../../../viewModels/saveToken/save_token.dart';
import '../../../data/models/responseModels/login/login_response_model.dart';
import '../../../resources/strings/strings.dart';
import '../../../resources/textStyles/text_styles.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../data/network/network_api_services.dart';

class CustomerCreateNewLeadScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomerCreateNewLeadScreen({
    super.key,
    required this.scaffoldKey,
  });
  @override
  State<CustomerCreateNewLeadScreen> createState() =>
      _CustomerCreateNewLeadScreenState();
}

class _CustomerCreateNewLeadScreenState
    extends State<CustomerCreateNewLeadScreen> {
  RxList<String> categoriesRxList = RxList<String>();
  // final LeadMasterController controller1 = Get.put(LeadMasterController());

  final PinCodeViewModel createLeadPinController = Get.put(PinCodeViewModel());
  final PinCodeViewModel _viewModel = Get.put(PinCodeViewModel());
  TextEditingController searchController = TextEditingController();
  final ProductCategoryController productCategoryController = Get.put(ProductCategoryController());
  final CreateNewLeadController controller = Get.put(CreateNewLeadController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  final LeadSourceController leadSourceController =
      Get.put(LeadSourceController(apiService: NetworkApiServices()));

  final AssignedLeadToViewModel _assignedLeadToController =
      Get.put(AssignedLeadToViewModel());

  // final DivisionsViewModel _divisionsController = Get.put(DivisionsViewModel());
  final LeadTypeViewModel leadTypeViewModel = Get.put(LeadTypeViewModel());
  final CreateLeadCustomFieldsViewModel customFieldsController =
      Get.put(CreateLeadCustomFieldsViewModel());

  final ConstantValueViewModel constantValueViewModel =
      Get.put(ConstantValueViewModel());
  final SaveUserData userPreference = SaveUserData();

  String userName = '';
  String? userEmail;

  var selectedTab = 'types'.obs; // Track selected tab

  @override
  void initState() {
    super.initState();
    // customFieldsController.getIndustryType();
    leadSourceController.fetchLeadSources(AppUrls.createNewLeadSource);
    productCategoryController
        .createLeadProductCategory(context); // Ensure this is called
    _assignedLeadToController
        .fetchAssignedLeads(context); // Ensure this is called
    productCategoryController.createLeadProductCategory(context);

    fetchUserData();
    _initControllers();
    // _divisionsController.createNewLeadDivisions(context);
    // productCategoryController.fetchLeadProductCategories(context); // Ensure this is called
  }

  void _initControllers() {
    // _assignedLeadToController.assignedLead(context);
    // _divisionsController.createNewLeadDivisions(context);
    customFieldsController.createNewLeadCustomFields(context);
    leadSourceController.fetchLeadSources(AppUrls.createNewLeadSource);
    // productCategoryController.fetchLeadProductCategories(context);
  }

  Future<void> fetchUserData() async {
    try {
      LoginResponseModel response = await userPreference.getUser();
      setState(() {
        userName = response.user?.firstName ?? '';
        userEmail = response.user?.email;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    //   statusBarIconBrightness: Brightness.dark,
    //   statusBarBrightness: Brightness.light,));

    final bool isTablet = MediaQuery.of(context).size.width > 600;
    final DivisionsViewModel divisionsController =
        Get.put(DivisionsViewModel());
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AllColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 98,
              decoration: isTablet
                  ? null
                  : BoxDecoration(
                      color: AllColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45.withOpacity(0.10),
                          spreadRadius: 0.5,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40, right: 15),
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
                      'Create New Customer',
                      style: TextStyle(
                        color: AllColors.blackColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 17.5,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      TextStyles.w600_15(
                          color: AllColors.vividPurple,
                          context,
                          Strings.standardFields),
                      const SizedBox(height: 28),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextStyles.w500_14_Black(context, Strings.firstName),
                          CreateNewLeadScreenCard2(
                            hintText: Strings.enterFirstName,
                            controller: controller.firstNameController,
                          ),
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(context, Strings.lastName),
                          CreateNewLeadScreenCard2(
                            hintText: Strings.enterLastName,
                            controller: controller.lastNameController,
                          ),
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(
                              context, Strings.phoneNumber),
                          CreateNewLeadScreenCard2(
                            hintText: Strings.enterPhoneNumber,
                            controller: controller.mobileController,
                          ),
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(context, Strings.email),

                          CreateNewLeadScreenCard2(
                            hintText: Strings.emailExample,
                            controller: controller.emailController,
                          ),
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(context, Strings.address),
                          const CreateNewLeadScreenCard2(
                              hintText: Strings.enterAddresscal),
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(
                              context, Strings.cityPincode),
                          const CreateNewLeadScreenCard2(
                              hintText: Strings.cityPincode),
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(context, Strings.state),
                          const CreateNewLeadScreenCard2(
                            hintText: Strings.state,
                          ),
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(context, Strings.country),
                          const CreateNewLeadScreenCard2(
                              hintText: Strings.country),
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(context, Strings.source),
                          const SizedBox(height: 5),

                          Obx(() {
                            if (productCategoryController.isLoading.value) {
                              return const CircularProgressIndicator();
                            } else if (productCategoryController.errorMessage.isNotEmpty) {
                              return Text(productCategoryController.errorMessage.value);
                            } else if (productCategoryController.leadProductCategories.isEmpty) {
                              return const Text('No product categories available');
                            }

                            return CreateNewLeadScreenCard2(
                              hintText: Strings.select,
                              categories: productCategoryController.leadProductCategories
                                  .map<String>((category) => category.name ?? 'Unknown')
                                  .toList(),
                              onCategoriesChanged: (selectedCategories) {
                                productCategoryController.updateSelectedCategories(selectedCategories);
                              },
                              isMultiSelect: true,
                            );
                          }),
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(context, Strings.type),
                          Obx(() {
                            if (leadTypeViewModel.loading.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return Column(
                              children: [
                                CreateNewLeadScreenCard2(
                                  hintText: Strings.type,
                                  categories:
                                      leadTypeViewModel.getLeadTypeNames(),
                                  onCategoryChanged: (selectedType) {
                                    print("Selected Lead Type: $selectedType");
                                  },
                                ),
                              ],
                            );
                          }),
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(context, Strings.status),
                          const CreateNewLeadScreenCard2(
                            hintText: Strings.status,
                            categories: [
                              "New",
                              "In_Progress",
                              "Converted",
                              "Dead"
                            ],
                          ),
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(
                            context,
                            Strings.assignedLeadTo,
                          ),

                          Obx(() {
                            if (_assignedLeadToController.loading.value) {
                              return const CircularProgressIndicator();
                            } else {
                              return CreateNewLeadScreenCard2(
                                hintText: _assignedLeadToController
                                        .selectedLeadName.value.isEmpty
                                    ? Strings.select
                                    : _assignedLeadToController
                                        .selectedLeadName.value,
                                categories: _assignedLeadToController
                                    .fullCategoriesRxList,
                                onCategoryChanged: (selectedCategory) {
                                  // Handle selection for full names with emails
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
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(
                              context, Strings.organisation),
                          CreateNewLeadScreenCard2(
                            hintText: Strings.enterName,
                            controller: controller.organizationController,
                          ),
                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(
                            context,
                            Strings.divisions,
                          ),

                          Obx(() {
                            if (divisionsController.isLoading.value) {
                              // Change 'loading' to 'isLoading'
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

                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(context, Strings.categories),

                          Obx(() {
                            if (productCategoryController.isLoading.value) {
                              return const CircularProgressIndicator();
                            } else if (productCategoryController.errorMessage.isNotEmpty) {
                              return Text(productCategoryController.errorMessage.value);
                            } else if (productCategoryController.leadProductCategories.isEmpty) {
                              return const Text('No product categories available');
                            }

                            return CreateNewLeadScreenCard2(
                              hintText: Strings.select,
                              categories: productCategoryController.leadProductCategories
                                  .map((category) => category.name ?? 'Unknown')
                                  .toList(),
                              onCategoriesChanged: (selectedCategories) {
                                productCategoryController.updateSelectedCategories(selectedCategories);
                              },
                              isMultiSelect: true, // Allow multiple selections
                            );
                          }),
                          //

                          CommonSizedBox.height(context, 7.5),
                          TextStyles.w500_14_Black(
                              context, Strings.requirement),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            height: ResponsiveUtilsScreenSize.isMobile(context)
                                ? Get.height / 6
                                : Get.height / 9,
                            width: Get.width / 1,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AllColors.lightGrey,
                                // Specify the outline color here
                                width: 0.3,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(left: 10),
                                hintText: Strings.enterDescription,
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: AllColors.lighterGrey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      TextStyles.w600_universal(
                          fontSize: 15,
                          color: AllColors.vividPurple,
                          context,
                          Strings.customFields),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextStyles.w500_14_Black(context, Strings.pincode),

                          CreateNewLeadScreenCard2(
                            hintText: Strings.enterPincode,
                            controller: searchController,
                            onSearch: (text) {
                              _viewModel.searchPincode(text);
                            },
                            // isPincode: true,
                            // isLoading: _viewModel.isLoading,
                            // filteredPincodeList: _viewModel.filteredPincodeList,filteredPincodeList
                          ),

                          ////

                          //
                          // Obx(() => _viewModel.isLoading.value
                          //     ? Center(child: CircularProgressIndicator())
                          //   : ListView.builder(
                          //   shrinkWrap: true, // Allows the ListView to take only the space it needs
                          //   physics: NeverScrollableScrollPhysics(), // Prevents scrolling of the ListView
                          //   itemCount: _viewModel.filteredPincodeList.length,
                          //   itemBuilder: (context, index) {
                          //     return ListTile(
                          //       title: Text(_viewModel.filteredPincodeList[index].code ?? ""),
                          //       subtitle: Text(_viewModel.filteredPincodeList[index].district?.name ?? ""),
                          //     );
                          //   },
                          // )),
                          CommonSizedBox.height(context, 7.5),

                          TextStyles.w500_14_Black(
                              context, Strings.designation),
                          const CreateNewLeadScreenCard2(
                              hintText: Strings.select),
                          CommonSizedBox.height(context, 7.5),

                          TextStyles.w500_14_Black(context, Strings.website),
                          const CreateNewLeadScreenCard2(
                              hintText: Strings.website),
                          CommonSizedBox.height(context, 7.5),

                          TextStyles.w500_14_Black(context, Strings.gstNumber),
                          const CreateNewLeadScreenCard2(
                              hintText: Strings.enterGSTNumber),
                          CommonSizedBox.height(context, 7.5),

                          TextStyles.w500_14_Black(
                              context, Strings.customerDivision),

                          Obx(() {
                            if (customFieldsController.loading.value) {
                              return const CircularProgressIndicator();
                            } else if (customFieldsController
                                .errorMessage.isNotEmpty) {
                              return Text(
                                customFieldsController.errorMessage.value,
                                style: const TextStyle(color: Colors.red),
                              );
                            } else {
                              return CreateNewLeadScreenCard2(
                                hintText: Strings.select,
                                categories: customFieldsController
                                    .customDivisionList, // Using the industryList
                                onCategoryChanged: (selectedIndustry) {
                                  print("Selected Industry: $selectedIndustry");
                                },
                              );
                              // CreateNewLeadScreenCard(
                              //   hintText: 'Select a Product Category',
                              //   categories:customFieldsController.createNewLeadCustomFields.map((category) => category.description) // Mapping 'description' from productCategory
                              //       .toList(),
                              //   onCategoryChanged: (selectedDescription) {
                              //     // Find the selected category by matching the description
                              //     final selectedCategory = productCategoryController.leadProductCategories.firstWhere(
                              //           (category) => category.description == selectedDescription,
                              //     );
                              //     print("Selected Category Description: ${selectedCategory.description}");
                              //   },
                              // );
                            }
                          }),

                          CommonSizedBox.height(context, 7.5),


                          TextStyles.w500_14_Black(
                              context, Strings.industryType),

                          Obx(() {
                            if (customFieldsController.loading.value) {
                              return const CircularProgressIndicator();
                            } else if (customFieldsController
                                .errorMessage.isNotEmpty) {
                              return Text(
                                customFieldsController.errorMessage.value,
                                style: const TextStyle(color: Colors.red),
                              );
                            } else {
                              return CreateNewLeadScreenCard2(
                                hintText: Strings.select,
                                categories:
                                    customFieldsController.industryTypeList,
                                // Using the industryList
                                onCategoryChanged: (selectedIndustry) {
                                  print("Selected Industry: $selectedIndustry");
                                },
                              );
                              // CreateNewLeadScreenCard(
                              //   hintText: 'Select a Product Category',
                              //   categories:customFieldsController.createNewLeadCustomFields.map((category) => category.description) // Mapping 'description' from productCategory
                              //       .toList(),
                              //   onCategoryChanged: (selectedDescription) {
                              //     // Find the selected category by matching the description
                              //     final selectedCategory = productCategoryController.leadProductCategories.firstWhere(
                              //           (category) => category.description == selectedDescription,
                              //     );
                              //     print("Selected Category Description: ${selectedCategory.description}");
                              //   },
                              // );
                            }
                          }),

                          CommonSizedBox.height(context, 7.5),

                          TextStyles.w500_14_Black(
                              context, Strings.leadCategory),
                          Obx(() {
                            if (customFieldsController.loading.value) {
                              return const CircularProgressIndicator();
                            } else if (customFieldsController
                                .errorMessage.isNotEmpty) {
                              return Text(
                                customFieldsController.errorMessage.value,
                                style: const TextStyle(color: Colors.red),
                              );
                            } else {
                              return CreateNewLeadScreenCard2(
                                hintText: Strings.select,
                                categories: customFieldsController.leadCategory,
                                // Using the industryList
                                onCategoryChanged: (selectedIndustry) {
                                  print("Selected Industry: $selectedIndustry");
                                },
                              );

                              // CreateNewLeadScreenCard(
                              //   hintText: 'Select a Product Category',
                              //   categories:customFieldsController.createNewLeadCustomFields.map((category) => category.description) // Mapping 'description' from productCategory
                              //       .toList(),
                              //   onCategoryChanged: (selectedDescription) {
                              //     // Find the selected category by matching the description
                              //     final selectedCategory = productCategoryController.leadProductCategories.firstWhere(
                              //           (category) => category.description == selectedDescription,
                              //     );
                              //     print("Selected Category Description: ${selectedCategory.description}");
                              //   },
                              // );
                            }
                          }),

                          CommonSizedBox.height(context, 7.5),


                          TextStyles.w500_14_Black(context, Strings.status),

                          const CreateNewLeadScreenCard2(
                            hintText: Strings.select,
                            categories: [],
                          ),
                          CommonSizedBox.height(context, 7.5),

                          TextStyles.w500_14_Black(context, Strings.industry),

                          //

                          Obx(() {
                            if (customFieldsController.loading.value) {
                              return const CircularProgressIndicator();
                            } else if (customFieldsController
                                .errorMessage.isNotEmpty) {
                              return Text(
                                customFieldsController.errorMessage.value,
                                style: const TextStyle(color: Colors.red),
                              );
                            } else if (customFieldsController
                                .industryList.isEmpty) {
                              return const Text(
                                'No industry options available',
                                style: TextStyle(color: Colors.red),
                              );
                            } else {
                              return CreateNewLeadScreenCard2(
                                hintText: 'Select an Industry',
                                categories: customFieldsController.industryList,
                                onCategoryChanged: (selectedIndustry) {
                                  print("Selected Industry: $selectedIndustry");
                                },
                              );
                            }
                          }),

                          CommonSizedBox.height(context, 7.5),

                          ElevatedButton(
                            onPressed: () => controller.createNewLead(context),
                            child: const Text('Create Lead'),
                          ),
                          Obx(() => controller.isLoading.value
                              ? const CircularProgressIndicator()
                              : const SizedBox()),
                          Obx(() => Text(controller.errorMessage.value,
                              style: const TextStyle(color: Colors.red))),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: Get.height / 24,
                                width: Get.width / 4,
                                decoration: BoxDecoration(
                                  color: AllColors.mediumPurple,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: TextStyles.w500_universal(
                                      fontSize: 15,
                                      color: AllColors.whiteColor,
                                      context,
                                      Strings.create),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                height: Get.height / 24,
                                width: Get.width / 4,
                                decoration: BoxDecoration(
                                  color: AllColors.lighterGrey,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: TextStyles.w500_universal(
                                      fontSize: 15,
                                      color: AllColors.whiteColor,
                                      context,
                                      Strings.reset),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
