import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../data/models/requestModels/lead/lead_list/details/activities/LeadDetailsActivitiesAllResModel.dart';
import '../../../../../data/models/responseModels/leads/list/details/LeadDetails.dart';
import '../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../utils/appColors/app_colors.dart';
import '../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../utils/fontfamily/FontFamily.dart';
import 'LeadDetailsActivitiesAllViewModel.dart';

class LeadDetailsActivitiesAllScreen extends StatefulWidget {
  final String? leadId;
  final LeadDetailsResponseModel leadDetails;

  const LeadDetailsActivitiesAllScreen({
    super.key,
    this.leadId,
    required this.leadDetails,
  });

  @override
  State<LeadDetailsActivitiesAllScreen> createState() => _LeadDetailsActivitiesAllScreenState();
}

class _LeadDetailsActivitiesAllScreenState extends State<LeadDetailsActivitiesAllScreen> {
  final LeadDetailsActivitiesAllViewModel viewModel = Get.put(LeadDetailsActivitiesAllViewModel());

  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   if (widget.leadId != null && widget.leadId!.isNotEmpty) {
    //     print("bikku Screen: Initiating API call for leadId: ${widget.leadId}");
    //     viewModel.leadDetailsActivitiesAll(context, widget.leadId!);
    //   } else {
    //     print("bikku Screen: Error: leadId is null or empty");
    //   }
    // });
  }

  String _formatDescription(String? description) {
    if (description == null) return 'N/A';
    final isoDateRegExp = RegExp(r'(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}[+-]\d{2}:\d{2})');
    final match = isoDateRegExp.firstMatch(description);

    if (match != null) {
      try {
        final dateString = match.group(0)!;
        final parsedDate = DateTime.parse(dateString);
        final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
        return description.replaceFirst(dateString, formattedDate);
      } catch (e) {
        return description;
      }
    }

    final legacyDateRegExp = RegExp(r'(\w{3} \w{3} \d{2} \d{4} \d{2}:\d{2}:\d{2} GMT[+-]\d{4})');
    final legacyMatch = legacyDateRegExp.firstMatch(description);

    if (legacyMatch != null) {
      try {
        final dateString = legacyMatch.group(0)!;
        final parsedDate = DateTime.parse(dateString);
        final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
        return description.replaceFirst(dateString, formattedDate);
      } catch (e) {
        return description;
      }
    }

    return description;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.zero,
          child: Text(
            'Lead Activities',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.5,
              fontFamily: FontFamily.sfPro,
            ),
          ),
        ),
        GetX<LeadDetailsActivitiesAllViewModel>(
          builder: (controller) {
            if (controller.loading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final activities = controller.leadDetailsList;

            if (activities.isEmpty) {
              return const Center(
                child: Text(
                  'No activities found',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                // Normalize action to lowercase for comparison
                final action = activity.action?.toLowerCase();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                              color: action == 'reminder'
                                  ? AllColors.vividPurple
                                  : action == 'note'
                                  ? Colors.red
                                  : action == 'call'
                                  ? Colors.green
                                  : action == 'meeting'
                                  ? AllColors.darkYellow
                                  : action == 'lead assigned'
                                  ? Colors.blue
                                  : AllColors.textField2,
                              borderRadius: BorderRadius.circular(30.0),
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
                                    action == 'lead assigned'
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
                        ),
                        const SizedBox(width: 10),
                        Text(
                          activity.meetingWithMobile ?? '+91-9041628788', // Fallback if null
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
                                    text: 'Creator - ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AllColors.mediumPurple,
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: activity.createdBy ?? 'Not Available',
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
                                    text: 'Remarks - ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.green,
                                      fontFamily: FontFamily.sfPro,
                                      fontWeight: FontWeight.w400,
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
                    const SizedBox(height: 15),
                    const Divider(thickness: 0.4),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}