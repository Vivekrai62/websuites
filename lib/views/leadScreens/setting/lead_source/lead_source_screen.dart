import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/data/models/requestModels/lead/setting/source/create/lead_source_create_req_model.dart';
import 'package:websuites/data/models/responseModels/leads/setting/lead_source/create/lead_source_create_res_model.dart';
import 'package:websuites/utils/button/CustomButton.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/viewModels/leadScreens/setting/lead_source/lead_source_view_model.dart';
import 'package:websuites/viewModels/leadScreens/setting/lead_source/status/lead_source_status_list_view_model.dart';
import 'package:websuites/viewModels/leadScreens/setting/lead_source/create/lead_source_create/lead_source_create_view_model.dart';

import '../../../../data/models/requestModels/lead/setting/source/update/lead_source_update_req_model.dart';
import '../../../../data/models/responseModels/leads/setting/lead_source/lead_source_list_res_model.dart';
import '../../../../viewModels/leadScreens/setting/lead_source/update/lead_source_update_view_model.dart';
import '../../createNewLead/widgets/createNewLeadCard/common_text_field.dart';

// Placeholder for LeadSource model (adjust based on your actual model)
class LeadSource {
  final String? id;
  final String? name;
  final String? status;
  final DateTime? createdAt;

  LeadSource({this.id, this.name, this.status, this.createdAt});
}

class LeadSourceScreen extends StatefulWidget {
  const LeadSourceScreen({super.key});

  static void showCreateSourceDialog(
      BuildContext context, LeadSourceListViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          LeadSettingSourceScreenBottomSheet(viewModel: viewModel),
    );
  }

  @override
  State<LeadSourceScreen> createState() => _LeadSourceScreenState();
}

class _LeadSourceScreenState extends State<LeadSourceScreen> {
  final LeadSourceListViewModel leadSourceList =
      Get.put(LeadSourceListViewModel());
  final LeadSourceStatusListViewModel leadSourceStatusList =
      Get.put(LeadSourceStatusListViewModel());

