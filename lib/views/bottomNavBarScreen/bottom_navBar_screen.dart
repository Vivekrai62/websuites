// BottomNavBarScreen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/views/customerScreens/create/CustomerCreateScreen.dart';
import 'package:websuites/views/homeScreen/home_manager/HomeManagerScreen.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import '../../utils/components/widgets/navBar/custom_navBar.dart';
import '../leadScreens/createNewLead/customer_create_screen.dart';

class BottomNavBarScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeManagerController controller =
        Get.put(HomeManagerController(), permanent: true);
    final RxInt currentIndex = 0.obs; // Reactive current index

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AllColors.whiteColor,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex.value, // Pass the reactive value
        onTap: (index) {
          currentIndex.value = index; // Update the current index
        },
        scaffoldKey: scaffoldKey,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Get.to(() => CustomerCreateScreen(scaffoldKey: scaffoldKey));
        },
        backgroundColor: AllColors.vividPurple,
        child: Icon(
          Icons.search,
          size: 27,
          color: AllColors.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(() => controller.lastScreen.value),
    );
  }
}
