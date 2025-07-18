// import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'dart:math' as math;

import 'package:websuites/utils/components/widgets/navBar/custom_navBar.dart';
import 'package:websuites/utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import 'package:websuites/utils/components/widgets/sizedBoxes/sized_box_components.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/views/homeScreen/widgets/cards/lead_type_count_card.dart';
import 'package:websuites/views/homeScreen/widgets/cards/transaction_list_card.dart';
import '../../data/models/responseModels/login/login_response_model.dart';
import '../../resources/imageStrings/image_strings.dart';
import '../../resources/strings/strings.dart';
import '../../resources/textStyles/text_styles.dart';
import '../../utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import '../../utils/commonfilter/FilterBottomSheet.dart';

import '../../utils/dark_mode/dark_mode.dart';
import '../../viewModels/dashboard/main_dashboard/MainDashboardListViewModel.dart';
import '../../viewModels/userlistViewModel/userlist_viewModel.dart';
import '../../viewModels/master/divisions/master_divisions_viewModel.dart';
import '../../viewModels/saveToken/save_token.dart';
import '../../utils/container_Utils/ContainerUtils.dart';

import '../../resources/iconStrings/icon_strings.dart';

import '../Master/dashboard/SettingDashboardScreen.dart';
import '../analytics/sale/SaleAnalyticsScreen.dart';
import '../bottomNavBarScreen/profile_Screen/bottom__nav_profile_screen.dart';
import '../notification/NotificationScreen.dart';
import 'home_manager/HomeManagerScreen.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomeScreen({
    super.key,
    required this.scaffoldKey,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PieChartController tabController = Get.put(PieChartController());
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  late final MainDashboardListViewModel _dashboardListController;
  late final UserListViewModel userListViewModel;
  late final MasterDivisionsViewModel divisionViewModel;
  final SaleAnalyticsController controller = Get.put(SaleAnalyticsController());
  bool isFloatingButtonClicked = false;
  bool showFirstChart = false;

  String userName = '';
  String? userEmail = "";
  final SaveUserData userPreference = SaveUserData();

  @override
  void initState() {
    super.initState();
    _dashboardListController =
        Get.put(MainDashboardListViewModel(), permanent: true);
    userListViewModel = Get.put(UserListViewModel(), permanent: true);
    divisionViewModel = Get.put(MasterDivisionsViewModel(), permanent: true);
    fetchUserData().then((_) {
      Future.wait([
        userListViewModel.userListApi(),
        divisionViewModel.masterDivisions(context),
      ]);
    });
  }

  Future<void> fetchUserData() async {
    try {
      LoginResponseModel response = await userPreference.getUser();
      setState(() {
        userName = response.user?.firstName ?? '';
        userEmail = response.user?.email ?? '';
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    FontWeight getFontWeight(int value) {
      if (value <= 100) return FontWeight.w100;
      if (value <= 200) return FontWeight.w200;
      if (value <= 300) return FontWeight.w300;
      if (value <= 400) return FontWeight.w400;
      if (value <= 500) return FontWeight.w500;
      if (value <= 600) return FontWeight.w600;
      if (value <= 700) return FontWeight.w700;
      if (value <= 800) return FontWeight.w800;
      return FontWeight.w900; // If it's greater than 800, return w900
    }

    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      key: _globalKey,

      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          setState(() {
            isFloatingButtonClicked =
                !isFloatingButtonClicked; // Toggle the state
          });
        },
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,

        // backgroundColor:Theme
        //     .of(context)
        //     .brightness == Brightness.dark
        //     ? AllColors.mediumPurple
        //     : AllColors.mediumPurple,     // you can apply when you nedd in dark mode
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: DarkMode.backgroundColor(context),

      // drawer: CustomDrawer(
      //   userName: userName,
      //   phoneNumber: userEmail ?? '',
      //   version: 'VERSION 1.0.12',
      // ),
      body: Obx(() {
        if (_dashboardListController.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () async {
            await _dashboardListController.fetchDashboardData();
            _dashboardListController.resetFilters();
            await _dashboardListController.refreshAllData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 190,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? [
                                        AllColors.appBarColorTop,
                                        AllColors.appBarColorBottom,
                                      ]
                                    : [
                                        AllColors.appBarColorTop,
                                        AllColors.appBarColorBottom,
                                      ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              // Added subtle border for better definition
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                                width: 0.5,
                              ),
                              // Optional: Add subtle shadow for depth
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(8, 7.2.h, 15, 0),
                                child: Row(
                                  children: [
                                    // IconButton(
                                    //   onPressed: () => _globalKey.currentState?.openDrawer(),
                                    //   icon: const Icon(Icons.menu),
                                    //   iconSize: 30,
                                    //   color: AllColors.whiteColor,
                                    // ),

                                    if (!isTablet)
                                      IconButton(
                                        icon: const Icon(Icons.menu,
                                            size: 36, color: Colors.white),
                                        onPressed: () {
                                          widget.scaffoldKey.currentState
                                              ?.openDrawer();
                                        },
                                      ),

                                    SizedBox(width: 1.h),

                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hello, $userName !',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.5,
                                            color: AllColors.whiteColor,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('MMM dd, yyyy hh:mm a')
                                              .format(DateTime.now()),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11.5,
                                            color: AllColors.whiteColor,
                                            fontFamily: FontFamily.sfPro,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    if (isTablet)
                                      GestureDetector(
                                        onTap: () {
                                          final controller =
                                              Get.find<HomeManagerController>();
                                          controller.updateNavigation(
                                              'Notifications', '');
                                        },
                                        child: SvgPicture.asset(
                                          IconStrings.navNotification2,
                                          height: 20,
                                          width: 20,
                                          color: AllColors.whiteColor,
                                        ),
                                      ),
                                    if (isTablet) SizedBox(width: 2.h),
                                    InkWell(
                                      onTap: () =>
                                          openFilterBottomSheet(context),
                                      child: const Icon(
                                        Icons.filter_list,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 2.h),
                                    InkWell(
                                      onTap: () {
                                        print("Profile InkWell tapped");
                                        try {
                                          final controller =
                                              Get.find<HomeManagerController>();
                                          controller.updateNavigation(
                                              'Profile', '');
                                        } catch (e) {
                                          print(
                                              "Error finding HomeManagerController: $e");
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AllColors.whiteColor,
                                        ),
                                        height: 30,
                                        width: 40,
                                        child: Center(
                                          child: Image.asset(
                                            ImageStrings.welcomeCompanyLogo,
                                            scale: 5.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Scrollable revenue card

                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: TextStyles.defaultPadding(context),
                                  child: Row(
                                    children: [
                                      //New
                                      ContainerUtils(
                                        margin: EdgeInsets.fromLTRB(
                                            18, 2.5.h, 4, 0.5.h),

                                        // padding: const EdgeInsets.fromLTRB(
                                        //     15, 10, 15, 17),
                                        // decoration: BoxDecoration(
                                        //   color: Colors.white,
                                        //   borderRadius:
                                        //   BorderRadius.circular(10),
                                        //   boxShadow: [
                                        //     BoxShadow(
                                        //       color: Colors.black45
                                        //           .withOpacity(0.06),
                                        //       spreadRadius: 0.5,
                                        //       blurRadius: 4,
                                        //       offset: const Offset(0, 3),
                                        //     ),
                                        //   ],
                                        // ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 18),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      AllColors.lighterPurple,
                                                ),
                                                width: 35,
                                                height: 35,
                                                child: Center(
                                                  child: Text(
                                                    '₹',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: AllColors
                                                          .mediumPurple,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() {
                                                  final hasData =
                                                      _dashboardListController
                                                          .leadCards.isNotEmpty;
                                                  return Text(
                                                    hasData
                                                        ? '₹ ${_dashboardListController.leadCards[0].mainDashLeadCardListRespoModelNew}'
                                                        : '₹ 0',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: DarkMode
                                                          .backgroundColor2(
                                                              context),
                                                    ),
                                                  );
                                                }),
                                                Text(
                                                  'Total Revenue',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: DarkMode
                                                        .backgroundColor2(
                                                            context),
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: AllColors
                                                          .background_green,
                                                      radius: 8,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_upward_sharp,
                                                        size: 11,
                                                        color: AllColors
                                                            .text__green,
                                                      ),
                                                    ),
                                                    Text(
                                                      '  0.5%(30 Days)',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: DarkMode
                                                            .backgroundColor2(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      //In progress
                                      ContainerUtils(
                                        margin: EdgeInsets.fromLTRB(
                                            8, 2.5.h, 4, 0.5.h),
                                        // padding: const EdgeInsets.fromLTRB(
                                        //     15, 10, 15, 17),
                                        // decoration: BoxDecoration(
                                        //   color: Colors.white,
                                        //   borderRadius:
                                        //   BorderRadius.circular(10),
                                        //   boxShadow: [
                                        //     BoxShadow(
                                        //       color: Colors.black45
                                        //           .withOpacity(0.06),
                                        //       spreadRadius: 0.5,
                                        //       blurRadius: 4,
                                        //       offset: const Offset(0, 3),
                                        //     ),
                                        //   ],
                                        // ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 18),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      AllColors.lighterPurple,
                                                ),
                                                width: 35,
                                                height: 35,
                                                child: Center(
                                                  child: Text(
                                                    '₹',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: AllColors
                                                          .mediumPurple,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() {
                                                  final hasData =
                                                      _dashboardListController
                                                          .leadCards.isNotEmpty;
                                                  return Text(
                                                    hasData
                                                        ? '₹ ${_dashboardListController.leadCards[0].inProgress}'
                                                        : '₹ 0',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: DarkMode
                                                          .backgroundColor2(
                                                              context),
                                                    ),
                                                  );
                                                }),
                                                Text(
                                                  'Total Revenue',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: DarkMode
                                                        .backgroundColor2(
                                                            context),
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          AllColors.lightPurple,
                                                      radius: 8,
                                                      child: Icon(
                                                        Icons
                                                            .lock_clock_outlined,
                                                        size: 9,
                                                        color: AllColors
                                                            .mediumPurple,
                                                      ),
                                                    ),
                                                    Text(
                                                      '  0.5%(30 Days)',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: DarkMode
                                                            .backgroundColor2(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      //Repeat
                                      ContainerUtils(
                                        margin: EdgeInsets.fromLTRB(
                                            8, 2.5.h, 4, 0.5.h),
                                        // padding: const EdgeInsets.fromLTRB(
                                        //     15, 10, 15, 17),
                                        // decoration: BoxDecoration(
                                        //   color: Colors.white,
                                        //   borderRadius:
                                        //   BorderRadius.circular(10),
                                        //   boxShadow: [
                                        //     BoxShadow(
                                        //       color: Colors.black45
                                        //           .withOpacity(0.06),
                                        //       spreadRadius: 0.5,
                                        //       blurRadius: 4,
                                        //       offset: const Offset(0, 3),
                                        //     ),
                                        //   ],
                                        // ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 18),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      AllColors.lighterPurple,
                                                ),
                                                width: 35,
                                                height: 35,
                                                child: Center(
                                                  child: Text(
                                                    '₹',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: AllColors
                                                          .mediumPurple,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() {
                                                  final hasData =
                                                      _dashboardListController
                                                          .leadCards.isNotEmpty;
                                                  return Text(
                                                    hasData
                                                        ? '₹ ${_dashboardListController.leadCards[0].repeat}'
                                                        : '₹ 0',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: DarkMode
                                                          .backgroundColor2(
                                                              context),
                                                    ),
                                                  );
                                                }),
                                                Text(
                                                  'Total Revenue',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: DarkMode
                                                        .backgroundColor2(
                                                            context),
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          AllColors.lightRed,
                                                      radius: 8,
                                                      child: Icon(
                                                        Icons
                                                            .compare_arrows_sharp,
                                                        size: 9,
                                                        color:
                                                            AllColors.darkRed,
                                                      ),
                                                    ),
                                                    Text(
                                                      '  0.5%(30 Days)',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: DarkMode
                                                            .backgroundColor2(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      //TO DO LEADS
                                      ContainerUtils(
                                        margin: EdgeInsets.fromLTRB(
                                            8, 2.5.h, 4, 0.5.h),
                                        // padding: const EdgeInsets.fromLTRB(
                                        //     15, 10, 15, 17),
                                        // decoration: BoxDecoration(
                                        //   color: Colors.white,
                                        //   borderRadius:
                                        //   BorderRadius.circular(10),
                                        //   boxShadow: [
                                        //     BoxShadow(
                                        //       color: Colors.black45
                                        //           .withOpacity(0.06),
                                        //       spreadRadius: 0.5,
                                        //       blurRadius: 4,
                                        //       offset: const Offset(0, 3),
                                        //     ),
                                        //   ],
                                        // ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 18),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      AllColors.lighterPurple,
                                                ),
                                                width: 35,
                                                height: 35,
                                                child: Center(
                                                  child: Text(
                                                    '₹',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: AllColors
                                                          .mediumPurple,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() {
                                                  final hasData =
                                                      _dashboardListController
                                                          .leadCards.isNotEmpty;
                                                  return Text(
                                                    hasData
                                                        ? '₹ ${_dashboardListController.leadCards[0].unassigned}'
                                                        : '₹ 0',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: DarkMode
                                                          .backgroundColor2(
                                                              context),
                                                    ),
                                                  );
                                                }),
                                                Text(
                                                  'Total Revenue',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: DarkMode
                                                        .backgroundColor2(
                                                            context),
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: AllColors
                                                          .background_green,
                                                      radius: 8,
                                                      child: Icon(
                                                        Icons
                                                            .person_remove_outlined,
                                                        size: 9,
                                                        color: AllColors
                                                            .text__green,
                                                      ),
                                                    ),
                                                    Text(
                                                      '  0.5%(30 Days)',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: DarkMode
                                                            .backgroundColor2(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      //Un handled
                                      ContainerUtils(
                                        margin: EdgeInsets.fromLTRB(
                                            8, 2.5.h, 4, 0.5.h),
                                        // padding: const EdgeInsets.fromLTRB(
                                        //     15, 10, 15, 17),
                                        // decoration: BoxDecoration(
                                        //   color: Colors.white,
                                        //   borderRadius:
                                        //   BorderRadius.circular(10),
                                        //   boxShadow: [
                                        //     BoxShadow(
                                        //       color: Colors.black45
                                        //           .withOpacity(0.06),
                                        //       spreadRadius: 0.5,
                                        //       blurRadius: 4,
                                        //       offset: const Offset(0, 3),
                                        //     ),
                                        //   ],
                                        // ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 18),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      AllColors.lighterPurple,
                                                ),
                                                width: 35,
                                                height: 35,
                                                child: Center(
                                                  child: Text(
                                                    '₹',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: AllColors
                                                          .mediumPurple,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() {
                                                  final hasData =
                                                      _dashboardListController
                                                          .leadCards.isNotEmpty;
                                                  return Text(
                                                    hasData
                                                        ? '₹ ${_dashboardListController.leadCards[0].unhandled}'
                                                        : '₹ 0',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: DarkMode
                                                          .backgroundColor2(
                                                              context),
                                                    ),
                                                  );
                                                }),
                                                Text(
                                                  'Total Revenue',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: DarkMode
                                                        .backgroundColor2(
                                                            context),
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          AllColors.lightRed,
                                                      radius: 8,
                                                      child: Icon(
                                                        Icons
                                                            .person_remove_outlined,
                                                        size: 9,
                                                        color:
                                                            AllColors.darkRed,
                                                      ),
                                                    ),
                                                    Text(
                                                      '  0.5%(30 Days)',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: DarkMode
                                                            .backgroundColor2(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      //Dead
                                      ContainerUtils(
                                        margin: EdgeInsets.fromLTRB(
                                            8, 2.5.h, 4, 0.5.h),
                                        // padding: const EdgeInsets.fromLTRB(
                                        //     15, 10, 15, 17),
                                        // decoration: BoxDecoration(
                                        //   color: Colors.white,
                                        //   borderRadius:
                                        //   BorderRadius.circular(10),
                                        //   boxShadow: [
                                        //     BoxShadow(
                                        //       color: Colors.black45
                                        //           .withOpacity(0.06),
                                        //       spreadRadius: 0.5,
                                        //       blurRadius: 4,
                                        //       offset: const Offset(0, 3),
                                        //     ),
                                        //   ],
                                        // ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 18),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      AllColors.lighterPurple,
                                                ),
                                                width: 35,
                                                height: 35,
                                                child: Center(
                                                  child: Text(
                                                    '₹',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: AllColors
                                                          .mediumPurple,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() {
                                                  final hasData =
                                                      _dashboardListController
                                                          .leadCards.isNotEmpty;
                                                  return Text(
                                                    hasData
                                                        ? '₹ ${_dashboardListController.leadCards[0].deadLead}'
                                                        : '₹ 0',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: DarkMode
                                                          .backgroundColor2(
                                                              context),
                                                    ),
                                                  );
                                                }),
                                                Text(
                                                  'Total Revenue',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: DarkMode
                                                        .backgroundColor2(
                                                            context),
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          AllColors.lightRed,
                                                      radius: 8,
                                                      child: Icon(
                                                        Icons.person_rounded,
                                                        size: 9,
                                                        color:
                                                            AllColors.darkRed,
                                                      ),
                                                    ),
                                                    Text(
                                                      '  0.5%(30 Days)',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: DarkMode
                                                            .backgroundColor2(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _dashboardListController
                                  .selectedDashboardCharts.value.length ??
                              0,
                          itemBuilder: (context, index) {
                            // Get the chart name from the controller
                            final chart = _dashboardListController
                                .selectedDashboardCharts.value[index];

                            // Clean the chart name
                            String cleanChart = chart
                                .replaceAll('_', ' ')
                                .replaceAll('*', '')
                                .replaceAll('chart', '')
                                .replaceAll('cards', '')
                                .trim()
                                .toUpperCase();

                            if (index == 0) {
                              return const SizedBox
                                  .shrink(); // Return an empty widget for index 0
                            }

                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      if (index == 1)
                                        const Icon(
                                          Icons.list_alt_outlined,
                                          size: 16,
                                        ),
                                      if (index == 2)
                                        const Icon(
                                          Icons.read_more_rounded,
                                          size: 16,
                                        ),
                                      if (index == 3)
                                        const Icon(
                                          Icons.signal_wifi_statusbar_null,
                                          size: 16,
                                        ),
                                      if (index == 4)
                                        const Icon(
                                          Icons.leaderboard,
                                          size: 16,
                                        ),
                                      if (index == 5)
                                        const Icon(
                                          Icons.person_pin,
                                          size: 16,
                                        ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(cleanChart,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          )),
                                      const Spacer(),
                                      if (index == 1)
                                        Row(
                                          children: [
                                            Obx(() => InkWell(
                                                  onTap: () {
                                                    tabController.isListSelected
                                                            .value =
                                                        true; // Switch to List tab
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.list,
                                                        color: tabController
                                                                .isListSelected
                                                                .value
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        size: 22.5,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      TextStyles.w300_12(
                                                        color: tabController
                                                                .isListSelected
                                                                .value
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        context,
                                                        Strings.leadSourceList,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            const SizedBox(width: 10),
                                            Obx(() => InkWell(
                                                  onTap: () {
                                                    tabController.isListSelected
                                                            .value =
                                                        false; // Switch to Chart tab
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.pie_chart,
                                                        color: !tabController
                                                                .isListSelected
                                                                .value
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      TextStyles.w400_12(
                                                        color: !tabController
                                                                .isListSelected
                                                                .value
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        context,
                                                        Strings.leadSourceChart,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      if (index == 3)
                                        Row(
                                          children: [
                                            Obx(() => InkWell(
                                                  onTap: () {
                                                    tabController.isCusSelected
                                                            .value =
                                                        true; // Switch to List tab
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.list,
                                                        color: tabController
                                                                .isCusSelected
                                                                .value
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        size: 22.5,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      TextStyles.w300_12(
                                                        color: tabController
                                                                .isCusSelected
                                                                .value
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        context,
                                                        Strings.leadSourceList,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            const SizedBox(width: 10),
                                            Obx(() => InkWell(
                                                  onTap: () {
                                                    tabController.isCusSelected
                                                            .value =
                                                        false; // Switch to Chart tab
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.pie_chart,
                                                        color: !tabController
                                                                .isCusSelected
                                                                .value
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      TextStyles.w400_12(
                                                        color: !tabController
                                                                .isCusSelected
                                                                .value
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        context,
                                                        Strings.leadSourceChart,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      if (index == 4)
                                        Row(
                                          children: [
                                            Obx(() => InkWell(
                                                  onTap: () {
                                                    tabController
                                                            .isLeadSourceSelected
                                                            .value =
                                                        true; // Switch to List tab
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.list,
                                                        color: tabController
                                                                .isLeadSourceSelected
                                                                .value
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        size: 22.5,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      TextStyles.w300_12(
                                                        color: tabController
                                                                .isLeadSourceSelected
                                                                .value
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        context,
                                                        Strings.leadSourceList,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            const SizedBox(width: 10),
                                            Obx(() => InkWell(
                                                  onTap: () {
                                                    tabController
                                                            .isLeadSourceSelected
                                                            .value =
                                                        false; // Switch to Chart tab
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.pie_chart,
                                                        color: !tabController
                                                                .isLeadSourceSelected
                                                                .value
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      TextStyles.w400_12(
                                                        color: !tabController
                                                                .isLeadSourceSelected
                                                                .value
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        context,
                                                        Strings.leadSourceChart,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      if (index == 5)
                                        InkWell(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              Text(
                                                Strings.latestCustomerSeeAll,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: AllColors.vividPurple,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12,
                                                color: AllColors.vividPurple,
                                              )
                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                                  if (index == 1 &&
                                      _dashboardListController
                                          .leadType.isNotEmpty)
                                    Obx(() {
                                      if (tabController.isListSelected.value) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: _dashboardListController
                                              .leadType.length,
                                          itemBuilder: (context, index) {
                                            final leadType =
                                                _dashboardListController
                                                    .leadType[index];
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    // SCROLLER ROW WITH CONTAINERS
                                                    children: [
                                                      LeadTypeCountCard(
                                                        count:
                                                            "${leadType.leadCount ?? 'Not available'} Leads",
                                                        statusText:
                                                            leadType.name ??
                                                                'Not available',
                                                        countColor:
                                                            Colors.black,
                                                        statusColor:
                                                            Colors.grey,
                                                        icon: Icons.bed_rounded,
                                                        iconColor: Colors.blue,
                                                        containerColor:
                                                            Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: 200,
                                                height: 190,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    GetX<PieChartController>(
                                                      init:
                                                          PieChartController(),
                                                      builder: (controller) {
                                                        return PieChart(
                                                          PieChartData(
                                                            sectionsSpace: 0,
                                                            borderData:
                                                                FlBorderData(
                                                                    show:
                                                                        false),
                                                            pieTouchData:
                                                                PieTouchData(
                                                              touchCallback:
                                                                  (FlTouchEvent
                                                                          event,
                                                                      pieTouchResponse) {
                                                                if (!event
                                                                        .isInterestedForInteractions ||
                                                                    pieTouchResponse ==
                                                                        null ||
                                                                    pieTouchResponse
                                                                            .touchedSection ==
                                                                        null) {
                                                                  // Set touched index to -1 when no section is touched
                                                                  controller
                                                                      .setTouchedIndex(
                                                                          -1);
                                                                  return;
                                                                }
                                                                // Set touched index based on the touched section
                                                                controller.setTouchedIndex(
                                                                    pieTouchResponse
                                                                        .touchedSection!
                                                                        .touchedSectionIndex);
                                                              },
                                                            ),
                                                            sections: List.generate(
                                                                _dashboardListController
                                                                    .leadType
                                                                    .length,
                                                                (i) {
                                                              final isTouched = i ==
                                                                  controller
                                                                      .touchedIndex
                                                                      .value;
                                                              final fontSize =
                                                                  isTouched
                                                                      ? 12.0
                                                                      : 12.0;
                                                              final radius =
                                                                  isTouched
                                                                      ? 52.0
                                                                      : 48.0;

                                                              // Get the lead type for the current index
                                                              final leadType =
                                                                  _dashboardListController
                                                                      .leadType[i];
                                                              // Get numerical lead count from leadType, defaulting to 0 if null
                                                              final double
                                                                  leadCount =
                                                                  (leadType.leadCount ??
                                                                          0)
                                                                      .toDouble();

                                                              switch (i) {
                                                                case 0: // Blue section
                                                                  return PieChartSectionData(
                                                                    color: Colors
                                                                        .blue,
                                                                    value:
                                                                        leadCount, // Use actual lead count
                                                                    title:
                                                                        '${leadCount.toInt()}00%', // Update this based on actual data
                                                                    radius:
                                                                        radius,
                                                                    titleStyle: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            fontSize,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  );
                                                                case 1: // Red section
                                                                  return PieChartSectionData(
                                                                    color: Colors
                                                                        .red,
                                                                    value:
                                                                        10, // Replace with actual data
                                                                    title:
                                                                        '0%', // Update this based on actual data
                                                                    radius:
                                                                        radius,
                                                                    titleStyle: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            fontSize,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  );
                                                                case 2: // Purple section
                                                                  return PieChartSectionData(
                                                                    color: Colors
                                                                        .purple,
                                                                    value:
                                                                        10, // Replace with actual data
                                                                    title:
                                                                        '0%', // Update this based on actual data
                                                                    radius:
                                                                        radius,
                                                                    titleStyle:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          fontSize,
                                                                    ),
                                                                  );
                                                                case 3: // Orange section
                                                                  return PieChartSectionData(
                                                                    color: Colors
                                                                        .orange,
                                                                    value:
                                                                        0, // Replace with actual data
                                                                    title:
                                                                        '0%', // Update this based on actual data
                                                                    radius:
                                                                        radius,
                                                                    titleStyle:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          fontSize,
                                                                    ),
                                                                  );
                                                                default:
                                                                  throw Error();
                                                              }
                                                            }),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    // Center text displaying the total
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Total', // Total label
                                                          style: TextStyle(
                                                            fontSize: 23,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${_dashboardListController.leadType.fold(0, (sum, lead) => sum + (lead.leadCount ?? 0))}', // Total value
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 7,
                                                        backgroundColor:
                                                            Colors.blue,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        "Hot",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              FontFamily.sfPro,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // Row(
                                                  //   children: [
                                                  //     CircleAvatar(
                                                  //       radius: 7,
                                                  //       backgroundColor: Colors.yellow,
                                                  //     ),
                                                  //     SizedBox(width: 8),
                                                  //     Text(
                                                  //       "Cold",
                                                  //       style: TextStyle(
                                                  //         fontWeight: FontWeight.w500,
                                                  //         fontFamily: FontFamily.sfPro,
                                                  //         fontSize: 16,
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // Row(
                                                  //   children: [
                                                  //     CircleAvatar(
                                                  //       radius: 7,
                                                  //       backgroundColor: Colors.red,
                                                  //     ),
                                                  //     SizedBox(width: 8),
                                                  //     Text(
                                                  //       "Dead",
                                                  //       style: TextStyle(
                                                  //         fontWeight: FontWeight.w500,
                                                  //         fontFamily: FontFamily.sfPro,
                                                  //         fontSize: 16,
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // Row(
                                                  //   children: [
                                                  //     CircleAvatar(
                                                  //       radius: 7,
                                                  //       backgroundColor: Colors.purple,
                                                  //     ),
                                                  //     SizedBox(width: 8),
                                                  //     Text(
                                                  //       "FollowUp",
                                                  //       style: TextStyle(
                                                  //         fontWeight: FontWeight.w400,
                                                  //         fontFamily: FontFamily.sfPro,
                                                  //         fontSize: 16,
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    }),
                                  if (index == 2 &&
                                      _dashboardListController
                                          .leadReminder.isNotEmpty)
                                    Obx(() {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _dashboardListController
                                            .leadReminder.length,
                                        // Use leadSources length
                                        itemBuilder: (context, index) {
                                          final leadReminder =
                                              _dashboardListController
                                                      .leadReminder[
                                                  index]; // Get the lead source at the current index
                                          return
                                              //   Row(
                                              //   children: [
                                              //     Padding(
                                              //       padding: const EdgeInsets
                                              //           .symmetric(
                                              //           vertical: 8.0),
                                              //       child:
                                              //
                                              //
                                              //           SingleChildScrollView(
                                              //             scrollDirection: Axis.horizontal,
                                              //             child: Row(
                                              //               children: [
                                              //                 LeadTypeCountCard(
                                              //                   count: "Today",
                                              //                   statusText:"${leadReminder.today ?? 'N/A'}",
                                              //                   countColor: Colors.black,
                                              //                   statusColor: Colors.grey,
                                              //                   icon: Icons.date_range_sharp,
                                              //                   iconColor: AllColors.darkYellow,
                                              //                   containerColor: AllColors.lightYellow,
                                              //                 ),
                                              //                 LeadTypeCountCard(
                                              //                   count: "Today",
                                              //                   statusText:"${leadReminder.today ?? 'N/A'}",
                                              //                   countColor: Colors.black,
                                              //                   statusColor: Colors.grey,
                                              //                   icon: Icons.date_range_sharp,
                                              //                   iconColor: AllColors.darkYellow,
                                              //                   containerColor: AllColors.lightYellow,
                                              //                 ),
                                              //
                                              //
                                              //                 // Text(
                                              //                 //     "${leadReminder.today ?? 'N/A'}"),
                                              //                 // Text(
                                              //                 //     "${leadReminder.missing ?? 'N/A'}"),
                                              //                 // Text(
                                              //                 //     "${leadReminder.upcomming ?? 'N/A'}"),
                                              //                 // Text(
                                              //                 //   leadReminder
                                              //                 //       .data.isEmpty
                                              //                 //       ? 'N/A'
                                              //                 //       : leadReminder
                                              //                 //       .data
                                              //                 //       .toString(),
                                              //                 // )
                                              //               ],
                                              //             ),
                                              //           )
                                              //     ),
                                              //   ],
                                              // );
                                              Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  // SCROLLER ROW WITH CONTAINERS
                                                  children: [
                                                    LeadTypeCountCard(
                                                      count: "Today",
                                                      statusText:
                                                          "${leadReminder.today ?? 'N/A'}",
                                                      countColor: Colors.black,
                                                      statusColor: Colors.grey,
                                                      icon: Icons
                                                          .date_range_sharp,
                                                      iconColor:
                                                          AllColors.darkYellow,
                                                      containerColor:
                                                          AllColors.lightYellow,
                                                    ),
                                                    LeadTypeCountCard(
                                                      count: "Missed",
                                                      statusText:
                                                          "${leadReminder.missing ?? 'N/A'}",
                                                      countColor: Colors.black,
                                                      statusColor: Colors.grey,
                                                      icon: Icons
                                                          .error_outline_rounded,
                                                      iconColor:
                                                          AllColors.darkRed,
                                                      containerColor:
                                                          AllColors.lightRed,
                                                    ),
                                                    LeadTypeCountCard(
                                                      count: "UpComing",
                                                      statusText:
                                                          "${leadReminder.upcomming ?? 'N/A'}",
                                                      countColor: Colors.black,
                                                      statusColor: Colors.grey,
                                                      icon: Icons.computer,
                                                      iconColor:
                                                          AllColors.text__green,
                                                      containerColor: AllColors
                                                          .background_green,
                                                    ),
                                                    LeadTypeCountCard(
                                                      count: "Reminder",
                                                      statusText: leadReminder
                                                              .data.isNotEmpty
                                                          ? leadReminder.data
                                                              .toString()
                                                          : '0',
                                                      countColor: Colors.black,
                                                      statusColor: Colors.grey,
                                                      icon: Icons
                                                          .date_range_sharp,
                                                      iconColor:
                                                          AllColors.darkYellow,
                                                      containerColor:
                                                          AllColors.lightYellow,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }),
                                  if (index == 3 &&
                                      _dashboardListController
                                          .leadCustomer.isNotEmpty)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Obx(() {
                                        if (tabController.isCusSelected.value) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: _dashboardListController
                                                .leadCustomer.length,
                                            itemBuilder: (context, index) {
                                              final leadCustomer =
                                                  _dashboardListController
                                                      .leadCustomer[index];
                                              return Row(
                                                children: [
                                                  ContainerUtils(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            "${leadCustomer.servicesRunning ?? 'N/A'}"),
                                                        Text(
                                                            "${leadCustomer.projectNotStarted ?? 'N/A'}"),
                                                        Text(
                                                            "${leadCustomer.projectInProgress ?? 'N/A'}"),
                                                        Text(
                                                            "${leadCustomer.projectOnHold ?? 'N/A'}"),
                                                        Text(
                                                            "${leadCustomer.noServices ?? 'N/A'}"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          final servicesRunning = double.tryParse(
                                                  '${_dashboardListController.leadCustomer[0].servicesRunning}') ??
                                              0.0;
                                          final projectNotStarted = double.tryParse(
                                                  '${_dashboardListController.leadCustomer[0].projectNotStarted}') ??
                                              0.0;
                                          final projectOnHold = double.tryParse(
                                                  '${_dashboardListController.leadCustomer[0].projectOnHold}') ??
                                              0.0;
                                          final projectInProgress = double.tryParse(
                                                  '${_dashboardListController.leadCustomer[0].projectInProgress}') ??
                                              0.0;
                                          final noServices = double.tryParse(
                                                  '${_dashboardListController.leadCustomer[0].noServices}') ??
                                              0.0;

                                          // Optional things if we need in future

                                          // final servicesRunningText = _dashboardListController.leadCustomer[0].servicesRunning?.toString() ?? 0.0;
                                          // final projectNotStartedText = _dashboardListController.leadCustomer[0].projectNotStarted?.toString() ?? 0.0;
                                          // final projectOnHoldText = _dashboardListController.leadCustomer[0].projectOnHold?.toString() ?? 0.0;
                                          // final projectInProgressText = _dashboardListController.leadCustomer[0].projectInProgress?.toString() ?? 0.0;
                                          // final noServicesText = _dashboardListController.leadCustomer[0].noServices?.toString() ?? 0.0;

                                          return Column(
                                            children: [
                                              Center(
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 300,
                                                      height: 300,
                                                      child: PieChart(
                                                        PieChartData(
                                                          sectionsSpace: 2,
                                                          centerSpaceRadius: 52,
                                                          sections: [
                                                            // Service Running
                                                            PieChartSectionData(
                                                              value:
                                                                  servicesRunning,
                                                              color: AllColors
                                                                  .greenJungle,
                                                              title:
                                                                  '${servicesRunning.toStringAsFixed(0)}0%',
                                                              titleStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              radius: 52,
                                                              showTitle: true,
                                                            ),

                                                            // Project Not Stated
                                                            PieChartSectionData(
                                                              value:
                                                                  projectNotStarted,
                                                              color:
                                                                  Colors.blue,
                                                              title:
                                                                  '${projectNotStarted.toStringAsFixed(0)}0%',
                                                              titleStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              radius: 52,
                                                              showTitle: true,
                                                            ),

                                                            // Project on Hold
                                                            PieChartSectionData(
                                                              value:
                                                                  projectOnHold,
                                                              color: Colors.red,
                                                              title:
                                                                  '${projectOnHold.toStringAsFixed(0)}0%',
                                                              titleStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              radius: 52,
                                                              showTitle: true,
                                                            ),

                                                            // Project In Progress
                                                            PieChartSectionData(
                                                              value:
                                                                  projectInProgress,
                                                              color: AllColors
                                                                  .mediumOrange,
                                                              title:
                                                                  '${projectInProgress.toStringAsFixed(0)}0%',
                                                              titleStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              radius: 52,
                                                              showTitle: true,
                                                            ),

                                                            // No Services
                                                            PieChartSectionData(
                                                              value: noServices,
                                                              color: AllColors
                                                                  .darkBlue,
                                                              title:
                                                                  '${noServices.toStringAsFixed(0)}0%',
                                                              titleStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              radius: 52,
                                                              showTitle: true,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                          'Total',
                                                          style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          (servicesRunning +
                                                                  projectNotStarted +
                                                                  projectOnHold +
                                                                  projectInProgress +
                                                                  noServices)
                                                              .toStringAsFixed(
                                                                  0),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 6,
                                                        backgroundColor:
                                                            Colors.blue,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Project Not Startd",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                FontFamily
                                                                    .sfPro,
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 6,
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                      SizedBox(
                                                        width: 18.2,
                                                      ),
                                                      Text(
                                                        "Project On Hold",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                FontFamily
                                                                    .sfPro,
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 6,
                                                    backgroundColor:
                                                        Colors.orange,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  const Text(
                                                    "Project In Progress",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            FontFamily.sfPro,
                                                        fontSize: 15),
                                                  ),
                                                  const Spacer(),
                                                  CircleAvatar(
                                                      radius: 6,
                                                      backgroundColor: AllColors
                                                          .greenJungle),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  const Text(
                                                    "Service Running",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            FontFamily.sfPro,
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 6,
                                                    backgroundColor:
                                                        AllColors.darkPink,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  const Text(
                                                    "No Services",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            FontFamily.sfPro,
                                                        fontSize: 15),
                                                  ),
                                                  const Spacer(),
                                                ],
                                              ),
                                            ],
                                          );
                                        }
                                      }),
                                    ),
                                  if (index == 4 &&
                                      _dashboardListController
                                          .leadSources.isNotEmpty)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Obx(() {
                                        if (tabController
                                            .isLeadSourceSelected.value) {
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List.generate(
                                                _dashboardListController
                                                    .leadSources.length,
                                                (index) {
                                                  final leadSource =
                                                      _dashboardListController
                                                          .leadSources[index];

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.5,
                                                            top: 10,
                                                            bottom: 9,
                                                            right: 15),
                                                    child: StatusCard(
                                                      number:
                                                          "${leadSource.leadCount} Leads",
                                                      label:
                                                          "${leadSource.name}",
                                                      color: leadSource.name
                                                                  ?.toLowerCase() ==
                                                              "google"
                                                          ? Colors.orange
                                                          : leadSource.name
                                                                      ?.toLowerCase() ==
                                                                  "app dashboard"
                                                              ? Colors
                                                                  .blue.shade200
                                                              : Colors.blue
                                                                  .shade200, // Default color
                                                      showBorder: true,
                                                      height: 54,
                                                      width: 150,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const Text("vivekk");
                                        }
                                      }),
                                    ),
                                  if (index == 5 &&
                                      _dashboardListController
                                          .leadCustomerReminder.isNotEmpty)
                                    Obx(() {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _dashboardListController
                                            .leadCustomerReminder.length,
                                        // Use leadSources length
                                        itemBuilder: (context, index) {
                                          final leadCustomerReminder =
                                              _dashboardListController
                                                      .leadCustomerReminder[
                                                  index]; // Get the lead source at the current index
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  // SCROLLER ROW WITH CONTAINERS
                                                  children: [
                                                    LeadTypeCountCard(
                                                      count: "Today",
                                                      statusText:
                                                          "${leadCustomerReminder.today ?? 'N/A'}",
                                                      countColor: Colors.black,
                                                      statusColor: Colors.grey,
                                                      icon: Icons
                                                          .date_range_sharp,
                                                      iconColor:
                                                          AllColors.darkYellow,
                                                      containerColor:
                                                          AllColors.lightYellow,
                                                    ),
                                                    LeadTypeCountCard(
                                                      count: "Missed",
                                                      statusText:
                                                          "${leadCustomerReminder.missing ?? 'N/A'}",
                                                      countColor: Colors.black,
                                                      statusColor: Colors.grey,
                                                      icon: Icons
                                                          .error_outline_rounded,
                                                      iconColor:
                                                          AllColors.darkRed,
                                                      containerColor:
                                                          AllColors.lightRed,
                                                    ),
                                                    LeadTypeCountCard(
                                                      count: "UpComing",
                                                      statusText:
                                                          "${leadCustomerReminder.upcomming ?? 'N/A'}",
                                                      countColor: Colors.black,
                                                      statusColor: Colors.grey,
                                                      icon: Icons.computer,
                                                      iconColor:
                                                          AllColors.text__green,
                                                      containerColor: AllColors
                                                          .background_green,
                                                    ),
                                                    LeadTypeCountCard(
                                                      count: "Reminder",
                                                      statusText:
                                                          leadCustomerReminder
                                                                  .data
                                                                  .isNotEmpty
                                                              ? leadCustomerReminder
                                                                  .data
                                                                  .toString()
                                                              : '0',
                                                      countColor: Colors.black,
                                                      statusColor: Colors.grey,
                                                      icon: Icons
                                                          .date_range_sharp,
                                                      iconColor:
                                                          AllColors.darkYellow,
                                                      containerColor:
                                                          AllColors.lightYellow,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                          //   Row(
                                          //   children: [
                                          //     Padding(
                                          //       padding: const EdgeInsets
                                          //           .symmetric(
                                          //           vertical: 8.0),
                                          //       child: ContainerUtils(
                                          //         child: Column(
                                          //           children: [
                                          //             Text(
                                          //                 "${leadCustomerReminder.missing ?? 'N/A'}"),
                                          //             Text(
                                          //                 "${leadCustomerReminder.today ?? 'N/A'}"),
                                          //             Text(
                                          //                 "${leadCustomerReminder.data.isEmpty ? 'N/A' : leadCustomerReminder.data.toString()}"),
                                          //             Text(
                                          //                 "${leadCustomerReminder.upcomming ?? 'N/A'}"),
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // );
                                        },
                                      );
                                    }),
                                  if (index == 6 &&
                                      _dashboardListController
                                          .taskStatus.isNotEmpty)
                                    Obx(() {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _dashboardListController
                                            .taskStatus.length,
                                        itemBuilder: (context, index) {
                                          final taskStatus =
                                              _dashboardListController
                                                  .taskStatus[index];
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    taskStatus.notStarted?.count
                                                            .toString() ??
                                                        'N/A',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? Colors.black
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        },
                                      );
                                    }),
                                  if (index == 7 &&
                                      _dashboardListController
                                              .projectStatusData.value !=
                                          null)
                                    Obx(() {
                                      final projectStatusData =
                                          _dashboardListController
                                              .projectStatusData.value!;
                                      return ContainerUtils(
                                        paddingLeft: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Project Status Overview",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              "Not Started: ${projectStatusData.notStarted ?? 'No projects not started'}",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "In Progress: ${projectStatusData.inProgress != null && projectStatusData.inProgress! > 0 ? projectStatusData.inProgress : 'No projects in progress'}",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "On Hold: ${projectStatusData.onHold != null && projectStatusData.onHold! > 0 ? projectStatusData.onHold : 'No projects on hold'}",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            // Add some spacing
                                            ...projectStatusData.complete
                                                .map((complete) {
                                              return Text(
                                                "${complete.month}: ${complete.count}",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      );
                                    }),
                                  if (index == 8 &&
                                      _dashboardListController
                                          .paymentReminder.isNotEmpty)
                                    Obx(() {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _dashboardListController
                                            .paymentReminder.length,
                                        itemBuilder: (context, index) {
                                          final paymentReminder =
                                              _dashboardListController
                                                  .paymentReminder[index];
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      // SCROLLER ROW WITH CONTAINERS
                                                      children: [
                                                        LeadTypeCountCard(
                                                          count: "Today",
                                                          statusText:
                                                              "${paymentReminder.today ?? 'N/A'}",
                                                          countColor:
                                                              Colors.black,
                                                          statusColor:
                                                              Colors.grey,
                                                          icon: Icons
                                                              .date_range_sharp,
                                                          iconColor: AllColors
                                                              .darkYellow,
                                                          containerColor:
                                                              AllColors
                                                                  .lightYellow,
                                                        ),
                                                        LeadTypeCountCard(
                                                          count: "Missed",
                                                          statusText:
                                                              "${paymentReminder.missing ?? 'N/A'}",
                                                          countColor:
                                                              Colors.black,
                                                          statusColor:
                                                              Colors.grey,
                                                          icon: Icons
                                                              .error_outline_rounded,
                                                          iconColor:
                                                              AllColors.darkRed,
                                                          containerColor:
                                                              AllColors
                                                                  .lightRed,
                                                        ),
                                                        LeadTypeCountCard(
                                                          count: "UpComing",
                                                          statusText:
                                                              "${paymentReminder.upcoming ?? 'N/A'}",
                                                          countColor:
                                                              Colors.black,
                                                          statusColor:
                                                              Colors.grey,
                                                          icon: Icons.computer,
                                                          iconColor: AllColors
                                                              .text__green,
                                                          containerColor: AllColors
                                                              .background_green,
                                                        ),
                                                        LeadTypeCountCard(
                                                          count: "Reminder",
                                                          statusText: paymentReminder
                                                                  .data
                                                                  .isNotEmpty
                                                              ? paymentReminder
                                                                  .data
                                                                  .toString()
                                                              : '0',
                                                          countColor:
                                                              Colors.black,
                                                          statusColor:
                                                              Colors.grey,
                                                          icon: Icons
                                                              .date_range_sharp,
                                                          iconColor: AllColors
                                                              .darkYellow,
                                                          containerColor:
                                                              AllColors
                                                                  .lightYellow,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ));
                                          // Column(
                                          //   crossAxisAlignment:
                                          //   CrossAxisAlignment
                                          //       .start,
                                          //   children: [
                                          //     Text(
                                          //         "${paymentReminder.today ?? 'Not available'}"),
                                          //     Text(
                                          //         "${paymentReminder.missing ?? 'Not available'}"),
                                          //     Text(
                                          //         "${paymentReminder.upcoming ?? 'Not available'}"),
                                          //     Text(
                                          //       paymentReminder.data != null &&
                                          //           paymentReminder
                                          //               .data!
                                          //               .isEmpty
                                          //           ? "0"
                                          //           : "${paymentReminder.data ?? 'Not available ji'}",
                                          //     ),
                                          //   ],
                                          // ));
                                        },
                                      );
                                    }),
                                  if (index == 9 &&
                                      _dashboardListController
                                          .projectReminder.isNotEmpty)
                                    Obx(() {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _dashboardListController
                                            .projectReminder.length,
                                        itemBuilder: (context, index) {
                                          final projectReminder =
                                              _dashboardListController
                                                  .projectReminder[index];

                                          // Extracting values
                                          String countText = projectReminder
                                                  .count
                                                  ?.toString() ??
                                              'Not available ji';
                                          String dataText =
                                              (projectReminder.data.isEmpty)
                                                  ? "0"
                                                  : projectReminder.data
                                                          .toString() ??
                                                      'Not available ji';

                                          // Check if both values are "0"
                                          bool showImage = countText == "0" &&
                                              dataText == "0";

                                          return Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: showImage
                                                ? Image.asset(
                                                    'assets/images/datanotfound.png',
                                                    height:
                                                        250) // Replace with your image path
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(countText),
                                                      Text(dataText),
                                                    ],
                                                  ),
                                          );
                                        },
                                      );
                                    }),
                                  if (index == 10 &&
                                      _dashboardListController
                                          .salesChart.isNotEmpty)
                                    Obx(() {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _dashboardListController
                                            .salesChart.length,
                                        itemBuilder: (context, index) {
                                          final salesChart =
                                              _dashboardListController
                                                  .salesChart[index];

                                          // Extract status code
                                          String statusCodeText = salesChart
                                                  .statusCode
                                                  ?.toString() ??
                                              'Not available ji';

                                          // Check if status code is 500
                                          bool showStatic =
                                              statusCodeText == "500";

                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: showStatic
                                                ? Column(
                                                    children: [
                                                      IntrinsicHeight(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        16.0),
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,

                                                                  // mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AllColors
                                                                            .lighterPurple,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .shopping_bag_outlined,
                                                                        color: AllColors
                                                                            .mediumPurple,
                                                                        size:
                                                                            24,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            12),
                                                                    const Text(
                                                                      "110",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: Colors
                                                                            .black87,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            4),
                                                                    const Text(
                                                                      "Orders",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Color(
                                                                            0xFF6B7280),
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 1,
                                                              color: Colors
                                                                  .black12,
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        16.0),
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AllColors
                                                                            .lighterPurple,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .medical_services_outlined,
                                                                        color: AllColors
                                                                            .mediumPurple,
                                                                        size:
                                                                            24,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            12),
                                                                    const Text(
                                                                      "20000",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: Colors
                                                                            .black87,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            4),
                                                                    const Text(
                                                                      "Incentive",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Color(
                                                                            0xFF6B7280),
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 1,
                                                        color: Colors.black12,
                                                      ),
                                                      IntrinsicHeight(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        16.0),
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AllColors
                                                                            .lighterPurple,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .hexagon_outlined,
                                                                        color: AllColors
                                                                            .mediumPurple,
                                                                        size:
                                                                            24,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            12),
                                                                    const Text(
                                                                      "20.06 Cr",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: Colors
                                                                            .black87,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            4),
                                                                    const Text(
                                                                      "Sales",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Color(
                                                                            0xFF6B7280),
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 1,
                                                              color: Colors
                                                                  .black12,
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        16.0),
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AllColors
                                                                            .lighterPurple,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .bar_chart,
                                                                        color: AllColors
                                                                            .mediumPurple,
                                                                        size:
                                                                            24,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            12),
                                                                    const Text(
                                                                      "3.67 L",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: Colors
                                                                            .black87,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            4),
                                                                    const Text(
                                                                      "Revenue",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Color(
                                                                            0xFF6B7280),
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(statusCodeText),
                                                    ],
                                                  ),
                                          );
                                        },
                                      );
                                    }),
                                  if (index == 11 &&
                                      _dashboardListController
                                          .transactionChart.isNotEmpty)
                                    Obx(() {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _dashboardListController
                                            .transactionChart.length,
                                        itemBuilder: (context, index) {
                                          final transactionChart =
                                              _dashboardListController
                                                  .transactionChart[index];

                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: transactionChart.data
                                                .length, // Use the length of transaction data
                                            itemBuilder: (context, dataIndex) {
                                              final transaction =
                                                  transactionChart
                                                      .data[dataIndex];
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2, bottom: 5),
                                                child: TransactionListCard(
                                                    title: transaction
                                                            .information ??
                                                        'Not available', // Use appropriate field from your data
                                                    name:
                                                        '${transaction.amount ?? 'Not available'}', // Use appropriate field from your data
                                                    amount:
                                                        "₹ ${transaction.amount ?? 'Not available ji'}", // Use appropriate field from your data
                                                    subtitle: DateFormat(
                                                            'dd MMM, yyyy \'at\' hh:mm a')
                                                        .format(DateTime.parse(
                                                                transaction
                                                                    .createdAt
                                                                    .toString())
                                                            .add(const Duration(
                                                                hours: 5,
                                                                minutes: 30)))),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }),
                                  if (index == 12 &&
                                      _dashboardListController
                                          .taskPerformance.isNotEmpty)
                                    Obx(() {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _dashboardListController
                                            .taskPerformance.length,
                                        itemBuilder: (context, index) {
                                          final taskPerformance =
                                              _dashboardListController
                                                  .taskPerformance[index];
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text(
                                                  //     "${taskPerformance.totalHours ?? 'Not available ji'}"),

                                                  Column(
                                                    children: [
                                                      // Row(
                                                      //   children: [
                                                      //     Expanded(child: CreateNewLeadScreenCard2(hintText: '2025-01-30',isDateField: true,)),
                                                      //     Spacer()
                                                      //   ],
                                                      // ),
                                                      // SizedBox(height: 10,),
                                                      // Center(
                                                      //   child: Column(
                                                      //     mainAxisAlignment: MainAxisAlignment.center,
                                                      //     children: [
                                                      //       Stack(
                                                      //         alignment: Alignment.center,
                                                      //         children: [
                                                      //           Container(
                                                      //             width: 200,
                                                      //             height: 200,
                                                      //             child: CustomPaint(
                                                      //               painter: _CircleProgressPainter(
                                                      //                 progress: 0.07,
                                                      //                 progressColor: Colors.orange.shade200,
                                                      //                 backgroundColor: Colors.grey.shade200,
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           Column(
                                                      //             mainAxisSize: MainAxisSize.min,
                                                      //             children: [
                                                      //               Text(
                                                      //                 'PROGRESS',
                                                      //                 style: TextStyle(
                                                      //                   color: Colors.grey[600],
                                                      //                   fontSize: 14,
                                                      //                   fontWeight: FontWeight.w500,
                                                      //                 ),
                                                      //               ),
                                                      //               const SizedBox(height: 4),
                                                      //               Text(
                                                      //                 '${taskPerformance.totalHours ?? 'Not available ji'}',
                                                      //                 style: TextStyle(
                                                      //                   color: Colors.grey[800],
                                                      //                   fontSize: 24,
                                                      //                   fontWeight: FontWeight.bold,
                                                      //                 ),
                                                      //               ),
                                                      //             ],
                                                      //           ),
                                                      //         ],
                                                      //       ),
                                                      //       const SizedBox(height: 16),
                                                      //       Row(
                                                      //         mainAxisAlignment: MainAxisAlignment.center,
                                                      //         children: [
                                                      //           Text(
                                                      //             '00',
                                                      //             style: TextStyle(
                                                      //               color: Colors.red,
                                                      //               fontSize: 16,
                                                      //               fontWeight: FontWeight.bold,
                                                      //             ),
                                                      //           ),
                                                      //           Text(
                                                      //             ' : ',
                                                      //             style: TextStyle(
                                                      //               color: Colors.grey[600],
                                                      //               fontSize: 16,
                                                      //             ),
                                                      //           ),
                                                      //           Text(
                                                      //             '00',
                                                      //             style: TextStyle(
                                                      //               color: Colors.red,
                                                      //               fontSize: 16,
                                                      //               fontWeight: FontWeight.bold,
                                                      //             ),
                                                      //           ),
                                                      //           Text(
                                                      //             ' : ',
                                                      //             style: TextStyle(
                                                      //               color: Colors.grey[600],
                                                      //               fontSize: 16,
                                                      //             ),
                                                      //           ),
                                                      //           Text(
                                                      //             '',
                                                      //             style: TextStyle(
                                                      //               color: Colors.red,
                                                      //               fontSize: 16,
                                                      //               fontWeight: FontWeight.bold,
                                                      //             ),
                                                      //           ),
                                                      //           Text(
                                                      //             ' / ${taskPerformance.totalHours ?? 'Not available ji'} Hrs',
                                                      //             style: TextStyle(
                                                      //                 color: Colors.black,
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700
                                                      //             ),
                                                      //           ),
                                                      //         ],
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),

                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 40),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AllColors
                                                                    .whiteColor,
                                                                shape: BoxShape
                                                                    .circle,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: AllColors
                                                                        .vividPurple
                                                                        .withOpacity(
                                                                            0.10),
                                                                    spreadRadius:
                                                                        10,
                                                                    blurRadius:
                                                                        10,
                                                                  ),
                                                                ],
                                                              ),
                                                              child:
                                                                  CircularPercentIndicator(
                                                                progressColor:
                                                                    AllColors
                                                                        .mediumPurple,
                                                                backgroundColor:
                                                                    AllColors
                                                                        .lighterPurple,
                                                                lineWidth: 10,
                                                                radius: 65,
                                                                percent: 0.4,
                                                                startAngle: 0,
                                                                animation: true,
                                                                animationDuration:
                                                                    2000,
                                                                // backgroundWidth: 30,
                                                                curve: Curves
                                                                    .decelerate,
                                                                circularStrokeCap:
                                                                    CircularStrokeCap
                                                                        .round,
                                                                center:
                                                                    Container(
                                                                  height:
                                                                      Get.height /
                                                                          7,
                                                                  width:
                                                                      Get.width /
                                                                          4.7,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AllColors
                                                                        .whiteColor,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: AllColors
                                                                            .vividPurple
                                                                            .withOpacity(0.04),
                                                                        spreadRadius:
                                                                            10,
                                                                        blurRadius:
                                                                            3,
                                                                        offset: const Offset(
                                                                            0,
                                                                            0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      TextStyles.w600_universal(
                                                                          fontSize:
                                                                              10,
                                                                          context,
                                                                          Strings
                                                                              .completed),

                                                                      // SizedBox(height: 5,),

                                                                      const Text(
                                                                        '40%',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                TextStyles.w600_15(
                                                                    context,
                                                                    Strings
                                                                        .taskProgress),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Text(
                                                                      '06:06:15 /',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      '4hrs',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: AllColors
                                                                            .vividPurple,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ));
                                        },
                                      );
                                    }),
                                ],
                              ),
                            );
                          },
                        );
                      })
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // void _showFilterBottomSheet(BuildContext context) {
  //   // Initialize filter values from the controller
  //   final teamValue = _dashboardListController.isTeamFilter.value ? "With Team" : "Individual";
  //   String? initialUserName;
  //   String? initialDivisionName;
  //
  //   // Find current user name
  //   if (_dashboardListController.currentUserId != null) {
  //     final currentUser = userListViewModel.userList.firstWhereOrNull(
  //             (user) => user.id == _dashboardListController.currentUserId
  //     );
  //     if (currentUser != null) {
  //       initialUserName = '${currentUser.firstName ?? ''} ${currentUser.lastName ?? ''}'.trim();
  //     }
  //   }
  //
  //   // Find current division name
  //   if (_dashboardListController.currentDivision != null) {
  //     final currentDivision = divisionViewModel.divisions.firstWhereOrNull(
  //             (division) => division.id == _dashboardListController.currentDivision
  //     );
  //     if (currentDivision != null) {
  //       initialDivisionName = currentDivision.name;
  //     }
  //   }
  //
  //   // Variables to track selected values
  //   String selectedTeamValue = teamValue;
  //   String? selectedUserName = initialUserName;
  //   String? selectedDivisionName = initialDivisionName;
  //
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
  //     ),
  //     builder: (context) => Container(
  //       height: 300,
  //       child: Padding(
  //         padding: const EdgeInsets.only(top: 10),
  //         child: SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 15, right: 15),
  //             child: Column(
  //               children: [
  //                 CreateNewLeadScreenCard2(
  //                   hintText: '',
  //                   categories: const ["Individual", "With Team"],
  //                   initialValue: selectedTeamValue,
  //                   onCategoryChanged: (value) {
  //                     selectedTeamValue = value;
  //                   },
  //                 ),
  //                 const SizedBox(height: 10),
  //                 CreateNewLeadScreenCard2(
  //                   hintText: 'Select User',
  //                   categories: userListViewModel.userList
  //                       .map((user) => '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim())
  //                       .toList(),
  //                   initialValue: selectedUserName,
  //                   onCategoryChanged: (value) {
  //                     selectedUserName = value;
  //                   },
  //                 ),
  //                 const SizedBox(height: 10),
  //                 CreateNewLeadScreenCard2(
  //                   hintText: 'Select Division',
  //                   categories: divisionViewModel.divisions
  //                       .map((division) => division.name ?? '')
  //                       .toList(),
  //                   initialValue: selectedDivisionName,
  //                   onCategoryChanged: (value) {
  //                     selectedDivisionName = value;
  //                   },
  //                 ),
  //                 const SizedBox(height: 20),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     CustomButton(
  //                       backgroundColor: Colors.grey,
  //                       width: 80,
  //                       height: 30,
  //                       borderRadius: 25,
  //                       onPressed: () => Navigator.pop(context),
  //                       child: const Text(
  //                         'Cancel',
  //                         style: TextStyle(
  //                             fontSize: 14,
  //                             fontWeight: FontWeight.w400,
  //                             fontFamily: FontFamily.sfPro
  //                         ),
  //                       ),
  //                     ),
  //                     CustomButton(
  //                       onPressed: () {
  //                         // Find selected user ID
  //                         final selectedUser = userListViewModel.userList.firstWhereOrNull(
  //                                 (user) => '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim() == selectedUserName
  //                         );
  //
  //                         // Find selected division ID
  //                         final selectedDivision = divisionViewModel.divisions.firstWhereOrNull(
  //                                 (division) => division.name == selectedDivisionName
  //                         );
  //
  //                         // Apply filters
  //                         _dashboardListController.applyFilters(
  //                           userId: selectedUser?.id,
  //                           division: selectedDivision?.id,
  //                           isTeam: selectedTeamValue == "With Team",
  //                         );
  //                         Navigator.pop(context);
  //                       },
  //                       child: const Text('Update'),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void openFilterBottomSheet(BuildContext context) {
    showResponsiveFilter(
      context,
      FilterConfig(
        title: "My Filters",
        primaryColor: AllColors.mediumPurple,
        filterOptions: [
          FilterOption(
            id: 'person',
            label: 'Person',
            hintText: 'Select type',
          ),
          FilterOption(
            id: 'user',
            label: 'User',
            hintText: 'Select user',
          ),
          FilterOption(
            id: 'division',
            label: 'Division',
            hintText: 'Select division',
          ),
        ],
        customBuilders: {
          'person': (context) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateNewLeadScreenCard2(
                    hintText: 'Select type',
                    categories: const ["Individual", "With Team"],
                    initialValue: _dashboardListController.isTeamFilter.value
                        ? "With Team"
                        : "Individual",
                    onCategoryChanged: (value) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _dashboardListController.isTeamFilter.value =
                            value == "With Team";
                      });
                    },
                  ),
                ],
              ),
          'user': (context) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    final userNames = userListViewModel.userList
                        .map((user) =>
                            '${user.firstName ?? ''} ${user.lastName ?? ''}'
                                .trim())
                        .toList();

                    return CreateNewLeadScreenCard2(
                      hintText: 'Select User',
                      categories: userNames,
                      initialValue:
                          _dashboardListController.selectedUserId.value != null
                              ? (() {
                                  final user = userListViewModel.userList
                                      .firstWhereOrNull(
                                    (user) =>
                                        user.id ==
                                        _dashboardListController
                                            .selectedUserId.value,
                                  );
                                  return user != null
                                      ? '${user.firstName ?? ''} ${user.lastName ?? ''}'
                                          .trim()
                                      : null;
                                })()
                              : null,
                      onCategoryChanged: (selectedUserName) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          final selectedUser =
                              userListViewModel.userList.firstWhereOrNull(
                            (user) =>
                                '${user.firstName ?? ''} ${user.lastName ?? ''}'
                                    .trim() ==
                                selectedUserName,
                          );
                          _dashboardListController.selectedUserId.value =
                              selectedUser?.id;
                        });
                      },
                    );
                  }),
                ],
              ),
          'division': (context) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    final divisionNames = divisionViewModel.divisions
                        .map((division) => division.name ?? '')
                        .toList();

                    return CreateNewLeadScreenCard2(
                      hintText: 'Select Division',
                      categories: divisionNames,
                      initialValue:
                          _dashboardListController.selectedDivision.value !=
                                  null
                              ? divisionViewModel.divisions
                                  .firstWhereOrNull(
                                    (division) =>
                                        division.id ==
                                        _dashboardListController
                                            .selectedDivision.value,
                                  )
                                  ?.name
                              : null,
                      onCategoryChanged: (selectedDivisionName) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          final selectedDivision = divisionViewModel.divisions
                              .firstWhereOrNull((division) =>
                                  division.name == selectedDivisionName);
                          _dashboardListController.selectedDivision.value =
                              selectedDivision?.id;
                        });
                      },
                    );
                  }),
                ],
              ),
        },
        onFilterApplied: (filterId, value) {
          // Apply all filters together
          _dashboardListController.applyFilters(
            userId: _dashboardListController.selectedUserId.value,
            division: _dashboardListController.selectedDivision.value,
            isTeam: _dashboardListController.isTeamFilter.value,
          );
        },
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  final String number;
  final String label;
  final Color color;
  final bool showBorder;
  final double height; // Add a height property
  final double width; // Add a width property

  const StatusCard({
    super.key,
    required this.number,
    required this.label,
    required this.color,
    this.showBorder = false,
    this.height = 100, // Set a default height
    this.width = 150, // Set a default width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Set the fixed width here
      child: Container(
        height: height, // Set the fixed height here
        padding: const EdgeInsets.only(top: 1, left: 15, bottom: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
          border: showBorder
              ? Border(
                  right: BorderSide(
                    color: color,
                    width: 6,
                  ),
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number,
              style: TextStyle(
                fontSize: 16,
                color: AllColors.figmaGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              label, // Use the label parameter instead of hardcoded text
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              softWrap: true, // Allow text to wrap
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;

  _CircleProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 15;
    const strokeWidth = 30.0;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircleProgressPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
