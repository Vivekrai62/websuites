import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../../../../../data/models/requestModels/globalSetting/update/GlobalSettingCheckReqModel.dart';
import '../../../../../data/models/responseModels/callDetails/CallDetailsResModel.dart';
import '../../../../../data/models/responseModels/leads/createNewLead/product_category/product_category.dart';
import '../../../../../data/models/responseModels/leads/list/details/LeadDetails.dart';
import '../../../../../data/models/responseModels/leads/trashLeads/leadTypes/lead_types_response_model.dart';
import '../../../../../resources/strings/strings.dart';
import '../../../../../utils/appColors/app_colors.dart';
import '../../../../../utils/checkbox/LabeledCheckbox.dart';
import '../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../../utils/reusable_validation/RequiredLabel.dart';
import '../../../../../viewModels/callDetails/CallDetailsViewModel.dart';
import '../../../../../viewModels/globalSetting/GlobalSettingViewModel.dart';
import '../../../../../viewModels/globalSetting/update/GlobalSettingUpdateViewModel.dart';
import '../../../../../viewModels/leadScreens/createNewLead/product_category/product_category_controller.dart';
import '../../../../../viewModels/leadScreens/lead_list/lead_detail_view/actions/lead/LeadActionCreateViewModel.dart';
import '../../../../../viewModels/leadScreens/lead_list/lead_detail_view/actions/leadType/LeadDetailLeadTypeCreateViewModel.dart';
import '../../../../../viewModels/leadScreens/lead_list/lead_detail_view/leadProductsViewModel/LeadProductsViewModel.dart';
import '../../../../../viewModels/leadScreens/lead_list/lead_type/lead_type.dart';
import '../../../leadDetails/addProjection/LeadDetailsAddProjectionScreen.dart';
import '../lead_details_activities_all/LeadDetailsActivitiesAllViewModel.dart';
import '../../../../../data/models/responseModels/leads/list/lead_list.dart';

class LeadDetailsAddCallScreen extends StatefulWidget {
  final String? leadId;
  final LeadDetailsResponseModel leadDetails;
  final bool useContainerStyling;
  final Item? orderItem;

  const LeadDetailsAddCallScreen({
    super.key,
    this.leadId,
    this.orderItem,
    required this.leadDetails,
    this.useContainerStyling = true,
  });

  @override
  State<LeadDetailsAddCallScreen> createState() => _LeadDetailsAddCallScreenState();
}

class _LeadDetailsAddCallScreenState extends State<LeadDetailsAddCallScreen> {
  final LeadDetailsActivitiesAllViewModel viewModel = Get.put(LeadDetailsActivitiesAllViewModel());
  final CallDetailsViewModel callDetailsViewModel = Get.put(CallDetailsViewModel());
  final ProductCategoryController productCat = Get.put(ProductCategoryController());
  final LeadActionCreateViewModel leadActionViewModel = Get.put(LeadActionCreateViewModel());
  final GlobalSettingUpdateViewModel globalSettingUpdateViewModel = Get.put(GlobalSettingUpdateViewModel());
  final TextEditingController _callStatusController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _leadStatusController = TextEditingController();
  final TextEditingController _leadControllerReminder = TextEditingController();
  final TextEditingController _leadControllerNotified = TextEditingController();
  final TextEditingController _productCategoryController = TextEditingController();
  final TextEditingController _leadSubTypeController = TextEditingController();
  final ListLeadTypeViewModel leadTypeViewModel = Get.put(ListLeadTypeViewModel());
  final LeadDetailLeadTypeCreateViewModel leadTypeUpdateViewModel = Get.put(LeadDetailLeadTypeCreateViewModel());
  final controller = Get.put(LeadDetailsAddProjectionController());
  final leadProductsViewModel = Get.put(LeadProductsViewModel());
  final GlobalSettingViewModel globalSettingViewModel = Get.put(GlobalSettingViewModel());

