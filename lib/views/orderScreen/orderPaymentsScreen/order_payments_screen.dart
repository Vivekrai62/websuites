import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/responseModels/customers/list/customers_list_response_model.dart'
    as customer_model;
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/components/widgets/sizedBoxes/sized_box_components.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/customerScreens/customer_list/customer_list_viewModel.dart';
import '../../../viewModels/order/payments/order_payments_viewModel.dart';

class OrderPaymentsScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onOrderSelected;

  const OrderPaymentsScreen({
    super.key,
    required this.scaffoldKey,
    this.onOrderSelected,
  });

  @override
  _OrderPaymentsScreenState createState() => _OrderPaymentsScreenState();
}

class _OrderPaymentsScreenState extends State<OrderPaymentsScreen> {
  final Map<String, bool> _expandedState = {};
  final CustomerListViewModel _viewModel = Get.put(CustomerListViewModel());
  final OrderPaymentsViewModel controller = Get.put(OrderPaymentsViewModel());
  bool isFloatingButtonClicked = false;
  TextEditingController searchController = TextEditingController();

  // Refresh method to fetch both customer and payment data
  Future<void> _refreshData() async {
    try {
      await Future.wait([
        _viewModel.customersListApi(context, forceRefresh: true),
        // Assuming this method supports forceRefresh
        controller.orderPayment(forceRefresh: true),
      ]);
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    if (controller.orderPayments.isEmpty) {
      controller.orderPayment();
    }
    if (_viewModel.customers.isEmpty) {
      _viewModel.customersListApi(context);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          setState(() {
            isFloatingButtonClicked = !isFloatingButtonClicked;
          });
        },
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: DarkMode.backgroundColor(context),
      body: Obx(() {
        if (controller.loading.value && controller.orderPayments.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            CustomAppBar(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
                child: Row(
                  children: [
                    if (!isTablet)
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        onPressed: () {
                          widget.scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                    if (isTablet) const SizedBox(width: 10),
                    Text(
                      'Payment List',
                      style: TextStyle(
                        color: AllColors.blackColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.sfPro,
                        fontSize: 17.5,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        // Add filter functionality here if needed
                      },
                      child: const Icon(Icons.filter_list, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshData,
                color: AllColors.mediumPurple, // Custom refresh indicator color
                backgroundColor: Colors.white,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (controller.orderPayments.isEmpty) {
                      return const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Center(child: Text("No payments available")),
                      );
                    }

                    final double screenWidth = constraints.maxWidth;
                    int columns = screenWidth < 600
                        ? 1
                        : screenWidth < 1200
                            ? 2
                            : 3;
                    int rowCount =
                        (controller.orderPayments.length / columns).ceil();
                    List<Widget> rows = [];

                    for (int i = 0; i < rowCount; i++) {
                      List<Widget> rowChildren = [];

                      for (int j = 0; j < columns; j++) {
                        final int index = i * columns + j;
                        if (index < controller.orderPayments.length) {
                          final payment = controller.orderPayments[index];
                          final orderId = payment.id ?? index.toString();
                          _expandedState.putIfAbsent(orderId, () => false);

                          rowChildren.add(
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _expandedState[orderId] =
                                          !_expandedState[orderId]!;
                                    });
                                  },
                                  child: ContainerUtils(
                                    child: SingleChildScrollView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  payment.order?.company
                                                          ?.companyName ??
                                                      'N/A',
                                                  style: TextStyle(
                                                    color: AllColors.blackColor,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              const Spacer(flex: 1),
                                              Container(
                                                height: 27,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                decoration: BoxDecoration(
                                                  color: (payment.status ?? '')
                                                              .toLowerCase() ==
                                                          'pending'
                                                      ? AllColors.lightYellow
                                                      : AllColors
                                                          .greenJungleLight,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      payment.status ?? 'N/A',
                                                      style: TextStyle(
                                                        color: (payment.status ??
                                                                        '')
                                                                    .toLowerCase() ==
                                                                'pending'
                                                            ? AllColors
                                                                .darkYellow
                                                            : AllColors
                                                                .greenJungle,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    if (payment.status
                                                            ?.toLowerCase() ==
                                                        'pending') ...[
                                                      const SizedBox(width: 5),
                                                      Builder(
                                                        builder: (BuildContext
                                                            context) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              final RenderBox
                                                                  button =
                                                                  context.findRenderObject()
                                                                      as RenderBox;
                                                              final RenderBox
                                                                  overlay =
                                                                  Overlay.of(context)
                                                                          .context
                                                                          .findRenderObject()
                                                                      as RenderBox;
                                                              final RelativeRect
                                                                  position =
                                                                  RelativeRect
                                                                      .fromRect(
                                                                Rect.fromPoints(
                                                                  button.localToGlobal(
                                                                      Offset
                                                                          .zero,
                                                                      ancestor:
                                                                          overlay),
                                                                  button.localToGlobal(
                                                                      button
                                                                          .size
                                                                          .bottomRight(Offset
                                                                              .zero),
                                                                      ancestor:
                                                                          overlay),
                                                                ),
                                                                Offset.zero &
                                                                    overlay
                                                                        .size,
                                                              );

                                                              showMenu(
                                                                color: Colors
                                                                    .white,
                                                                context:
                                                                    context,
                                                                position:
                                                                    position,
                                                                items: [
                                                                  const PopupMenuItem(
                                                                      value:
                                                                          'approved',
                                                                      child: Text(
                                                                          'Approved')),
                                                                  const PopupMenuItem(
                                                                      value:
                                                                          'pending',
                                                                      child: Text(
                                                                          'Pending')),
                                                                  const PopupMenuItem(
                                                                      value:
                                                                          'cancel',
                                                                      child: Text(
                                                                          'Cancel')),
                                                                ],
                                                              ).then((value) {
                                                                if (value !=
                                                                    null) {
                                                                  // Handle status update here if needed
                                                                  print(
                                                                      'Selected status: $value');
                                                                }
                                                              });
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_drop_down_sharp,
                                                              size: 20,
                                                              color: AllColors
                                                                  .darkYellow,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                _expandedState[orderId]!
                                                    ? Icons.arrow_drop_up_sharp
                                                    : Icons
                                                        .arrow_drop_down_sharp,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                '${payment.customer?.firstName ?? ''} ${payment.customer?.lastName ?? ''}'
                                                        .trim()
                                                        .isEmpty
                                                    ? 'Unknown'
                                                    : '${payment.customer?.firstName ?? ''} ${payment.customer?.lastName ?? ''}',
                                                style: TextStyle(
                                                  color: AllColors.grey,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const Spacer(),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                      'assets/svg/fresh.png',
                                                      height: 14,
                                                      width: 14),
                                                  const SizedBox(width: 9),
                                                  Text(
                                                    payment.isFresh == false
                                                        ? 'Fresh'
                                                        : 'Old',
                                                    style: TextStyle(
                                                      color: AllColors
                                                          .mediumPurple,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          const Divider(),
                                          if (!_expandedState[orderId]!) ...[
                                            const SizedBox(height: 17),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  payment.order?.division
                                                          ?.name ??
                                                      'N/A',
                                                  style: TextStyle(
                                                    color: AllColors.blackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '₹${payment.currencyAmount?.toStringAsFixed(2) ?? '0.00'}',
                                                  style: TextStyle(
                                                    color: AllColors.blackColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 19,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                          if (_expandedState[orderId]!) ...[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        'assets/icons/menuRemark.png',
                                                        height: 14,
                                                        width: 13),
                                                    const SizedBox(width: 11),
                                                    Expanded(
                                                      child: Text(
                                                        'No Product',
                                                        style: TextStyle(
                                                          color: AllColors.grey,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    // InkWell(
                                                    //   onTap: payment.paymentMode
                                                    //                   ?.toLowerCase() ==
                                                    //               'online' &&
                                                    //           payment.uploadDocument
                                                    //                   ?.isNotEmpty ==
                                                    //               true
                                                    //       ? () async {
                                                    //           var status =
                                                    //               await Permission
                                                    //                   .storage
                                                    //                   .request();
                                                    //           if (status
                                                    //               .isGranted) {
                                                    //             try {
                                                    //               showDialog(
                                                    //                 context:
                                                    //                     context,
                                                    //                 barrierDismissible:
                                                    //                     false,
                                                    //                 builder: (BuildContext
                                                    //                         context) =>
                                                    //                     const Center(
                                                    //                         child:
                                                    //                             CircularProgressIndicator()),
                                                    //               );
                                                    //
                                                    //               final documentUrl =
                                                    //                   payment
                                                    //                       .uploadDocument;
                                                    //               if (documentUrl !=
                                                    //                   null) {
                                                    //                 final response =
                                                    //                     await http
                                                    //                         .get(Uri.parse(documentUrl));
                                                    //                 if (response
                                                    //                         .statusCode ==
                                                    //                     200) {
                                                    //                   await ImageGallerySaver
                                                    //                       .saveImage(
                                                    //                           Uint8List.fromList(response.bodyBytes));
                                                    //                   Navigator.of(
                                                    //                           context)
                                                    //                       .pop();
                                                    //                   ScaffoldMessenger.of(
                                                    //                           context)
                                                    //                       .showSnackBar(
                                                    //                     const SnackBar(
                                                    //                         content:
                                                    //                             Text('Document downloaded successfully'),
                                                    //                         backgroundColor: Colors.green),
                                                    //                   );
                                                    //                 } else {
                                                    //                   Navigator.of(
                                                    //                           context)
                                                    //                       .pop();
                                                    //                   ScaffoldMessenger.of(
                                                    //                           context)
                                                    //                       .showSnackBar(
                                                    //                     const SnackBar(
                                                    //                         content:
                                                    //                             Text('Failed to download document'),
                                                    //                         backgroundColor: Colors.red),
                                                    //                   );
                                                    //                 }
                                                    //               } else {
                                                    //                 Navigator.of(
                                                    //                         context)
                                                    //                     .pop();
                                                    //                 ScaffoldMessenger.of(
                                                    //                         context)
                                                    //                     .showSnackBar(
                                                    //                   const SnackBar(
                                                    //                       content: Text(
                                                    //                           'No document URL available'),
                                                    //                       backgroundColor:
                                                    //                           Colors.red),
                                                    //                 );
                                                    //               }
                                                    //             } catch (e) {
                                                    //               Navigator.of(
                                                    //                       context)
                                                    //                   .pop();
                                                    //               ScaffoldMessenger.of(
                                                    //                       context)
                                                    //                   .showSnackBar(
                                                    //                 SnackBar(
                                                    //                     content:
                                                    //                         Text(
                                                    //                             'Failed to download document: $e'),
                                                    //                     backgroundColor:
                                                    //                         Colors.red),
                                                    //               );
                                                    //             }
                                                    //           }
                                                    //         }
                                                    //       : null,
                                                    //   child: payment.paymentMode
                                                    //                   ?.toLowerCase() ==
                                                    //               'online' &&
                                                    //           payment.uploadDocument
                                                    //                   ?.isNotEmpty ==
                                                    //               true
                                                    //       ? Row(
                                                    //           mainAxisSize:
                                                    //               MainAxisSize
                                                    //                   .min,
                                                    //           children: [
                                                    //             const Text(
                                                    //                 'Doc',
                                                    //                 style: TextStyle(
                                                    //                     fontSize:
                                                    //                         12,
                                                    //                     fontWeight:
                                                    //                         FontWeight
                                                    //                             .w400,
                                                    //                     color: Colors
                                                    //                         .blue)),
                                                    //             const SizedBox(
                                                    //                 width: 3),
                                                    //             Image.asset(
                                                    //                 'assets/icons/document.png',
                                                    //                 height: 15,
                                                    //                 width: 15),
                                                    //           ],
                                                    //         )
                                                    //       : Container(
                                                    //           padding:
                                                    //               const EdgeInsets
                                                    //                   .symmetric(
                                                    //                   horizontal:
                                                    //                       10,
                                                    //                   vertical:
                                                    //                       1),
                                                    //           decoration: BoxDecoration(
                                                    //               borderRadius:
                                                    //                   BorderRadius
                                                    //                       .circular(
                                                    //                           30),
                                                    //               color: Colors
                                                    //                   .blue
                                                    //                   .withOpacity(
                                                    //                       0.1)),
                                                    //           child: Text(
                                                    //             payment.paymentMode ??
                                                    //                 'N/A',
                                                    //             style: const TextStyle(
                                                    //                 fontSize:
                                                    //                     12,
                                                    //                 fontWeight:
                                                    //                     FontWeight
                                                    //                         .w400,
                                                    //                 color: Colors
                                                    //                     .blue),
                                                    //           ),
                                                    //         ),
                                                    // ),
                                                    const SizedBox(width: 5),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        size: 16,
                                                        color: AllColors
                                                            .mediumPurple),
                                                    CommonSizedBox.height(context, 2.5),
                                                    Text(
                                                      formatDateToLongMonth(
                                                              payment
                                                                  .createdAt) ??
                                                          'N/A',
                                                      style: TextStyle(
                                                          color: AllColors.grey,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      'N/A',
                                                      style: TextStyle(
                                                          color: AllColors.grey,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Order Id',
                                                      style: TextStyle(
                                                          color: AllColors
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      payment.order
                                                              ?.orderSerialNumber ??
                                                          '#00',
                                                      style: TextStyle(
                                                          color: AllColors
                                                              .lightGrey,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13),
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      height: 27,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15),
                                                      decoration: BoxDecoration(
                                                          color: AllColors
                                                              .lightRed,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Center(
                                                        child: Text(
                                                          'N/A',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: AllColors
                                                                  .vividRed,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 1),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: AllColors
                                                          .lighterPurple),
                                                  child: Text(
                                                    '${payment.createdBy?.firstName ?? ''} ${payment.createdBy?.lastName ?? ''}'
                                                        .trim(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AllColors
                                                            .vividPurple),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                const Divider(thickness: 0.4),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Text(
                                                      payment.order?.division
                                                              ?.name ??
                                                          'N/A',
                                                      style: TextStyle(
                                                        color: AllColors
                                                            .blackColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      '₹${payment.currencyAmount?.toStringAsFixed(2) ?? '0.00'}',
                                                      style: TextStyle(
                                                          color: AllColors
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 19),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          rowChildren.add(Expanded(child: Container()));
                        }
                      }

                      rows.add(
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: rowChildren,
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            if (isFloatingButtonClicked)
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15),
                                child: TextField(
                                  controller: searchController,
                                  decoration: const InputDecoration(
                                    hintText: 'Search payments...',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    // Implement search logic here if needed
                                    controller.orderPayments.value = controller
                                        .orderPayments
                                        .where((payment) {
                                      final companyName = payment
                                              .order?.company?.companyName
                                              ?.toLowerCase() ??
                                          '';
                                      final customerName =
                                          '${payment.customer?.firstName ?? ''} ${payment.customer?.lastName ?? ''}'
                                              .toLowerCase();
                                      return companyName
                                              .contains(value.toLowerCase()) ||
                                          customerName
                                              .contains(value.toLowerCase());
                                    }).toList();
                                  },
                                ),
                              ),
                            Column(children: rows),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