  @override
  void initState() {
    super.initState();
    leadSourceList.fetchLeadSourceList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (leadSourceList.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (leadSourceList.sourceList.isEmpty) {
        return const Center(
          child: Text(
            'No lead sources available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        itemCount: leadSourceList.sourceList.length,
        itemBuilder: (context, index) {
          final source = leadSourceList.sourceList[index];
          return ContainerUtils(
            margin: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      source.name ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: (source.status ?? '').toLowerCase() == 'inactive'
                            ? AllColors.lightRed
                            : AllColors.background_green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          source.status ?? 'Unknown',
                          style: TextStyle(
                            color: (source.status ?? '').toLowerCase() ==
                                    'inactive'
                                ? AllColors.darkRed
                                : AllColors.text__green,
                            fontFamily: FontFamily.sfPro,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                      ImageStrings.date,
                      height: 14,
                      width: 14,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      source.createdAt != null
                          ? DateFormat('dd MMM yyyy, HH:mm')
                              .format(source.createdAt!)
                          : 'Unknown',
                      style: TextStyle(
                        fontFamily: FontFamily.sfPro,
                        color: AllColors.mediumPurple,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        _showEditDialog(context,
                            source); // Pass the specific 'source' instead of LeadSource()
                      },
                      child: Image.asset(
                        ImageStrings.edit,
                        height: 17,
                        width: 17,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }

  void _showEditDialog(BuildContext context, LeadSourceListResModel source) {
    final TextEditingController nameController =
        TextEditingController(text: source.name);
    final RxString status =
        (source.status ?? 'Active').obs; // Initialize with source.status
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final LeadSourceUpdateViewModel leadSourceCreateViewModel =
        Get.put(LeadSourceUpdateViewModel());
    final isLoading = false.obs;

    leadSourceStatusList.fetchLeadSourceStatus(source.id ?? '').then((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Material(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.83,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AllColors.mediumPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.edit_outlined,
                            color: AllColors.mediumPurple,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "Edit Lead Source",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.sfPro,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: const Icon(Icons.close,
                                size: 18, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 0.4),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(
                          top: 10, right: 15, left: 15, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContainerUtils(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.label_outline,
                                      size: 16,
                                      color: AllColors.mediumPurple,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Lead Source Name',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF374151),
                                      ),
                                    ),
                                    const Text(
                                      ' *',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                CommonTextField(
                                  hintText: 'Enter lead source name',
                                  controller: nameController,
                                  onCategoriesChanged:
                                      (List<String> updatedCategories) {
                                    debugPrint(
                                        'Categories updated: $updatedCategories');
                                  },
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Name is required';
                                    }
                                    return null;
                                  },
                                  onChanged: (newValue) {
                                    debugPrint('Selected source: $newValue');
                                  },
                                  onSearch: (String query) {
                                    debugPrint('Search query: $query');
                                  },
                                  isMultiSelect: false,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          ContainerUtils(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.signal_wifi_statusbar_4_bar,
                                      size: 16,
                                      color: AllColors.mediumPurple,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Status',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF374151),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                _buildOptionTile(
                                  Icons.signal_wifi_statusbar_4_bar,
                                  'Status',
                                  'Toggle between Active and Inactive',
                                  status,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide(color: Colors.grey)),
                    ),
                    child: SafeArea(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 3,
                            child: Obx(() => ElevatedButton(
                                  onPressed: isLoading.value
                                      ? null
                                      : () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            isLoading.value = true;
                                            try {
                                              LeadSourceUpdateReqModel
                                                  sourceRequest =
                                                  LeadSourceUpdateReqModel(
                                                name:
                                                    nameController.text.trim(),
                                                status: status.value,
                                                // Use RxString value
                                                id: source.id ?? '',
                                                createdAt: source.createdAt
                                                        ?.toIso8601String() ??
                                                    '',
                                                updateAt: DateTime.now()
                                                    .toIso8601String(),
                                              );

                                              debugPrint(
                                                  'Request Model: ${sourceRequest.name}, ${sourceRequest.status}');

                                              await leadSourceCreateViewModel
                                                  .leadSourceUpdateApi(
                                                context,
                                                sourceRequest,
                                                source.id ?? '',
                                              );

                                              Navigator.pop(context);
                                              await leadSourceList
                                                  .fetchLeadSourceList(context);
                                            } catch (e) {
                                              _showSnackBar(
                                                context,
                                                'Failed to update lead source.',
                                                Colors.red,
                                                Icons.error_outline,
                                              );
                                            } finally {
                                              isLoading.value = false;
                                            }
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.mediumPurple,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                  ),
                                  child: isLoading.value
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.save, size: 18),
                                            SizedBox(width: 8),
                                            Text(
                                              "Save",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildOptionTile(
      IconData icon, String title, String subtitle, RxString? status) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AllColors.mediumPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 16, color: AllColors.mediumPurple),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1F2937))),
                Text(subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Obx(() => Switch(
                value: status != null && status.value.toLowerCase() == 'active',
                onChanged: (newValue) {
                  if (status != null) {
                    status.value = newValue
                        ? 'Active'
                        : 'InActive'; // Match API's "InActive" casing
                  }
                },
                activeColor: AllColors.mediumPurple,
                activeTrackColor: AllColors.mediumPurple.withOpacity(0.3),
                inactiveThumbColor: AllColors.vividRed ?? Colors.red,
                inactiveTrackColor:
                    (AllColors.whiteColor ?? AllColors.vividRed),
                trackOutlineColor: WidgetStateProperty.resolveWith((states) =>
                    status != null && status.value.toLowerCase() == 'active'
                        ? Colors.grey[300]
                        : AllColors.vividRed ?? Colors.red),
                trackOutlineWidth: WidgetStateProperty.all(2),
              )),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message,
      Color backgroundColor, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
                child: Text(message,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500))),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class LeadSettingSourceScreenBottomSheet extends StatelessWidget {
  final LeadSourceListViewModel viewModel;

  const LeadSettingSourceScreenBottomSheet(
      {super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final LeadSourceCreateViewModel leadSourceCreateViewModel =
        Get.put(LeadSourceCreateViewModel());
    final TextEditingController typeController = TextEditingController();
    final isReminder = false.obs,
        removeFromTodo = false.obs,
        removeFromList = false.obs,
        isLoading = false.obs;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                spreadRadius: 2,
                offset: Offset(0, -4)),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.83,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (AllColors.mediumPurple ?? Colors.blue)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.add_business_outlined,
                          color: AllColors.mediumPurple ?? Colors.blue,
                          size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Add New Lead Source",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.sfPro),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: const Icon(Icons.close,
                            size: 18, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 0.4),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      top: 10, right: 15, left: 15, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ContainerUtils(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.label_outline,
                                    size: 16,
                                    color:
                                        AllColors.mediumPurple ?? Colors.blue),
                                const SizedBox(width: 8),
                                const Text('Lead Source Name',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF374151))),
                                const Text(' *',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            CommonTextField(
                              hintText: 'Enter lead source name',
                              controller: typeController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Name is required';
                                }
                                return null;
                              },
                              onChanged: (newValue) {
                                debugPrint('Selected source: $newValue');
                              },
                              onCategoriesChanged:
                                  (List<String> updatedCategories) {
                                debugPrint(
                                    'Categories updated: $updatedCategories');
                              },
                              onSearch: (String query) {
                                debugPrint('Search query: $query');
                              },
                              isMultiSelect: false,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ContainerUtils(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.settings_outlined,
                                    size: 16,
                                    color:
                                        AllColors.mediumPurple ?? Colors.blue),
                                const SizedBox(width: 8),
                                const Text('Configuration Options',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF374151))),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildOptionTile(
                              Icons.notification_important_outlined,
                              'Enable Reminders',
                              'Set automatic reminders for this lead source',
                              isReminder,
                            ),
                            const SizedBox(height: 12),
                            _buildOptionTile(
                              Icons.checklist_outlined,
                              'Remove from To-Do',
                              'Automatically remove completed items from to-do list',
                              removeFromTodo,
                            ),
                            const SizedBox(height: 12),
                            _buildOptionTile(
                              Icons.list_alt_outlined,
                              'Remove from List',
                              'Hide this lead source from main listings when completed',
                              removeFromList,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey)),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text("Cancel",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 3,
                        child: Obx(() => ElevatedButton(
                              onPressed: isLoading.value
                                  ? null
                                  : () async {
                                      if (formKey.currentState!.validate()) {
                                        isLoading.value = true;
                                        try {
                                          // Set the nameController value in the ViewModel
                                          leadSourceCreateViewModel
                                                  .nameController.text =
                                              typeController.text.trim();

                                          // Call the API to create the lead source
                                          await leadSourceCreateViewModel
                                              .leadSourceCreateApi(context);

                                          // Close the bottom sheet
                                          Navigator.pop(context);

                                          // Refresh the lead source list
                                          await viewModel
                                              .fetchLeadSourceList(context);
                                        } catch (e) {
                                          _showSnackBar(
                                            context,
                                            'Failed to add lead source. Please try again.',
                                            Colors.red,
                                            Icons.error_outline,
                                          );
                                        } finally {
                                          isLoading.value = false;
                                        }
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AllColors.mediumPurple ?? Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                              child: isLoading.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.add, size: 18),
                                        SizedBox(width: 8),
                                        Text("Add Lead Source",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile(
      IconData icon, String title, String subtitle, RxBool value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (AllColors.mediumPurple ?? Colors.blue).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon,
                size: 16, color: AllColors.mediumPurple ?? Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1F2937))),
                Text(subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Obx(() => Switch(
                value: value.value,
                onChanged: (newValue) => value.value = newValue,
                activeColor: AllColors.mediumPurple ?? Colors.blue,
                activeTrackColor:
                    (AllColors.mediumPurple ?? Colors.blue).withOpacity(0.3),
                inactiveThumbColor: AllColors.vividRed,
                inactiveTrackColor: Colors.white,
                trackOutlineColor: WidgetStateProperty.resolveWith((states) =>
                    value.value ? Colors.grey[300] : AllColors.vividRed),
              )),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message,
      Color backgroundColor, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
                child: Text(message,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500))),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