  bool isDocumentsComplete = false;
  bool isConvinced = false;
  final Map<String, String?> _validationErrors = {
    'callStatus': null,
    'mobileNo': null,
    'leadStatus': null,
    'remark': null,
    'reminderTo': null,
    'notifiedOn': null,
    'productCategory': null,
    'leadSubType': null,
  };
  final RxBool smsChecked = false.obs;
  final RxBool mailChecked = false.obs;
  final RxBool whatsappChecked = false.obs;

  bool _notifyCustomer = false;
  bool _addProjection = false;
  final bool _isAdmin = true;
  final _formKey = GlobalKey<FormState>();

  String? _selectedLeadType;
  List<String> _subLeadTypeCategories = [];
  String? _selectedSubLeadTypeId;
  final RxList<String> _selectedProductCategories = <String>[].obs;

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are permanently denied.')),
      );
      return null;
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  String _formatLeadStatus(String? status) {
    if (status == null) return '';
    return status.replaceAll('_', ' ').toUpperCase();
  }

  @override
  void initState() {
    super.initState();
    if (widget.leadId != null) {
      viewModel.leadDetailsActivitiesAll(context, widget.leadId!);
    }
    leadTypeViewModel.leadListLeadType(context);
    globalSettingViewModel.fetchGlobalSettings(context);

    globalSettingViewModel.globalSetting.listen((settings) {
      if (settings != null) {
        smsChecked.value = settings.smsEnabled;
        mailChecked.value = settings.mailEnabled;
        whatsappChecked.value = settings.whatsappEnabled;
      }
    });
    callDetailsViewModel.callDetails(context);
    productCat.createLeadProductCategory(context);
    leadActionViewModel.leadDetailActionLead(context);
    leadTypeViewModel.leadListLeadType(context);
    if (widget.leadDetails.leadStatus != null) {
      _leadStatusController.text = _formatLeadStatus(widget.leadDetails.leadStatus);
    }
    if (widget.leadDetails.mobileWithCountrycode != null) {
      _mobileNoController.text = widget.leadDetails.mobileWithCountrycode!;
      globalSettingUpdateViewModel.selectedMobile.value = widget.leadDetails.mobileWithCountrycode!;
      globalSettingUpdateViewModel.selectedCountryCode.value = '91'; // Update based on actual country code
    }
    _selectedProductCategories.clear();
    globalSettingUpdateViewModel.fetchInitialData();
  }

  @override
  void dispose() {
    _callStatusController.dispose();
    _mobileNoController.dispose();
    _remarkController.dispose();
    _leadStatusController.dispose();
    _leadControllerReminder.dispose();
    _leadControllerNotified.dispose();
    _productCategoryController.dispose();
    _leadSubTypeController.dispose();
    super.dispose();
  }

  void _handleNotificationAction(String action) {
    if (!_isAdmin && action != 'Notify Customer') {
      Get.snackbar('Permission Denied', 'Only admins can perform this action.',
          backgroundColor: AllColors.vividRed, colorText: Colors.white);
      return;
    }
    switch (action) {
      case 'Notify Customer':
        print('Notifying customer...');
        break;
    }
  }

  bool _validateFields() {
    bool isValid = true;
    _validationErrors.updateAll((key, value) => null);

    if (_callStatusController.text.trim().isEmpty) {
      _validationErrors['callStatus'] = 'Call status is required';
      isValid = false;
    } else if (!CallDetailsResModel.validStatuses.contains(_callStatusController.text)) {
      _validationErrors['callStatus'] = 'Invalid call status';
      isValid = false;
    }

    if (_mobileNoController.text.trim().isEmpty) {
      _validationErrors['mobileNo'] = 'Mobile number is required';
      isValid = false;
    }

    if (_leadStatusController.text.trim().isEmpty) {
      _validationErrors['leadStatus'] = 'Lead status is required';
      isValid = false;
    } else if (![
      if (widget.leadDetails.leadStatus != null) _formatLeadStatus(widget.leadDetails.leadStatus),
    ].contains(_leadStatusController.text)) {
      _validationErrors['leadStatus'] = 'Invalid lead status';
      isValid = false;
    }

    if (_remarkController.text.trim().isEmpty) {
      _validationErrors['remark'] = 'Remark is required';
      isValid = false;
    }

    if (_notifyCustomer) {
      if (_leadControllerReminder.text.trim().isEmpty) {
        _validationErrors['reminderTo'] = 'Reminder is required';
        isValid = false;
      }
      if (_leadControllerNotified.text.trim().isEmpty) {
        _validationErrors['notifiedOn'] = 'Date is required';
        isValid = false;
      }
    }

    if (_selectedProductCategories.isEmpty && _productCategoryController.text.trim().isNotEmpty) {
      _validationErrors['productCategory'] = 'Please select at least one product category';
      isValid = false;
    } else if (_productCategoryController.text.trim().isNotEmpty &&
        !productCat.leadProductCategories.any((cat) => cat.name == _productCategoryController.text)) {
      _validationErrors['productCategory'] = 'Invalid product category';
      isValid = false;
    }

    print('Validation Errors: $_validationErrors');
    return isValid;
  }

  void _handleSave() async {
    if (_validateFields()) {
      final position = await _getCurrentLocation();
      globalSettingUpdateViewModel.selectedLat.value = position?.latitude ?? 0.0;
      globalSettingUpdateViewModel.selectedLng.value = position?.longitude ?? 0.0;

      globalSettingUpdateViewModel.selectedCallStatus.value = _callStatusController.text;
      globalSettingUpdateViewModel.selectedMobile.value = _mobileNoController.text;
      globalSettingUpdateViewModel.selectedLeadStatus.value = _leadStatusController.text;
      globalSettingUpdateViewModel.selectedRemark.value = _remarkController.text;
      globalSettingUpdateViewModel.selectedIsReminder.value = _notifyCustomer;
      globalSettingUpdateViewModel.selectedNotifyCustomer.value = _notifyCustomer;
      globalSettingUpdateViewModel.selectedIsSendSms.value = smsChecked.value;
      globalSettingUpdateViewModel.selectedIsSendEmail.value = mailChecked.value;
      globalSettingUpdateViewModel.selectedIsSendWhatsapp.value = whatsappChecked.value;
      globalSettingUpdateViewModel.selectedReminderTo.value = _leadControllerReminder.text;

      // Parse notified date
      if (_leadControllerNotified.text.isNotEmpty) {
        try {
          // Assuming date format is dd/mm/yy
          final parts = _leadControllerNotified.text.split('/');
          if (parts.length == 3) {
            final day = int.parse(parts[0]);
            final month = int.parse(parts[1]);
            final year = int.parse('20${parts[2]}'); // Assuming 20xx
            globalSettingUpdateViewModel.selectedReminderDate.value = DateTime(year, month, day);
          }
        } catch (e) {
          print('Error parsing notified date: $e');
        }
      }

      String? leadTypeId;
      if (_selectedLeadType != null) {
        final selectedLead = leadTypeViewModel.leadTypesRes.firstWhere(
              (lead) => lead.name?.trim() == _selectedLeadType,
          orElse: () => LeadTypesResponseModel(),
        );
        leadTypeId = selectedLead.id;
      }

      globalSettingUpdateViewModel.updateSelectedLeadType(leadTypeId ?? '');
      globalSettingUpdateViewModel.updateSelectedLeadSubType(_selectedSubLeadTypeId ?? '');
      globalSettingUpdateViewModel.selectedProductCategories.assignAll(_selectedProductCategories);

      if (_addProjection) {
        globalSettingUpdateViewModel.addProjectionProduct(
          ProjectionProduct(
            productCategory: _selectedProductCategories.isNotEmpty ? _selectedProductCategories.first : '',
            product: 'a5313fff-2e7d-4ceb-8ff6-b08dc519f47d',
            amount: 30000,
            projectionDate: DateTime.now(),
          ),
        );
      }

      await globalSettingUpdateViewModel.saveGlobalSetting(context, leadId: widget.leadId ?? '');
    } else {
      setState(() {});
      Get.snackbar(
        'Validation Error',
        'Please check the form for errors.',
        backgroundColor: AllColors.vividRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _printSelectedCategories() {
    print('Selected Product Categories: ${_selectedProductCategories.toList()}');
    for (var categoryId in _selectedProductCategories) {
      final category = productCat.leadProductCategories.firstWhere(
            (cat) => cat.id == categoryId,
        orElse: () => LeadProductCategoryList(id: categoryId, name: 'Unknown'),
      );
      print('Category ID: $categoryId, Name: ${category.name}');
    }
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

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productCat.createLeadProductCategory(context);
      leadProductsViewModel.fetchLeadProducts(context);
    });
    return Column(
      children: [
        Obx(() {
          final leadTypeCategories = leadTypeViewModel.leadTypeItems.map((item) => item.label).toList();
          if (viewModel.loading.value ||
              callDetailsViewModel.loading.value ||
              productCat.isLoading.value ||
              globalSettingViewModel.loading.value ||
              leadActionViewModel.loading.value ||
              globalSettingUpdateViewModel.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final settings = globalSettingViewModel.globalSetting.value;
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add Call",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: FontFamily.sfPro,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RequiredLabel(
                    label: 'Call Status',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 13,
                      color: AllColors.grey,
                    ),
                  ),
                  CommonTextField(
                    categories: CallDetailsResModel.validStatuses,
                    hintText: 'Select call status',
                    controller: _callStatusController,
                    onCategoryChanged: (selectedCategory) {
                      print('Selected Call Status: $selectedCategory');
                      _callStatusController.text = selectedCategory;
                      globalSettingUpdateViewModel.selectedCallStatus.value = selectedCategory;
                    },
                  ),
                  _buildErrorText(_validationErrors['callStatus']),
                  RequiredLabel(
                    label: 'Select Mobile No.',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 13,
                      color: AllColors.grey,
                    ),
                  ),
                  CommonTextField(
                    hintText: 'Enter mobile number',
                    controller: _mobileNoController,
                    keyboardType: TextInputType.phone,
                    value: widget.leadDetails.mobileWithCountrycode?.isNotEmpty ?? false
                        ? (widget.leadDetails.mobileWithCountrycode ?? '')
                        : '',
                    onChanged: (value) {
                      globalSettingUpdateViewModel.selectedMobile.value = value;
                    },
                  ),
                  _buildErrorText(_validationErrors['mobileNo']),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _notifyCustomer,
                        onChanged: (value) {
                          setState(() {
                            _notifyCustomer = value ?? false;
                            globalSettingUpdateViewModel.selectedNotifyCustomer.value = _notifyCustomer;
                            globalSettingUpdateViewModel.selectedIsReminder.value = _notifyCustomer;
                          });
                          if (_notifyCustomer) {
                            _handleNotificationAction('Notify Customer');
                          }
                        },
                        activeColor: AllColors.mediumPurple,
                      ),
                      const Text('Is Reminder'),
                    ],
                  ),
                  if (_notifyCustomer)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RequiredLabel(
                          label: 'Reminder To',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: FontFamily.sfPro,
                            fontSize: 13,
                            color: AllColors.grey,
                          ),
                        ),
                        CommonTextField(
                          hintText: 'Select',
                          controller: _leadControllerReminder,
                          categories: leadActionViewModel.filteredLeadResponseList.isNotEmpty
                              ? leadActionViewModel.filteredLeadResponseList
                              .map((lead) => '${lead.firstName} ${lead.lastName}'.trim())
                              .toList()
                              : ['No users available'],
                          onCategoryChanged: (selectedCategory) {
                            print('Selected Reminder To: $selectedCategory');
                            _leadControllerReminder.text = selectedCategory;
                            globalSettingUpdateViewModel.updateSelectedReminderTo(selectedCategory);
                          },
                        ),
                        _buildErrorText(_validationErrors['reminderTo']),
                        RequiredLabel(
                          label: 'Notified On',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: FontFamily.sfPro,
                            fontSize: 13,
                            color: AllColors.grey,
                          ),
                        ),
                        CommonTextField(
                          hintText: 'dd/mm/yy',
                          isDateField: true,
                          controller: _leadControllerNotified,
                          prefixIcon: Icon(Icons.date_range_rounded, color: AllColors.grey, size: 19),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              try {
                                final parts = value.split('/');
                                if (parts.length == 3) {
                                  final day = int.parse(parts[0]);
                                  final month = int.parse(parts[1]);
                                  final year = int.parse('20${parts[2]}');
                                  globalSettingUpdateViewModel.selectedReminderDate.value =
                                      DateTime(year, month, day);
                                }
                              } catch (e) {
                                print('Error parsing notified date: $e');
                              }
                            }
                          },
                        ),
                        _buildErrorText(_validationErrors['notifiedOn']),
                      ],
                    ),
                  RequiredLabel(
                    label: 'Lead Status',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 13,
                      color: AllColors.grey,
                    ),
                  ),
                  CommonTextField(
                    categories: [
                      if (widget.leadDetails.leadStatus != null) _formatLeadStatus(widget.leadDetails.leadStatus),
                    ],
                    hintText: 'Select lead status',
                    value: _formatLeadStatus(widget.leadDetails.leadStatus),
                    controller: _leadStatusController,
                    onCategoryChanged: (selectedCategory) {
                      print('Selected Lead Status: $selectedCategory');
                      _leadStatusController.text = selectedCategory;
                      globalSettingUpdateViewModel.selectedLeadStatus.value = selectedCategory;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lead status is required';
                      }
                      return null;
                    },
                  ),
                  _buildErrorText(_validationErrors['leadStatus']),
                  const SizedBox(height: 8),
                  RequiredLabel(
                    label: 'Select Product Categories',
                    isRequired: false,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 13,
                      color: AllColors.grey,
                    ),
                  ),
                  Obx(() => CommonTextField(
                    hintText: 'Select product categories',
                    categories: productCat.leadProductCategories.map((cat) => cat.name ?? '').toList(),
                    controller: _productCategoryController,
                    onCategoryChanged: (selectedCategory) {
                      print('Selected Product Category: $selectedCategory');
                      final selectedCat = productCat.leadProductCategories.firstWhere(
                            (cat) => cat.name == selectedCategory,
                        orElse: () => LeadProductCategoryList(id: '', name: ''),
                      );
                      if (selectedCat.id != null && selectedCat.id!.isNotEmpty) {
                        if (!_selectedProductCategories.contains(selectedCat.id)) {
                          _selectedProductCategories.add(selectedCat.id!);
                          globalSettingUpdateViewModel.updateSelectedProductCategory(selectedCat.id!);
                          productCat.updateSelectedCategories(_selectedProductCategories.toList());
                        }
                      }
                      _productCategoryController.text = selectedCategory;
                    },
                  )),
                  _buildErrorText(_validationErrors['productCategory']),
                  const SizedBox(height: 8),
                  RequiredLabel(
                    label: 'Lead Type',
                    isRequired: false,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 13,
                      color: AllColors.grey,
                    ),
                  ),
                  CommonTextField(
                    allowCustomInput: true,
                    onChanged: (query) {
                      leadTypeViewModel.filterLeadsType(query);
                    },
                    value: widget.leadDetails.type?.name?.isNotEmpty ?? false
                        ? (widget.leadDetails.type?.name ?? '')
                        : '',
                    hintText: 'Select lead type',
                    categories: leadTypeCategories,
                    onCategoryChanged: (selectedLeadType) async {
                      print('Selected Lead Type: $selectedLeadType');
                      setState(() {
                        _selectedLeadType = selectedLeadType;
                        isDocumentsComplete = false;
                        isConvinced = false;
                        _leadSubTypeController.clear();
                        _selectedSubLeadTypeId = null;
                      });

                      final selectedLead = leadTypeViewModel.leadTypesRes.firstWhere(
                            (lead) => lead.name?.trim() == selectedLeadType,
                        orElse: () => LeadTypesResponseModel(name: selectedLeadType, id: ''),
                      );

                      final reasons = <String>[];
                      final reasonIds = <String, String>{};
                      if (selectedLead.children?.isNotEmpty == true) {
                        for (var child in selectedLead.children!) {
                          if (child.name?.trim().isNotEmpty == true) {
                            reasons.add(child.name!.trim());
                            if (child.id != null) {
                              reasonIds[child.name!.trim()] = child.id!;
                            }
                          }
                        }
                      }

                      setState(() {
                        _subLeadTypeCategories = reasons;
                      });

                      print('Sub-lead type categories updated: $_subLeadTypeCategories');
                      globalSettingUpdateViewModel.updateSelectedLeadType(selectedLead.id ?? '');
                    },
                  ),
                  const SizedBox(height: 8),
                  RequiredLabel(
                    label: 'Lead Sub Type',
                    isRequired: false,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 13,
                      color: AllColors.grey,
                    ),
                  ),
                  CommonTextField(
                    hintText: 'Select lead sub type',
                    categories: _subLeadTypeCategories,
                    controller: _leadSubTypeController,
                    onCategoryChanged: (selectedSubLeadType) {
                      print('Selected Lead Sub Type: $selectedSubLeadType');
                      setState(() {
                        _leadSubTypeController.text = selectedSubLeadType;
                        if (_selectedLeadType != null) {
                          final selectedLead = leadTypeViewModel.leadTypesRes.firstWhere(
                                (lead) => lead.name?.trim() == _selectedLeadType,
                            orElse: () => LeadTypesResponseModel(name: _selectedLeadType, id: ''),
                          );
                          if (selectedLead.children?.isNotEmpty == true) {
                            final selectedChild = selectedLead.children!.firstWhere(
                                  (child) => child.name?.trim() == selectedSubLeadType,
                              orElse: () => Children(name: selectedSubLeadType, id: ''),
                            );
                            _selectedSubLeadTypeId = selectedChild.id;
                            globalSettingUpdateViewModel.updateSelectedLeadSubType(selectedChild.id ?? '');
                          }
                        }

                        if (selectedSubLeadType == 'Documents Complete') {
                          isDocumentsComplete = true;
                          isConvinced = false;
                        } else if (selectedSubLeadType == 'Convinced') {
                          isConvinced = true;
                          isDocumentsComplete = false;
                        } else {
                          isDocumentsComplete = false;
                          isConvinced = false;
                        }
                      });
                    },
                  ),
                  _buildErrorText(_validationErrors['leadSubType']),
                  const SizedBox(height: 8),
                  RequiredLabel(
                    label: 'Remarks',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 13,
                      color: AllColors.grey,
                    ),
                  ),
                  CommonTextField(
                    hintText: 'Enter remarks',
                    controller: _remarkController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      globalSettingUpdateViewModel.selectedRemark.value = value;
                    },
                  ),
                  _buildErrorText(_validationErrors['remark']),
                  const SizedBox(height: 8),
                  RequiredLabel(
                    label: 'Notify Users',
                    isRequired: false,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 13,
                      color: AllColors.grey,
                    ),
                  ),
                  CommonTextField(
                    hintText: 'Select users to notify',
                    categories: leadActionViewModel.filteredLeadResponseList
                        .map((lead) => '${lead.firstName} ${lead.lastName}'.trim())
                        .toList(),
                    onCategoryChanged: (selectedCategory) {
                      print('Selected Notify User: $selectedCategory');
                      globalSettingUpdateViewModel.updateSelectedReminderTo(selectedCategory);
                    },
                  ),
                  // Inside the build method of _LeadDetailsAddCallScreenState, within the Obx widget

                  Obx(() {
                    final settings = globalSettingViewModel.globalSetting.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabeledCheckbox(
                          label: 'Notify Customer',
                          value: _notifyCustomer,
                          onChanged: (value) {
                            setState(() {
                              _notifyCustomer = value ?? false;
                              globalSettingUpdateViewModel.selectedNotifyCustomer.value = _notifyCustomer;
                              globalSettingUpdateViewModel.selectedIsReminder.value = _notifyCustomer;
                            });
                            if (_notifyCustomer) {
                              _handleNotificationAction('Notify Customer');
                            }
                          },
                          activeColor: AllColors.mediumPurple,
                          labelStyle: TextStyle(
                            fontFamily: FontFamily.sfPro,
                            color: AllColors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            LabeledCheckbox(
                              label: 'Send SMS',
                              value: smsChecked.value,
                              onChanged: settings?.smsEnabled == true
                                  ? (value) {
                                smsChecked.value = value ?? false;
                                globalSettingUpdateViewModel.selectedIsSendSms.value = value ?? false;
                              }
                                  : (value) {}, // Empty callback when disabled
                              activeColor: AllColors.mediumPurple,
                              labelStyle: TextStyle(
                                fontFamily: FontFamily.sfPro,
                                color: AllColors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            LabeledCheckbox(
                              label: 'Send Mail',
                              value: mailChecked.value,
                              onChanged: settings?.mailEnabled == true
                                  ? (value) {
                                mailChecked.value = value ?? false;
                                globalSettingUpdateViewModel.selectedIsSendEmail.value = value ?? false;
                              }
                                  : (value) {}, // Empty callback when disabled
                              activeColor: AllColors.mediumPurple,
                              labelStyle: TextStyle(
                                fontFamily: FontFamily.sfPro,
                                color: AllColors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            LabeledCheckbox(
                              label: 'Send WhatsApp',
                              value: whatsappChecked.value,
                              onChanged: settings?.whatsappEnabled == true
                                  ? (value) {
                                whatsappChecked.value = value ?? false;
                                globalSettingUpdateViewModel.selectedIsSendWhatsapp.value = value ?? false;
                              }
                                  : (value) {}, // Empty callback when disabled
                              activeColor: AllColors.mediumPurple,
                              labelStyle: TextStyle(
                                fontFamily: FontFamily.sfPro,
                                color: AllColors.grey,
                              ),
                            ),
                          ],
                        ),
                        LabeledCheckbox(
                          label: 'Add Projection',
                          value: _addProjection,
                          onChanged: (value) {
                            setState(() {
                              _addProjection = value ?? false;
                            });
                          },
                          activeColor: AllColors.mediumPurple,
                          labelStyle: TextStyle(
                            fontFamily: FontFamily.sfPro,
                            color: AllColors.grey,
                          ),
                        ),
                        if (_addProjection)
                          SingleChildScrollView(
                            child: Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Add UI for projection products if needed
                              ],
                            )),
                          ),
                      ],
                    );
                  }),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: _printSelectedCategories,
                        icon: const Icon(Icons.print, color: Colors.white),
                        label: const Text(
                          "Print Categories",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: AllColors.darkBlue,
                          minimumSize: const Size(40, 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: _handleSave,
                        icon: const Icon(Icons.save, color: Colors.white),
                        label: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: AllColors.mediumPurple,
                          minimumSize: const Size(40, 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}