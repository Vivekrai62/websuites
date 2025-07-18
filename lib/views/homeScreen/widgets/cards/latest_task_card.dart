import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/appColors/app_colors.dart';

class LatestTaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final IconData ContainerIcon;
  final Color IconColor;
  final Color statusBackgroundColor;
  final String statusText;

  const LatestTaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.ContainerIcon,
    required this.IconColor,
    required this.statusBackgroundColor,
    required this.statusText,
  });

  // @override
  // Widget build(BuildContext context) {
  //   return
  //       Container(
  //       height: Get.height / 9.5,
  //       width: Get.width / 1.05,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black45.withOpacity(0.06),
  //             spreadRadius: 0.5,
  //             blurRadius: 4,
  //             offset: const Offset(0, 0),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.only( left: 12),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   title,
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.w400,
  //                     fontSize: 12,
  //                     color: Color(0xff4d4d4d),
  //                     fontFamily: Fonts.nunitoRegular,
  //                   ),
  //                 ),
  //                 SizedBox(height: 3,),
  //                 Text(
  //                   subtitle,
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.w500,
  //                     fontSize: 15,
  //                     color: Colors.black,
  //                     fontFamily: Fonts.nunitoRegular,
  //                   ),
  //                 ),
  //                 SizedBox(height: 3,),
  //
  //
  //                 Row(
  //                   children: [
  //                     Icon(Icons.access_time, size: 15, color: App_Colors.vividPurple,),
  //                     SizedBox(width: 5,),
  //
  //                     Text(
  //                       date,
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.w400,
  //                         fontSize: 11,
  //                         color: Color(0xff5131ff),
  //                         fontFamily: Fonts.nunitoRegular,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const Spacer(),
  //           Container(
  //             margin: const EdgeInsets.only(top: 6, bottom: 6, right: 7),
  //             padding: const EdgeInsets.only(top: 6, bottom: 8, right: 4),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     Container(
  //                       height: Get.height / 30,
  //                       width: Get.width / 14,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10),
  //                         color: statusBackgroundColor,
  //                       ),
  //                       child:
  //                       Icon(
  //                         ContainerIcon,
  //                         size: 15,
  //                         color: IconColor,
  //
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const Spacer(),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     Container(
  //                       height: Get.height / 55,
  //                       width: Get.width / 5.5,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10),
  //                         color: statusBackgroundColor.withOpacity(0.5),
  //                       ),
  //                       child: Center(
  //                         child: Text(
  //                           statusText,
  //                           style: TextStyle(
  //                             fontFamily: Fonts.nunitoRegular,
  //                             fontSize: 9,
  //                             color: IconColor,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //             );
  //
  //
  //     // Container(
  //     //   height: Get.height / 9.5,
  //     //   width: Get.width / 1.05,
  //     //   decoration: BoxDecoration(
  //     //     color: Colors.white,
  //     //     borderRadius: BorderRadius.circular(10),
  //     //     boxShadow: [
  //     //       BoxShadow(
  //     //         color: Colors.black45.withOpacity(0.06),
  //     //         spreadRadius: 0.5,
  //     //         blurRadius: 4,
  //     //         offset: const Offset(0, 0),
  //     //       ),
  //     //     ],
  //     //   ),
  //     //   child: Row(
  //     //     children: [
  //     //       Container(
  //     //         padding: const EdgeInsets.only(left: 12),
  //     //         child: Column(
  //     //           crossAxisAlignment: CrossAxisAlignment.start,
  //     //           mainAxisAlignment: MainAxisAlignment.center,
  //     //           children: [
  //     //             Text(
  //     //               title,
  //     //               style: const TextStyle(
  //     //                 fontWeight: FontWeight.w400,
  //     //                 fontSize: 16,
  //     //                 color: Colors.black,
  //     //                 fontFamily: Fonts.nunitoRegular,
  //     //               ),
  //     //             ),
  //     //             SizedBox(height: 4,),
  //     //             Text(
  //     //               subtitle,
  //     //               style: const TextStyle(
  //     //                 fontWeight: FontWeight.w500, fontSize: 19,
  //     //                 color: Colors.black,
  //     //                 fontFamily: Fonts.nunitoRegular,
  //     //               ),
  //     //             ),
  //     //             const SizedBox(height: 4,),
  //     //             Row(
  //     //               children: [
  //     //                 const Icon(
  //     //                   Icons.access_time, size: 18, color: Color(0xff5131ff),),
  //     //
  //     //                 SizedBox(width: 4,),
  //     //
  //     //                 Text(
  //     //                   date,
  //     //                   style: const TextStyle(
  //     //                     fontWeight: FontWeight.w400,
  //     //                     fontSize: 15,
  //     //                     color: Color(0xff5131ff),
  //     //                     fontFamily: Fonts.nunitoRegular,
  //     //                   ),
  //     //                 ),
  //     //               ],
  //     //             ),
  //     //           ],
  //     //         ),
  //     //       ),
  //     //       const Spacer(),
  //     //
  //     //       Container(
  //     //         margin: const EdgeInsets.only(top: 17.5, bottom: 15, right: 17),
  //     //         child: Column(
  //     //           crossAxisAlignment: CrossAxisAlignment.end,
  //     //           children: [
  //     //             Row(
  //     //               mainAxisAlignment: MainAxisAlignment.end,
  //     //               children: [
  //     //                 Container(
  //     //                   height: Get.height / 26,
  //     //                   width: Get.width / 17,
  //     //                   decoration: BoxDecoration(
  //     //                     borderRadius: BorderRadius.circular(10),
  //     //                     color: statusBackgroundColor,
  //     //                   ),
  //     //                   child:
  //     //                   Icon(
  //     //                     ContainerIcon,
  //     //                     size: 23,
  //     //                     color: IconColor,
  //     //                   ),
  //     //                 ),
  //     //               ],
  //     //             ),
  //     //             SizedBox(height: 17,),
  //     //             Row(
  //     //               mainAxisAlignment: MainAxisAlignment.end,
  //     //               children: [
  //     //                 Container(
  //     //                   height: Get.height / 45,
  //     //                   width: Get.width / 6,
  //     //                   decoration: BoxDecoration(
  //     //                     borderRadius: BorderRadius.circular(20),
  //     //                     color: statusBackgroundColor.withOpacity(0.5),
  //     //                   ),
  //     //                   child: Center(
  //     //                     child: Text(
  //     //                       statusText,
  //     //                       style: TextStyle(
  //     //                         fontFamily: Fonts.nunitoRegular,
  //     //                         fontSize: 13,
  //     //                         color: IconColor,
  //     //                       ),
  //     //                     ),
  //     //                   ),
  //     //                 ),
  //     //               ],
  //     //             ),
  //     //           ],
  //     //         ),
  //     //       ),
  //     //     ],
  //     //   ),
  //     // );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       final isTablet = constraints.maxWidth > 600;
  //
  //       return Container(
  //         height: isTablet ? Get.height / 9.5 : Get.height / 10,
  //         width: isTablet ? Get.width / 1.5 : Get.width / 1.05,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(10),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black45.withOpacity(0.06),
  //               spreadRadius: 0.5,
  //               blurRadius: 4,
  //               offset: const Offset(0, 0),
  //             ),
  //           ],
  //         ),
  //         child: Row(
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.only(left: 12),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     title,
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w400,
  //                       fontSize: isTablet ? 14 : 12,
  //                       color: const Color(0xff4d4d4d),
  //                       fontFamily: Fonts.nunitoRegular,
  //                     ),
  //                   ),
  //                   SizedBox(height: isTablet ? 4 : 3),
  //                   Text(
  //                     subtitle,
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w500,
  //                       fontSize: isTablet ? 17 : 15,
  //                       color: Colors.black,
  //                       fontFamily: Fonts.nunitoRegular,
  //                     ),
  //                   ),
  //                   SizedBox(height: isTablet ? 4 : 3),
  //                   Row(
  //                     children: [
  //                       Icon(Icons.access_time, size: isTablet ? 17 : 15, color: App_Colors.vividPurple),
  //                       SizedBox(width: 5),
  //                       Text(
  //                         date,
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w400,
  //                           fontSize: isTablet ? 13 : 11,
  //                           color: const Color(0xff5131ff),
  //                           fontFamily: Fonts.nunitoRegular,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const Spacer(),
  //             Container(
  //               margin: const EdgeInsets.only(top: 6, bottom: 6, right: 7),
  //               padding: const EdgeInsets.only(top: 6, bottom: 8, right: 4),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       Container(
  //                         height: isTablet ? Get.height / 30 : Get.height / 55,
  //                         width: isTablet ? Get.width / 14 : Get.width / 5.5,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(10),
  //                           color: statusBackgroundColor,
  //                         ),
  //                         child: Icon(
  //                           ContainerIcon,
  //                           size: isTablet ? 20 : 15,
  //                           color: IconColor,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   const Spacer(),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       Container(
  //                         height: isTablet ? Get.height / 55 : Get.height / 75,
  //                         width: isTablet ? Get.width / 5.5 : Get.width / 8,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(10),
  //                           color: statusBackgroundColor.withOpacity(0.5),
  //                         ),
  //                         child: Center(
  //                           child: Text(
  //                             statusText,
  //                             style: TextStyle(
  //                               fontFamily: Fonts.nunitoRegular,
  //                               fontSize: isTablet ? 11 : 9,
  //                               color: IconColor,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(right: 12, left: 10, top: 4, bottom: 4),
      height: screenSize.height / 9.5,
      width: screenSize.width / 1.05,
      decoration: BoxDecoration(
        color: AllColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black45.withOpacity(0.06),
            spreadRadius: 0.5,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xff4d4d4d),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 15, color: AllColors.vividPurple),
                    const SizedBox(width: 5),
                    Text(
                      date,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xff5131ff),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            // color: Colors.blue,
            margin: const EdgeInsets.only(top: 6, bottom: 6, right: 7),
            padding: const EdgeInsets.only(top: 6, bottom: 8, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      // padding: EdgeInsets.symmetric(vertical: Get.height/100, horizontal: Get.width/100),
                      height: Get.height / 30,
                      width: Get.width / 12.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: statusBackgroundColor,
                      ),
                      child: Icon(
                        ContainerIcon,
                        size: 20,
                        color: IconColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 40, vertical: 7),
                      height: Get.height / 49,
                      width: Get.width / 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: statusBackgroundColor.withOpacity(0.5),
                      ),
                      child: Center(
                        child: Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 10,
                            color: IconColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppCardOneTab extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final IconData ContainerIcon;
  final Color IconColor;
  final Color statusBackgroundColor;
  final String statusText;

  const AppCardOneTab({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.ContainerIcon,
    required this.IconColor,
    required this.statusBackgroundColor,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(right: 12, left: 10, top: 5, bottom: 5),
      height: screenSize.height / 7,
      width: screenSize.width / 1.05,
      decoration: BoxDecoration(
        color: AllColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black45.withOpacity(0.06),
            spreadRadius: 0.5,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: Color(0xff4d4d4d),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 15, color: AllColors.vividPurple),
                    const SizedBox(width: 5),
                    Text(
                      date,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0xff5131ff),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            // color: Colors.blue,
            //margin: const EdgeInsets.only(top: 6, bottom: 6, right: 7),
            padding: const EdgeInsets.only(top: 16, bottom: 16, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      // padding: EdgeInsets.symmetric(vertical: Get.height/100, horizontal: Get.width/100),
                      height: Get.height / 20,
                      width: Get.width / 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: statusBackgroundColor,
                      ),
                      child: Icon(
                        ContainerIcon,
                        size: 25,
                        color: IconColor,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 13,),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 40, vertical: 7),
                      height: Get.height / 35,
                      width: Get.width / 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: statusBackgroundColor.withOpacity(0.5),
                      ),
                      child: Center(
                        child: Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 14,
                            color: IconColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
