import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import '../../../../Utils/utils.dart';
import '../../../../data/models/requestModels/lead/setting/dead/update/lead_dead_update_req_model.dart';
import '../../../../data/models/responseModels/leads/setting/dead_reasons/lead_setting_dead_reason_res_model.dart';
import '../../../../resources/imageStrings/image_strings.dart';
import '../../../../utils/appColors/app_colors.dart';
import '../../../../utils/fontfamily/FontFamily.dart';
import '../../../../viewModels/leadScreens/setting/dead_reason/create/lead_setting_dead_create_view_model.dart';
import '../../../../viewModels/leadScreens/setting/dead_reason/delete/lead_delete_reason_view_model.dart';
import '../../../../viewModels/leadScreens/setting/dead_reason/lead_dead_reason_view_model.dart';
import '../../../../viewModels/leadScreens/setting/dead_reason/update/lead_dead_update_view_model.dart';
import '../../createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class LeadDeadReasonsScreen extends StatefulWidget {
  const LeadDeadReasonsScreen({super.key});

  static void showCreateDeadDialog(
      BuildContext context, LeadDeadReasonViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          LeadSettingDeadScreenBottomSheet(viewModel: viewModel),
    );
  }

  @override
  State<LeadDeadReasonsScreen> createState() => _LeadDeadReasonsScreenState();
}

class _LeadDeadReasonsScreenState extends State<LeadDeadReasonsScreen> {
  // Initialize the view models
  final LeadDeadReasonViewModel viewModel = Get.put(LeadDeadReasonViewModel());
  final LeadDeleteReasonViewModel deleteViewModel = Get.put(LeadDeleteReasonViewModel());

  @override
  void initState() {
    super.initState();
    // Fetch data when the screen is initialized
    viewModel.leadDeadReasonListApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Show loading indicator while data is being fetched
      if (viewModel.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (viewModel.leadDeadReasons.isEmpty) {
        return const Center(child: Text('No lead dead reasons found'));
      }

      return ListView.builder(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        itemCount: viewModel.leadDeadReasons.length,
        itemBuilder: (context, index) {
          final reason = viewModel.leadDeadReasons[index];
          return GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Warning!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AllColors.vividRed,
                      ),
                    ),
                    content: const Text(
                      'Are you sure you want to delete?',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'SFPro',
                        color: Colors.grey,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SFPro',
                            color: AllColors.figmaGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Call the delete API with the reason's id
                          deleteViewModel.deleteLeadDeadReasonApi(context, reason.id.toString());
                          Navigator.of(context).pop(); // Close the dialog after action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AllColors.vividRed, // Delete button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Yes, Delete',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SFPro',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 4,
                  );
                },
              );
            },
            child: ContainerUtils(
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        reason.reason ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 17.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          color: (reason.status ?? false)
                              ? AllColors.background_green
                              : AllColors.lightRed,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            reason.status != null
                                ? (reason.status! ? 'Active' : 'Inactive')
                                : 'Unknown',
                            style: TextStyle(
                              color: (reason.status ?? false)
                                  ? AllColors.text__green
                                  : AllColors.darkRed,
                              fontFamily: 'SFPro',
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
                        formatDateWithTime(reason.createdAt),
                        style: TextStyle(
                          fontFamily: 'SFPro',
                          color: AllColors.mediumPurple,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          _showEditDialog(context, reason); // Pass the specific 'source' instead of LeadSource()
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
            ),
          );
        },
      );
    });
  }

  void _showEditDialog(BuildContext context, LeadSettingDeadReasonList reason) {
    final TextEditingController nameController = TextEditingController(text: reason.reason);
    final RxString status = (reason.status ?? true ? 'Active' : 'Inactive').obs; // Use RxString and boolean status
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final LeadDeadUpdateViewModel leadDeadUpdateViewModel = Get.put(LeadDeadUpdateViewModel());
    final isLoading = false.obs;

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
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                        "Edit Dead Reason",
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
                        child: const Icon(Icons.close, size: 18, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 0.4),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 10),
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
                                  'Lead Dead Reason',
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
                              hintText: 'Enter Dead Reason',
                              controller: nameController,
                              onCategoriesChanged: (List<String> updatedCategories) {
                                debugPrint('Categories updated: $updatedCategories');
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
                            padding: const EdgeInsets.symmetric(vertical: 10),
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
                            if (formKey.currentState!.validate()) {
                              isLoading.value = true;
                              try {
                                LeadSettingDeadUpdateReqModel deadRequest =
                                LeadSettingDeadUpdateReqModel(
                                  reason: nameController.text.trim(),
                                  status: status.value == 'Active', // Convert to boolean
                                );

                                debugPrint(
                                    'Request Model: ${deadRequest.toJson()}');

                                await leadDeadUpdateViewModel.leadDeadUpdateApi(
                                  context,
                                  deadRequest,
                                  reason.id ?? '',
                                );

                                Navigator.pop(context);
                                await viewModel
                                    .leadDeadReasonListApi(context); // Refresh list
                              } catch (e) {
                                Utils.snackbarFailed(
                                    'Failed to update dead reason: $e');
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
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: isLoading.value
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.save, size: 18),
                              SizedBox(width: 8),
                              Text(
                                "Update Dead Reason",
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
    ));
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



}

class LeadSettingDeadScreenBottomSheet extends StatelessWidget {
  final LeadDeadReasonViewModel viewModel;

  const LeadSettingDeadScreenBottomSheet(
      {super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final LeadDeadCreateViewModel leadDeadCreateViewModel = Get.put(LeadDeadCreateViewModel());
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
                        "Add New Dead Reason",
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
                                const Text('Enter Reason',
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
                              hintText: 'Enter dead reason name',
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
                                leadDeadCreateViewModel
                                    .nameController.text =
                                    typeController.text.trim();

                                // Call the API to create the lead source
                                await leadDeadCreateViewModel
                                    .leadDeadCreateApi(context);

                                // Close the bottom sheet
                                Navigator.pop(context);

                                // Refresh the lead source list
                                await viewModel
                                    .leadDeadReasons();
                              } catch (e) {
                                _showSnackBar(
                                  context,
                                  'Failed to add lead dead. Please try again.',
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
                              Text("Add Dead Reason",
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
