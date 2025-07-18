import 'package:flutter/material.dart';
import 'package:websuites/views/customerScreens/orderProducts/widgets/orderProductsCard/order_product_screen_card.dart';
import '../../../data/models/responseModels/login/login_response_model.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';

import '../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';
import '../../../viewModels/saveToken/save_token.dart';

class CustomerOrderProductsScreen extends StatefulWidget {
  const CustomerOrderProductsScreen({super.key});

  @override
  State<CustomerOrderProductsScreen> createState() =>
      _CustomerOrderProductsScreenState();
}

class _CustomerOrderProductsScreenState
    extends State<CustomerOrderProductsScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  SaveUserData userPreferences = SaveUserData();

  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    FetchUserData();
    super.initState();
  }

  Future<void> FetchUserData() async {
    try {
      LoginResponseModel response = await userPreferences.getUser();
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
        backgroundColor: AllColors.whiteColor,
        // drawer: CustomDrawer(
        //     userName: userName, phoneNumber: userEmail, version: '1.10.12'),
        body: Stack(
          children: [
            const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    SizedBox(height: 135),
                    CustomerOrderProductScreenCard(title: 'LifeCare Neuro'),
                    CustomerOrderProductScreenCard(title: 'LifeCare Neuro'),
                    CustomerOrderProductScreenCard(title: 'LifeCare Neuro'),
                    CustomerOrderProductScreenCard(title: 'LifeCare Neuro'),
                    CustomerOrderProductScreenCard(title: 'LifeCare Neuro'),
                    CustomerOrderProductScreenCard(title: 'LifeCare Neuro'),
                    CustomerOrderProductScreenCard(title: 'LifeCare Neuro'),
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
                      Icons.menu,
                      size: 25,
                    )),
                CommonSizedBox.width(context, 5),
                Text('Order Products',
                    style: TextStyle(
                      color: AllColors.blackColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    )),
                const Spacer(),
                Icon(
                  Icons.filter_list_outlined,
                  size: 15,
                  color: AllColors.lightGrey,
                ),
                CommonSizedBox.width(context, 5),
                Text(
                  'Filter',
                  style: TextStyle(
                      color: AllColors.lightGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                )
              ],
            )),
          ],
        ));
  }
}
