import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/models/responseModels/leads/list/details/LeadDetails.dart';
import '../../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../../utils/appColors/app_colors.dart';
import '../../../../../../utils/datetrim/DateTrim.dart';
import '../../../../../../utils/fontfamily/FontFamily.dart';
import '../../../../../../viewModels/leadScreens/lead_list/lead_detail_view/activities/assigned/LeadDetailsActiAssignedViewModelModel.dart';

class LeadActivitiesAssignedScreen extends StatefulWidget {
  final String? leadId;
  final LeadDetailsResponseModel leadDetails;

  const LeadActivitiesAssignedScreen({
    super.key,
    this.leadId,
    required this.leadDetails,
  });

  @override
  State<LeadActivitiesAssignedScreen> createState() => _LeadActivitiesAssignedScreenState();
}

class _LeadActivitiesAssignedScreenState extends State<LeadActivitiesAssignedScreen> {
  final LeadDetailsActiAssignedViewModelModel viewModel = Get.put(LeadDetailsActiAssignedViewModelModel());

  @override
  void initState() {
    super.initState();
    if (widget.leadId != null) {
      viewModel.leadDetailsActivitiesAssigned(context, widget.leadId!);
    }
  }

  String _getFormattedDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final DateTime date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
    } catch (e) {
      return 'N/A';
    }
  }

  String _getStatusText(int? status) {
    switch (status) {
      case 0: return 'Pending';
      case 1: return 'Current Assignee';
      case 2: return 'Completed';
      case 3: return 'Cancelled';
      default: return 'Unknown';
    }
  }

  Color _getStatusColor(int? status) {
    switch (status) {
      case 0: return Colors.orange;
      case 1: return AllColors.background_green;
      case 2: return Colors.blue;
      case 3: return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Ensures Column takes minimal vertical space
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4), // Minimal padding for title
            child: Text(
              "Assigned",
              style: TextStyle(
                fontFamily: FontFamily.sfPro,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // Explicit minimal spacing to control gap
          const SizedBox(height: 4), // Reduced from 8 to 4 for tighter spacing
          Obx(() {
            if (viewModel.loading.value) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0), // Further reduced padding
                  child: const CircularProgressIndicator(),
                ),
              );
            } else if (viewModel.leadActivitiesAssigned.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0), // Minimal padding
                  child: Text(
                    'No assigned activities found',
                    style: TextStyle(
                      fontFamily: FontFamily.sfPro,
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              );
            } else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero, // Remove any default padding in ListView
                itemCount: viewModel.leadActivitiesAssigned.length,
                separatorBuilder: (context, index) => const SizedBox(height: 0), // No extra separator height
                itemBuilder: (context, index) {
                  final activity = viewModel.leadActivitiesAssigned[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // User info and avatar
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AllColors.background_green.withOpacity(0.2),
                                  radius: 20,
                                  child: Text(
                                    activity.user?.firstName?.substring(0, 1) ?? 'U',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${activity.user?.firstName ?? 'N/A'} ${activity.user?.lastName ?? ''}",
                                      style: TextStyle(
                                        fontFamily: FontFamily.sfPro,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      _getFormattedDate(activity.createdAt.toString()),
                                      style: TextStyle(
                                        fontFamily: FontFamily.sfPro,
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Status badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(activity.status),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _getStatusText(activity.status),
                                style: TextStyle(
                                  fontFamily: FontFamily.sfPro,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                           color: AllColors.text__green
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Divider
                        Divider(color: Colors.grey[300], height: 1),
                        const SizedBox(height: 16),
                        // Department info
                        Row(
                          children: [
                            Icon(Icons.business, size: 18, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            Text(
                              "Department: ",
                              style: TextStyle(
                                fontFamily: FontFamily.sfPro,
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              activity.department?.name ?? 'N/A',
                              style: TextStyle(
                                fontFamily: FontFamily.sfPro,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Assigned by info
                        Row(
                          children: [
                            Icon(Icons.person_outline, size: 18, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            Text(
                              "Assigned by: ",
                              style: TextStyle(
                                fontFamily: FontFamily.sfPro,
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              "${activity.assignedBy?.firstName ?? 'N/A'} ${activity.assignedBy?.lastName ?? ''}",
                              style: TextStyle(
                                fontFamily: FontFamily.sfPro,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Action buttons
                      ],
                    ),
                  );
                },
              );
            }
          }),
        ],
      );
  }
}