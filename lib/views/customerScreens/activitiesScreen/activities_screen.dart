import 'package:flutter/material.dart';
import 'package:websuites/views/customerScreens/activitiesScreen/widgets/ActivitiesScreenCard/activities_screen_card.dart';
import '../../../data/models/responseModels/login/login_response_model.dart';
import '../../../resources/strings/strings.dart';
import '../../../resources/textStyles/text_styles.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../../viewModels/saveToken/save_token.dart';

class CustomersActivitiesScreen extends StatefulWidget {
  const CustomersActivitiesScreen({super.key});

  @override
  State<CustomersActivitiesScreen> createState() =>
      _CustomersActivitiesScreenState();
}

class _CustomersActivitiesScreenState extends State<CustomersActivitiesScreen> {
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
        backgroundColor: AllColors.whiteColor,
        key: _globalKey,
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
                      height: 135,
                    ),
                    CustomerActivitiesScreenCard(
                        title: 'Ms. Komal Sharma',
                        subtitle: 'Medisys biotech Private Limited'),
                    CustomerActivitiesScreenCard(
                        title: 'Ms. Komal Sharma',
                        subtitle: 'Medisys biotech Private Limited'),
                    CustomerActivitiesScreenCard(
                        title: 'Ms. Komal Sharma',
                        subtitle: 'Medisys biotech Private Limited'),
                    CustomerActivitiesScreenCard(
                        title: 'Ms. Komal Sharma',
                        subtitle: 'Medisys biotech Private Limited'),
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
                    width: 12,
                  ),
                  TextStyles.w700_17(
                      color: AllColors.blackColor,
                      context,
                      Strings.customerActivity),
                  const Spacer(),
                  Icon(
                    Icons.filter_list_outlined,
                    size: 17,
                    color: AllColors.grey,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  TextStyles.w400_14(
                      color: AllColors.lightGrey, context, Strings.filter),
                  const SizedBox(
                    width: 10,
                  ),
                  TextStyles.w400_14(
                      color: AllColors.blackColor, context, Strings.details),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    size: 20,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
