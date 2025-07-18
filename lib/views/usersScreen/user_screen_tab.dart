import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/views/usersScreen/widgets/users_card.dart';
import '../../data/models/responseModels/login/login_response_model.dart';
import '../../resources/iconStrings/icon_strings.dart';
import '../../utils/appColors/app_colors.dart';
import '../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../viewModels/saveToken/save_token.dart';

class UserScreenTab extends StatefulWidget {
  const UserScreenTab({super.key});
  @override
  State<UserScreenTab> createState() => _UserScreenTabState();
}

class _UserScreenTabState extends State<UserScreenTab> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  SaveUserData userPreference = SaveUserData();

  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    FetchUserData();
    super.initState();
  }

  Future<void> FetchUserData() async {
    try {
      LoginResponseModel response = await userPreference.getUser();
      String? firstName = response.user!.firstName;
      String? email = response.user!.email;

      setState(() {
        userName = firstName!;
        userEmail = email!;
      });
    } catch (e) {
      print('Error fetching userData: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
          onPressed: () {},
          imageIcon: IconStrings.navSearch3,
          backgroundColor: AllColors.mediumPurple),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: AllColors.whiteColor,
      // drawer: CustomDrawer(
      //     userName: userName, phoneNumber: userEmail, version: '1.0.12'),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // Container(
                  //   color: AllColors.whiteColor,
                  //   width: Get.width / 2,
                  //   height: Get.height * 1,
                  //   child: CustomDrawer(
                  //       userName: userName,
                  //       phoneNumber: userEmail,
                  //       version: '1.0.12'),
                  //   // Drawer(
                  //   //   backgroundColor: AppColors.whiteColor,
                  //   //   child:
                  //   //   ListView(
                  //   //     children: [
                  //   //       Container(
                  //   //         padding: EdgeInsets.only(left: 13),
                  //   //         height: Get.height / 9,
                  //   //         child: Row(
                  //   //
                  //   //           children: [
                  //   //             Container(
                  //   //               height: Get.height / 14,
                  //   //               width: Get.width / 14,
                  //   //               decoration: BoxDecoration(
                  //   //                 shape: BoxShape.circle,
                  //   //                 color: AppColors.whiteColor,
                  //   //               ),
                  //   //               child: Center(
                  //   //                   child: Image.asset(
                  //   //                       AppImages.Splash_WHLogo)),
                  //   //             ),
                  //   //             SizedBox(width: Get.width / 40,),
                  //   //
                  //   //              Column(
                  //   //               mainAxisAlignment: MainAxisAlignment.center,
                  //   //               crossAxisAlignment: CrossAxisAlignment
                  //   //                   .start,
                  //   //
                  //   //               children: [
                  //   //                 Text('$userName',
                  //   //                   style: TextStyle(
                  //   //                     fontWeight: FontWeight.w500,
                  //   //                     fontSize: 17,
                  //   //                     fontFamily: Fonts.nunitoRegular,
                  //   //
                  //   //                   ),),
                  //   //                 Text('$userEmail',
                  //   //                   style: TextStyle(
                  //   //                       fontWeight: FontWeight.w400,
                  //   //                       fontSize: 13,
                  //   //                       fontFamily: Fonts.nunitoRegular,
                  //   //                       color: AppColors.grey,
                  //   //                   ),),
                  //   //               ],
                  //   //             )
                  //   //           ],),
                  //   //       ),
                  //   //
                  //   //       Column(
                  //   //         children: [
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.dashboard,
                  //   //               title: AppStrings.Drawer_Dashboard,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.leaderboard,
                  //   //               title: AppStrings.Drawer_Lead,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.person,
                  //   //               title: AppStrings.Drawer_Customer,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.shopping_bag,
                  //   //               title: AppStrings.Drawer_Orders,
                  //   //               onTap: (){}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.group,
                  //   //               title: AppStrings.Drawer_HRM,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.analytics,
                  //   //               title: AppStrings.Drawer_Analytics,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.dashboard,
                  //   //               title: AppStrings.Drawer_Campaign,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.bar_chart,
                  //   //               title: AppStrings.Drawer_Sales,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.person_2,
                  //   //               title: AppStrings.Drawer_Roles,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.verified_user,
                  //   //               title: AppStrings.Drawer_Users,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.add_task,
                  //   //               title: AppStrings.Drawer_Tasks,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.data_object,
                  //   //               title: AppStrings.Drawer_Projects,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.location_city_sharp,
                  //   //               title: AppStrings.Drawer_ServiceArea,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.shopping_bag,
                  //   //               title: AppStrings.Drawer_Products,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //           CustomListTileTab(
                  //   //               icon: Icons.grade,
                  //   //               title: AppStrings.Drawer_Master,
                  //   //               onTap: () {}
                  //   //           ),
                  //   //         ],
                  //   //       ),
                  //   //
                  //   //       SizedBox(height: 30,),
                  //   //
                  //   //       const Divider(
                  //   //         thickness: 1,
                  //   //         indent: 20,
                  //   //         endIndent: 20,
                  //   //       ),
                  //   //
                  //   //       Container(
                  //   //           height: Get.height/20,
                  //   //           width: Get.width/2,
                  //   //           padding: EdgeInsets.only(left: 20),
                  //   //
                  //   //           child: Text(AppStrings.Drawer_Versions,
                  //   //             style: TextStyle(
                  //   //                 fontWeight: FontWeight.w300,
                  //   //                 fontFamily: Fonts.nunitoRegular,
                  //   //                 fontSize: 10,
                  //   //                 color: AppColors.grey
                  //   //             ),)
                  //   //       ),
                  //   //
                  //   //       Container(
                  //   //         margin: EdgeInsets.only(left: 20, right: 20),
                  //   //         child: GenericButton(
                  //   //             height: Get.height/30,
                  //   //             width: Get.width/4,
                  //   //             title: 'Logout',
                  //   //             onPress: () {
                  //   //               SaveUserData().removeUser();
                  //   //               Get.toNamed(RoutesName.login_screen);
                  //   //               Utils.SnackbarSuccess('Logout Successful');
                  //   //             }
                  //   //         ),
                  //   //       ),
                  //   //       SizedBox(height: 10,),
                  //   //     ],
                  //   //   ),
                  //   // )
                  // ),
                ],
              ),
            ),
          ),

          // Container(
          //   height: Get.height/1.15,
          //   width: 0.1,
          //   color: AllColors.lightGrey,
          // ),

          Expanded(
            flex: 2,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(height: Get.height / 15),
                        Row(
                          children: [
                            Text(
                              'Users',
                              style: TextStyle(
                                  color: AllColors.blackColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.filter_list_outlined,
                              size: 20,
                              color: AllColors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Filter',
                              style: TextStyle(
                                color: AllColors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const UsersScreenCard(
                            title: 'Dinesh Kumar', subtitle: 'Development TL'),
                        const UsersScreenCard(
                            title: 'Dinesh Kumar', subtitle: 'Development TL'),
                        const UsersScreenCard(
                            title: 'Dinesh Kumar', subtitle: 'Development TL'),
                        const UsersScreenCard(
                            title: 'Dinesh Kumar', subtitle: 'Development TL'),
                        const UsersScreenCard(
                            title: 'Dinesh Kumar', subtitle: 'Development TL'),
                      ],
                    ),
                  ),
                ),
                //================================================================
                // CUSTOM APP BAR

                // CustomAppBar(
                //     child: Row(
                //   children: [
                //     SizedBox(width: 10,),
                //     Text('Users', style: TextStyle(
                //         color: AllColors.blackColor,
                //         fontSize: 18,
                //         fontFamily: AllFonts.nunitoRegular,
                //         fontWeight: FontWeight.w700
                //     ),
                //     ),
                //
                //     Spacer(),
                //
                //     Icon(Icons.filter_list_outlined, size: 16, color: AllColors.grey,),
                //     SizedBox(width: 5,),
                //     Text('Filter', style: TextStyle(
                //         color: AllColors.grey,
                //         fontWeight: FontWeight.w400,
                //         fontFamily: AllFonts.nunitoRegular,
                //         fontSize: 14,
                //     ),
                //     ),
                //   ],
                // )
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
