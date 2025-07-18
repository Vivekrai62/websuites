import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../viewModels/customerScreens/activities/assigned/customer_details_activities_assigned_view_model.dart';

class CustomerDetailsActivitiesAssignedScreen extends StatefulWidget {
  final String customerId;

  const CustomerDetailsActivitiesAssignedScreen({super.key, required this.customerId});

  @override
  State<CustomerDetailsActivitiesAssignedScreen> createState() => _CustomerDetailsActivitiesAssignedScreenState();
}

class _CustomerDetailsActivitiesAssignedScreenState extends State<CustomerDetailsActivitiesAssignedScreen> {
  final CustomerDetailsActivitiesAssignedViewModel viewModel = Get.put(CustomerDetailsActivitiesAssignedViewModel());

  @override
  void initState() {
    super.initState();
    viewModel.customerDetailsActivitiesAssigned(context, widget.customerId);
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
              const Text(
                'Assigned :- ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.5,
                  fontFamily: 'SF Pro',
                ),
              ),
              Obx(() => Text(
                '${viewModel.customerAssigned.length}',
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
              padding: EdgeInsets.zero,
              child: Text(
                viewModel.errorMessage.value,
                style: const TextStyle(color: CupertinoColors.systemRed, fontSize: 16),
              ),
            );
          }

          final assignedItems = viewModel.customerAssigned;

          if (assignedItems.isEmpty) {
            return const Center(
              child: Text(
                'No Assigned Activities found',
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
            itemCount: assignedItems.length,
            itemBuilder: (context, index) {
              final assigned = assignedItems[index];
              final formattedCreatedDate = assigned.createdAt != null
                  ? DateFormat('MMM dd, yyyy • hh:mm a').format(assigned.createdAt!)
                  : 'N/A';

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:   Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Remark
                    if (assigned.remark != null && assigned.remark!.isNotEmpty)
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
                                  'Remark: ${assigned.remark}',
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
                    if (assigned.company != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (assigned.remark != null && assigned.remark!.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 4),
                          ],
                          Row(
                            children: [
                              const Icon(Icons.business, size: 16, color: Colors.blue),
                              const SizedBox(width: 6),
                              Text(
                                'Company: ${assigned.company!.companyName ?? 'N/A'}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          if (assigned.company!.companyEmail != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Row(
                                children: [
                                  const Icon(Icons.email_outlined, size: 16, color: Colors.teal),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Email: ${assigned.company!.companyEmail}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),

                    // Created by and date
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (assigned.user != null)
                          Row(
                            children: [
                              const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                'Created by: ${assigned.user!.firstName ?? ''} ${assigned.user!.lastName ?? ''}'.trim(),
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

                    // Assigned By (optional, if needed)
                    if (assigned.assignedBy != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              'Assigned by: ${assigned.assignedBy!.firstName ?? ''} ${assigned.assignedBy!.lastName ?? ''}'.trim(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Department (optional, if needed)
                    if (assigned.department != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.group_work_outlined, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              'Department: ${assigned.department!.name ?? 'N/A'}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),

              );
            },
          );
        }),
      ],
    );
  }
}