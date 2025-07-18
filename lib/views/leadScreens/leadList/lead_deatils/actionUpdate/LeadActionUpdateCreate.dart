import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/viewModels/leadScreens/lead_list/lead_detail_view/actions/lead/LeadActionCreateViewModel.dart';
import 'package:websuites/viewModels/leadScreens/lead_list/lead_detail_view/actions/leadAssignedToSales/LeadAssignedToSalesViewModel.dart';
import '../../../../../data/models/responseModels/leads/list/details/LeadDetails.dart';
import '../../../../../data/models/responseModels/leads/trashLeads/leadTypes/lead_types_response_model.dart';
import '../../../../../viewModels/leadScreens/createNewLead/product_category/product_category_controller.dart';
import '../../../../../viewModels/leadScreens/lead_list/lead_detail_view/actions/leadType/LeadDetailLeadTypeCreateViewModel.dart';
import '../../../../../viewModels/leadScreens/lead_list/lead_type/lead_type.dart';
import '../../../createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class LeadActionUpdateCreate extends StatefulWidget {
  final String? leadId;
  final LeadDetailsResponseModel leadDetails; // Keep this non-nullable

  const LeadActionUpdateCreate({
    super.key,
    this.leadId,
    required this.leadDetails, // Mark this as required
  });

  @override
  State<LeadActionUpdateCreate> createState() => _LeadActionUpdateCreateState();
}

class _LeadActionUpdateCreateState extends State<LeadActionUpdateCreate> {
  final LeadActionCreateViewModel viewModel = Get.put(LeadActionCreateViewModel());
  final LeadAssignedToSalesViewModel assignViewModel = Get.put(LeadAssignedToSalesViewModel());
  final ListLeadTypeViewModel leadTypeViewModel = Get.put(ListLeadTypeViewModel());
  final LeadDetailLeadTypeCreateViewModel leadTypeUpdateViewModel = Get.put(LeadDetailLeadTypeCreateViewModel());
  final ProductCategoryController services = Get.put(ProductCategoryController());
  final TextEditingController _searchController = TextEditingController();

  // Checkbox state
  bool isDocumentsComplete = false;
  bool isConvinced = false;

