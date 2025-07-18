import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/data/models/responseModels/roles/roles_response_model.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/components/widgets/drawer/custom_drawer.dart';
import 'package:websuites/views/rolesScreen/role_details/RoleDetailsScreen.dart';
import '../../data/models/requestModels/role/add_role/UserAddRoleRequestModel.dart';
import '../../data/models/responseModels/customers/orderProducts/services/order_product_services.dart';
import '../../data/models/responseModels/userList/list/add_role/UserAddRoleResponseModel.dart';
import '../../utils/button/CustomButton.dart';
import '../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../utils/container_Utils/ContainerUtils.dart';
import '../../utils/dark_mode/dark_mode.dart';
import '../../utils/fontfamily/FontFamily.dart';
import '../../viewModels/saveToken/save_token.dart';
import '../../data/models/responseModels/login/login_response_model.dart';
import '../../utils/appColors/app_colors.dart';
import '../../viewModels/userlistViewModel/roles/add_role/UserAddRoleViewModel.dart';
import '../../viewModels/userlistViewModel/roles/roles_viewModel.dart';
import '../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../usersScreen/role/UserUpdateRoleScreen.dart';

class RolesScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const RolesScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final RolesViewModel rolesViewModel = Get.put(RolesViewModel());
  final UserAddRoleViewModel userAddRoleViewModel =
      Get.put(UserAddRoleViewModel());

  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
    rolesViewModel.fetchRoles(context);
  }

  Future<void> fetchUserData() async {
    try {
      final LoginResponseModel response = await SaveUserData().getUser();
      setState(() {
        userName = response.user?.firstName ?? 'No Name';
        userEmail = response.user?.email ?? 'No Email';
      });
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }

  Future<void> _refreshRoleList() async {
    await rolesViewModel.refreshRoles(context); // Use the new refresh method
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _globalKey,
      backgroundColor:   DarkMode.backgroundColor(context),
      // drawer: CustomDrawer(
      //   userName: userName,
      //   phoneNumber: userEmail,
      //   version: '1.0.12',
      // ),
      body: Obx(() {
        if (rolesViewModel.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
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
                          if (widget.scaffoldKey.currentState != null) {
                            if (!widget
                                .scaffoldKey.currentState!.isDrawerOpen) {
                              widget.scaffoldKey.currentState!.openDrawer();
                            }
                          }
                        },
                      ),
                    if (isTablet) const SizedBox(width: 10),
                    Text(
                      'Role List',
                      style: TextStyle(
                        color: DarkMode.backgroundColor2(context),
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 18.5,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      width: 70,
                      height: 22,
                      borderRadius: 54,
                      onPressed: () {
                        UserAddRoleResponseModel addRole =
                            UserAddRoleResponseModel(
                          id: null,
                          name: '',
                          description: '',
                          isDefault: true,
                        );
                        _showDialog(addRole);
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
              child: RefreshIndicator(
                onRefresh: _refreshRoleList,
                child: rolesViewModel.roles.isEmpty
                    ? const Center(child: Text('No roles available'))
                    : GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(15),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width < 600
                                  ? 1
                                  : MediaQuery.of(context).size.width < 1200
                                      ? 2
                                      : 3,
                          childAspectRatio:
                              2.5, // Fixed aspect ratio that works better for cards
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: rolesViewModel.roles.length,
                        itemBuilder: (context, index) {
                          final role = rolesViewModel.roles[index];
                          List<String> firstLetters = role.users
                              .map((user) =>
                                  user.firstName.substring(0, 1) ?? 'N')
                              .toList();

                          return ContainerUtils(
                            paddingBottom: 10,
                            paddingTop: 15,
                            paddingLeft: 15,
                            paddingRight: 15,
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => RoleDetailsScreen(role: role),
                                //   ),
                                // );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          role.name ?? 'No Title',
                                          style: TextStyle(
                                            color: DarkMode.backgroundColor2(context),
                                            fontSize: 17.5,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserUpdateRolescreen(
                                                      role: role),
                                            ),
                                          );
                                        },
                                        child: Image.asset(ImageStrings.edit,
                                            height: 17, width: 17),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'DESCRIPTION - ',
                                        style: TextStyle(
                                          color: DarkMode.backgroundColor2(context),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          role.description ?? 'No Description',
                                          style: TextStyle(
                                            color: AllColors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(thickness: 0.4),
                                  Row(
                                    children: [
                                      Text(
                                        'MEMBERS - ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: DarkMode.backgroundColor2(context),
                                        ),
                                      ),
                                      Text(
                                        role.users.length.toString(),
                                        style: TextStyle(
                                          color: AllColors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      // Fixed-size container for avatars
                                      // Fixed-size container for avatars
                                      // Fixed-size container for avatars
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RoleDetailsScreen(role: role),
                                            ),
                                          );
                                        },
                                        child: SizedBox(
                                          height: screenHeight / 30,
                                          width: min(screenWidth / 4, 120),
                                          child: Stack(
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      min(firstLetters.length,
                                                          4);
                                                  i++)
                                                Positioned(
                                                  right: (i *
                                                      18.0), // Reduced spacing between avatars
                                                  child: Container(
                                                    height: screenHeight / 30,
                                                    width: screenHeight /
                                                        30, // Consistent dimensions
                                                    decoration: BoxDecoration(
                                                      color: i % 4 == 0
                                                          ? AllColors.lightRed
                                                          : i % 4 == 1
                                                              ? AllColors
                                                                  .lighterPurple
                                                              : i % 4 == 2
                                                                  ? AllColors
                                                                      .lightBlue
                                                                  : AllColors
                                                                      .lightYellow,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        firstLetters[i],
                                                        style: TextStyle(
                                                          color: i % 4 == 0
                                                              ? AllColors
                                                                  .vividRed
                                                              : i % 4 == 1
                                                                  ? AllColors
                                                                      .mediumPurple
                                                                  : i % 4 == 2
                                                                      ? AllColors
                                                                          .vividBlue
                                                                      : AllColors
                                                                          .darkYellow,
                                                          // Scale font size relative to avatar size
                                                          fontSize: (screenHeight /
                                                                  30) *
                                                              0.4, // 50% of avatar size
                                                          fontWeight: FontWeight
                                                              .w500, // Making it slightly bolder for visibility
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (role.users.isNotEmpty)
                                        Text(
                                          '+${role.users.length}',
                                          style: TextStyle(
                                            color: AllColors.grey,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14, // Smaller font size
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
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showDialog(UserAddRoleResponseModel addRole) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    if (addRole.id != null) {
      nameController.text = addRole.name ?? '';
      descriptionController.text = addRole.description ?? '';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              const Text(
                'Add New Role',
                style: TextStyle(
                  fontFamily: FontFamily.sfPro,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.5,
                ),
              ),
              const Spacer(),

              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close))
              // GestureDetector(
              //     onTap: (){
              //       Get.back();
              //     },
              //     child: Icon(Icons.close))
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Role Name'),
              const SizedBox(height: 8),
              CommonTextField(
                hintText: 'Enter role name',
                controller: nameController,
              ),
              const SizedBox(height: 8),
              const Text('Role Description'),
              const SizedBox(height: 8),
              CommonTextField(
                hintText: 'Enter role description',
                controller: descriptionController,
              ),
              const SizedBox(height: 15),
              CustomButton(
                width: double.infinity,
                height: 35,
                borderRadius: 8,
                onPressed: () async {
                  UserAddRoleRequestModel newRole = UserAddRoleRequestModel(
                    name: nameController.text,
                    description: descriptionController.text,
                  );
                  await userAddRoleViewModel.addRole(context, newRole);
                  await rolesViewModel
                      .refreshRoles(context); // Refresh after adding
                  Navigator.pop(context);
                },
                child:
                    Text('Save', style: TextStyle(color: AllColors.whiteColor)),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
