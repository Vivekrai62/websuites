import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/iconStrings/icon_strings.dart';
import '../../../resources/strings/strings.dart';
import '../../../resources/svg/svg_string.dart';
import '../../../resources/textStyles/responsive/test_responsive.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';

import '../../../utils/common_responsive_list/common_responsive_list.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/responsive/responsive_utils.dart';
import '../../../viewModels/customerScreens/proformas/CustomerProformaListViewModel.dart';
import '../../../viewModels/leadScreens/createNewLead/constant_controller/constant_controller.dart';
import '../../../viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import '../../../viewModels/leadScreens/lead_list/lead_assign/lead_assign.dart';
import '../../../viewModels/saveToken/save_token.dart';
import '../../homeScreen/home_manager/HomeManagerScreen.dart';

class ThemeController extends GetxController {
  var themeMode = ThemeMode.system.obs;
  final SaveUserData _saveUserData = SaveUserData();

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() async {
    String? theme = await _saveUserData.getString('themeMode');
    if (theme != null) {
      switch (theme) {
        case 'light':
          themeMode.value = ThemeMode.light;
          break;
        case 'dark':
          themeMode.value = ThemeMode.dark;
          break;
          case 'system':
        default:
          themeMode.value = ThemeMode.system;
      }
    }
  }

  void changeTheme(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    _saveUserData.saveString('themeMode', mode.toString().split('.').last);
  }
}

class BottomNavProfileScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const BottomNavProfileScreen({
    super.key,
    required this.scaffoldKey,
  });

  @override
  _BottomNavProfileScreenState createState() => _BottomNavProfileScreenState();
}

class _BottomNavProfileScreenState extends State<BottomNavProfileScreen> {
  final _saveUser = SaveUserData();
  final CustomerProformaListViewModel _viewModel =
  Get.put(CustomerProformaListViewModel());
  final TextEditingController searchController = TextEditingController();
  final ThemeController _themeController = Get.find<ThemeController>();
  bool isFloatingButtonClicked = false;

