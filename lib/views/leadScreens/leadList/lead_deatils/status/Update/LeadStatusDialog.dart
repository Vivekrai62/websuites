import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

import '../../../../../../utils/appColors/app_colors.dart';
import '../../../../../../utils/button/CustomButton.dart';
import '../../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../../../viewModels/leadScreens/lead_list/detail/LeadDetailsViewModel.dart';
import '../../../../../../viewModels/leadScreens/lead_list/lead_detail_view/update_status/dead_reason/LeadDetailsStatusDeadReason.dart';
import '../../../../../../viewModels/leadScreens/lead_list/lead_detail_view/update_status/lead_update_statsu_view_model.dart';

class LeadStatusDialog extends StatefulWidget {
  @override
  _LeadStatusDialogState createState() => _LeadStatusDialogState();
}

class _LeadStatusDialogState extends State<LeadStatusDialog> {
  final TextEditingController statusController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  String selectedStatus = 'In Progress'; // Default to 'In Progress'

  @override
  void initState() {
    super.initState();
    final leadDetailUpdateStatusViewModel = Get.put(LeadDetailUpdateStatusViewModel(), permanent: true);
    final leadDetailsViewModel = Get.find<LeadDetailsViewModel>();
    final leadDetailsStatusDeadReason = Get.find<LeadDetailsStatusDeadReason>();

    // Map API status to display status
    String? currentStatus = leadDetailsViewModel.leadDetails.value?.leadStatus;
    const Map<String, String> statusMap = {
      'in_progress': 'In Progress',
      'dead': 'Dead',
    };

    // Set initial status based on API data, default to 'In Progress' if not found
    String displayStatus = statusMap[currentStatus] ?? 'In Progress';
    selectedStatus = displayStatus;
    statusController.text = displayStatus;

    // Fetch dead reasons if the initial status is 'Dead'
    if (displayStatus == 'Dead') {
      leadDetailsStatusDeadReason.deadReasons();
    }
  }

  @override
  void dispose() {
    statusController.dispose();
    reasonController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leadDetailsStatusDeadReason = Get.find<LeadDetailsStatusDeadReason>();

    return Obx(() {
      final deadReasons = leadDetailsStatusDeadReason.deadReasons.map((r) => r.reason ?? '').toList();
      final bool hasReasons = deadReasons.isNotEmpty;
      final bool isLoading = leadDetailsStatusDeadReason.loading.value;

      return AlertDialog(
        backgroundColor: Colors.white,
        titlePadding: const EdgeInsets.only(top: 16, left: 16, right: 8),
        contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Row(
          children: [
            const Text(
              'Lead Status',
              style: TextStyle(
                fontFamily: FontFamily.sfPro,
                fontWeight: FontWeight.w600,
                fontSize: 17.5,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Status'),
                const SizedBox(height: 8),
                CommonTextField(
                  hintText: 'Select',
                  controller: statusController,
                  onChanged: (String? newValue) async {
                    if (newValue != null && newValue != selectedStatus) {
                      setState(() {
                        selectedStatus = newValue;
                        statusController.text = newValue;
                      });

                      if (newValue == 'Dead') {
                        try {
                          leadDetailsStatusDeadReason.loading.value = true;
                          await leadDetailsStatusDeadReason.deadReasons();
                          if (leadDetailsStatusDeadReason.deadReasons.isEmpty) {
                            Get.snackbar(
                              'Warning',
                              'No dead reasons available',
                              backgroundColor: Colors.orange,
                              colorText: Colors.white,
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Failed to load dead reasons: $e',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } finally {
                          leadDetailsStatusDeadReason.loading.value = false;
                        }
                      } else {
                        reasonController.clear();
                        leadDetailsStatusDeadReason.deadReasons.clear(); // Clear reasons for non-Dead status
                      }
                    }
                  },
                  categories: const ['In Progress', 'Dead'],
                  allowCustomBorderInput: BorderRadius.circular(12),
                ),
                const SizedBox(height: 16),

                if (selectedStatus == 'Dead') ...[
                  const Text('Lead Dead Reason'),
                  const SizedBox(height: 8),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CommonTextField(
                    hintText: hasReasons ? 'Select Reason' : 'No Reasons Available',
                    controller: reasonController,
                    onChanged: hasReasons
                        ? (String? newValue) {
                      if (newValue != null) {
                        reasonController.text = newValue;
                      }
                    }
                        : null,
                    categories: deadReasons,
                    allowCustomBorderInput: BorderRadius.circular(12),
                  ),
                  const SizedBox(height: 16),
                ],

                const Text('Remark'),
                const SizedBox(height: 8),
                CommonTextField(
                  hintText: 'Enter Remark...',
                  maxLines: 3,
                  controller: remarksController,
                  allowCustomBorderInput: BorderRadius.circular(12),
                ),
                const SizedBox(height: 15),

                CustomButton(
                  width: double.infinity,
                  height: 35,
                  borderRadius: 8,
                  onPressed: () async {
                    if (selectedStatus.isNotEmpty && remarksController.text.isNotEmpty) {
                      if (selectedStatus == 'Dead' && reasonController.text.isEmpty && hasReasons) {
                        Get.snackbar(
                          'Error',
                          'Please select a reason for Dead status',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      const Map<String, String> statusMap = {
                        'In Progress': 'in_progress',
                        'Dead': 'dead',
                      };

                      String apiStatus = statusMap[selectedStatus] ?? '';

                      final leadDetailUpdateStatusViewModel = Get.find<LeadDetailUpdateStatusViewModel>();
                      final leadDetailsViewModel = Get.find<LeadDetailsViewModel>();

                      // Example API call (uncomment when ready)
                      // await leadDetailUpdateStatusViewModel.updateLeadStatus(
                      //   leadId: leadDetailsViewModel.leadDetails.value?.id ?? '',
                      //   status: apiStatus,
                      //   reason: reasonController.text,
                      //   remarks: remarksController.text,
                      // );

                      Navigator.pop(context);
                    } else {
                      Get.snackbar(
                        'Error',
                        'Please fill all required fields',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: AllColors.whiteColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}