  @override
  void initState() {
    super.initState();
    viewModel.leadDetailActionLead(context);
    leadTypeViewModel.leadListLeadType(context);
    services.createLeadProductCategory(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Function to get current location
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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (viewModel.leadResponseList.isEmpty && !viewModel.loading.value) {
        return const Center(child: Text('No data available'));
      }

      final categories = viewModel.filteredLeadResponseList
          .map((lead) => '${lead.firstName} ${lead.lastName}'.trim())
          .toList();

      final leadTypeCategories = leadTypeViewModel.leadTypeItems.map((item) => item.label).toList();

      final servicesType = services.leadProductCategories
          .where((item) => item.name != null && item.name!.isNotEmpty)
          .map((item) => item.name!)
          .toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          Row(
            children: [
              const Text(
                'REPORTING TO :-',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: FontFamily.sfPro,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'No reporting person found.',
                  style: TextStyle(
                    color: AllColors.grey,
                    fontFamily: FontFamily.sfPro,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            'Lead Assigned To(Sales)',
            style: TextStyle(
              fontSize: 14,
              fontFamily: FontFamily.sfPro,
              fontWeight: FontWeight.w600,
              color: AllColors.grey,
            ),
          ),


          CommonTextField(
            hintText: "Search leads...",
            categories: categories, // List<String> containing available categories
      value: widget.leadDetails.leadAssigned.isNotEmpty &&
      widget.leadDetails.leadAssigned.first.user != null
      ? '${widget.leadDetails.leadAssigned.first.user!.firstName ?? ''} ${widget.leadDetails.leadAssigned.first.user!.lastName ?? ''}'.trim()
          : '',
            controller: _searchController,
            allowCustomInput: true,
            onChanged: (query) {
              viewModel.filterLeads(query);
            },
            onCategoryChanged: (selectedItem) {
              final selectedLead = viewModel.leadResponseList.firstWhere(
                    (lead) => '${lead.firstName} ${lead.lastName}'.trim() == selectedItem,
                orElse: () => throw Exception('No lead found for selection'),
              );

              final selectedLeadId = selectedLead.id;

              if (selectedLeadId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Lead ID is missing'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return Dialog(
                    insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Container(
                      width: 400,
                      constraints: BoxConstraints(
                        maxWidth: 600,
                        minWidth: 300,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: const LinearGradient(
                          colors: [Colors.white, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AllColors.myGreen,
                                  radius: 19,
                                  child: Icon(
                                    Icons.person,
                                    color: AllColors.whiteColor,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    'Lead Selected',
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Name: $selectedItem',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Email: ${selectedLead.email ?? 'N/A'}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.grey.shade600,
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Obx(() => ElevatedButton(
                                  onPressed: assignViewModel.loading.value
                                      ? null
                                      : () async {
                                    String targetLeadId = widget.leadId ?? selectedLeadId;
                                    await assignViewModel.assignLeadToSales(
                                      context,
                                      selectedLeadId,
                                      targetLeadId,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.darkGreen,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 0,
                                    ),
                                  ),
                                  child: assignViewModel.loading.value
                                      ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                      : const Text(
                                    'Confirm',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 15),
          Text(
            'Lead Type',
            style: TextStyle(
              fontSize: 14,
              fontFamily: FontFamily.sfPro,
              fontWeight: FontWeight.w600,
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
              // Find the selected lead type from leadTypesRes based on name
              final selectedLead = leadTypeViewModel.leadTypesRes.firstWhere(
                    (lead) => lead.name?.trim() == selectedLeadType,
                orElse: () {
                  print('No lead found for selection: $selectedLeadType');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Selected lead type not found'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return LeadTypesResponseModel(name: selectedLeadType);
                },
              );

              // Local state for checkboxes
              int? selectedIndex;

              // Create a list of reasons from children only
              final reasons = <Map<String, dynamic>>[];
              if (selectedLead.children?.isNotEmpty == true) {
                reasons.addAll(
                  selectedLead.children!
                      .asMap()
                      .entries
                      .where((entry) => entry.value.name?.trim().isNotEmpty == true)
                      .map((entry) => ({
                    'index': entry.key,
                    'name': entry.value.name!.trim(),
                    'id': entry.value.id, // Include child ID
                  })),
                );
              }

              // Debug the reasons list
              print('Reasons list: $reasons');
              print('Number of reasons: ${reasons.length}');

              // Initialize selectedIndex based on current state
              if (selectedLead.name == 'Hot') {
                if (isDocumentsComplete && reasons.any((r) => r['name'] == 'Documents Complete')) {
                  selectedIndex = reasons.indexWhere((r) => r['name'] == 'Documents Complete');
                } else if (isConvinced && reasons.any((r) => r['name'] == 'Convinced')) {
                  selectedIndex = reasons.indexWhere((r) => r['name'] == 'Convinced');
                }
              }

              // Controller for custom reason input
              final customReasonController = TextEditingController();
              print('Custom reason on dialog open: ${customReasonController.text}');

              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter dialogSetState) {
                      return Dialog(
                        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        child: Container(
                          width: 400,
                          constraints: const BoxConstraints(
                            maxWidth: 600,
                            minWidth: 300,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: const LinearGradient(
                              colors: [Colors.white, Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10.0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Want to change lead type to $selectedLeadType?',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(Icons.close, color: AllColors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Flexible(
                                  child: Text(
                                    "Please select a reason or write a custom one!",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AllColors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                CommonTextField(
                                  hintText: 'Enter custom reason',
                                  maxLines: 3,
                                  allowCustomBorderInput: BorderRadius.circular(15),
                                  controller: customReasonController,
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: reasons.length * 40.0,
                                  child: ListView.builder(
                                    itemCount: reasons.length,
                                    itemBuilder: (context, index) {
                                      final reason = reasons[index];
                                      final isChecked = selectedIndex == index;
                                      final reasonName = reason['name'] as String;
                                      if (reasonName.isEmpty) return const SizedBox.shrink();
                                      return Row(
                                        children: [
                                          Checkbox(
                                            value: isChecked,
                                            onChanged: (value) {
                                              dialogSetState(() {
                                                if (value == true) {
                                                  selectedIndex = index;
                                                } else {
                                                  selectedIndex = null;
                                                }
                                              });
                                            },
                                            shape: const CircleBorder(),
                                            fillColor: WidgetStateProperty.resolveWith((states) {
                                              if (states.contains(WidgetState.selected)) {
                                                return AllColors.mediumPurple;
                                              }
                                              return null;
                                            }),
                                          ),
                                          Text(
                                            reasonName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Obx(() => ElevatedButton(
                                      onPressed: leadTypeViewModel.loading.value
                                          ? null
                                          : () async {
                                        // Reset state
                                        setState(() {
                                          isDocumentsComplete = false;
                                          isConvinced = false;
                                        });

                                        // Construct remark
                                        List<String> remarkParts = [selectedLeadType];
                                        String? subLeadTypeId;
                                        if (selectedIndex != null) {
                                          final selectedReason = reasons[selectedIndex!];
                                          final selectedReasonName = selectedReason['name'] as String;
                                          subLeadTypeId = selectedReason['id'] as String?;
                                          remarkParts.add(selectedReasonName);
                                          // Update state based on selected reason
                                          setState(() {
                                            if (selectedReasonName == 'Documents Complete') {
                                              isDocumentsComplete = true;
                                            } else if (selectedReasonName == 'Convinced') {
                                              isConvinced = true;
                                            }
                                          });
                                        }
                                        if (customReasonController.text.isNotEmpty) {
                                          remarkParts.add(customReasonController.text.trim());
                                        }
                                        final remark = remarkParts.join(', ');

                                        // Get current location
                                        final position = await _getCurrentLocation();
                                        int lat = 0;
                                        int lng = 0;
                                        if (position != null) {
                                          lat = position.latitude.toInt();
                                          lng = position.longitude.toInt();
                                        }

                                        // Construct request data
                                        final requestData = {
                                          'activity': 'lead_type',
                                          'lead_type': selectedLead.id,
                                          'sub_lead_type': subLeadTypeId ?? '',
                                          'remark': remark,
                                          'lat': lat,
                                          'lng': lng,
                                        };

                                        // Call API to update lead type
                                        if (widget.leadId != null) {
                                          await leadTypeUpdateViewModel.leadTypeToSalesUpdate(
                                            context,
                                            widget.leadId!,
                                            requestData,
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Lead ID is missing'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }

                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AllColors.darkGreen,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 0,
                                        ),
                                      ),
                                      child: leadTypeViewModel.loading.value
                                          ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                          : const Text(
                                        'Change',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 15),
          Text(
            'Product Categories',
            style: TextStyle(
              fontSize: 14,
              fontFamily: FontFamily.sfPro,
              fontWeight: FontWeight.w600,
              color: AllColors.grey,
            ),
          ),

          servicesType.isEmpty
              ? const Center(child: Text('No product categories available'))
              :
          CommonTextField(
            value: widget.leadDetails.productCategories.isNotEmpty
                ? (widget.leadDetails.productCategories.first.name ?? '')
                : '',
            allowCustomInput: true,
            onChanged: (query) {
              services.filterProductsCategory(query);
            },
            hintText: 'Select Product Category',
            categories: servicesType,
            isMultiSelect: true,
            onCategoryChanged: (selectedCategory) {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return Dialog(
                    insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Container(
                      width: 400,
                      constraints: BoxConstraints(
                        maxWidth: 600,
                        minWidth: 300,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: const LinearGradient(
                          colors: [Colors.white, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AllColors.myGreen,
                                  radius: 19,
                                  child: Icon(
                                    Icons.person,
                                    color: AllColors.whiteColor,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    'Service Selected',
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Name: $selectedCategory',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.grey.shade600,
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Obx(() => ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.darkGreen,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 0,
                                    ),
                                  ),
                                  child: assignViewModel.loading.value
                                      ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                      : const Text(
                                    'Confirm',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      );
    });
  }
}