  final ListLeadAssignViewModel searchAssigned =
  Get.put(ListLeadAssignViewModel());
  final ConstantValueViewModel staticText = Get.put(ConstantValueViewModel());
  final DivisionsViewModel divisionList = Get.put(DivisionsViewModel());
  final HomeManagerController homeController =
  Get.find<HomeManagerController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchAssigned.leadListLeadAssign(context);
      staticText.fetchConstantList(context);
      divisionList.fetchDivisions();
      _viewModel.fetchCustomerProformas();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget _buildProfileHeader() {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
            const Color(0xFF1A1A2E),
            const Color(0xFF16213E),
            const Color(0xFF0F3460),
          ]
              : [
            AllColors.lightPurple,
            AllColors.lightPurple.withOpacity(0.8),
            AllColors.mediumPurple.withOpacity(0.9),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.6)
                : AllColors.mediumPurple.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? Colors.white.withOpacity(0.03)
                    : Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? Colors.white.withOpacity(0.02)
                    : Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? Colors.white.withOpacity(0.02)
                    : Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 40, 25, 50),
            child: Column(
              children: [
                // Profile Avatar
                Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDark
                              ? [
                            const Color(0xFF2A2A3E),
                            const Color(0xFF1E1E2E),
                          ]
                              : [
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF3A3A4E)
                              : Colors.white.withOpacity(0.4),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.4)
                                : Colors.black.withOpacity(0.2),
                            blurRadius: 25,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: isDark
                            ? const Color(0xFF2A2A3E)
                            : Colors.white,
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: isDark
                                  ? [
                                const Color(0xFF3A3A4E),
                                const Color(0xFF2A2A3E),
                              ]
                                  : [
                                Colors.grey[100]!,
                                Colors.grey[200]!,
                              ],
                            ),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: isDark
                                ? const Color(0xFF4FC3F7)
                                : AllColors.mediumPurple.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? const Color(0xFF2A2A3E) : Colors
                                .white,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4CAF50).withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // Name
                Text(
                  'Admin',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Nunito',
                    letterSpacing: 1.0,
                    shadows: [
                      Shadow(
                        color: isDark
                            ? Colors.black.withOpacity(0.5)
                            : Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Role Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2A2A3E).withOpacity(0.8)
                        : Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF4A4A5E)
                          : Colors.white.withOpacity(0.4),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withOpacity(0.3)
                            : Colors.white.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Administrator',
                    style: TextStyle(
                      color: isDark
                          ? const Color(0xFF4FC3F7)
                          : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito',
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Email
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.black.withOpacity(0.2)
                        : Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF3A3A4E)
                          : Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: isDark
                            ? const Color(0xFF4FC3F7)
                            : Colors.white.withOpacity(0.9),
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'admin@test.com',
                        style: TextStyle(
                          color: isDark
                              ? Colors.white.withOpacity(0.9)
                              : Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Edit Profile Button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.3)
                                : Colors.black.withOpacity(0.15),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Add edit profile functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? AllColors.mediumPurple
                              : Colors.white,
                          foregroundColor: isDark
                              ? Colors.white
                              : AllColors.mediumPurple,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              size: 20,
                              color: isDark
                                  ? Colors.white
                                  : AllColors.mediumPurple,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                color: isDark
                                    ? Colors.white
                                    : AllColors.mediumPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Settings Button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF4A4A5E)
                              : Colors.white.withOpacity(0.4),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.2)
                                : Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Add settings functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: isDark
                              ? AllColors.mediumPurple
                              : Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Icon(
                          Icons.settings_outlined,
                          size: 22,
                          color: isDark
                              ? AllColors.mediumPurple
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery
        .of(context)
        .size
        .width > 600;
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          setState(() {
            isFloatingButtonClicked = !isFloatingButtonClicked;
          });
        },
        imageIcon: IconStrings.navSearch3,
        backgroundColor: isDark
            ? AllColors.mediumPurple
            : AllColors.lightPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: isDark
          ?  Colors.grey[80]
          : Colors.grey[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomAppBar(
          //
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
          //     child: Row(
          //       children: [
          //         if (!isTablet)
          //           IconButton(
          //             icon: Icon(
          //               Icons.menu,
          //               color: isDark ? Colors.white : Colors.black,
          //             ),
          //             onPressed: () {
          //               if (widget.scaffoldKey.currentState != null) {
          //                 if (!widget.scaffoldKey.currentState!.isDrawerOpen) {
          //                   widget.scaffoldKey.currentState!.openDrawer();
          //                 }
          //               } else {
          //                 debugPrint("Scaffold key has no current state");
          //               }
          //             },
          //           ),
          //         if (isTablet) const SizedBox(width: 15),
          //         if (isTablet)
          //           // IconButton(onPressed: (){
          //           //   homeController.resetOrderDetails();
          //           // }, icon: Icon(
          //           //   Icons.arrow_back_ios,
          //           //   color: isDark ? Colors.white : Colors.black,
          //           // ),),
          //           GestureDetector(
          //             onTap: () {
          //               homeController.resetOrderDetails();
          //             },
          //             child: Icon(
          //               Icons.arrow_back_ios,
          //               color: isDark ? Colors.white : Colors.black,
          //             ),
          //           ),
          //         if (!isTablet) const SizedBox(width: 12),
          //         Text(
          //           'Profile',
          //           style: TextStyle(
          //             color: isDark ? Colors.white : AllColors.blackColor,
          //             fontWeight: FontWeight.w700,
          //             fontFamily: 'Nunito',
          //             fontSize: 18.5,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          CustomAppBar(
            child: Row(
              children: [
                if (ResponsiveUtilsScreenSize.isMobile(context))
                  GestureDetector(
                    onTap: () {
                      widget.scaffoldKey.currentState?.openDrawer();
                    },
                    child: SvgIcon(
                      assetPath: IconStrings.drawer,
                      color: DarkMode.backgroundColor2(context),
                      // size: 22.0,
                    ),
                  ),
                if (ResponsiveUtilsScreenSize.isMobile(context))
                  SizedBox(
                    width: 10,

                  ),
                ResponsiveText.getAppBarTextSize(context, Strings.profile),

              ],
            ),
          ),

          Expanded(

            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileHeader(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Account Settings Section
                        Text(
                          'Account Settings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : AllColors.blackColor,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const SizedBox(height: 5),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount;
                            if (constraints.maxWidth > 1200) {
                              crossAxisCount = 4;
                            } else if (constraints.maxWidth > 900) {
                              crossAxisCount = 3;
                            } else if (constraints.maxWidth > 600) {
                              crossAxisCount = 2;
                            } else {
                              crossAxisCount = 1;
                            }
                            return GridView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 5,
                              ),
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                final items = [
                                  {
                                    'title': 'My Profile',
                                    'icon': Icons.person_outline,
                                    'color': const Color(0xFF4FC3F7),
                                    'onTap': () {
                                      // Navigate to profile details
                                    },
                                  },
                                  {
                                    'title': 'Company Profile',
                                    'icon': Icons.business_outlined,
                                    'color': const Color(0xFF66BB6A),
                                    'onTap': () {
                                      // Navigate to company profile
                                    },
                                  },
                                  {
                                    'title': 'Source Integration',
                                    'icon': Icons
                                        .integration_instructions_outlined,
                                    'color': const Color(0xFFFF9800),
                                    'onTap': () {
                                      // Navigate to source integration
                                    },
                                  },
                                  {
                                    'title': 'My Analytics',
                                    'icon': Icons.analytics_outlined,
                                    'color': const Color(0xFF9C27B0),
                                    'onTap': () {
                                      // Navigate to analytics
                                    },
                                    'showBadge': true,
                                    'badgeText': 'New',
                                  },
                                  {
                                    'title': 'Theme Settings',
                                    'icon': Icons.brightness_6_outlined,
                                    'color': const Color(0xFF607D8B),
                                    'onTap': () {
                                      _showThemeDialog(context);
                                    },
                                  },
                                ];

                                final item = items[index];
                                return ProfileMenuItem(
                                  icon: item['icon'] as IconData,
                                  title: item['title'] as String,
                                  onTap: item['onTap'] as VoidCallback,
                                  showBadge: item['showBadge'] as bool? ??
                                      false,
                                  badgeText: item['badgeText'] as String?,
                                  iconColor: item['color'] as Color?,
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 25),
                        // General Section
                        Text(
                          'General',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : AllColors.blackColor,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const SizedBox(height: 5),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount;
                            if (constraints.maxWidth > 1200) {
                              crossAxisCount = 4;
                            } else if (constraints.maxWidth > 900) {
                              crossAxisCount = 3;
                            } else if (constraints.maxWidth > 600) {
                              crossAxisCount = 2;
                            } else {
                              crossAxisCount = 1;
                            }
                            return GridView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 5,
                              ),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                final items = [
                                  {
                                    'title': 'Settings',
                                    'icon': Icons.settings_outlined,
                                    'color': const Color(0xFF4FC3F7),
                                    'onTap': () {
                                      // Navigate to settings
                                    },
                                  },
                                  {
                                    'title': 'Help & Support',
                                    'icon': Icons.help_outline,
                                    'color': const Color(0xFF66BB6A),
                                    'onTap': () {
                                      // Navigate to help
                                    },
                                  },
                                  {
                                    'title': 'Privacy Policy',
                                    'icon': Icons.privacy_tip_outlined,
                                    'color': const Color(0xFF607D8B),
                                    'onTap': () {
                                      // Navigate to privacy policy
                                    },
                                  },
                                  {
                                    'title': 'Logout',
                                    'icon': Icons.logout,
                                    'color': const Color(0xFFE53935),
                                    'onTap': () => _showLogoutDialog(context),
                                  },
                                ];

                                final item = items[index];
                                return ProfileMenuItem(
                                  icon: item['icon'] as IconData,
                                  title: item['title'] as String,
                                  onTap: item['onTap'] as VoidCallback,
                                  iconColor: item['color'] as Color?,
                                  textColor: item['title'] == 'Logout'
                                      ? const Color(0xFFE53935)
                                      : null,
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark
              ? const Color(0xFF1A1A1A)
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: Text(
            'Select Theme',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: 'Nunito',
              fontSize: 20,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          content: Obx(() =>
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildThemeOption(
                    'Light Mode',
                    Icons.light_mode_outlined,
                    ThemeMode.light,
                    const Color(0xFFFF9800),
                  ),
                  const SizedBox(height: 8),
                  _buildThemeOption(
                    'Dark Mode',
                    Icons.dark_mode_outlined,
                    ThemeMode.dark,
                    const Color(0xFF4FC3F7),
                  ),
                  const SizedBox(height: 8),
                  _buildThemeOption(
                    'System Mode',
                    Icons.brightness_auto_outlined,
                    ThemeMode.system,
                    const Color(0xFF66BB6A),
                  ),
                ],
              )),
        );
      },
    );
  }

  Widget _buildThemeOption(String title, IconData icon, ThemeMode mode,
      Color color) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final isSelected = _themeController.themeMode.value == mode;

    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? color.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected
              ? color
              : (isDark ? const Color(0xFF2A2A2A) : Colors.grey[300]!),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: RadioListTile<ThemeMode>(
        title: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? color : (isDark ? Colors.white70 : Colors
                  .black54),
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? color
                    : (isDark ? Colors.white : Colors.black),
              ),
            ),
          ],
        ),
        value: mode,
        groupValue: _themeController.themeMode.value,
        activeColor: color,
        onChanged: (ThemeMode? value) {
          if (value != null) {
            _themeController.changeTheme(value);
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme
              .of(context)
              .brightness == Brightness.dark
              ? Colors.grey[900]
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito', // Changed to Nunito
              color: Theme
                  .of(context)
                  .brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontFamily: 'Nunito', // Changed to Nunito
              color: Theme
                  .of(context)
                  .brightness == Brightness.dark
                  ? Colors.grey[300]
                  : Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Colors.grey[400]
                      : Colors.grey[600],
                  fontFamily: 'Nunito', // Changed to Nunito
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _saveUser.removeUser();
                Get.offNamed('/login_screen');
                Get.snackbar('Logout', 'Logout Successful');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Nunito', // Changed to Nunito
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}