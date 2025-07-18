import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../viewModels/customerScreens/activities/notes/customer_details_notes_view_model.dart';

class CustomerDetailsActivitiesNotesScreen extends StatefulWidget {
  final String customerId;

  const CustomerDetailsActivitiesNotesScreen({super.key, required this.customerId});

  @override
  State<CustomerDetailsActivitiesNotesScreen> createState() => _CustomerDetailsActivitiesNotesScreenState();
}

class _CustomerDetailsActivitiesNotesScreenState extends State<CustomerDetailsActivitiesNotesScreen> {
  final CustomerActivitiesNotesViewModel viewModel = Get.put(CustomerActivitiesNotesViewModel());

  @override
  void initState() {
    super.initState();
    viewModel.customerDetailsActivitiesNotes(context, widget.customerId);
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
                'Notes :- ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.5,
                  fontFamily: 'SF Pro',
                ),
              ),
              Obx(() => Text(
                '${viewModel.customerNotes.length}',
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

          final notes = viewModel.customerNotes;

          if (notes.isEmpty) {
            return const Center(
              child: Text(
                'No Notes found',
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
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              final formattedCreatedDate = note.createdAt != null
                  ? DateFormat('MMM dd, yyyy • hh:mm a').format(note.createdAt!)
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
                      // Remark
                      if (note.remark != null && note.remark!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.note_outlined, size: 16, color: Colors.brown),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Remark: ${note.remark}',
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

                      // Company
                      if (note.company != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.business, size: 16, color: Colors.blue),
                                const SizedBox(width: 6),
                                Text(
                                  'Company: ${note.company!.companyName ?? 'N/A'}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            if (note.company!.companyEmail != null)
                              Row(
                                children: [
                                  const Icon(Icons.email_outlined, size: 16, color: Colors.teal),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Email: ${note.company!.companyEmail}',
                                    style: const TextStyle(fontSize: 14),
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
                          if (note.createdBy != null)
                            Row(
                              children: [
                                const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  'Created by: ${note.createdBy!.firstName ?? ''} ${note.createdBy!.lastName ?? ''}'.trim(),
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