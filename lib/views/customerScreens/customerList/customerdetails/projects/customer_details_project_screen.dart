import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import 'package:websuites/resources/imageStrings/image_strings.dart';
import '../../../../../data/models/responseModels/customers/list/customer_detail_view/projects/customer_details_projects_res_model.dart';
import '../../../../../utils/container_Utils/container_border/container_border_screen.dart';
import '../../../../../utils/responsive/responsive_utils.dart';
import '../../../../../viewModels/customerScreens/customer_list/customer_detail_view/projects/customer_detail_project_view_model.dart';

class CustomerDetailsProjectScreen extends StatefulWidget {
  final String customerId;

  const CustomerDetailsProjectScreen({super.key, required this.customerId});

  @override
  State<CustomerDetailsProjectScreen> createState() => _CustomerDetailsProjectScreenState();
}

class _CustomerDetailsProjectScreenState extends State<CustomerDetailsProjectScreen> {
  final CustomerDetailProjectViewModel viewModel = Get.put(CustomerDetailProjectViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.customerDetailsProject(context, widget.customerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (viewModel.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final projects = viewModel.customerProjects;

      if (projects.isEmpty) {
        return const Center(
          child: Text(
            'No projects found',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        );
      }

      return ResponsiveMasonryGridView<CustomerDetailsProjectsResModel>(
        items: projects,
        itemBuilder: (context, project, index) => _buildProjectCard(project, index),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 10, bottom: 5),
      );
    });
  }

  Widget _buildProjectCard(CustomerDetailsProjectsResModel project, int index) {
    return RepaintBoundary(
      key: ValueKey('project_card_$index'),
      child: ContainerBorderComponent(
        child:   Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Row(
              children: [
                Expanded(
                  child: Text(
                    project.projectName ?? 'N/A',
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
                    color: AllColors.darkYellow,
                  ),
                  child: Text(
                    project.status ?? 'N/A',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.sfPro,
                      color: AllColors.whiteColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),

            Text(
              project.billingType ?? 'N/A',
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
                    formatDate(project.startDate?.toString() ?? ''),
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
                    'Est. Hours: ${project.estimatedHours?.toString() ?? 'N/A'}',
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AllColors.background_green,
                  ),
                  child: Text(
                    'Total Rate: ${project.totalRate?.toString() ?? 'N/A'}',
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
                  formatDate(project.deadline?.toString() ?? 'N/A'),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                    color: AllColors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),


            Text(
              project.description ?? 'No description',
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