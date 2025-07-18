import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';

import '../../../../../data/models/responseModels/customers/list/details/payments/customer_details_payment_res_model.dart';
import '../../../../../utils/container_Utils/container_border/container_border_screen.dart';
import '../../../../../utils/responsive/responsive_utils.dart';
import '../../../../../viewModels/customerScreens/customer_list/customer_detail_view/payments/customer_detail_view_payment_view_model.dart';

class CustomerDetailsPaymentsScreen extends StatefulWidget {
  final String customerId;

  const CustomerDetailsPaymentsScreen({super.key, required this.customerId});

  @override
  State<CustomerDetailsPaymentsScreen> createState() =>
      _CustomerDetailsPaymentsScreenState();
}

class _CustomerDetailsPaymentsScreenState
    extends State<CustomerDetailsPaymentsScreen> {
  final CustomerDetailPaymentViewModel viewModel =
      Get.put(CustomerDetailPaymentViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.customerDetailsPayments(context, widget.customerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (viewModel.loading.value) {}

      final payments = viewModel.customerPayments;

      if (payments.isEmpty) {
        return Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 40),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  ImageStrings.notFound,
                  height: 80,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "No Data Available ",
                  style: TextStyle(
                      fontSize: 16.5,
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      }

      return ResponsiveMasonryGridView<CustomerDetailsPaymentResModel>(
        padding: EdgeInsets.only(top: 10),
        items: payments,
        mainAxisSpacing: 10,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 8,
        shrinkWrap: true,
        itemBuilder: (context, payment, index) {
          return _buildPaymentCard(payment, index);
        },
      );
    });
  }

  Widget _buildPaymentCard(CustomerDetailsPaymentResModel payment, int index) {
    return ContainerBorderComponent(
      key: ValueKey('payment_card_$index'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  payment.invoice ?? 'N/A',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.sfPro,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: _getStatusColor(payment.status),
                ),
                child: Text(
                  payment.status ?? 'Unknown',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.sfPro,
                    color: _getStatusTextColor(payment.status),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(ImageStrings.date, height: 13),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  formatDate(payment.createdAt?.toString() ?? ''),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                    color: AllColors.mediumPurple,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  payment.order?.company?.customer?.firstName != null
                      ? '${payment.order?.company?.customer?.firstName} ${payment.order?.company?.customer?.lastName ?? ''}'
                      : 'N/A',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                    color: AllColors.grey,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '${payment.currency?.symbol ?? ''}${payment.amount ?? 0}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.sfPro,
                  color: AllColors.blackColor,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AllColors.lightBlue,
                ),
                child: Text(
                  payment.paymentMode ?? 'Unknown',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.sfPro,
                    color: AllColors.darkBlue,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: payment.isFresh == true
                      ? AllColors.mediumPurple
                      : AllColors.textField2,
                ),
                child: Text(
                  payment.isFresh == true ? 'Fresh' : 'Not Fresh',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.sfPro,
                    color: payment.isFresh == true
                        ? AllColors.whiteColor
                        : AllColors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              Image.asset(ImageStrings.date, height: 13),
              const SizedBox(width: 8),
              Text(
                formatDate(payment.paymentDate?.toString() ?? ''),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.sfPro,
                  color: AllColors.mediumPurple,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Allocation:-',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.sfPro,
              color: AllColors.blackColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          if (payment.paymentAllocations != null &&
              payment.paymentAllocations!.isNotEmpty)
            ...payment.paymentAllocations!
                .map((allocation) => Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              allocation.customerService?.productName ?? 'N/A',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: FontFamily.sfPro,
                                color: AllColors.blackColor,
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${payment.currency?.symbol ?? '₹'}${allocation.amount ?? 0}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.sfPro,
                              color: AllColors.blackColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList()
          else
            Text(
              'No allocations found',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.sfPro,
                color: AllColors.grey,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return AllColors.darkYellow;
      case 'failed':
        return AllColors.lightRed;
      case 'approved':
        return AllColors.greenJungle;
      case 'refunded':
        return Colors.blue.shade100;
      default:
        return AllColors.textField2;
    }
  }

  Color _getStatusTextColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return AllColors.whiteColor;
      case 'failed':
        return AllColors.darkRed;
      case 'approved':
        return AllColors.whiteColor;
      case 'refunded':
        return Colors.blue.shade700;
      default:
        return AllColors.grey;
    }
  }
}
