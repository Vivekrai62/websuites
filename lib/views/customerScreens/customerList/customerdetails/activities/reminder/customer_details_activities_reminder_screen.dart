import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../viewModels/customerScreens/activities/reminder/customer_activities_reminder_view_model.dart';

class CustomerDetailsActivitiesReminderScreen extends StatefulWidget {
  final String customerId;

  const CustomerDetailsActivitiesReminderScreen({super.key, required this.customerId});

  @override
  State<CustomerDetailsActivitiesReminderScreen> createState() => _CustomerDetailsActivitiesReminderScreenState();
}

class _CustomerDetailsActivitiesReminderScreenState extends State<CustomerDetailsActivitiesReminderScreen> {
  final CustomerActivitiesReminderViewModel viewModel = Get.put(CustomerActivitiesReminderViewModel());

  @override
  void initState() {
    super.initState();
    viewModel.customerDetailsActivitiesReminder(context, widget.customerId);
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
                'Reminders :- ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.5,
                  fontFamily: 'SF Pro',
                ),
              ),
              Obx(() => Text(
                '${viewModel.customerReminder.length}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.5,
                  color: Colors.grey[600],
                  fontFamily: 'SF Pro',
                ),
              )),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() {
          if (viewModel.loading.value) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (viewModel.errorMessage.value.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                viewModel.errorMessage.value,
                style: const TextStyle(color: CupertinoColors.systemRed, fontSize: 16),
              ),
            );
          }

          final reminders = viewModel.customerReminder;

          if (reminders.isEmpty) {
            return const Center(
              child: Text(
                'No reminder activities found',
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
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              final formattedCreatedDate = reminder.createdAt != null
                  ? DateFormat('MMM dd, yyyy • hh:mm a').format(reminder.createdAt!)
                  : 'N/A';
              final formattedReminderDate = reminder.reminderDate != null
                  ? DateFormat('MMM dd, yyyy • hh:mm a').format(reminder.reminderDate!)
                  : 'N/A';

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              reminder.title ?? 'No Title',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: (reminder.reminderStatus ?? false)
                                  ? Colors.green.shade100
                                  : Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              (reminder.reminderStatus ?? false) ? 'Active' : 'Inactive',
                              style: TextStyle(
                                color: (reminder.reminderStatus ?? false)
                                    ? Colors.green.shade800
                                    : Colors.orange.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Category and Type
                      if (reminder.category != null)
                        Row(
                          children: [
                            const Icon(Icons.category_outlined, size: 16, color: Colors.blue),
                            const SizedBox(width: 6),
                            Text(
                              'Category: ${reminder.category}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      if (reminder.category != null) const SizedBox(height: 4),

                      if (reminder.type != null)
                        Row(
                          children: [
                            const Icon(Icons.label_outline, size: 16, color: Colors.purple),
                            const SizedBox(width: 6),
                            Text(
                              'Type: ${reminder.type}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      if (reminder.type != null) const SizedBox(height: 4),

                      // Reminder Date
                      Row(
                        children: [
                          const Icon(Icons.schedule, size: 16, color: Colors.orange),
                          const SizedBox(width: 6),
                          Text(
                            'Reminder Date: $formattedReminderDate',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Reminder To
                      if (reminder.reminderTo != null)
                        Row(
                          children: [
                            const Icon(Icons.person_outline, size: 16, color: Colors.teal),
                            const SizedBox(width: 6),
                            Text(
                              'Reminder To: ${reminder.reminderTo!.firstName ?? ''} ${reminder.reminderTo!.lastName ?? ''}'.trim(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      if (reminder.reminderTo != null) const SizedBox(height: 4),

                      // Notify Customer
                      Row(
                        children: [
                          Icon(
                            (reminder.notifyCustomer ?? false)
                                ? Icons.notifications_active
                                : Icons.notifications_off,
                            size: 16,
                            color: (reminder.notifyCustomer ?? false)
                                ? Colors.green
                                : Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Notify Customer: ${(reminder.notifyCustomer ?? false) ? 'Yes' : 'No'}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Recurring Information
                      if (reminder.recurringFrequency != null || reminder.recurringInterval != null)
                        Row(
                          children: [
                            const Icon(Icons.repeat, size: 16, color: Colors.indigo),
                            const SizedBox(width: 6),
                            Text(
                              'Recurring: ${reminder.recurringFrequency ?? 'N/A'} ${reminder.recurringInterval ?? ''}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      if (reminder.recurringFrequency != null || reminder.recurringInterval != null)
                        const SizedBox(height: 4),

                      // Remark
                      if (reminder.remark != null && reminder.remark!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.note_outlined, size: 16, color: Colors.brown),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Remark: ${reminder.remark}',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      // Created by and date
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (reminder.createdBy != null)
                            Row(
                              children: [
                                const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  'Created by: ${reminder.createdBy!.firstName ?? ''} ${reminder.createdBy!.lastName ?? ''}'.trim(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          Text(
                            formattedCreatedDate,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
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