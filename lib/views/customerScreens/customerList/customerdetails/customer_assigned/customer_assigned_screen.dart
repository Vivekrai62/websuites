import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../../../../../data/models/responseModels/leads/list/lead_assign/lead_assign.dart';
import '../../../../../utils/appColors/app_colors.dart';
import 'package:websuites/views/leadScreens/leadList/widgets/manat.dart';
import '../../../../../viewModels/customerScreens/customer_list/customer_detail_view/customer_creatre_assigned/customer_create_assigned_viewModel.dart';
import '../../../../../viewModels/leadScreens/lead_list/lead_assign/lead_assign.dart';

class LeadAssignmentBottomSheet {
  static Future<void> show(
      BuildContext context,
      List<String> customerIds,
      Function(String) onLeadSelected,
      ) async {
    final ListLeadAssignViewModel viewModel = Get.put(ListLeadAssignViewModel());
    bool isLoading = true;

    try {
      await viewModel.leadListLeadAssign(context);
    } catch (e) {
      isLoading = false;
      return;
    }

    isLoading = false;

    showResponsiveFilter(
      context,
      _LeadAssignmentContent(
        viewModel: viewModel,
        customerIds: customerIds,
        onLeadSelected: onLeadSelected,
      ),
      desktopWidth: 450,
    );
  }

  static Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off_outlined, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No Assigned available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildLeadOption(
      LeadAssignResponseModel lead,
      String selectedLeadId,
      Function(String) onSelect,
      ) {
    bool isSelected = selectedLeadId == lead.id;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onSelect(lead.id ?? ''),
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.shade50 : Colors.white,
              border: Border.all(
                color: isSelected ? Colors.blue.shade500 : Colors.grey.shade200,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: isSelected
                  ? [BoxShadow(color: Colors.blue.shade100, blurRadius: 8, offset: const Offset(0, 2))]
                  : [BoxShadow(color: Colors.grey.shade100, blurRadius: 4, offset: const Offset(0, 1))],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue.shade50 : Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person,
                    color: isSelected ? Colors.blue.shade700 : Colors.blue.shade600,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          lead.firstName ?? 'Unknown',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade900,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isSelected)
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade500,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 16),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LeadAssignmentContent extends StatefulWidget {
  final ListLeadAssignViewModel viewModel;
  final List<String> customerIds;
  final Function(String) onLeadSelected;

  const _LeadAssignmentContent({
    required this.viewModel,
    required this.customerIds,
    required this.onLeadSelected,
  });

  @override
  State<_LeadAssignmentContent> createState() => _LeadAssignmentContentState();
}

class _LeadAssignmentContentState extends State<_LeadAssignmentContent> {
  String selectedLeadId = '';

  @override
  Widget build(BuildContext context) {
    final isEmpty = widget.viewModel.leadAssignList.isEmpty;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Customer Assigned', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 20),
                ),
              ],
            ),
          ),
          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CommonTextField(
              hintText: 'Search',
              borderColor: AllColors.darkBlue,
            ),
          ),
          // Lead List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: isEmpty
                  ? LeadAssignmentBottomSheet._buildEmptyState()
                  : ListView.builder(
                itemCount: widget.viewModel.leadAssignList.length,
                itemBuilder: (_, index) {
                  final lead = widget.viewModel.leadAssignList[index];
                  return LeadAssignmentBottomSheet._buildLeadOption(
                    lead,
                    selectedLeadId,
                        (String leadId) {
                      setState(() {
                        selectedLeadId = leadId;
                      });
                      Navigator.pop(context);
                      LeadAssignmentApiHandler.assignCustomersToLead(
                        context,
                        leadId: leadId,
                        customerIds: widget.customerIds,
                      ).then((success) {
                        if (success) widget.onLeadSelected(leadId);
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LeadAssignmentApiHandler {
  static Future<bool> assignCustomersToLead(
      BuildContext context, {
        required String leadId,
        required List<String> customerIds,
      }) async {
    final CustomerAssignedViewModel customerViewModel = Get.put(CustomerAssignedViewModel());
    return await customerViewModel.assignCustomersToLead(
      leadId: leadId,
      assignedId: customerIds,
    );
  }
}
