import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/appColors/app_colors.dart';
import '../../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../../viewModels/customerScreens/activities/meeting/customer_activity_meeting_view_models.dart';

class CustomerDetailsActivitiesMeetingScreen extends StatefulWidget {
  final String customerId;

  const CustomerDetailsActivitiesMeetingScreen({super.key, required this.customerId});

  @override
  State<CustomerDetailsActivitiesMeetingScreen> createState() => _CustomerDetailsActivitiesMeetingScreenState();
}

class _CustomerDetailsActivitiesMeetingScreenState extends State<CustomerDetailsActivitiesMeetingScreen> {
  final CustomerActivitiesMeetingViewModel viewModel = Get.put(CustomerActivitiesMeetingViewModel());

  @override
  void initState() {
    super.initState();
    viewModel.customerDetailsActivitiesMeeting(context, widget.customerId);
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
              Text(
                'Meetings :- ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.5,
                  fontFamily: FontFamily.sfPro,
                ),
              ),
              Obx(() => Text(
                '${viewModel.customerMeeting.length}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.5,
                  color: AllColors.figmaGrey,
                  fontFamily: FontFamily.sfPro,
                ),
              )),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() {
          if (viewModel.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final meetings = viewModel.customerMeeting;

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
                          Image.asset(ImageStrings.date, height: 14, width: 14),
                          const SizedBox(width: 8),
                          Text(
                            formatDateWithTime(meeting.createdAt?.toString() ?? 'N/A'),
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
                          meeting.status ?? 'N/A',
                          style: const TextStyle(
                            color:Colors.blue,
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
                      '${meeting.meetingWith} (${meeting.companyName ?? 'N/A'})',
                    ),
                  if (meeting.meetingWithMobile != null && meeting.meetingWithMobile!.isNotEmpty)
                    _buildInfoRow(
                      'Contact:',
                      '+${meeting.meetingWithMobile}',
                    ),
                  if (meeting.meetingWithEmail != null && meeting.meetingWithEmail!.isNotEmpty)
                    _buildInfoRow('Email:', meeting.meetingWithEmail!),
                  if (meeting.remark != null && meeting.remark!.isNotEmpty)
                    _buildInfoRow('Remarks:', meeting.remark!),
                  if (meeting.createdBy != null && meeting.createdBy!.isNotEmpty)
                    _buildInfoRow('Created By:', meeting.createdBy!),
                  if (meeting.visitedWith != null && meeting.visitedWith!.isNotEmpty)
                    _buildInfoRow('Visited With:', meeting.visitedWith!),
                  if (meeting.lat != null && meeting.lng != null && meeting.location != null)
                    _buildInfoRow('Location:', meeting.location.toString()),
                  if (meeting.reminderTo != null && meeting.reminderTo!.isNotEmpty)
                    _buildInfoRow('Reminder To:', meeting.reminderTo!),
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