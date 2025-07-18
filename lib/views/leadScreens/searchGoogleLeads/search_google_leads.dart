import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/responseModels/login/login_response_model.dart';
import '../../../resources/imageStrings/image_strings.dart';
import '../../../resources/strings/strings.dart';
import '../../../resources/textStyles/text_styles.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';

import '../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';
import '../../../viewModels/saveToken/save_token.dart';
import '../createNewLead/widgets/createNewLeadCard/common_text_field.dart';

class SearchGoogleLeads extends StatefulWidget {
  const SearchGoogleLeads({super.key});

  @override
  State<SearchGoogleLeads> createState() => _SearchGoogleLeadsState();
}

class _SearchGoogleLeadsState extends State<SearchGoogleLeads> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  SaveUserData userPreference = SaveUserData();

  String userName = '';
  String? userEmail = "";

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
        //     userName: userName, phoneNumber: '$userEmail', version: '1.0.12'),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 130, left: 30, right: 20),
              child: Image.asset(
                ImageStrings.worldMap,
                scale: 1,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 140,
                  ),
                  Center(
                    child: TextStyles.w700_16(
                        color: AllColors.vividPurple,
                        context,
                        Strings.findActiveSmall),
                  ),
                  Center(
                    child: TextStyles.w700_16(
                        color: AllColors.vividPurple,
                        context,
                        Strings.andPlacesOnGoogleMap),
                  ),
                  CommonSizedBox.height(context,11),
                  TextStyles.w500_14_Black(context, Strings.searchLead),
                  const CommonTextField(hintText: Strings.search),
                  CommonSizedBox.height(context, 7.5),
                  TextStyles.w500_14_Black(context, Strings.byLocation),
                  const CommonTextField(
                      hintText: Strings.enterLocation),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: Get.height / 24,
                        width: Get.width / 4,
                        decoration: BoxDecoration(
                          color: AllColors.mediumPurple,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child:
                              TextStyles.w500_14_White(context, Strings.search),
                        ),
                      ),
                    ],
                  )
                ],
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
                      child: Icon(
                        Icons.menu_sharp,
                        size: 25,
                        color: AllColors.blackColor,
                      )),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextStyles.w700_16(
                          color: AllColors.blackColor,
                          context,
                          Strings.searchGoogleLeads))
                ],
              ),
            ),
          ],
        ));
  }
}
