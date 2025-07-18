import 'package:flutter/material.dart';
import '../../../data/models/responseModels/login/login_response_model.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';

import '../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';
import '../../../viewModels/saveToken/save_token.dart';

class CustomerMyTeamScreen extends StatefulWidget {
  const CustomerMyTeamScreen({super.key});

  @override
  State<CustomerMyTeamScreen> createState() => _CustomerMyTeamScreenState();
}

class _CustomerMyTeamScreenState extends State<CustomerMyTeamScreen> {
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
      backgroundColor: AllColors.whiteColor,
      // drawer: CustomDrawer(
      //     userName: userName, phoneNumber: userEmail, version: '1.0.12'),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User',
                      style: TextStyle(
                          color: AllColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Text(
                      'T.Customers',
                      style: TextStyle(
                        color: AllColors.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Anshuman Khurana',
                      style: TextStyle(
                        color: AllColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '234',
                      style: TextStyle(
                          color: AllColors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    )
                  ],
                ),
                const Divider(
                  thickness: 0.7,
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Anmol Rana',
                      style: TextStyle(
                        color: AllColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '345',
                      style: TextStyle(
                          color: AllColors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    )
                  ],
                ),
                const Divider(
                  thickness: 0.7,
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ashu Kumar',
                      style: TextStyle(
                        color: AllColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '265',
                      style: TextStyle(
                          color: AllColors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    )
                  ],
                ),
                const Divider(
                  thickness: 0.7,
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ankit Pathak',
                      style: TextStyle(
                        color: AllColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '143',
                      style: TextStyle(
                          color: AllColors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    )
                  ],
                ),
              ],
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
                'My Team',
                style: TextStyle(
                  color: AllColors.blackColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
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
                    fontSize: 15),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
