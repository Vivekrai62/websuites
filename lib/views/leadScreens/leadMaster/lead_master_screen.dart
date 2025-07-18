import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:websuites/views/leadScreens/leadMaster/widgets/leadMasterCard/lead_master_card.dart';
import '../../../data/models/responseModels/login/login_response_model.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../resources/strings/strings.dart';
import '../../../resources/textStyles/text_styles.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../viewModels/saveToken/save_token.dart';

class LeadMasterScreen extends StatefulWidget {
  const LeadMasterScreen({super.key});

  @override
  State<LeadMasterScreen> createState() => _LeadMasterScreenState();
}

class _LeadMasterScreenState extends State<LeadMasterScreen> {
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
      //     userName: '$userName', phoneNumber: '$userEmail', version: '1.0.12'),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: Get.height / 30,
                        width: Get.width / 3.5,
                        decoration: BoxDecoration(
                          color: AllColors.mediumPurple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: TextStyles.w400_15(
                              color: AllColors.whiteColor,
                              context,
                              Strings.types),
                        ),
                      ),
                      Container(
                        height: Get.height / 30,
                        width: Get.width / 3.5,
                        decoration: BoxDecoration(
                          color: AllColors.textField2,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: TextStyles.w400_15(
                              color: AllColors.blackColor,
                              context,
                              Strings.source),
                        ),
                      ),
                      Container(
                        height: Get.height / 30,
                        width: Get.width / 3.5,
                        decoration: BoxDecoration(
                          color: AllColors.textField2,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: TextStyles.w400_15(
                              color: AllColors.blackColor,
                              context,
                              Strings.status),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextStyles.w500_14_Black(
                      context, Strings.availableLeadStatus),
                  const SizedBox(
                    height: 20,
                  ),
                  const LeadMasterScreenCard(title: 'Cold', activity: 'Active'),
                  const LeadMasterScreenCard(
                      title: 'Hot', activity: 'In Progress'),
                  const LeadMasterScreenCard(
                      title: 'Hot', activity: 'Completed'),
                  const LeadMasterScreenCard(title: 'Cold', activity: 'Active'),
                  const LeadMasterScreenCard(title: 'Cold', activity: 'Active'),
                  const LeadMasterScreenCard(
                      title: 'Cold', activity: 'In Progress'),
                  const SizedBox(height: 50),
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
                    color: AllColors.blackColor, context, Strings.leadMaster),
                const Spacer(),
                Icon(
                  Icons.search,
                  size: 20,
                  color: AllColors.lightGrey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: Get.height / 30,
                  decoration: BoxDecoration(
                      color: AllColors.mediumPurple,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: TextStyles.w500_12(
                        color: AllColors.whiteColor,
                        context,
                        Strings.addLeadType),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
