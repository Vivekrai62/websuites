import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../resources/iconStrings/icon_strings.dart';
import '../utils/appColors/app_colors.dart';
import '../utils/components/buttons/common_button.dart';
import '../utils/components/widgets/drawer/drawerListTiles/custom_list_tile.dart';
import '../utils/components/widgets/drawer/drawerListTiles/expandedListTile.dart';
import '../viewModels/saveToken/save_token.dart';

class CustomDrawer extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final bool isCollapsed;
  final VoidCallback? onCollapseToggle;
  final bool isTabletOrDesktop;

  const CustomDrawer({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.isTabletOrDesktop,
    this.isCollapsed = false,
    this.onCollapseToggle,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? expandedSection;
  bool isLocalCollapsed = false;
  final _saveUser = SaveUserData();

  @override
  void initState() {
    super.initState();
    isLocalCollapsed = widget.isCollapsed;
  }

  void toggleDrawerWithSection(String section) {
    setState(() {
      if (isLocalCollapsed) {
        isLocalCollapsed = false;
        expandedSection = section;
      } else if (expandedSection == section) {
        isLocalCollapsed = true;
        expandedSection = null;
      } else {
        expandedSection = section;
      }
    });
    widget.onCollapseToggle?.call();
  }

  Widget buildExpandedContent() {
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
      CustomListTile(
      leadIconImage: IconStrings.dashboard,
      title: 'Dashboard',
      onTap: () => widget.onItemSelected(0),
      selectedIndex: widget.selectedIndex,
    ),
    CustomExpandedListTile(
    leadingIconImage: IconStrings.lead,
    title: 'Lead',
    initiallyExpanded: expandedSection == 'lead',
    children: List.generate(
    7,
    (index) => ListTile(
    onTap: () => widget.onItemSelected(index + 1),
    title: Text(
    '• ${["Create", "Google Leads", "List", "Trash", "Activities", "Setting", "(Lead) Master"][index]}',
    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),
    ),
    ),
    CustomExpandedListTile(
    title: 'Customer',
    leadingIconImage: IconStrings.customer,
    initiallyExpanded: expandedSection == 'customer',
    children: [
    ListTile(
    onTap: () => widget.onItemSelected(8),
    title: Text(
    '• List',
    style: TextStyle(color: AllColors.welcomeColor, fontSize: 14, fontWeight: FontWeight.w300),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(9),
    title: Text(
    '• Activities',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),

    ),
    ),


    ListTile(
    onTap: () => widget.onItemSelected(10),
    title: Text(
    '• Payment Reminder',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14,),
    maxLines: 2, // Allow up to 2 lines
    overflow: TextOverflow.visible, // Allow text to overflow and wrap
    textAlign: TextAlign.start, // Align text to the sta
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(11),
    title: Text(
    '• Companies',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(12),
    title: Text(
    '• Services',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(13),
    title: Text(
    '• Order Products',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),
    ],
    ),


    CustomExpandedListTile(
    title: 'Orders',
    leadingIconImage: IconStrings.orders,
    initiallyExpanded: expandedSection == 'orders',
    children: [
    ListTile(
    onTap: () => widget.onItemSelected(14),
    title: Text(
    '• List',
    style: TextStyle(color: AllColors.welcomeColor, fontSize: 14, fontWeight: FontWeight.w300),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(15),
    title: Text(
    '• Activities',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(16),
    title: Text(
    '• Proforma List',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),

    ListTile(
    onTap: () => widget.onItemSelected(17),
    title: Text(
    '• Payments',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(18),
    title: Text(
    '• Projection',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),

    ListTile(
    onTap: () => widget.onItemSelected(19),
    title: Text(
    '• Order(Master)',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),

    ],
    ),

        CustomExpandedListTile(
            title: 'Sales',
            leadingIconImage: IconStrings.tasks,
            children: [
              ListTile(
                onTap: () => widget.onItemSelected(20),
                title: Text(
                  '• Targets',
                  style: TextStyle(
                    color: AllColors.welcomeColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              ListTile(
                onTap: () => widget.onItemSelected(21),
                title: Text(
                  '• Projections',
                  style: TextStyle(
                      color: AllColors.welcomeColor,

                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
              ),



            ]),

    CustomListTile(
    leadIconImage: IconStrings.roles,
    title: 'Roles',
    onTap: () => widget.onItemSelected(22),
    selectedIndex: widget.selectedIndex,
    ),


    CustomExpandedListTile(
    title: 'Reports',
    leadingIconImage: IconStrings.orders,
    initiallyExpanded: expandedSection == 'Reports',
    children: [
    ListTile(
    onTap: () => widget.onItemSelected(23),
    title: Text(
    '• Analytics',
    style: TextStyle(color: AllColors.welcomeColor, fontSize: 14, fontWeight: FontWeight.w300),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(5),
    title: Text(
    '• Lead Activities',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(24),
    title: Text(
    '• Task Report',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),

    ListTile(
    onTap: () => widget.onItemSelected(25),
    title: Text(
    '• Employees Report',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),


    ],
    ),

    CustomExpandedListTile(
    title: 'Task',
    leadingIconImage: IconStrings.tasks,
    initiallyExpanded: expandedSection == 'Task',
    children: [
    ListTile(
    onTap: () => widget.onItemSelected(26),
    title: Text(
    '• List',
    style: TextStyle(color: AllColors.welcomeColor, fontSize: 14, fontWeight: FontWeight.w300),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(27),
    title: Text(
    '• Master',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),


    ],
    ),
    CustomExpandedListTile(
    title: 'Project',
    leadingIconImage: IconStrings.tasks,
    initiallyExpanded: expandedSection == 'Project',
    children: [
    ListTile(
    onTap: () => widget.onItemSelected(28),
    title: Text(
    '• List',
    style: TextStyle(color: AllColors.welcomeColor, fontSize: 14, fontWeight: FontWeight.w300),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(29),
    title: Text(
    '• Master',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),


    ],
    ),
    CustomExpandedListTile(
    title: 'Products',
    leadingIconImage: IconStrings.tasks,
    initiallyExpanded: expandedSection == 'Products',
    children: [
    ListTile(
    onTap: () => widget.onItemSelected(30),
    title: Text(
    '• List',
    style: TextStyle(color: AllColors.welcomeColor, fontSize: 14, fontWeight: FontWeight.w300),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(31),
    title: Text(
    '• Category',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(32),
    title: Text(
    '• Brand',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(33),
    title: Text(
    '• GST List',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),

    ListTile(
    onTap: () => widget.onItemSelected(34),
    title: Text(
    '• Master',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),


    ],
    ),

    CustomExpandedListTile(
    title: 'User',
    leadingIconImage: IconStrings.tasks,
    initiallyExpanded: expandedSection == 'User',
    children: [
    ListTile(
    onTap: () => widget.onItemSelected(35),
    title: Text(
    '• List',
    style: TextStyle(color: AllColors.welcomeColor, fontSize: 14, fontWeight: FontWeight.w300),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(36),
    title: Text(
    '• Roles',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(37),
    title: Text(
    '• Departments',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(38),
    title: Text(
    '• Activities',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),


    ],
    ),

    CustomExpandedListTile(
    title: 'Setting',
    leadingIconImage: IconStrings.tasks,
    initiallyExpanded: expandedSection == 'Setting',
    children: [
      ListTile(
        onTap: () => widget.onItemSelected(39),
        title: Text(
          '• Divisions',
          style: TextStyle(color: AllColors.welcomeColor, fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ),
    ListTile(
    onTap: () => widget.onItemSelected(40),
    title: Text(
    '• Divisions',
    style: TextStyle(color: AllColors.welcomeColor, fontSize: 14, fontWeight: FontWeight.w300),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(41),
    title: Text(
    '• Proposals',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),
    ListTile(
    onTap: () => widget.onItemSelected(42),
    title: Text(
    '• Cities',
    style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
    ),
    ),



    ],
    ),


        CustomExpandedListTile(
          title: 'Analytics',
          leadingIconImage: IconStrings.tasks,
          initiallyExpanded: expandedSection == 'Setting',
          children: [
            ListTile(
              onTap: () => widget.onItemSelected(42),
              title: Text(
                '• Sale Analytics',
                style: TextStyle(color: AllColors.welcomeColor, fontSize: 14, fontWeight: FontWeight.w300),
              ),
            ),

            ListTile(
              onTap: () => widget.onItemSelected(43),
              title: Text(
                '• Lead Analytics',
                style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () => widget.onItemSelected(44),
              title: Text(
                '• Customer Analytics',
                style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () => widget.onItemSelected(45),
              title: Text(
                '• PH Performance',
                style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
              ),
            ),


          ],
        ),
        CustomExpandedListTile(
          title: 'Hrm',
          leadingIconImage: IconStrings.tasks,
          initiallyExpanded: expandedSection == 'Setting',
          children: [
            ListTile(
              onTap: () => widget.onItemSelected(46),
              title: Text(
                '• Attendance',
                style: TextStyle(color: AllColors.welcomeColor, fontSize: 14, fontWeight: FontWeight.w300),
              ),
            ),

            ListTile(
              onTap: () => widget.onItemSelected(47),
              title: Text(
                '• Leave',
                style: TextStyle(color: AllColors.welcomeColor, fontWeight: FontWeight.w300, fontSize: 14),
              ),
            ),



          ],
        ),
      ]

    );
  }

  Widget buildCollapsedContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: IconButton(
            icon: Image.asset(IconStrings.dashboard, width: 40),
            onPressed: () => widget.onItemSelected(0),
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: IconButton(
            icon: Image.asset(IconStrings.lead, width: 40),
            onPressed: () => toggleDrawerWithSection('lead'),
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: IconButton(
            icon: Image.asset(IconStrings.customer, width: 40),
            onPressed: () => toggleDrawerWithSection('customer'),
          ),
        ),
      ],
    );
  }

  Widget buildHeader() {
    if (isLocalCollapsed) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/WHLogo.png',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/WHLogo.png',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Webhopers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isLocalCollapsed ? 80 : 200,
      color: Colors.white,
      child: Column(
        children: [
          // Header with logo
          buildHeader(),
          // Navigation items
          Expanded(
            child: isLocalCollapsed
                ? buildCollapsedContent()
                : buildExpandedContent(),
          ),
          // Collapse toggle button and Logout
          Column(
            children: [
              if (widget.isTabletOrDesktop)
                IconButton(
                  icon: Icon(
                    isLocalCollapsed ? Icons.arrow_forward_ios : Icons
                        .arrow_back_ios,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    setState(() {
                      isLocalCollapsed = !isLocalCollapsed;
                      if (isLocalCollapsed) expandedSection = null;
                    });
                    widget.onCollapseToggle?.call();
                  },
                ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: CommonButton(
                  height: 40,
                  width: isLocalCollapsed ? 60 : 120,
                  title: 'Logout',
                  onPress: () {
                    _saveUser.removeUser();
                    Get.offNamed('/login_screen');
                    Get.snackbar('Logout', 'Logout Successful');
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}