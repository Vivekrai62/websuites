import 'package:flutter/material.dart';
import 'package:websuites/views/customerScreens/companiesScreen/widgets/companiesCard/companies_screen_card.dart';
import '../../../data/models/responseModels/login/login_response_model.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../../viewModels/saveToken/save_token.dart';

class CustomerCompaniesScreen extends StatefulWidget {
  const CustomerCompaniesScreen({super.key});

  @override
  State<CustomerCompaniesScreen> createState() =>
      _CustomerCompaniesScreenState();
}

class _CustomerCompaniesScreenState extends State<CustomerCompaniesScreen> {
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
        userEmail = email;
        userName = firstName;
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
                    SizedBox(height: 135),
                    CustomerCompaniesScreenCard(title: 'Eras International'),
                    CustomerCompaniesScreenCard(title: 'Eras International'),
                    CustomerCompaniesScreenCard(title: 'Eras International'),
                    CustomerCompaniesScreenCard(title: 'Eras International'),
                    CustomerCompaniesScreenCard(title: 'Eras International'),
                    CustomerCompaniesScreenCard(title: 'Eras International'),
                    CustomerCompaniesScreenCard(title: 'Eras International'),
                  ],
                ),
              ),
            ),

            //====================================================================
            //CUSTOM APP BAR

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
                    'All Companies',
                    style: TextStyle(
                        color: AllColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
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
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
