import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../viewModels/customerScreens/activities/call/customer_activity_calls_view_models.dart';

class CustomerDetailsActivitiesCallScreen extends StatefulWidget {
  final String customerId;

  const CustomerDetailsActivitiesCallScreen({super.key, required this.customerId});

  @override
  State<CustomerDetailsActivitiesCallScreen> createState() => _CustomerDetailsActivitiesCallScreenState();
}

class _CustomerDetailsActivitiesCallScreenState extends State<CustomerDetailsActivitiesCallScreen> {
  final CustomerActivitiesCallsViewModel viewModel = Get.put(CustomerActivitiesCallsViewModel());

  @override
  void initState() {
    super.initState();
    viewModel.customerDetailsActivitiesCall(context, widget.customerId);
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
                'Call :- ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.5,
                  fontFamily: 'SF Pro', // Ensure you have this font or replace with a similar one
                ),
              ),
              Obx(() => Text(
                '${viewModel.customerCalls.length}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.5,
                  color: Colors.grey[600], // Match AllColors.figmaGrey equivalent
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

          final calls = viewModel.customerCalls;

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
              final formattedDate = call.createdAt != null
                  ? DateFormat('MMM dd, yyyy • hh:mm a').format(call.createdAt)
                  : 'N/A';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        call.status ?? 'Unknown Status',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        formattedDate,
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
                  if (call.duration != 0)
                    Row(
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
                  if (call.leadType != null)
                    Row(
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
                  if (call.leadSubType != null)
                    Row(
                      children: [
                        const Icon(Icons.label, size: 16, color: Colors.green),
                        const SizedBox(width: 6),
                        Text(
                          'Sub Type: ${call.leadSubType ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  const SizedBox(height: 4),
                  if (call.productCategories.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.category, size: 16, color: Colors.teal),
                        const SizedBox(width: 6),
                        Text(
                          'Product Categories: ${call.productCategories}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  const SizedBox(height: 4),
                  if (call.location != null && call.location!.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.red),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Location: ${call.location}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  if (call.remark.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                    ),
                  if (call.reminder != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.event_note, size: 18, color: Colors.red),
                            const SizedBox(width: 6),
                            Text(
                              'Reminder: ${call.reminder}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'Created by: ${call.createdBy.firstName} ${call.createdBy.lastName}'.trim(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          );
        }),
      ],
    );
  }
}