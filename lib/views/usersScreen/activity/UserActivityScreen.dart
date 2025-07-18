import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';

import 'package:websuites/views/usersScreen/activity/userlocation/UserLocationScreen.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/button/CustomButton.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/container_Utils/ContainerUtils.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../data/models/responseModels/userList/activity/UserActivitiesResponseModel.dart';
import '../../../viewModels/userlistViewModel/activities/UserActivitiesViewModel.dart';
import '../../../viewModels/userlistViewModel/userlist_viewModel.dart';

class UserActivityScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(Items)?
      onOrderSelected; // Updated to accept Items instead of UserActivitiesResponseModel

  const UserActivityScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  State<UserActivityScreen> createState() => _UserActivityScreenState();
}

class _UserActivityScreenState extends State<UserActivityScreen> {
  final UserListViewModel userListViewModel = Get.put(UserListViewModel());
  final UserActivitiesModel userActivitiesModel =
      Get.put(UserActivitiesModel());
  bool _isDataLoaded = false; // Define the variable here
  String? selectedUser;

  Future<void> _refreshActivitiesList() async {
    await userActivitiesModel.getUserActivities(context, forceRefresh: true);
    _isDataLoaded = true; // Mark data as loaded after refresh
  }

  Widget getBrowserIcon(String? browserName) {
    if (browserName == null)
      return Icon(Icons.language, color: AllColors.grey, size: 17);

    switch (browserName.toLowerCase()) {
      case 'chrome':
        return Image.asset(
          'assets/images/chrome.png', // Ensure this image is in your assets
          width: 17,
          height: 17,
        );
      default:
        return Icon(Icons.language, color: AllColors.grey, size: 17);
    }
  }

  @override
  void initState() {
    super.initState();
    // Load data only if it hasn't been loaded yet
    if (!_isDataLoaded && userActivitiesModel.userActivities.isEmpty) {
      userActivitiesModel.usersActivitiesApi();
      userListViewModel.userListApi();
      _isDataLoaded = true; // Mark as loaded after initial fetch
    }
  }

  List<Items> filterActivitiesByUser(String? userName) {
    if (userName == null || userName.isEmpty) {
      return userActivitiesModel.userActivities;
    }
    return userActivitiesModel.userActivities.where((activity) {
      final userFullName =
          '${activity.user?.firstName ?? ''} ${activity.user?.lastName ?? ''}'
              .trim();
      return userFullName.contains(userName);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor:              DarkMode.backgroundColor(context),
      body: Obx(() {
        if (userActivitiesModel.loading.value && !_isDataLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userActivitiesModel.userActivities.isEmpty) {
          return const Center(child: Text("No activities found"));
        }

        final filteredActivities = filterActivitiesByUser(selectedUser);

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
                      'Activities',
                      style: TextStyle(
                        color: AllColors.blackColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 17.5,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      width: 70,
                      height: 22,
                      borderRadius: 54,
                      child: InkWell(
                        onTap: () {},
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
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshActivitiesList,
                child: userActivitiesModel.userActivities.isEmpty
                    ? const Center(child: Text("No products available"))
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          if (userActivitiesModel.userActivities.isEmpty) {
                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height: constraints.maxHeight,
                                child: const Center(
                                  child: Text("No products available"),
                                ),
                              ),
                            );
                          }

                          final double screenWidth = constraints.maxWidth;
                          int crossAxisCount = screenWidth < 600
                              ? 1
                              : screenWidth < 1200
                                  ? 2
                                  : 3;
                          final double itemWidth =
                              (screenWidth - (crossAxisCount - 1) * 16) /
                                  crossAxisCount;
                          const double itemHeight = 208;
                          final double childAspectRatio =
                              itemWidth / itemHeight;

                          return GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: childAspectRatio,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount:
                                userActivitiesModel.userActivities.isNotEmpty
                                    ? userActivitiesModel.userActivities.length
                                    : 1,
                            itemBuilder: (context, index) {
                              if (userActivitiesModel.userActivities.isEmpty) {
                                return const Text("No products to display");
                              }

                              final activity =
                                  userActivitiesModel.userActivities[index];

                              return ContainerUtils(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${activity.user?.firstName ?? ''} ${activity.user?.lastName ?? ''}',
                                          style: TextStyle(
                                            color: DarkMode.backgroundColor2(context),
                                            fontSize: 17.5,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          height: 18,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2),
                                          decoration: BoxDecoration(
                                              color: AllColors.lighterOrange,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                            child: Text(
                                              (activity.deviceType
                                                          ?.trim()
                                                          .isEmpty ??
                                                      true)
                                                  ? 'N/A'
                                                  : activity.deviceType!
                                                          .substring(0, 1)
                                                          .toUpperCase() +
                                                      activity.deviceType!
                                                          .substring(1),
                                              style: TextStyle(
                                                color: AllColors.vividOrange,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          activity.user?.email ?? 'N/A',
                                          style: TextStyle(
                                            color: AllColors.grey,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          (activity.deviceDetail
                                                      ?.trim()
                                                      .isEmpty ??
                                                  true)
                                              ? 'N/A'
                                              : activity.deviceDetail!
                                                      .substring(0, 1)
                                                      .toUpperCase() +
                                                  activity.deviceDetail!
                                                      .substring(1),
                                          style: TextStyle(
                                            color: AllColors.vividBlue,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Image.asset(ImageStrings.date,
                                            height: 13,
                                            width: 13,
                                            color: AllColors.mediumPurple),
                                        const SizedBox(width: 10),
                                        Text(
                                          formatDateWithTime(
                                              activity.createdAt?.toString() ??
                                                  'N/A'),
                                          style: TextStyle(
                                            color: AllColors.mediumPurple,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          height: 18,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2),
                                          decoration: BoxDecoration(
                                              color: AllColors.lighterPurple,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                            child: Text(
                                              activity.ipaddress ?? 'N/A',
                                              style: TextStyle(
                                                color: AllColors.mediumPurple,
                                                fontFamily: FontFamily.sfPro,
                                                fontWeight: FontWeight.w400,
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
                                        Image.asset(
                                            'assets/icons/userLogin.png',
                                            height: 16,
                                            width: 16),
                                        const SizedBox(width: 5),
                                        Text(
                                          activity.description ?? 'N/A',
                                          style: TextStyle(
                                            color: AllColors.lightGrey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(thickness: 0.4),
                                    Row(
                                      children: [
                                        getBrowserIcon(activity.browserName),
                                        const SizedBox(width: 5),
                                        Text(
                                          (activity.browserName
                                                      ?.trim()
                                                      .isEmpty ??
                                                  true)
                                              ? 'N/A'
                                              : activity.browserName!
                                                      .substring(0, 1)
                                                      .toUpperCase() +
                                                  activity.browserName!
                                                      .substring(1),
                                          style: TextStyle(
                                            color: AllColors.grey,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            if (widget.onOrderSelected !=
                                                null) {
                                              widget.onOrderSelected!(
                                                  activity); // Pass Items object
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MapScreen(
                                                    latitude: double.tryParse(
                                                            activity.lat ??
                                                                '0.0') ??
                                                        0.0,
                                                    longitude: double.tryParse(
                                                            activity.lng ??
                                                                '0.0') ??
                                                        0.0,
                                                    username:
                                                        '${activity.user?.firstName ?? ''} ${activity.user?.lastName ?? ''}',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          icon: Image.asset(
                                              ImageStrings.location,
                                              height: 18,
                                              width: 18),
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
              ),
            ),
          ],
        );
      }),
    );
  }
}
