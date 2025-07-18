// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
//
// import '../../../../utils/appColors/app_colors.dart';
// import '../../../../utils/components/widgets/sizedBoxes/sizedBox_5w.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
//
// import 'package:permission_handler/permission_handler.dart';
//
// class OrderPaymentScreenCard extends StatefulWidget {
//   final String title;
//   final String paid;
//   final String name;
//   final String payment;
//   final String uploadDocument;
//   final String productRenewal;
//   final String paymentMode;
//   final String paidOn;
//   final String product;
//   final String orderId;
//   final String paidProduct;
//   final String createdBy;
//   final String division;
//   final String amount;
//
//   const OrderPaymentScreenCard({
//     Key? key,
//     required this.title,
//     required this.paid,
//     required this.name,
//     required this.payment,
//     required this.uploadDocument,
//     required this.productRenewal,
//     required this.paymentMode,
//     required this.paidOn,
//     required this.product,
//     required this.orderId,
//     required this.paidProduct,
//     required this.createdBy,
//     required this.division,
//     required this.amount,
//   }) : super(key: key);
//
//   @override
//   State<OrderPaymentScreenCard> createState() => _OrderPaymentScreenCardState();
// }
//
// class _OrderPaymentScreenCardState extends State<OrderPaymentScreenCard> {
//   // New variable to track dropdown state
//   bool _isExpanded = false;
//   final Map<String, bool> _expandedState = {};
//
//   static const Map<String, String> _divisionLogos = {
//     'pharmahopers': 'assets/images/pharmahoperslogo-first-logo.png',
//     'webhopers infotech private limited':
//     'assets/images/webhopers-first-logo.png',
//     'development': 'assets/images/development-first-logo.png',
//     'seo': 'assets/images/seo.png',
//     'ppc': 'assets/images/ppc.png',
//     'webhopers': 'assets/images/webhopers-first-logo.png',
//     'wordpress': 'assets/images/wordpress-first-logo.png',
//   };
//
//   // Method to get logos for multiple divisions
//   List<Widget> _getDivisionLogos(String divisionsString) {
//     // Split divisions and trim whitespace
//     List<String> divisions = divisionsString
//         .toLowerCase()
//         .split(',')
//         .map((div) => div.trim())
//         .toList();
//
//     List<Widget> logos = [];
//
//     for (var division in divisions) {
//       // Check if logo exists for the division
//       if (_divisionLogos.containsKey(division)) {
//         logos.add(
//           Padding(
//             padding: const EdgeInsets.only(right: 0),
//             child: Image.asset(
//               _divisionLogos[division]!,
//               height: division == 'pharmahopers' ? 18 : 20,
//               width: division == 'webhopers infotech private limited' ? 20 : 30,
//               fit: BoxFit.contain,
//             ),
//           ),
//         );
//       }
//     }
//
//     return logos;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> divisionLogos = _getDivisionLogos(widget.division);
//
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 10), // Smooth transition
//       height: _isExpanded ? 500 : 500, // Adjust these values as needed
//       child: ContainerUtils(
//         child: SingleChildScrollView( // Add this to handle overflow if content exceeds height
//           physics: const NeverScrollableScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _isExpanded = !_isExpanded;
//                   });
//                 },
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: Text(
//                             widget.title,
//                             style: TextStyle(
//                               color: AllColors.blackColor,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                           ),
//                         ),
//                         Spacer(flex: 1),
//                         Container(
//                           height: 27,
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           decoration: BoxDecoration(
//                             color: widget.paid.toLowerCase() == 'pending'
//                                 ? AllColors.lightYellow
//                                 : AllColors.greenJungleLight,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 widget.paid,
//                                 style: TextStyle(
//                                   color: widget.paid.toLowerCase() == 'pending'
//                                       ? AllColors.darkYellow
//                                       : AllColors.greenJungle,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               if (widget.paid.toLowerCase() == 'pending') ...[
//                                 SizedBox(width: 5),
//                                 Builder(
//                                   builder: (BuildContext context) {
//                                     return GestureDetector(
//                                       onTap: () {
//                                         final RenderBox button = context.findRenderObject() as RenderBox;
//                                         final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
//                                         final RelativeRect position = RelativeRect.fromRect(
//                                             Rect.fromPoints(
//                                                 button.localToGlobal(Offset.zero, ancestor: overlay),
//                                                 button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay)),
//                                             Offset.zero & overlay.size);
//
//                                         showMenu(
//                                           color: Colors.white,
//                                           context: context,
//                                           position: position,
//                                           items: [
//                                             PopupMenuItem(value: 'approved', child: Text('Approved')),
//                                             PopupMenuItem(value: 'pending', child: Text('Pending')),
//                                             PopupMenuItem(value: 'cancel', child: Text('Cancel')),
//                                           ],
//                                         );
//                                       },
//                                       child: Icon(
//                                         Icons.arrow_drop_down_sharp,
//                                         size: 20,
//                                         color: AllColors.darkYellow,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ],
//                           ),
//                         ),
//                         Icon(
//                           _isExpanded ? Icons.arrow_drop_up_sharp : Icons.arrow_drop_down_sharp,
//                           size: 30,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Text(
//                           widget.name,
//                           style: TextStyle(
//                             color: AllColors.grey,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 12,
//                           ),
//                         ),
//                         Spacer(),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset('assets/svg/fresh.png', height: 14, width: 14),
//                             SizedBox(width: 9),
//                             Text(
//                               widget.payment,
//                               style: TextStyle(
//                                 color: AllColors.mediumPurple,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 15),
//                     Divider(),
//                     if (!_isExpanded) ...[
//                       SizedBox(height: 17),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Wrap(spacing: 4.0, runSpacing: 4.0, children: divisionLogos),
//                           Spacer(),
//                           Text(
//                             widget.amount,
//                             style: TextStyle(
//                               color: AllColors.blackColor,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 19,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               if (_isExpanded) ...[
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Image.asset('assets/icons/menuRemark.png', height: 14, width: 13),
//                         SizedBox(width: 11),
//                         Expanded(
//                           child: Text(
//                             widget.productRenewal,
//                             style: TextStyle(
//                               color: AllColors.grey,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                           ),
//                         ),
//                         Spacer(),
//                         InkWell(
//                           onTap: widget.paymentMode.toLowerCase() == 'online' && widget.uploadDocument.isNotEmpty
//                               ? () async {
//                             var status = await Permission.storage.request();
//                             if (status.isGranted) {
//                               try {
//                                 showDialog(
//                                   context: context,
//                                   barrierDismissible: false,
//                                   builder: (BuildContext context) => Center(child: CircularProgressIndicator()),
//                                 );
//                                 final response = await http.get(Uri.parse(widget.uploadDocument));
//                                 if (response.statusCode == 200) {
//                                   await ImageGallerySaver.saveImage(Uint8List.fromList(response.bodyBytes));
//                                   Navigator.of(context).pop();
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(content: Text('Document downloaded successfully'), backgroundColor: Colors.green),
//                                   );
//                                 } else {
//                                   Navigator.of(context).pop();
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(content: Text('Failed to download document'), backgroundColor: Colors.red),
//                                   );
//                                 }
//                               } catch (e) {
//                                 Navigator.of(context).pop();
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text('Failed to download document: $e'), backgroundColor: Colors.red),
//                                 );
//                               }
//                             }
//                           }
//                               : null,
//                           child: widget.paymentMode.toLowerCase() == 'online' && widget.uploadDocument.isNotEmpty
//                               ? Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text('Doc', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.blue)),
//                               SizedBox(width: 3),
//                               Image.asset('assets/icons/document.png', height: 15, width: 15),
//                             ],
//                           )
//                               : Container(
//                             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.blue.withOpacity(0.1)),
//                             child: Text(
//                               widget.paymentMode,
//                               style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.blue),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 5),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Icon(Icons.calendar_month_outlined, size: 16, color: AllColors.mediumPurple),
//                         SizedBox5w(),
//                         Text(
//                           widget.paidOn,
//                           style: TextStyle(color: AllColors.grey, fontSize: 13, fontWeight: FontWeight.w400),
//                         ),
//                         Spacer(),
//                         Text(
//                           widget.product,
//                           style: TextStyle(color: AllColors.grey, fontSize: 12, fontWeight: FontWeight.w400),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Text(
//                           'Order Id',
//                           style: TextStyle(color: AllColors.blackColor, fontWeight: FontWeight.w600, fontSize: 13),
//                         ),
//                         SizedBox(width: 5),
//                         Text(
//                           widget.orderId,
//                           style: TextStyle(color: AllColors.lightGrey, fontWeight: FontWeight.w600, fontSize: 13),
//                         ),
//                         Spacer(),
//                         Container(
//                           height: 27,
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           decoration: BoxDecoration(color: AllColors.lightRed, borderRadius: BorderRadius.circular(20)),
//                           child: Center(
//                             child: Text(
//                               widget.paidProduct,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(color: AllColors.vividRed, fontWeight: FontWeight.w500, fontSize: 12),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AllColors.lighterPurple),
//                       child: Text(
//                         widget.createdBy,
//                         style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AllColors.vividPurple),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Divider(thickness: 0.4),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Row(children: divisionLogos),
//                         Spacer(),
//                         Text(
//                           widget.amount,
//                           style: TextStyle(color: AllColors.blackColor, fontWeight: FontWeight.w600, fontSize: 19),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
