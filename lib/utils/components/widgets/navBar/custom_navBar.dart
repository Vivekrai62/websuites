import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../resources/svg/svg_string.dart';
import 'package:websuites/resources/iconStrings/icon_strings.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/views/homeScreen/home_manager/HomeManagerScreen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int? currentIndex; // Made optional
  final ValueChanged<int>? onTap; // Made optional
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const CustomBottomNavBar({
    Key? key,
    this.currentIndex,
    this.onTap,
    this.scaffoldKey,
  }) : super(key: key);

  static final List<Map<String, dynamic>> _navItems = [
    {
      'icon': IconStrings.navDashboard,
      'nav': 'Dashboard',
      'subNav': '',
    },
    {
      'icon': IconStrings.navChat,
      'nav': 'Customer',
      'subNav': 'Create',
    },
    {
      'icon': IconStrings.navNotification2,
      'nav': 'Notifications',
      'subNav': '',
    },
    {
      'icon': IconStrings.navAccount3,
      'nav': 'Profile',
      'subNav': '',
    },
  ];

  Widget _buildNavItem(
      int index, Map<String, dynamic> item, BuildContext context) {
    final HomeManagerController controller = Get.find<HomeManagerController>();
    // Determine if the item is selected by comparing nav and subNav
    final bool isSelected = controller.selectedNav.value == item['nav'] &&
        controller.selectedSubNav.value == item['subNav'];

    return GestureDetector(
      onTap: () {
        // Update the navigation in HomeManagerController
        controller.updateNavigation(item['nav'], item['subNav']);
        // Call onTap if provided
        if (onTap != null) {
          onTap!(index);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 21, right: 21),
        child: SvgIcon(
          assetPath: item['icon'],
          size: 25.0,
          color: isSelected
              ? AllColors.mediumPurple
              : Theme.of(context).brightness == Brightness.dark
                  ? AllColors.bottomNavColor
                  : AllColors.bottomNavColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    if (!isMobile) return const SizedBox.shrink();

    return BottomAppBar(
      elevation: 0,
      height: Get.height / 15,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black12
          : Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNavItem(0, _navItems[0], context),
              _buildNavItem(1, _navItems[1], context),
            ],
          ),
          const SizedBox(width: 40),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNavItem(2, _navItems[2], context),
              _buildNavItem(3, _navItems[3], context),
            ],
          ),
        ],
      ),
    );
  }
}
