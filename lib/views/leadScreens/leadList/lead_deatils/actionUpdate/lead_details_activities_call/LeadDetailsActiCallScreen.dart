import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/models/responseModels/leads/list/details/LeadDetails.dart';
import '../../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../../utils/appColors/app_colors.dart';
import '../../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../../../viewModels/leadScreens/lead_list/lead_detail_view/activities_call/LeadDetailsActiCallViewModel.dart';

class LeadDetailsActiCallScreen extends StatefulWidget {
  final String? leadId;
  final LeadDetailsResponseModel leadDetails;

  const LeadDetailsActiCallScreen({
    super.key,
    this.leadId,
    required this.leadDetails,
  });

  @override
  State<LeadDetailsActiCallScreen> createState() => _LeadDetailsActiCallScreenState();
}

class _LeadDetailsActiCallScreenState extends State<LeadDetailsActiCallScreen> {
  final LeadDetailsActiCallViewModel viewModel = Get.put(LeadDetailsActiCallViewModel());

  @override
  void initState() {
    super.initState();
    if (widget.leadId != null) {
      viewModel.leadDetailsActivitiesCall(context, widget.leadId!);
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
                    'Call :- ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.5,
                      fontFamily: FontFamily.sfPro,
                    ),
                  ),

                  Text('${viewModel.leadActivitiesCall.length}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.5,
                      color: AllColors.figmaGrey,
                      fontFamily: FontFamily.sfPro,
                    ),
                  ),

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

          final calls = viewModel.leadActivitiesCall;

          if (calls.isEmpty) {
            return const Center(
              child: Text(
                'No call activities found',
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
            itemCount: calls.length,
            itemBuilder: (context, index) {
              final call = calls[index];
              return      Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration:BoxDecoration(

                        ),
                        child: Text(
                          call.status ?? 'Unknown Status',
                          style:  TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,

                          ),
                        ),
                      ),
                      Text(
                        call.createdAt != null
                            ? DateFormat('MMM dd, yyyy • hh:mm a').format(call.createdAt!)
                            : 'N/A',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color: Colors.blue),
                      const SizedBox(width: 6),
                      Text(
                        '${call.countryCode ?? ''} ${call.mobile ?? 'N/A'}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (call.duration != null) Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 16, color: Colors.orange),
                      const SizedBox(width: 6),
                      Text(
                        'Duration: ${call.duration} seconds',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (call.leadType != null) Row(
                    children: [
                      const Icon(Icons.label_outline, size: 16, color: Colors.purple),
                      const SizedBox(width: 6),
                      Text(
                        'Type: ${call.leadType?.name ?? 'N/A'}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (call.leadSubType != null) Row(
                    children: [
                      const Icon(Icons.label, size: 16, color: Colors.green),
                      const SizedBox(width: 6),
                      Text(
                        'Sub Type: ${call.leadSubType?.name ?? 'N/A'}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),

                  if (call.remark != null && call.remark!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 4),
                    Text(
                      'Remark: ${call.remark}',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      ),
                    ),
                  ],

                  // Reminder section
                  if (call.reminder != null) ...[
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.event_note, size: 18, color: Colors.red),
                        const SizedBox(width: 6),
                        Text(
                          'Reminder: ${call.reminder?.title ?? 'N/A'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (call.reminder?.reminderDate != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          'Date: ${DateFormat('MMM dd, yyyy • hh:mm a').format(call.reminder!.reminderDate!)}',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    if (call.reminder?.remark != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 24, top: 4),
                        child: Text(
                          'Note: ${call.reminder?.remark}',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                  ],

                  // Created by section
                  if (call.createdBy != null) ...[
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          'Created by: ${call.createdBy?.firstName ?? ''} ${call.createdBy?.lastName ?? ''}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              );
            },
          );
        }),
      ],
    );
  }
}