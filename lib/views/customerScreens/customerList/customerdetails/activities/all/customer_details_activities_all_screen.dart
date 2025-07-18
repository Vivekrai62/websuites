import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../data/models/responseModels/customers/activities/activities_list/activities_list.dart';
import '../../../../../../utils/appColors/app_colors.dart';
import '../../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../../viewModels/customerScreens/activities/activities_list/activities_list.dart';

class CustomerDetailsActivitiesAllScreen extends StatelessWidget {
  final String customerId;

  const CustomerDetailsActivitiesAllScreen({
    super.key,
    required this.customerId,
  });

  String _formatDescription(String? description) {
    if (description == null) return 'N/A';
    final isoDateRegExp =
    RegExp(r'(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z)');
    final match = isoDateRegExp.firstMatch(description);
    if (match != null) {
      try {
        final dateString = match.group(0)!;
        final parsedDate = DateTime.parse(dateString);
        final formattedDate =
        DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
        return description.replaceFirst(dateString, formattedDate);
      } catch (e) {
        return description;
      }
    }
    final legacyDateRegExp =
    RegExp(r'(\w{3} \w{3} \d{2} \d{4} \d{2}:\d{2}:\d{2} GMT[+-]\d{4})');
    final legacyMatch = legacyDateRegExp.firstMatch(description);
    if (legacyMatch != null) {
      try {
        final dateString = legacyMatch.group(0)!;
        final parsedDate = DateTime.parse(dateString);
        final formattedDate =
        DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
        return description.replaceFirst(dateString, formattedDate);
      } catch (e) {
        return description;
      }
    }
    return description;
  }

  @override
  Widget build(BuildContext context) {
    // print("🏗️ Building CustomerDetailsActivitiesAllScreen");
    // print("📝 Customer ID: '$customerId'");

    if (!Get.isRegistered<CustomerActivitiesListViewModel>()) {
      // print("📦 Registering CustomerActivitiesListViewModel");
      Get.put(CustomerActivitiesListViewModel());
    }

    final CustomerActivitiesListViewModel customerViewModel =
    Get.find<CustomerActivitiesListViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {


      if (customerId.isNotEmpty) {
        // print("✅ Customer ID is valid: '$customerId'");
        // print("🚀 Fetching activities for customerId: $customerId");
        customerViewModel.customerDetailsActivitiesAll(context, customerId);
      } else {
        // print("❌ Error: customerId is empty");
        // Get.snackbar(
        //     'Error',
        //     'Invalid customer ID',
        //     backgroundColor: AllColors.vividRed,
        //     colorText: Colors.white
        // );
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Customer Activities',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.5,
              fontFamily: FontFamily.sfPro,
              color: AllColors.darkBlue,
            ),
          ),
        ),
        Obx(() {
          // print("🔄 Obx rebuild - Loading: ${customerViewModel.loading.value}, Activities: ${customerViewModel.customerActivities.length}");

          if (customerViewModel.loading.value) {
            // print("⏳ Showing loading indicator");
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Loading customer activities...',
                    style: TextStyle(fontSize: 16, fontFamily: FontFamily.sfPro),
                  ),
                ],
              ),
            );
          }

          if (customerViewModel.customerActivities.isEmpty) {
            // print("📭 No activities found");
            return const Center(
              child: Text(
                'No activities found',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: FontFamily.sfPro,
                ),
              ),
            );
          }

          // print("📋 Rendering ${customerViewModel.customerActivities.length} activities");
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: customerViewModel.customerActivities.length,
            itemBuilder: (context, index) {
              final activity = customerViewModel.customerActivities[index];
              final action = activity.action?.toLowerCase();

              // print("🎯 Rendering activity $index: ${activity.action} - ${activity.title}");

              return
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                              color: action == 'reminder'
                                  ? AllColors.vividPurple
                                  : action == 'note'
                                  ? Colors.red
                                  : action == 'call'
                                  ? Colors.green
                                  : action == 'meeting'
                                  ? AllColors.darkYellow
                                  : action == 'assignee'
                                  ? Colors.blue
                                  : AllColors.textField2,
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              activity.action?.toUpperCase() ?? 'N/A',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: FontFamily.sfPro,
                                fontSize: 13,
                                color: action == 'reminder' ||
                                    action == 'note' ||
                                    action == 'call' ||
                                    action == 'meeting' ||
                                    action == 'assignee'
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Image.asset(
                            ImageStrings.date,
                            height: 14,
                            width: 15.69,
                            color: AllColors.mediumPurple,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            formatDateWithTime(activity.createdAt),
                            style: TextStyle(
                              fontSize: 14,
                              color: AllColors.mediumPurple,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.sfPro,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(
                          ImageStrings.call,
                          height: 14,
                          width: 15.69,
                          color: AllColors.grey,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          activity.meetingWithMobile ?? 'Not Available',
                          style: TextStyle(
                            color: AllColors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.sfPro,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          ImageStrings.person,
                          height: 15,
                          width: 15,
                          color: AllColors.darkBlue,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          activity.createdBy ?? 'Not Available',
                          style: TextStyle(
                            color: AllColors.darkBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.sfPro,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Title - ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AllColors.mediumPurple,
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: activity.title ?? 'Not Available',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AllColors.grey,
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Remark - ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.green,
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: _formatDescription(activity.remark),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AllColors.grey,
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (activity.companyName != null &&
                        activity.companyName!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Company - ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AllColors.mediumPurple,
                                        fontFamily: FontFamily.sfPro,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: activity.companyName,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AllColors.grey,
                                        fontFamily: FontFamily.sfPro,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    if (activity.location != null &&
                        activity.location!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Location - ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AllColors.mediumPurple,
                                        fontFamily: FontFamily.sfPro,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: activity.location,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AllColors.grey,
                                        fontFamily: FontFamily.sfPro,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(height: 15),
                    Divider(
                      thickness: 0.4,
                    ),
                  ],
                );
            },
          );
        }),
      ],
    );
  }
}
