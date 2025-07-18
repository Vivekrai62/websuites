import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/models/responseModels/leads/list/details/LeadDetails.dart';
import '../../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../../utils/appColors/app_colors.dart';
import '../../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../../../viewModels/leadScreens/lead_list/lead_detail_view/activities/meeting/LeadDetailsActiMeetingViewModel.dart';

class LeadDetailsActiMeetingScreen extends StatefulWidget {
  final String? leadId;
  final LeadDetailsResponseModel leadDetails;

  const LeadDetailsActiMeetingScreen({
    super.key,
    this.leadId,
    required this.leadDetails,
  });

  @override
  State<LeadDetailsActiMeetingScreen> createState() => _LeadDetailsActiMeetingScreenState();
}

class _LeadDetailsActiMeetingScreenState extends State<LeadDetailsActiMeetingScreen> {
  final LeadDetailsActiMeetingViewModel viewModel = Get.put(LeadDetailsActiMeetingViewModel());

  @override
  void initState() {
    super.initState();
    if (widget.leadId != null) {
      viewModel.leadDetailsActivitiesMeeting(context, widget.leadId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Row(
                children: [
                  Text(
                    'Meetings :- ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.5,
                      fontFamily: FontFamily.sfPro,
                    ),
                  ),
                  Obx(() => Text(
                    '${viewModel.leadActivitiesMeeting.length}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.5,
                      color: AllColors.figmaGrey,
                      fontFamily: FontFamily.sfPro,
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() {
          if (viewModel.loading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final meetings = viewModel.leadActivitiesMeeting;

          if (meetings.isEmpty) {
            return const Center(
              child: Text(
                'No meeting activities found',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: meetings.length,
            itemBuilder: (context, index) {
              final meeting = meetings[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            ImageStrings.date,
                            height: 14,
                            width: 14,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            meeting.createdAt != null
                                ? formatDateWithTime(meeting.createdAt.toString())
                                : 'N/A',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: FontFamily.sfPro,
                              color: AllColors.mediumPurple,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          meeting.action ?? 'N/A', // Using 'action' instead of 'type'
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (meeting.meetingWith != null && meeting.meetingWith!.isNotEmpty)
                    _buildInfoRow(
                      'Meeting With:',
                      meeting.meetingWith!,
                    ),
                  if (meeting.meetingWithMobile != null && meeting.meetingWithMobile!.isNotEmpty)
                    _buildInfoRow(
                      'Contact:',
                      meeting.meetingWithMobile!,
                    ),
                  if (meeting.remark != null && meeting.remark!.isNotEmpty)
                    _buildInfoRow('Remarks:', meeting.remark!),
                  if (meeting.createdBy != null && meeting.createdBy!.isNotEmpty)
                    _buildInfoRow('Created By:', meeting.createdBy!),
                  if (meeting.visitedWith != null && meeting.visitedWith!.isNotEmpty)
                    _buildInfoRow('Visited With:', meeting.visitedWith!),
                  if (meeting.lat != null && meeting.lng != null && meeting.location != null)
                    _buildInfoRow(
                      'Location:',
                      meeting.location.toString(),
                    ),
                ],
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}