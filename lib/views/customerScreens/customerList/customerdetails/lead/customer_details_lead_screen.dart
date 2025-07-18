import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import '../../../../../data/models/responseModels/customers/list/customer_detail_view/lead/customer_detail_lead_response_model.dart';
import '../../../../../utils/container_Utils/container_border/container_border_screen.dart';
import '../../../../../utils/responsive/responsive_utils.dart';
import '../../../../../viewModels/customerScreens/customer_list/customer_detail_view/lead/customer_detail_lead_view_model.dart';

class CustomerDetailsLeadsScreen extends StatefulWidget {
  final String customerId;

  const CustomerDetailsLeadsScreen({super.key, required this.customerId});

  @override
  State<CustomerDetailsLeadsScreen> createState() => _CustomerDetailsLeadsScreenState();
}

class _CustomerDetailsLeadsScreenState extends State<CustomerDetailsLeadsScreen> {
  final CustomerDetailLeadViewModel viewModel = Get.put(CustomerDetailLeadViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.customerDetailViewLead(context, widget.customerId);
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
          final leads = viewModel.customerProjects; // Changed variable name to 'leads' for clarity

          if (leads.isEmpty) {
            return const Center(
              child: Text(
                'No leads found', // Updated message to reflect 'leads'
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ResponsiveMasonryGridView<CustomerDetailsLeadsResModel>(
            items: leads,
            itemBuilder: (context, lead, index) => _buildProjectCard(lead, index),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 10, bottom: 5),
          );
        }),
      ],
    );
  }

  Widget _buildProjectCard(CustomerDetailsLeadsResModel lead, int index) {
    return RepaintBoundary(
      key: ValueKey('lead_card_$index'), // Updated key to reflect 'lead'
      child: ContainerBorderComponent(
        child:    Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Row(
              children: [
                Expanded(
                  child: Text(
                    lead.firstName ?? 'N/A',
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AllColors.lightBlue,
                  ),
                  child: Text(
                    lead.divisions.isNotEmpty ? lead.divisions.first.name ?? 'N/A' : 'N/A',
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
                Expanded(
                  child: Text(
                    lead.email ?? 'N/A',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.sfPro,
                      color: AllColors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Text(
                  lead.source?.name ?? 'N/A',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.sfPro,
                    color: AllColors.blackColor,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 8),


            Row(
              children: [
                Image.asset(ImageStrings.call, height: 14),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    '+${lead.mobileWithCountrycode?.toString() ?? 'N/A'}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.sfPro,
                      color: AllColors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AllColors.background_green,
                  ),
                  child: Text(
                    lead.divisions.isNotEmpty ? lead.divisions.first.status ?? 'N/A' : 'N/A',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      color: AllColors.text__green,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),


            Row(
              children: [
                Image.asset(
                  ImageStrings.date,
                  height: 14,
                  color: AllColors.mediumPurple,
                ),
                const SizedBox(width: 8),
                Text(
                  formatDate(lead.createdAt?.toString() ?? 'N/A'),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                    color: AllColors.mediumPurple,
                    fontSize: 12,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 8),


            Text(
              lead.description ?? 'No description',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.sfPro,
                color: AllColors.grey,
                fontSize: 12,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}