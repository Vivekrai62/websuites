import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';

import '../../../Utils/utils.dart';
import '../../../data/models/requestModels/userlist/list/UserProfileScreen.dart';
import '../../../resources/strings/strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/section_divider/SectionDivider.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../viewModels/leadScreens/createNewLead/assignedLeadTo/assigned_lead_to_viewModel.dart';
import '../../../viewModels/saveToken/save_token.dart';
import '../../../viewModels/userlistViewModel/roles/roles_viewModel.dart';
import '../../../viewModels/userlistViewModel/status/UserStatusViewModel.dart';
import '../../../viewModels/userlistViewModel/user_update/UserUpdateViewModel.dart';
import '../../../viewModels/userlistViewModel/userlist_viewModel.dart';
import 'package:websuites/data/models/responseModels/userList/list/UserListResponseModels.dart';

import '../../leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class UsersScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const UsersScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>
    with SingleTickerProviderStateMixin {
  final AssignedLeadToViewModel _assignedLeadToController =
      Get.put(AssignedLeadToViewModel());
  final UserUpdateViewModel userUpdateViewModel =
      Get.put(UserUpdateViewModel());
  String? selectedDepartment;
  int _selectedIndex = 0;

  final UserStatusViewModel userStatusViewModel =
      Get.put(UserStatusViewModel());
  bool isSwitched = true;
  bool isListView = true;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  SaveUserData userPreference = SaveUserData();
  final TransformationController _controller = TransformationController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  double _scale = 1.0;
  final Map<String, bool> userSwitchStates = {};
  final UserListViewModel userListViewModel = Get.put(UserListViewModel());
  final RolesViewModel _rolesViewModel = Get.put(RolesViewModel());
  String? selectedRole;

  @override
  void initState() {
    super.initState();
    _assignedLeadToController.fetchAssignedLeads(context);
    _rolesViewModel.fetchRoles(context);
    userListViewModel.userListApi().then((_) {
      for (var user in userListViewModel.userList) {
        userSwitchStates[user.id.toString()] = user.status ?? false;
      }
      setState(() {});
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _refreshProductList() async {
    await userListViewModel.userListApi(forceRefresh: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor:DarkMode.backgroundColor(context),
      body: Obx(() {
        if (userListViewModel.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (userListViewModel.userList.isEmpty) {
          return const Center(child: Text('No users found'));
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
                          widget.scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                    if (isTablet) const SizedBox(width: 10),
                    Text(
                      'User List',
                      style: TextStyle(
                        color: DarkMode.backgroundColor2(context),
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 18.5,
                      ),
                    ),
                    // const Spacer(),
                    // CustomButton(
                    //   width: 140,
                    //   height: 22,
                    //   borderRadius: 54,
                    //   backgroundColor: !isListView ? AllColors.mediumPurple : Colors.grey,
                    //   onPressed: () {
                    //     setState(() {
                    //       isListView = false; // Switch to Graph view
                    //       _selectedIndex = 1; // Update toggle button selection
                    //     });
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Icon(Icons.auto_graph, color: AllColors.whiteColor, size: 18),
                    //       SizedBox(width: 5),
                    //       Text(
                    //         'Graph',
                    //         style: TextStyle(
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w400,
                    //           fontFamily: FontFamily.sfPro,
                    //           color: AllColors.whiteColor,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                  children: [
                    CustomToggleButtonGroup(
                      initialSelectedIndex: _selectedIndex,
                      onIndexChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                          isListView = index == 0; // 0 for List, 1 for Graph
                        });
                      },
                      options: [
                        ToggleButtonUtils.createIconTextOption(
                          icon: Icons.view_list,
                          selectedTextColor: AllColors.whiteColor,
                          text: 'List',
                          selectedColor: AllColors.practiceColor,
                        ),
                        ToggleButtonUtils.createIconTextOption(
                          icon: Icons.bar_chart,
                          selectedTextColor: AllColors.whiteColor,
                          text: 'Graph',
                          selectedColor: AllColors.practiceColor,
                        ),
                      ],
                    ),
                    Expanded(
                      child: isListView
                          ? RefreshIndicator(
                              onRefresh: _refreshProductList,
                              child: userListViewModel.userList.isEmpty
                                  ? const Center(
                                      child: Text("No products available"))
                                  : LayoutBuilder(
                                      builder: (context, constraints) {
                                        if (userListViewModel
                                            .userList.isEmpty) {
                                          return SingleChildScrollView(
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            child: SizedBox(
                                              height: constraints.maxHeight,
                                              child: const Center(
                                                child: Text(
                                                    "No products available"),
                                              ),
                                            ),
                                          );
                                        }

                                        final double screenWidth =
                                            constraints.maxWidth;
                                        int crossAxisCount = screenWidth < 600
                                            ? 1
                                            : screenWidth < 1200
                                                ? 2
                                                : 3;
                                        final double itemWidth = (screenWidth -
                                                (crossAxisCount - 1) * 16) /
                                            crossAxisCount;
                                        const double itemHeight = 195;
                                        final double childAspectRatio =
                                            itemWidth / itemHeight;

                                        return GridView.builder(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          padding: const EdgeInsets.all(16),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: crossAxisCount,
                                            childAspectRatio: childAspectRatio,
                                            crossAxisSpacing: 16,
                                            mainAxisSpacing: 16,
                                          ),
                                          itemCount: userListViewModel
                                                  .userList.isNotEmpty
                                              ? userListViewModel
                                                  .userList.length
                                              : 1,
                                          itemBuilder: (context, index) {
                                            if (userListViewModel
                                                .userList.isEmpty) {
                                              return const Text(
                                                  "No products to display");
                                            }

                                            final user = userListViewModel
                                                .userList[index];

                                            return ContainerUtils(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${user.firstName ?? ''} ${user.lastName ?? ''}',
                                                    style: TextStyle(
                                                      color: DarkMode.backgroundColor2(context),
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        user.email ?? 'N/A',
                                                        style: TextStyle(
                                                          color: AllColors.grey,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Container(
                                                        height: Get.height / 45,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AllColors
                                                              .lighterOrange,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            user.roleList.first
                                                                    .name ??
                                                                'N/A',
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .vividOrange,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .calendar_month_outlined,
                                                          size: 16,
                                                          color: AllColors
                                                              .mediumPurple),
                                                      Text(
                                                        formatDateToDDMMYYYY(user
                                                                .createdAt
                                                                .toString() ??
                                                            'N/A'),
                                                        style: TextStyle(
                                                          color: AllColors
                                                              .mediumPurple,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Icon(Icons.group_sharp,
                                                          color: AllColors
                                                              .vividBlue,
                                                          size: 17),
                                                      Text(
                                                        '${user.parent?.firstName ?? ''} ${user.parent?.lastName ?? ''}'
                                                                .trim()
                                                                .isEmpty
                                                            ? 'N/A'
                                                            : '${user.parent?.firstName ?? ''} ${user.parent?.lastName ?? ''}',
                                                        style: TextStyle(
                                                          color: AllColors
                                                              .vividBlue,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.call_rounded,
                                                          size: 15,
                                                          color: AllColors
                                                              .lightGrey),
                                                      Text(
                                                        user.mobile != null
                                                            ? '+91-${user.mobile}'
                                                            : 'N/A',
                                                        style: TextStyle(
                                                          color: AllColors
                                                              .lightGrey,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        'ACTIONS - ',
                                                        style: TextStyle(
                                                          color: DarkMode.backgroundColor2(context),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          _showDialogBox(
                                                              context, user);
                                                        },
                                                        child: const Icon(
                                                            Icons.edit_calendar,
                                                            size: 15),
                                                      ),
                                                      const Icon(
                                                          Icons
                                                              .shield_moon_outlined,
                                                          size: 15),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const UserProfileScreen()));
                                                        },
                                                        child: const Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                            size: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(thickness: 0.4),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'DEPARTMENT',
                                                        style: TextStyle(
                                                          color: DarkMode.backgroundColor2(context),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const Icon(
                                                          Icons.arrow_right_alt,
                                                          size: 20),
                                                      Expanded(
                                                        child: Text(
                                                          user.department
                                                                  ?.name ??
                                                              'N/A',
                                                          style: TextStyle(
                                                            color:
                                                                AllColors.grey,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines:
                                                              1, // Ensures the text is displayed in a single line
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SizedBox(
                                                        height: Get.height / 40,
                                                        width: Get.width / 12,
                                                        child: Transform.scale(
                                                          scale: 0.7,
                                                          child:
                                                              CupertinoSwitch(
                                                            value: userSwitchStates[user
                                                                    .id
                                                                    .toString()] ??
                                                                false,
                                                            onChanged:
                                                                (value) async {
                                                              setState(() {
                                                                userSwitchStates[user
                                                                        .id
                                                                        .toString()] =
                                                                    value;
                                                              });
                                                              try {
                                                                bool
                                                                    updatedStatus =
                                                                    await userStatusViewModel
                                                                        .userStatusUpdate(
                                                                  user.id
                                                                      .toString(),
                                                                  value,
                                                                );
                                                                setState(() {
                                                                  userSwitchStates[user
                                                                          .id
                                                                          .toString()] =
                                                                      updatedStatus;
                                                                });
                                                              } catch (error) {
                                                                setState(() {
                                                                  userSwitchStates[user
                                                                          .id
                                                                          .toString()] =
                                                                      !value;
                                                                });
                                                                Utils.snackbarFailed(
                                                                    'Failed to update user status');
                                                              }
                                                            },
                                                            activeTrackColor:
                                                                AllColors
                                                                    .mediumPurple,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: InteractiveViewer(
                                transformationController: _controller,
                                boundaryMargin: const EdgeInsets.all(0),
                                minScale: 0.1,
                                maxScale: 2.0,
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (userListViewModel
                                              .userList.isNotEmpty) ...[
                                            OrgChartNode(
                                              initials: userListViewModel
                                                      .userList
                                                      .firstWhere((user) =>
                                                          user.parent == null)
                                                      .firstName
                                                      ?.substring(0, 1) ??
                                                  'N',
                                              name:
                                                  '${userListViewModel.userList.firstWhere((user) => user.parent == null).firstName ?? ''} ${userListViewModel.userList.firstWhere((user) => user.parent == null).lastName ?? ''}'
                                                      .trim(),
                                              role: userListViewModel.userList
                                                      .firstWhere((user) =>
                                                          user.parent == null)
                                                      .roleList
                                                      .first
                                                      .name ??
                                                  '',
                                              backgroundColor:
                                                  AllColors.mediumPurple,
                                              onDelete: () {},
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18),
                                              child: Container(
                                                width: 0.5,
                                                height: 55,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 800,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 601,
                                                    height: 0.5,
                                                    color: Colors.black,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: List.generate(
                                                      (userListViewModel
                                                                  .userList
                                                                  .length -
                                                              1)
                                                          .clamp(0, 4),
                                                      (index) => Container(
                                                        width: 0.5,
                                                        height: 50,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: List.generate(
                                                      userListViewModel.userList
                                                          .where((user) =>
                                                              user.parent?.id ==
                                                              userListViewModel
                                                                  .userList
                                                                  .firstWhere(
                                                                      (user) =>
                                                                          user.parent ==
                                                                          null)
                                                                  .id)
                                                          .toList()
                                                          .length,
                                                      (index) {
                                                        final user = userListViewModel
                                                            .userList
                                                            .where((user) =>
                                                                user.parent
                                                                    ?.id ==
                                                                userListViewModel
                                                                    .userList
                                                                    .firstWhere(
                                                                        (user) =>
                                                                            user.parent ==
                                                                            null)
                                                                    .id)
                                                            .toList()[index];
                                                        return OrgChartNode(
                                                          initials: user
                                                                  .firstName
                                                                  ?.substring(
                                                                      0, 1) ??
                                                              'N',
                                                          name:
                                                              '${user.firstName ?? ''} ${user.lastName ?? ''}'
                                                                  .trim(),
                                                          role: user.roleList
                                                                  .first.name ??
                                                              '',
                                                          backgroundColor:
                                                              Colors.deepPurple,
                                                          onDelete: () {},
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ] else ...[
                                            const Text('No users available'),
                                          ],
                                        ],
                                      ),
                                      Positioned(
                                        top: 38,
                                        left: 375,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.remove_circle),
                                          color: AllColors.vividRed,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: !isListView
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: AllColors.mediumPurple,
                  onPressed: () {
                    setState(() {
                      if (_scale < 2.0) {
                        _scale += 0.1;
                      }
                    });
                    _controller.value = Matrix4.identity()..scale(_scale);
                  },
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: AllColors.mediumPurple,
                  onPressed: () {
                    setState(() {
                      if (_scale > 0.1) {
                        _scale -= 0.1;
                      }
                    });
                    _controller.value = Matrix4.identity()..scale(_scale);
                  },
                  child: Icon(Icons.remove, color: AllColors.whiteColor),
                ),
              ],
            )
          : null,
    );
  }

  void _showDialogBox(BuildContext context, Item user) {
    final TextEditingController firstNameController =
        TextEditingController(text: user.firstName);
    final TextEditingController lastNameController =
        TextEditingController(text: user.lastName);
    final TextEditingController emailController =
        TextEditingController(text: user.email);
    final TextEditingController mobileController =
        TextEditingController(text: user.mobile);
    final TextEditingController departmentController =
        TextEditingController(text: user.department?.name);
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Edit',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.sfPro,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('First Name *'),
                CommonTextField(
                  hintText: 'Select First Name',
                  controller: firstNameController,
                  onChanged: (newValue) {},
                ),
                const SizedBox(height: 10),
                const Text('Last Name *'),
                CommonTextField(
                  hintText: 'Select Last Name',
                  controller: lastNameController,
                  onChanged: (newValue) {},
                ),
                const SizedBox(height: 10),
                const Text('Email *'),
                CommonTextField(
                  hintText: 'Select Email',
                  controller: emailController,
                  onChanged: (newValue) {},
                ),
                const SizedBox(height: 10),
                const Text('Mobile *'),
                CommonTextField(
                  hintText: 'Select Mobile',
                  controller: mobileController,
                  onChanged: (newValue) {},
                ),
                const SizedBox(height: 10),
                const Text('Department *'),
                CommonTextField(
                  hintText: 'Select Department',
                  categories: [user.department?.name ?? 'N/A'],
                  onChanged: (newValue) {},
                ),
                const SizedBox(height: 10),
                const Text('Report to *'),
                Obx(() {
                  if (_assignedLeadToController.loading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    final formattedCategories = _assignedLeadToController
                        .fullCategoriesRxList
                        .map((category) {
                      final parts = category.split('\n')[0].split(' ');
                      if (parts.length >= 2) {
                        return '${parts[0]} ${parts[1]}';
                      }
                      return category;
                    }).toList();

                    return CommonTextField(
                      hintText: _assignedLeadToController
                              .selectedLeadName.value.isEmpty
                          ? Strings.select
                          : _assignedLeadToController.selectedLeadName.value,
                      categories: formattedCategories,
                      onChanged: (selectedCategory) {
                        final names = selectedCategory.split(' ');
                        if (names.length >= 2) {
                          final firstName = names[0];
                          final lastName = names[1];
                          _assignedLeadToController.selectedLeadName.value =
                              '$firstName $lastName';
                        }
                      },
                    );
                  }
                }),
                const SizedBox(height: 10),
                const Text('Roles *'),
                Obx(() {
                  if (_rolesViewModel.loading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    String initialRole = user.roleList.isNotEmpty
                        ? user.roleList.first.name ?? 'N/A'
                        : 'N/A';
                    return CommonTextField(
                      hintText: 'Select Role',
                      value: initialRole,
                      categories: _rolesViewModel.roles
                          .map((role) => role.name ?? 'N/A')
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedRole = newValue;
                        });
                        print('Selected Role: $newValue');
                      },
                    );
                  }
                }),
                const SizedBox(height: 10),
                const Text('Change Password *'),
                CommonTextField(
                  hintText: '************',
                  suffixIcon: const Icon(Icons.remove_red_eye, size: 19),
                  controller: passwordController,
                ),
                const SizedBox(height: 10),
                const Text('Confirm Password *'),
                CommonTextField(
                  hintText: '************',
                  suffixIcon: const Icon(Icons.remove_red_eye, size: 19),
                  controller: confirmPasswordController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final result = await userUpdateViewModel.updateUser(
                  user.id!,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  mobile: mobileController.text,
                  department: selectedDepartment ?? 'Default Department23',
                  parent:
                      _assignedLeadToController.selectedLeadId.value.isNotEmpty
                          ? _assignedLeadToController.selectedLeadId.value
                          : 'Default Parent ID',
                  roleList: [selectedRole ?? 'Default Role'],
                  password: passwordController.text.isNotEmpty
                      ? passwordController.text
                      : null,
                  cpassword: confirmPasswordController.text.isNotEmpty
                      ? confirmPasswordController.text
                      : null,
                );
                if (result) {
                  Utils.snackbarSuccess("Success");
                  Navigator.pop(context);
                  await userListViewModel.userListApi();
                } else {
                  Utils.snackbarFailed(userUpdateViewModel.error);
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}

class OrgChartNode extends StatelessWidget {
  final String initials;
  final String name;
  final String role;
  final Color backgroundColor;
  final VoidCallback onDelete;

  const OrgChartNode({
    super.key,
    required this.initials,
    required this.name,
    required this.role,
    required this.backgroundColor,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: getColorFromString(name),
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color getColorFromString(String input) {
    int hash = input.hashCode;
    return Color((hash & 0xFFFFFF) + 0xFF000000);
  }
}
