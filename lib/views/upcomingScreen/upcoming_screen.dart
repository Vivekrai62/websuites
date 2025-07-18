import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/views/upcomingScreen/widgets/upcomingScreenCard/upcoming_screen_card.dart';
import '../../data/models/responseModels/login/login_response_model.dart';
import '../../resources/iconStrings/icon_strings.dart';
import '../../resources/imageStrings/image_strings.dart';
import '../../resources/strings/strings.dart';
import '../../resources/textStyles/text_styles.dart';
import '../../utils/appColors/app_colors.dart';
import '../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../viewModels/saveToken/save_token.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  SaveUserData userPreference = SaveUserData();

  String userName = '';
  String? userEmail = "";
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  Future<void> fetchUserData() async {
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
        bottomNavigationBar: CustomBottomNavBar(),
        floatingActionButton: CustomFloatingButton(
            onPressed: () {},
            imageIcon: IconStrings.navSearch3,
            backgroundColor: AllColors.mediumPurple),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        key: _globalKey,
        backgroundColor: AllColors.whiteColor,
        // drawer: CustomDrawer(
        //     userName: userName, phoneNumber: '$userEmail', version: '1.0.12'),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 70),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              _globalKey.currentState?.openDrawer();
                            },
                            child: const Icon(
                              Icons.menu_sharp,
                              size: 25,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, Sunil !',
                              style: TextStyle(
                                color: AllColors.blackColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'May 14, 2024, 12:45 PM',
                              style: TextStyle(
                                color: AllColors.blackColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          height: Get.height / 20,
                          width: Get.width / 11,
                          decoration: BoxDecoration(
                            color: AllColors.lighterPurple,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            ImageStrings.welcomeCompanyLogo,
                            scale: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Get.height / 34,
                          width: Get.width / 3.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AllColors.mediumPurple,
                          ),
                          child: Center(
                              child: TextStyles.w400_14(
                                  color: AllColors.whiteColor,
                                  context,
                                  Strings.upcoming)),
                        ),
                        Container(
                          height: Get.height / 34,
                          width: Get.width / 3.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AllColors.textField2,
                          ),
                          child: Center(
                            child: TextStyles.w400_14(
                                color: AllColors.blackColor,
                                context,
                                Strings.inProgress),
                          ),
                        ),
                        Container(
                          height: Get.height / 34,
                          width: Get.width / 3.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AllColors.textField2,
                          ),
                          child: Center(
                            child: TextStyles.w400_14(
                                color: AllColors.blackColor,
                                context,
                                Strings.upcomingCompleted),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          size: 20,
                          color: AllColors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextStyles.w500_14_Black(
                            context, Strings.upcomingInCapital),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(
                              Icons.filter_list_outlined,
                              color: AllColors.lightGrey,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TextStyles.w400_14(
                                color: AllColors.lightGrey,
                                context,
                                Strings.filter),
                            const SizedBox(
                              width: 10,
                            ),
                            TextStyles.w400_13(
                                color: AllColors.blackColor,
                                context,
                                Strings.lastWeek),
                            const Icon(
                              Icons.arrow_drop_down,
                              size: 30,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    const UpcomingScreenCard(
                        title: 'SEO - Content Writing',
                        companyName:
                            'Ayurvedic PCD Franchise Company in Nagaland'),
                    const UpcomingScreenCard(
                        title: 'SEO - Content Writing',
                        companyName:
                            'Ayurvedic PCD Franchise Company in Nagaland'),
                    const UpcomingScreenCard(
                        title: 'SEO - Content Writing',
                        companyName:
                            'Ayurvedic PCD Franchise Company in Nagaland'),
                    const UpcomingScreenCard(
                        title: 'SEO - Content Writing',
                        companyName:
                            'Ayurvedic PCD Franchise Company in Nagaland'),
                    const UpcomingScreenCard(
                        title: 'SEO - Content Writing',
                        companyName:
                            'Ayurvedic PCD Franchise Company in Nagaland'),
                  ],
                ),
              ),
            ),
            Container(
              height: Get.height / 16,
              width: Get.width / 1,
              decoration: BoxDecoration(
                color: AllColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45.withOpacity(0.10),
                    spreadRadius: 0.5,
                    blurRadius: 8,
                    offset: const Offset(0, 0),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              right: 16,
              child: SizedBox(
                height: 50,
                width: 50,
                child: FloatingActionButton(
                  elevation: 2,
                  shape: const CircleBorder(),
                  backgroundColor: AllColors.mediumPurple,
                  onPressed: () {},
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: AllColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
