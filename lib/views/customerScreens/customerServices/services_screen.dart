import 'package:flutter/material.dart';
import 'package:websuites/views/customerScreens/customerServices/widgets/ServicesCard/services_card.dart';
import '../../../data/models/responseModels/login/login_response_model.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../../viewModels/saveToken/save_token.dart';

class CustomerServicesScreen extends StatefulWidget {
  const CustomerServicesScreen({super.key});

  @override
  State<CustomerServicesScreen> createState() => _CustomerServicesScreenState();
}

class _CustomerServicesScreenState extends State<CustomerServicesScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  SaveUserData userPreference = SaveUserData();

  String? userName = '';
  String? userEmail = '';

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
        userName = firstName;
        userEmail = email;
      });
    } catch (e) {
      print('Error fetching userData: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        backgroundColor: AllColors.whiteColor,
        // drawer: CustomDrawer(
        //     userName: '$userName',
        //     phoneNumber: '$userEmail',
        //     version: '1.0.12'),
        body: Stack(
          children: [
            const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 130,
                    ),
                    AllServicesScreenCard(
                        title: 'Events Pharmaceuticals Pvt ltd'),
                    AllServicesScreenCard(
                        title: 'Events Pharmaceuticals Pvt ltd'),
                    AllServicesScreenCard(
                        title: 'Events Pharmaceuticals Pvt ltd'),
                    AllServicesScreenCard(
                        title: 'Events Pharmaceuticals Pvt ltd'),
                    AllServicesScreenCard(
                        title: 'Events Pharmaceuticals Pvt ltd'),
                  ],
                ),
              ),
            ),

            //============================================================
            // CUSTOM APP BAR

            CustomAppBar(
              child: Row(
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
                    width: 10,
                  ),
                  Text(
                    'All Services',
                    style: TextStyle(
                        color: AllColors.blackColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.filter_list_outlined,
                    size: 15,
                    color: AllColors.lightGrey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Filter',
                    style: TextStyle(
                        color: AllColors.lightGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
