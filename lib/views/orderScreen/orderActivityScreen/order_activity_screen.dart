import 'package:flutter/material.dart';
import 'package:websuites/views/orderScreen/orderActivityScreen/widgets/orderActivityCard/order_activity_card.dart';
import '../../../data/models/responseModels/login/login_response_model.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';

import '../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';
import '../../../viewModels/saveToken/save_token.dart';

class OrderActivityScreen extends StatefulWidget {
  const OrderActivityScreen({super.key});

  @override
  State<OrderActivityScreen> createState() => _OrderActivityScreenState();
}

class _OrderActivityScreenState extends State<OrderActivityScreen> {
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
        backgroundColor: AllColors.whiteColor,
        key: _globalKey,
        // drawer: CustomDrawer(
        //     userName: userName, phoneNumber: userEmail, version: '1.0.12'),
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
                    OrderActivityScreenCard(title: 'Lucky 7(Yearly)'),
                    OrderActivityScreenCard(title: 'Lucky 7(Quarterly)'),
                    OrderActivityScreenCard(title: 'Lucky 7(Yearly)'),
                    OrderActivityScreenCard(title: 'Lucky 7(Quarterly)'),
                    OrderActivityScreenCard(title: 'Lucky 7(Yearly)'),
                    OrderActivityScreenCard(title: 'Lucky 7(Quarterly)'),
                    OrderActivityScreenCard(title: 'Lucky 7(Quarterly)'),
                    OrderActivityScreenCard(title: 'Lucky 7(Quarterly)'),
                    OrderActivityScreenCard(title: 'Lucky 7(Yearly)'),
                    OrderActivityScreenCard(title: 'Lucky 7(Quarterly)'),
                    OrderActivityScreenCard(title: 'Lucky 7(Quarterly)'),
                  ],
                ),
              ),
            ),

            //================================================================
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
                CommonSizedBox.width(context, 5),
                Text(
                  'Activity',
                  style: TextStyle(
                      color: AllColors.blackColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Icon(
                  Icons.filter_list_outlined,
                  size: 15,
                  color: AllColors.lightGrey,
                ),
                CommonSizedBox.width(context, 2.5),
                Text(
                  'Filter',
                  style: TextStyle(
                    color: AllColors.lightGrey,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ))
          ],
        ));
  }
}
