import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../../../data/models/responseModels/leads/list/lead_list.dart';
import '../../../../../utils/appColors/app_colors.dart';
import '../../../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../../../utils/fontfamily/FontFamily.dart';

import '../../../homeScreen/home_manager/HomeManagerScreen.dart';
import '../../createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../../leadList/lead_deatils/LeadDetails.dart';

class LeadProformaCreateScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Item?
      orderItem; // Optional: Pass lead item if needed for proforma creation

  const LeadProformaCreateScreen({
    super.key,
    required this.scaffoldKey,
    this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeManagerController>();
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
              child: Row(
                children: [
                  if (!isTablet)
                    IconButton(
                      icon: const Icon(Icons.menu,
                          color: Colors.black, size: 25),
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      homeController.lastScreen.value = LeadDetailsScreen(
                        orderItem: orderItem,
                        scaffoldKey: homeController.scaffoldKey,
                      );
                      homeController.update();
                    },
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.back),
                        const SizedBox(width: 8),
                        Text(
                          "Back",
                          style: TextStyle(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.sfPro,
                            fontSize: 17.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Create Proforma",
                    style: TextStyle(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 17.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContainerUtils(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Items",style: TextStyle(fontWeight: FontWeight.w600,fontFamily: FontFamily.sfPro,fontSize: 17),),
                              SizedBox(width: 10,),
                              Icon(Icons.production_quantity_limits_sharp,),
                              Spacer(),
                              Text("Add new item",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: FontFamily.sfPro,fontSize: 15,color: AllColors.mediumPurple))
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text("You Can Add Items Behalf of Division",style: TextStyle(fontSize: 14,fontFamily: FontFamily.sfPro,color: AllColors.grey,fontWeight: FontWeight.w500),),
                             SizedBox(width: 5,),
                              Icon(Icons.error_outline,color: AllColors.grey,size: 17,)
                            ],
                          ),
                          SizedBox(height: 10,),
                          CommonTextField(hintText: "Select Division",categories: ["hello"],),
                          SizedBox(height: 10,),
                          Divider(thickness: 0.4,),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text('Evion',style: TextStyle(fontWeight: FontWeight.w500,fontFamily: FontFamily.sfPro,fontSize: 16.5,color: AllColors.blackColor)),
                              Spacer(),
                              Text('₹19999',style: TextStyle(fontWeight: FontWeight.w500,fontFamily: FontFamily.sfPro,fontSize: 16.5,color: AllColors.darkGreen)),

                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text('Serviceable',style: TextStyle(fontWeight: FontWeight.w500,fontFamily: FontFamily.sfPro,fontSize: 16,color: AllColors.grey)),
                              Spacer(),
                              Icon(Icons.shopping_cart_outlined,color: AllColors.figmaGrey,size: 20,),
                              SizedBox(width:5,),
                              Text('1',style: TextStyle(fontWeight: FontWeight.w500,fontFamily: FontFamily.sfPro,fontSize: 16.5,color: AllColors.figmaGrey)),

                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Baseline(

                                  baseline: 25, // Same as image height or font size
                                  baselineType: TextBaseline.alphabetic,
                                  child: Image.asset(ImageStrings.receive,color: AllColors.darkGreen,height: 22,width: 22,)),
                              SizedBox(width:5,),
                              Text('0',style: TextStyle(fontWeight: FontWeight.w500,fontFamily: FontFamily.sfPro,fontSize: 16.5,color: AllColors.darkGreen)),
                        const Spacer(),
                              Text('Sub Total:-',style: TextStyle(fontWeight: FontWeight.w500,fontFamily: FontFamily.sfPro,fontSize: 15,color: AllColors.mediumPurple)),
                              SizedBox(width:5,),
                              Text('₹19999',style: TextStyle(fontWeight: FontWeight.w500,fontFamily: FontFamily.sfPro,fontSize: 15,color: AllColors.mediumPurple)),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Container(
                                  alignment: Alignment.center,
                                  padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AllColors.background_green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                  child: Text('Duration : 22-04-2025 To 22-04-2025',style: TextStyle(fontWeight: FontWeight.w400,fontFamily: FontFamily.sfPro,fontSize: 15,color: AllColors.text__green))),

                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Image.asset(ImageStrings.splashWHLogo,height: 22,width: 22,),
                              Spacer(),
                              Text('₹19999',style: TextStyle(fontWeight: FontWeight.w500,fontFamily: FontFamily.sfPro,fontSize: 15,color: AllColors.blackColor)),
                              SizedBox(width: 10,),
                              Container(
                                  alignment: Alignment.center,
                                  padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AllColors.lightRed,
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                  child: Text("Remove",style: TextStyle(fontWeight: FontWeight.w600,fontFamily: FontFamily.sfPro,fontSize: 13,color: AllColors.vividRed),)),
                              
                              

                            ],
                          ),
                          SizedBox(height: 20,),





                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    CommonButton(
                        width: double.infinity,
                        color: AllColors.background_green,
                        textColor: AllColors.text__green,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        borderColor: AllColors.darkGreen,
                        title: 'Generate Proforma', onPress: (){})


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
