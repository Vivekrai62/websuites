import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import '../../../data/models/requestModels/role/edit_role/RoleListEditRequestModel.dart';
import '../../../data/models/responseModels/roles/roles_response_model.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../viewModels/userlistViewModel/roles/edit/RoleListEditViewModel.dart';
import '../../../viewModels/userlistViewModel/roles/update_role/RoleListUpdateViewModel.dart';
import '../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';


class UserUpdateRolescreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey; // Optional scaffold key
  final RolesResponseModel role; // Required role data

  const UserUpdateRolescreen({
    super.key,
    required this.role,
    this.scaffoldKey,
  });

  @override
  State<UserUpdateRolescreen> createState() => _UserUpdateRolescreenState();
}

class _UserUpdateRolescreenState extends State<UserUpdateRolescreen> {
  final RoleListUpdateViewModel roleViewModel =
      Get.put(RoleListUpdateViewModel());
  final RoleListEditViewModel roleNamDscViewModel =
      Get.put(RoleListEditViewModel());

  Map<String, List<bool>> permissionCheckboxes = {};
  bool isSelectAll = false;
  late TextEditingController nameController;
  late TextEditingController descriptionController;

  String formatPermissionText(String text) {
    final words = text.trim().split(' ');
    return words.length >= 4
        ? words.take(4).join(' ')
        : text; // Simplified logic
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.role.name ?? '');
    descriptionController =
        TextEditingController(text: widget.role.description ?? '');

    // Fetch role data with permissions
    roleViewModel.roleUpdateListApi(context).then((_) {
      setState(() {
        permissionCheckboxes.clear();
        for (var role in roleViewModel.roleData.value) {
          if (role.permissions != null) {
            permissionCheckboxes[role.id!] =
                List.generate(role.permissions!.length, (index) => false);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      key: widget
          .scaffoldKey, // Use the scaffoldKey passed from HomeManagerController
      backgroundColor: Colors.white,
      body: Obx(() {
        return Column(
          children: [
            CustomAppBar(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
                child: Row(
                  children: [
                    if (!isTablet && widget.scaffoldKey != null)
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        onPressed: () {
                          if (widget.scaffoldKey?.currentState?.isDrawerOpen ==
                              false) {
                            widget.scaffoldKey?.currentState?.openDrawer();
                          }
                        },
                      ),
                    if (isTablet) const SizedBox(width: 10),
                    Text(
                      'Edit Role', // Corrected title to reflect the screen purpose
                      style: TextStyle(
                        color: AllColors.blackColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 18.5,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      width: 70,
                      height: 25,
                      borderRadius: 54,
                      onPressed: () async {
                        final updatedRole = RoleListEditRequestModel(
                          name: nameController.text,
                          description: descriptionController.text,
                        );

                        await roleNamDscViewModel.roleListEditApi(
                          widget.role.id,
                          name: nameController.text,
                          description: descriptionController.text,
                        );

                        await _saveUpdatedPermissions();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.sfPro,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  if (roleViewModel.loading.value)
                    const Center(child: CircularProgressIndicator()),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Search Role'),
                          const SizedBox(height: 8),
                          CommonTextField(
                            controller: roleViewModel.searchController,
                            suffixIcon: Icon(Icons.search,
                                size: 18, color: Colors.grey.shade500),
                            hintText: 'Search',
                          ),
                          const SizedBox(height: 8),
                          const Text('Role Name'),
                          const SizedBox(height: 8),
                          CommonTextField(
                            controller: nameController,
                            hintText: 'Enter role name',
                          ),
                          const SizedBox(height: 10),
                          const Text('Role Description'),
                          const SizedBox(height: 8),
                          CommonTextField(
                            controller: descriptionController,
                            hintText: 'Description',
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Role Permissions',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: FontFamily.sfPro,
                                      ),
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(
                                      'assets/svg/role_update.svg',
                                      semanticsLabel: 'Role Update SVG',
                                      height: 15,
                                      width: 15,
                                      color: AllColors.grey,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Module Access',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: FontFamily.sfPro,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(Icons.error,
                                        color: Colors.grey, size: 18),
                                    const Spacer(),
                                    SizedBox(
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: isSelectAll,
                                            onChanged: (value) {
                                              setState(() {
                                                isSelectAll = value ?? false;
                                                permissionCheckboxes
                                                    .forEach((key, checkboxes) {
                                                  for (int i = 0;
                                                      i < checkboxes.length;
                                                      i++) {
                                                    checkboxes[i] = isSelectAll;
                                                  }
                                                });
                                              });
                                            },
                                            activeColor: AllColors.mediumPurple,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Select All',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: FontFamily.sfPro,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (roleViewModel.filteredCategories.isNotEmpty)
                            ...roleViewModel.filteredCategories.value
                                .where((role) => role.permissions != null)
                                .map((role) {
                              final roleId = role.id ?? 'defaultRoleId';
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      role.displayName ?? 'Module',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: FontFamily.sfPro,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Column(
                                      children:
                                          role.permissions!.map((permission) {
                                        String permissionName =
                                            permission.name ?? 'Permission';
                                        final firstUnderscoreIndex =
                                            permissionName.indexOf('_');
                                        if (firstUnderscoreIndex != -1) {
                                          permissionName =
                                              permissionName.substring(
                                                  firstUnderscoreIndex + 1);
                                        }
                                        final parts = permissionName.split('_');
                                        final formattedParts = parts
                                            .map((part) =>
                                                part[0].toUpperCase() +
                                                part.substring(1).toLowerCase())
                                            .toList();
                                        final formattedLabel =
                                            formattedParts.join(' ');
                                        final index = role.permissions!
                                            .indexOf(permission);

                                        return SizedBox(
                                          height: 40,
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                value:
                                                    permissionCheckboxes[roleId]
                                                            ?[index] ??
                                                        false,
                                                onChanged: (value) {
                                                  setState(() {
                                                    permissionCheckboxes[
                                                            roleId]![index] =
                                                        value ?? false;
                                                    isSelectAll =
                                                        permissionCheckboxes
                                                            .values
                                                            .every((list) =>
                                                                list.every(
                                                                    (checked) =>
                                                                        checked));
                                                  });
                                                },
                                                activeColor:
                                                    AllColors.mediumPurple,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  formatPermissionText(
                                                      formattedLabel),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        FontFamily.sfPro,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Future<void> _saveUpdatedPermissions() async {
    final updatedPermissions = <Map<String, dynamic>>[];
    permissionCheckboxes.forEach((roleId, permissions) {
      for (int i = 0; i < permissions.length; i++) {
        if (permissions[i]) {
          updatedPermissions.add({
            'roleId': roleId,
            'permissionId': roleViewModel.roleData.value
                .firstWhere((role) => role.id == roleId)
                .permissions![i]
                .id,
            'isGranted': true,
          });
        }
      }
    });

    await roleViewModel.saveUpdatedPermissions(
        widget.role.id, updatedPermissions);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
