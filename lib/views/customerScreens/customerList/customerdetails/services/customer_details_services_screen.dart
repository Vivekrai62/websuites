import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/components/widgets/sizedBoxes/sized_box_components.dart';
import '../../../../../../utils/appColors/app_colors.dart';
import '../../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../utils/container_Utils/container_border/container_border_screen.dart';
import '../../../../../utils/responsive/responsive_utils.dart';
import '../../../../../viewModels/customerScreens/customer_list/details/services/customer_details_services_view_model.dart';

class CustomerDetailsServicesScreen extends StatefulWidget {
  final String customerId;

  const CustomerDetailsServicesScreen({super.key, required this.customerId});

  @override
  State<CustomerDetailsServicesScreen> createState() => _CustomerDetailsServicesScreenState();
}

class _CustomerDetailsServicesScreenState extends State<CustomerDetailsServicesScreen> {
  final CustomerDetailsActivitiesServicesViewModel viewModel = Get.put(CustomerDetailsActivitiesServicesViewModel());

  @override
  void initState() {
    super.initState();
    // Delay the API call to avoid semantics conflicts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.customerDetailsActivitiesServices(context, widget.customerId);
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

          final services = viewModel.customerServices;

          if (services.isEmpty) {
            return const Center(
              child: Text(
                'No service activities found',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ResponsiveMasonryGridView(
            items: services,
            itemBuilder: (context, service, index) => _buildServiceCard(service, index),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 10, bottom: 5),
          );
        }),
      ],
    );
  }



  Widget _buildServiceCard(dynamic service, int index) {
    return RepaintBoundary(
      key: ValueKey('service_card_$index'),
      child: ContainerBorderComponent(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    service.service?.toString() ?? 'N/A',
                    style: TextStyle(
                      fontWeight:  FontWeight.w600,
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
                    color: _getStatusColor(service.statusType?.toString()),
                  ),
                  child: Text(
                    service.statusType?.toString() ?? 'Unknown',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      color: _getStatusTextColor(service.statusType?.toString()),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            CommonSizedBox.height(context, 1),
            Row(
              children: [
                Image.asset(ImageStrings.date, height: 13),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    formatDate(service.startDate?.toString() ?? ''),
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
                    service.company?.companyName?.toString() ?? 'N/A',
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
            CommonSizedBox.height(context, 1),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: service.isFree == true ? AllColors.mediumPurple : AllColors.textField2,
                  ),
                  child: Text(
                    service.isFree == true ? 'Free' : 'Not Free',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      color: service.isFree == true ? AllColors.whiteColor : AllColors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),
                Image.asset(ImageStrings.date, height: 13),
                SizedBox(width: 8),
                Text(
                  formatDate(service.endDate?.toString() ?? ''),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                    color: AllColors.mediumPurple,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'not started':
        return Colors.grey.shade200;
      case 'expired':
        return AllColors.lightRed;
      case 'active':
        return Colors.green.shade100;
      case 'completed':
        return Colors.blue.shade100;
      default:
        return AllColors.textField2;
    }
  }

  Color _getStatusTextColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'not started':
        return Colors.grey.shade700;
      case 'expired':
        return AllColors.darkRed;
      case 'active':
        return Colors.green.shade700;
      case 'completed':
        return Colors.blue.shade700;
      default:
        return AllColors.grey;
    }
  }
}