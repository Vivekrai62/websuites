import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../data/models/responseModels/login/login_response_model.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/drawer/custom_drawer.dart';
import '../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';
import '../../../viewModels/saveToken/save_token.dart';

class CustomerPaymentReminders extends StatefulWidget {
  const CustomerPaymentReminders({super.key});

  @override
  State<CustomerPaymentReminders> createState() =>
      _CustomerPaymentRemindersState();
}

class _CustomerPaymentRemindersState extends State<CustomerPaymentReminders> {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 140,
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
                          child: Text(
                            'Reminder to',
                            style: TextStyle(
                              color: AllColors.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
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
                          child: Text(
                            'By Status',
                            style: TextStyle(
                                color: AllColors.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
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
                          child: Text(
                            'Division',
                            style: TextStyle(
                              color: AllColors.blackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: Get.height / 3.3,
                    width: Get.width / 1,
                    decoration: BoxDecoration(
                        color: AllColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AllColors.blackColor.withOpacity(0.06),
                            spreadRadius: 2,
                            blurRadius: 4,
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Mr. Saurav Dhiman',
                                style: TextStyle(
                                  color: AllColors.blackColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              CommonSizedBox.width(context, 5),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: Get.height / 40,
                                  decoration: BoxDecoration(
                                    color: AllColors.lighterOrange,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Paid',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: AllColors.vividOrange),
                                    ),
                                  )),
                              const Spacer(),
                              Text(
                                '₹31,998',
                                style: TextStyle(
                                    color: AllColors.blackColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Ritelife Healthcare',
                                style: TextStyle(
                                  color: AllColors.welcomeColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_drop_down_sharp,
                                size: 25,
                              ),
                            ],
                          ),
                          Text(
                            'Product Super 50(Quaterly)',
                            style: TextStyle(
                                color: AllColors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          const Divider(
                            thickness: 0.4,
                          ),
                          Row(
                            children: [
                              Text(
                                'ORDER ID',
                                style: TextStyle(
                                  color: AllColors.lightGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'REMINDER TO',
                                style: TextStyle(
                                    color: AllColors.lightGrey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '#002572',
                                style: TextStyle(
                                  color: AllColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Shubham Saini',
                                style: TextStyle(
                                    color: AllColors.blackColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          CommonSizedBox.height(context, 10),
                          Row(
                            children: [
                              Text(
                                'CREATED BY',
                                style: TextStyle(
                                  color: AllColors.lightGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'CREATED AT',
                                style: TextStyle(
                                    color: AllColors.lightGrey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: Get.height / 40,
                                decoration: BoxDecoration(
                                    color: AllColors.lighterPurple,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    'Manish Jindal',
                                    style: TextStyle(
                                      color: AllColors.vividPurple,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'May 31, 2024, 10:47 AM',
                                style: TextStyle(
                                    color: AllColors.blackColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          CommonSizedBox.height(context, 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CHEQUE',
                                style: TextStyle(
                                  color: AllColors.lightGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                'CHEQUE/REMINDER',
                                style: TextStyle(
                                    color: AllColors.lightGrey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Aug-5bf9.jpg',
                                style: TextStyle(
                                  color: AllColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                'May 31, 2024, 10:47AM',
                                style: TextStyle(
                                    color: AllColors.blackColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height / 6,
                    width: Get.width / 1,
                    decoration: BoxDecoration(
                        color: AllColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: AllColors.blackColor.withOpacity(0.06),
                              spreadRadius: 2,
                              blurRadius: 4)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Mr. Sourav Dhiman',
                                style: TextStyle(
                                  color: AllColors.blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                              CommonSizedBox.width(context, 5),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                height: Get.height / 40,
                                decoration: BoxDecoration(
                                  color: AllColors.lighterOrange,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'Pending',
                                    style: TextStyle(
                                        color: AllColors.vividOrange,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '₹45,678',
                                style: TextStyle(
                                  color: AllColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ritelife Healthcare',
                                style: TextStyle(
                                    color: AllColors.welcomeColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Icon(
                                Icons.arrow_drop_down_sharp,
                                size: 30,
                              )
                            ],
                          ),
                          Text(
                            'Product Super 50(Quarterly)',
                            style: TextStyle(
                              color: AllColors.lightGrey,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          const Divider(
                            thickness: 0.4,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.call_rounded,
                                size: 20,
                                color: AllColors.lightGrey,
                              ),
                              Text(
                                '+91-9876512345',
                                style: TextStyle(
                                    color: AllColors.lightGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              const Spacer(),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                height: Get.height / 40,
                                decoration: BoxDecoration(
                                    color: AllColors.lightGreen,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    'Manish jindal',
                                    style: TextStyle(
                                      color: AllColors.darkGreen,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
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
                  ),
                ),
                CommonSizedBox.width(context, 5),
                Text(
                  'Payment Reminder',
                  style: TextStyle(
                      color: AllColors.blackColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Icon(
                  Icons.search,
                  size: 25,
                  color: AllColors.lightGrey,
                ),
                CommonSizedBox.width(context, 5),
                Container(
                    height: Get.height / 30,
                    width: Get.width / 12,
                    decoration: BoxDecoration(
                        color: AllColors.mediumPurple,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Icon(
                        Icons.upload,
                        size: 22,
                        color: AllColors.whiteColor,
                      ),
                    ))
              ],
            ))
          ],
        ));
  }
}
