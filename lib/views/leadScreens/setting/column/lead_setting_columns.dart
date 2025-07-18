import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../../data/models/responseModels/leads/setting/setting.dart';
import '../../../../resources/imageStrings/image_strings.dart';
import '../../../../utils/appColors/app_colors.dart';
import '../../../../utils/checkbox/LabeledCheckbox.dart';
import '../../../../utils/dark_mode/dark_mode.dart';
import '../../../../utils/fontfamily/FontFamily.dart';
import '../../../../viewModels/leadScreens/lead_list/column/update_column_list/lead_list_update_column_view_model.dart';
import '../../../../viewModels/leadScreens/setting/field_setting/field_setting.dart';
import '../../../../viewModels/leadScreens/setting/roles/roles.dart';
import '../../../../viewModels/leadScreens/setting/setting_list.dart';
import '../../createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class LeadSettingColumnScreen extends StatefulWidget {
  const LeadSettingColumnScreen({super.key});

  @override
  State<LeadSettingColumnScreen> createState() => _LeadSettingColumnScreenState();
}

class _LeadSettingColumnScreenState extends State<LeadSettingColumnScreen> {
  final LeadSettingListViewModel viewModel = Get.put(LeadSettingListViewModel());
  final LeadSettingRolesViewmodel rolesViewModel = Get.put(LeadSettingRolesViewmodel());
  final LeadListUpdateColumnViewModel updateViewModel = Get.put(LeadListUpdateColumnViewModel()); // Add view model




  @override
  void initState() {
    super.initState();
    viewModel.leadColumnSettingList(context);
    rolesViewModel.settingRoles(context);
  }

  Color getFieldColor(String fieldName) {
    final colors = [
      Colors.orange[400],
      Colors.green[400],
      Colors.blue[400],
      Colors.purple[400],
      Colors.red[400],
    ];
    return colors[fieldName.hashCode % colors.length] ?? Colors.grey;
  }

  String getFieldIcon(String fieldName) {
    return fieldName.isNotEmpty ? fieldName[0].toUpperCase() : 'F';
  }

  Widget buildFieldItem(LeadSettingResponseModel field) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: ContainerUtils(
        paddingTop: 5,
        paddingBottom: 5,
        paddingRight: 0,
        paddingLeft: 15,
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: getFieldColor(field.fieldName),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  getFieldIcon(field.fieldName),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field.leadField,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w600,
                        color:  DarkMode.backgroundColor2(context),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                LabeledCheckbox(
                  key: Key('locked_${field.id}'),
                  value: field.locked,
                  onChanged: (bool? newValue) {},
                  activeColor: AllColors.mediumPurple,
                  alignment: MainAxisAlignment.start,
                ),
                const SizedBox(width: 10),
                LabeledCheckbox(
                  key: Key('status_${field.id}'),
                  value: field.status,
                  onChanged: (bool? newValue) {},
                  activeColor: AllColors.mediumPurple,
                  alignment: MainAxisAlignment.start,
                ),
                const SizedBox(width: 10),
                Container(
                  width: 60,
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset(
                      ImageStrings.edit,
                      height: 17,
                      width: 16,
                      color: AllColors.figmaGrey,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          // State to hold selected roles
                          RxList<String> selectedRoles = field.hideLeadColumnsFromRole
                              .map((hideRole) => hideRole.role.name ?? 'N/A')
                              .toList()
                              .obs;

                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(
                              15,
                              15,
                              15,
                              MediaQuery.of(context).viewInsets.bottom + 16,
                            ),
                            content: SingleChildScrollView(
                              child: Obx(() {
                                if (rolesViewModel.loading.value) {
                                  return const Center(child: CircularProgressIndicator());
                                }

                                final roles = rolesViewModel.roles;
                                final categories = roles.isNotEmpty
                                    ? roles.map((role) => role.name ?? 'Unknown').toList()
                                    : ['No roles available'];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Update Permissions",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () => Get.back(),
                                          child: const Icon(Icons.close),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'View Restriction For Particular Roles*',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    CommonTextField(
                                      isMultiSelect: true,
                                      hintText: "Select",
                                      categories: categories,
                                      value: selectedRoles.isNotEmpty ? selectedRoles.join(', ') : 'N/A',
                                      onCategoriesChanged: (List<String> newRoles) {
                                        // Update selected roles
                                        selectedRoles.assignAll(newRoles);
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black54,
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              side: BorderSide(color: Colors.grey.shade300),
                                            ),
                                          ),
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        TextButton.icon(
                                          onPressed: () async {
                                            // Call API to update permissions
                                            await updateViewModel.leadListColumnUpdate(
                                              context,
                                              fieldId: field.id, // Pass field ID
                                              roleIds: rolesViewModel.roles
                                                  .asMap()
                                                  .entries
                                                  .where((entry) => selectedRoles.contains(entry.value.name))
                                                  .map((entry) => entry.value.id ?? '')
                                                  .toList(),
                                            );
                                            Navigator.of(context).pop();
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: AllColors.mediumPurple,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.check,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            'Update Permission',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                );
                              }),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (viewModel.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final leadSettings = viewModel.leadSettings;

      if (leadSettings.isEmpty) {
        return const Center(child: Text('No lead settings found'));
      }

      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: leadSettings.length,
        itemBuilder: (context, index) {
          return buildFieldItem(leadSettings[index]);
        },
      );
    });
  }
}