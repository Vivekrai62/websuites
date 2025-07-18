import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/models/responseModels/leads/list/details/LeadDetails.dart';
import '../../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../../utils/appColors/app_colors.dart';
import '../../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../../../viewModels/leadScreens/lead_list/lead_detail_view/activities_reminder/LeadDetailsActiReminderViewModel.dart';

class LeadDetailsActivitiesReminderScreen extends StatefulWidget {
  final String? leadId;
  final LeadDetailsResponseModel leadDetails;

  const LeadDetailsActivitiesReminderScreen({
    super.key,
    this.leadId,
    required this.leadDetails,
  });

  @override
  State<LeadDetailsActivitiesReminderScreen> createState() => _LeadDetailsActivitiesReminderScreenState();
}

class _LeadDetailsActivitiesReminderScreenState extends State<LeadDetailsActivitiesReminderScreen> {
  final LeadDetailsActiReminderViewModel viewModel = Get.put(LeadDetailsActiReminderViewModel());

  @override
  void initState() {
    super.initState();
    if (widget.leadId != null) {
      viewModel.leadDetailsActivitiesReminder(context, widget.leadId!);
    }
  }

  // Helper method to format date with time
  String formatDateWithTime(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    } catch (e) {
      return 'N/A';
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
              Text(
                'Reminder :- ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.5,
                  fontFamily: FontFamily.sfPro,
                ),
              ),
              Text('${viewModel.leadActivitiesReminder.length}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.5,
                  color: AllColors.figmaGrey,
                  fontFamily: FontFamily.sfPro,
                ),
              ),

            ],
          ),
        ),
        Obx(() {
          if (viewModel.loading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final reminder = viewModel.leadActivitiesReminder;

          if (reminder.isEmpty) {
            return const Center(
              child: Text(
                'No activities found',
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
            itemCount: reminder.length,
            itemBuilder: (context, index) {
              final reminders = reminder[index];
              final bool isReminderActive = reminders.reminderStatus ?? false;

              return Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),

                  border: Border.all(
                    color: isReminderActive ? Colors.green : Colors.red.shade700,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                              color: isReminderActive
                                  ? Colors.green
                                  : Colors.red.shade700,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              isReminderActive ? 'Reminder ON' : 'Reminder OFF',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: FontFamily.sfPro,
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [

                              Image.asset(
                                ImageStrings.date,
                                height: 14,
                                width: 15.69,
                              ),

                              const SizedBox(width: 8),
                              Text(
                                formatDateWithTime(reminders.createdAt?.toString() ?? ""),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AllColors.mediumPurple,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Reminder',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: FontFamily.sfPro,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Switch(
                            value: isReminderActive,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              // Implement the toggle functionality here
                              // You might want to call a method in your viewModel
                              // viewModel.toggleReminderStatus(reminders.id, value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}