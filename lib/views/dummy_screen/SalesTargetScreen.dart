// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:websuites/utils/datetrim/DateTrim.dart';
// import 'package:websuites/viewModels/sales/sales_viewModel.dart';
//
// import '../../utils/appColors/app_colors.dart';
// import '../salesTargetScreen/salesDetailsScreen/SalesDetailsScreen.dart';
//
// class SalesTargetScreen extends StatefulWidget {
//   const SalesTargetScreen({super.key});
//
//   @override
//   State<SalesTargetScreen> createState() => _SalesTargetScreenState();
// }
//
// class _SalesTargetScreenState extends State<SalesTargetScreen> {
//   final SalesViewModel salesViewModel = Get.put(SalesViewModel());
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch sales data when the screen is initialized
//     salesViewModel.salesApi(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Scaffold(
//         backgroundColor: Colors.white,
//
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           surfaceTintColor: Colors.white,
//           title: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("Sales Data"),
//             ],
//           ),
//         ),
//         body: salesViewModel.loading.value
//             ? Center(child: CircularProgressIndicator())
//             : salesViewModel.salesResponseModel.value.items != null &&
//             salesViewModel.salesResponseModel.value.items!.isNotEmpty
//             ? ListView.builder(
//           itemCount: salesViewModel.salesResponseModel.value.items!.length,
//           itemBuilder: (context, index) {
//             final item = salesViewModel.salesResponseModel.value.items![index];
//             return
//               Padding(
//                 padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
//                 child: GestureDetector(
//                   onTap: (){
//                     Get.to(() => Salesdetailsscreen());
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(bottom: 10),
//                     height: Get.height / 5.3,
//                     width: Get.width / 1,
//                     decoration: BoxDecoration(
//                         color: AllColors.whiteColor,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                               color: AllColors.blackColor.withOpacity(0.06),
//                               spreadRadius: 2,
//                               blurRadius: 4)
//                         ]),
//                     child: Padding(
//                       padding: const EdgeInsets.all(13),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                Navigator.push(context, MaterialPageRoute(builder: (context) => Salesdetailsscreen(),));
//                                 },
//                                 child: Text(
//                                   item.name ?? 'N/A',
//                                   style: TextStyle(
//                                     color: AllColors.blackColor,
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ),
//
//
//                             ],
//                           ),
//
//                           Row(
//                             children: [
//                               Text(
//                                 'START DATE - ',
//                                 style: TextStyle(
//                                   fontSize: 12,
//
//                                   fontWeight: FontWeight.w600,
//                                   color: AllColors.blackColor,
//                                 ),
//                               ),
//                               Text(
//                                 formatDateToLongMonth2(
//                                     item?.startDate != null ? DateTime.parse(item!.startDate.toString()) : DateTime.now()
//                                 ),
//                                 style: TextStyle(
//                                   color: AllColors.grey,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 12,
//                                 ),
//                               ),
//
//                               const Spacer(),
//                               Text(
//                                 item.members != null && item.members!.isNotEmpty && item.members![0].saleTarget != null
//                                     ? '₹${item.members![0].saleTarget}'
//                                     : '₹N/A',
//                                 style: TextStyle(
//                                   color: AllColors.blackColor,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.calendar_month_outlined,
//                                 size: 16,
//                                 color: AllColors.mediumPurple,
//                               ),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                               Text(
//                                 item.createdAt.toString() ??'n/a',
//                                 style: TextStyle(
//                                   color: AllColors.mediumPurple,
//                                   fontSize: 12,
//
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               const Spacer(),
//                               Text(
//                                 'DEADLINE - ',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//
//                                     fontSize: 12,
//                                     color: AllColors.blackColor),
//                               ),
//                               Text(
//                                 'okk',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   color: AllColors.grey,
//                                   fontSize: 12,
//
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const Divider(
//                             thickness: 0.4,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'MEMBERS - ',
//                                 style: TextStyle(
//                                   color: AllColors.blackColor,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               if (item.members != null && item.members!.isNotEmpty) ...[
//                                 Text(
//                                   "${item.members![0].saleTarget ?? 'N/A'}",
//                                   style: TextStyle(
//                                     color: AllColors.blackColor,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//
//                               const Spacer(),
//                               Image.asset('assets/svg/report.svg',height: 14,width: 14,),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                               Text(
//                                 'REPORT',
//                                 style: TextStyle(
//                                     color: AllColors.blackColor,
//
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//           },
//         )
//             : Center(child: Text("No sales data available")),
//       );
//     });
//   }
// }