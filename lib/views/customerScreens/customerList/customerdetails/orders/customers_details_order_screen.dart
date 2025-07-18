import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/components/widgets/sizedBoxes/sized_box_components.dart';
import '../../../../../../utils/appColors/app_colors.dart';
import '../../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../data/models/responseModels/customers/list/customer_detail_view/order/customer_detail_view_order_response_model.dart';
import '../../../../../utils/container_Utils/container_border/container_border_screen.dart';
import '../../../../../utils/responsive/responsive_utils.dart';
import '../../../../../viewModels/customerScreens/customer_list/customer_detail_view/order_list/customer_detail_view_order_view_model.dart';

class CustomersDetailsOrderScreen extends StatefulWidget {
  final String customerId;

  const CustomersDetailsOrderScreen({super.key, required this.customerId});

  @override
  State<CustomersDetailsOrderScreen> createState() => _CustomersDetailsOrderScreenState();
}

class _CustomersDetailsOrderScreenState extends State<CustomersDetailsOrderScreen> {
  final CustomerDetailOrdersViewModel viewModel = Get.put(CustomerDetailOrdersViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.customerDetailViewOrders(context, widget.customerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          if (viewModel.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = viewModel.customerOrders; // Changed from customerOrders to customerProjects

          if (orders.isEmpty) {
            return const Center(
              child: Text(
                'No orders found',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

          TextButton.icon(
            onPressed: (){}, label: Text('Filter',style: TextStyle(color: Colors.black),),
            icon: Icon(Icons.filter_list,color: Colors.black),),

              ResponsiveMasonryGridView(
                items: orders,
                itemBuilder: (context, order, index) => Column(
                  children: [
                    _buildOrderCard(order, index),

                  ],
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 5, bottom: 5),
              ),
            ],
          );

        }),
      ],
    );
  }

  Widget _buildOrderCard(CustomerDetailsOrdersResModel order, int index) {
    return RepaintBoundary(
      key: ValueKey('order_card_$index'),
      child: Column(
        children: [

          ContainerBorderComponent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.company?.companyName?.toString() ?? 'N/A',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: FontFamily.sfPro,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: _getStatusColor(order.status),
                      ),
                      child: Text(
                        order.status?.toString() ?? 'Unknown',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: FontFamily.sfPro,
                          color: _getStatusTextColor(order.status),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

               SizedBox(height: 8,),
                Row(

                  children: [
                    Text(
                      order.orderSerialNumber?.toString() ?? 'N/A',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: FontFamily.sfPro,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Image.asset(ImageStrings.date, height: 13),
                    SizedBox(width: 8),
                    Text(
                      formatDate(order.orderDate?.toString() ?? ''),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.sfPro,
                        color: AllColors.mediumPurple,
                        fontSize: 12,
                      ),
                    ),

                  ],
                ),
                CommonSizedBox.height(context, 0.3),
                Row(
                  children: [
                    Text(
                      order.company?.companyName?.toString() ?? 'N/A',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.sfPro,
                        color: AllColors.darkBlue,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Text(
                      '₹${order.receivedAmount?.toString() ?? '0'}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.sfPro,
                        color: AllColors.greenJungle,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                CommonSizedBox.height(context, 0.3),
                Row(
                  children: [

                    Text(
                      'Total Amount:- ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.sfPro,
                        color: AllColors.blackColor,
                        fontSize: 14,
                      ),
                    ),


                    Text(
                      '₹${order.totalAmount?.toString() ?? '0'}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.sfPro,
                        color: AllColors.mediumPurple,
                        fontSize: 14,

                      ),
                    ),
                    Spacer(),
                    Image.asset(ImageStrings.person,height: 14,),
                    SizedBox(width: 5,),
                    Text(
                      order.createdBy?.firstName.toString() ?? 'N.A',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.sfPro,
                        color: AllColors.darkBlue,
                        fontSize: 14,

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

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.grey.shade200;
      case 'cancelled':
        return AllColors.lightRed;
      case 'confirmed':
        return AllColors.greenJungle;
      case 'delivered':
        return Colors.blue.shade100;
      default:
        return AllColors.textField2;
    }
  }

  Color _getStatusTextColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.grey.shade700;
      case 'cancelled':
        return AllColors.darkRed;
      case 'confirmed':
        return AllColors.whiteColor;
      case 'delivered':
        return Colors.blue.shade700;
      default:
        return AllColors.grey;
    }
  }
}