import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/appColors/app_colors.dart';
import '../../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../data/models/responseModels/customers/list/details/services_area/customer_details_services_area_res_model.dart';
import '../../../../../utils/container_Utils/container_border/container_border_screen.dart';
import '../../../../../utils/responsive/responsive_utils.dart';
import '../../../../../viewModels/customerScreens/customer_list/customer_detail_view/service_area/customer_details _service_area_view_model.dart';

class CustomerDetailsServicesAreaScreen extends StatefulWidget {
  final String customerId;

  const CustomerDetailsServicesAreaScreen(
      {super.key, required this.customerId});

  @override
  State<CustomerDetailsServicesAreaScreen> createState() =>
      _CustomerDetailsServicesAreaScreenState();
}

class _CustomerDetailsServicesAreaScreenState
    extends State<CustomerDetailsServicesAreaScreen> {
  final CustomerDetailsServicesAreaViewModel viewModel =
      Get.put(CustomerDetailsServicesAreaViewModel());

  @override
  void initState() {
    super.initState();
    // Delay the API call to avoid semantics conflicts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.customerDetailsServiceArea(context, widget.customerId);
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

          final servicesArea = viewModel.customerServicesArea;

          if (servicesArea.isEmpty) {
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

          return ResponsiveMasonryGridView<CustomerDetailsServiceAreaResModel>(
            items: servicesArea,
            itemBuilder: (context, service, index) =>
                _buildServiceCard(service, index),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 10, bottom: 5),
          );
        }),
      ],
    );
  }

  Widget _buildServiceCard(
      CustomerDetailsServiceAreaResModel service, int index) {
    return ContainerBorderComponent(
      key: ValueKey('service_card_$index'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Company name and division row
          Row(
            children: [
              Expanded(
                child: Text(
                  service.company?.companyName ?? 'N/A',
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
                  color: AllColors.lightBlue,
                ),
                child: Text(
                  service.division?.name ?? 'N/A',
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
          const SizedBox(height: 1),
          Text(
            service.product?.name ?? 'N/A',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.sfPro,
              color: AllColors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Image.asset(ImageStrings.date, height: 13),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  formatDate(service.createdAt?.toString() ?? ''),
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
                  service.district?.name ?? 'N/A',
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AllColors.background_green,
                ),
                child: Text(
                  service.pincode?.code ?? 'N/A',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                    color: AllColors.text__green,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                service.state?.name ?? 'N/A',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.sfPro,
                  color: AllColors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
