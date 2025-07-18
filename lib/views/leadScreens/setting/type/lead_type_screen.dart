import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../data/models/responseModels/leads/trashLeads/leadTypes/lead_types_response_model.dart';
import '../../../../../../resources/imageStrings/image_strings.dart';
import '../../../../../../resources/strings/strings.dart';
import '../../../../../../utils/appColors/app_colors.dart';
import '../../../../../../viewModels/leadScreens/setting/lead_type/add_create/lead_type/lead_type_add_view_model.dart';
import '../../../../../../viewModels/leadScreens/trashLeads/leadTypes/lead_type_viewModel.dart';
import '../../../../data/models/requestModels/lead/setting/lead_type/lead_type/lead_type_add_request_model.dart';
import '../../../../data/models/requestModels/lead/setting/lead_type/sub_lead_type/create_add/lead_type_add_req_model.dart';
import '../../../../utils/container_Utils/ContainerUtils.dart';
import '../../../../utils/dark_mode/dark_mode.dart';
import '../../../../utils/datetrim/DateTrim.dart';
import '../../../../utils/fontfamily/FontFamily.dart';
import '../../../../viewModels/leadScreens/setting/lead_type/add_create/lead_type/update/lead_type_update_view_model.dart';
import '../../../../viewModels/leadScreens/setting/lead_type/add_create/sub_lead_type/lead_sub_type_add_view_model.dart';
import '../../../../viewModels/leadScreens/setting/lead_type/add_create/sub_lead_type/update/lead_sub_type_view_model.dart';
import '../../createNewLead/widgets/createNewLeadCard/common_text_field.dart';
import '../../leadList/widgets/manat.dart';

class LeadSettingTypeScreen extends StatefulWidget {
  const LeadSettingTypeScreen({super.key});

  static void showCreateTypeDialog(BuildContext context, LeadTypeViewModel viewModel) {
    showResponsiveFilter(context, LeadSettingTypeScreenBottomSheet(viewModel: viewModel), desktopWidth: 400, backgroundColor: Colors.white);
  }

  @override
  State<LeadSettingTypeScreen> createState() => _LeadSettingTypeScreenState();
}

class _LeadSettingTypeScreenState extends State<LeadSettingTypeScreen> {
  final LeadTypeViewModel leadTypeList = Get.put(LeadTypeViewModel());
  final TextEditingController _searchController = TextEditingController();
  final RxList<LeadTypesResponseModel> _filteredLeadTypesList = <LeadTypesResponseModel>[].obs;
  final RxString _searchQuery = ''.obs;

  @override
  void initState() {
    super.initState();
    leadTypeList.fetchLeadTypes();
    ever(leadTypeList.leadTypesList, (_) => _filterLeadTypes());
    ever(_searchQuery, (_) => _filterLeadTypes());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterLeadTypes() {
    _filteredLeadTypesList.assignAll(_searchQuery.value.isEmpty
        ? leadTypeList.leadTypesList
        : leadTypeList.leadTypesList.where((item) =>
    (item.name ?? '').toLowerCase().contains(_searchQuery.value.toLowerCase()) ||
        (item.children?.any((child) => (child.name ?? '').toLowerCase().contains(_searchQuery.value.toLowerCase())) ?? false)).toList());
  }


  Widget _buildSubtypeChip(String subtype, LeadTypesResponseModel item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: Get.height / 40,
      decoration: BoxDecoration(color: AllColors.textField2, borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(subtype, style: TextStyle(color: AllColors.darkGrey, fontWeight: FontWeight.w400, fontSize: 12)),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () => _showModal(context, item, isEditMode: true, subtypeName: subtype, subtypeId: item.children?.firstWhere((child) => child.name == subtype, orElse: () => Children(id: '', name: '', status: 'Active')).id, isLeadType: false),
            child: Icon(Icons.edit, size: 14, color: AllColors.lightGrey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (leadTypeList.loading.value) return const Center(child: CircularProgressIndicator());
      if (leadTypeList.leadTypesList.isEmpty) return const Center(child: Text('No lead types available', style: TextStyle(fontSize: 16, color: Colors.grey)));

      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            Positioned(top: 0, left: 15, right: 0, child: Text(Strings.availableLeadStatus, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black))),
            Positioned(top: 25, left: 15, right: 15, child:

// Updated UI widget usage
            // In your LeadSettingTypeScreen, replace the search widget with:

            CommonTextField(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search, color: AllColors.figmaGrey),
              controller: _searchController, // Use your existing controller
              onChanged: (value) => _searchQuery.value = value, // Update your existing RxString
            ),

            ),
            Positioned(
              top: 80, left: 0, right: 0, bottom: 0,
              child: Obx(() => _filteredLeadTypesList.isEmpty && _searchQuery.value.isNotEmpty
                  ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.search_off, size: 48, color: AllColors.lightGrey),
                const SizedBox(height: 16),
                Text('No results found for "${_searchQuery.value}"', style: TextStyle(fontSize: 16, color: AllColors.grey)),
              ]))
                  : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _filteredLeadTypesList.length,
                itemBuilder: (context, index) {
                  final item = _filteredLeadTypesList[index];
                  final subtypes = item.children?.map((child) => child.name ?? '').where((name) => name.isNotEmpty).toList() ?? [];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ContainerUtils(
                      paddingTop: 10, paddingLeft: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(item.name ?? 'Unknown', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13,   color: DarkMode.backgroundColor2(context),)),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                decoration: BoxDecoration(color: (item.status ?? 'Unknown').toLowerCase() == 'inactive' ? AllColors.lightRed : AllColors.background_green, borderRadius: BorderRadius.circular(15)),
                                child: Text(item.status ?? 'Unknown', style: TextStyle(color: (item.status ?? 'Unknown').toLowerCase() == 'inactive' ? AllColors.darkRed : AllColors.text__green, fontSize: 12, fontWeight: FontWeight.w600)),
                              ),
                              const Spacer(),
                              InkWell(onTap: () => _showModal(context, item, isEditMode: true, isLeadType: true, leadTypeName: item.name, leadTypeId: item.id, leadTypeStatus: item.status, leadTypeReminder: item.isReminderRequired ?? false, leadTypeRemoveFromTodo: item.removeFromTodo ?? false, leadTypeRemoveFromList: item.removeFromList ?? false), child: Image.asset(ImageStrings.edit, height: 18, width: 18)),
                              const SizedBox(width: 15),
                              GestureDetector(onTap: () => _showModal(context, item, isEditMode: false, isLeadType: false), child: Icon(Icons.add_circle_outline, size: 22, color: AllColors.lightGrey)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(children: [Image.asset(ImageStrings.date, height: 14, width: 14), const SizedBox(width: 8), Text(formatDate(item.createdAt), style: TextStyle(color: AllColors.grey, fontWeight: FontWeight.w400, fontSize: 13))]),
                          const SizedBox(height: 8),
                          const Divider(thickness: 0.4),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Strings.subtypes, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,   color: DarkMode.backgroundColor2(context),)),
                              const SizedBox(width: 5),
                              Icon(Icons.arrow_right_alt, size: 18, color: AllColors.lightGrey),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(spacing: 8, runSpacing: 8, children: subtypes.take(2).map((subtype) => _buildSubtypeChip(subtype, item)).toList()),
                                    const SizedBox(height: 8),
                                    SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: subtypes.skip(2).map((subtype) => Padding(padding: const EdgeInsets.only(right: 8), child: _buildSubtypeChip(subtype, item))).toList())),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      );
    });
  }

  void _showModal(BuildContext context, LeadTypesResponseModel item, {required bool isEditMode, bool isLeadType = false, String? subtypeName, String? subtypeId, String? leadTypeName, String? leadTypeId, String? leadTypeStatus, bool? leadTypeReminder, bool? leadTypeRemoveFromTodo, bool? leadTypeRemoveFromList}) {
    showResponsiveFilter(context, _buildModal(context, item, isEditMode: isEditMode, isLeadType: isLeadType, subtypeName: subtypeName, subtypeId: subtypeId, leadTypeName: leadTypeName, leadTypeId: leadTypeId, leadTypeStatus: leadTypeStatus, leadTypeReminder: leadTypeReminder, leadTypeRemoveFromTodo: leadTypeRemoveFromTodo, leadTypeRemoveFromList: leadTypeRemoveFromList), desktopWidth: 400, backgroundColor: Colors.white);
  }

  Widget _buildModal(BuildContext context, LeadTypesResponseModel item, {required bool isEditMode, bool isLeadType = false, String? subtypeName, String? subtypeId, String? leadTypeName, String? leadTypeId, String? leadTypeStatus, bool? leadTypeReminder, bool? leadTypeRemoveFromTodo, bool? leadTypeRemoveFromList}) {
    final controller = TextEditingController(text: isLeadType ? leadTypeName : (isEditMode ? subtypeName : null));
    final isReminder = (isLeadType ? (leadTypeReminder ?? false) : (isEditMode ? (item.children?.firstWhere((child) => child.name == subtypeName || child.id == subtypeId, orElse: () => Children(id: '', name: '', status: 'Active'))?.isReminderRequired ?? false) : false)).obs;
    final removeFromTodo = (isLeadType ? (leadTypeRemoveFromTodo ?? false) : (isEditMode ? (item.children?.firstWhere((child) => child.name == subtypeName || child.id == subtypeId, orElse: () => Children(id: '', name: '', status: 'Active'))?.removeFromTodo ?? false) : false)).obs;
    final removeFromList = (isLeadType ? (leadTypeRemoveFromList ?? false) : (isEditMode ? (item.children?.firstWhere((child) => child.name == subtypeName || child.id == subtypeId, orElse: () => Children(id: '', name: '', status: 'Active'))?.removeFromList ?? false) : false)).obs;
    final status = (isLeadType ? (leadTypeStatus ?? 'Active') : (isEditMode ? (item.children?.firstWhere((child) => child.name == subtypeName || child.id == subtypeId, orElse: () => Children(id: '', name: '', status: 'Active'))?.status ?? 'Active') : 'Active')).obs;
    final isLoading = false.obs;

    return Material(
      color: Colors.white, borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20, spreadRadius: 2, offset: const Offset(0, -4))]),
        child: Column(
          children: [
            Container(margin: const EdgeInsets.symmetric(vertical: 10), width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: (AllColors.mediumPurple ?? Colors.blue).withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(isLeadType ? Icons.add_business_outlined : Icons.playlist_add, color: AllColors.mediumPurple ?? Colors.blue, size: 20)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(isLeadType ? (isEditMode ? 'Edit Lead Type' : 'Add Lead Type') : (isEditMode ? 'Edit Subtype' : 'Add Subtype'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: FontFamily.sfPro)),
                    Text(isLeadType ? 'Manage lead type settings' : 'for ${item.name ?? 'Lead Type'}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  ])),
                  InkWell(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey[50], shape: BoxShape.circle, border: Border.all(color: Colors.grey[200]!)), child: const Icon(Icons.close, size: 18, color: Colors.grey))),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [Icon(Icons.label_outline, size: 16, color: AllColors.mediumPurple ?? Colors.blue), const SizedBox(width: 8), Text(isLeadType ? 'Lead Type Name' : 'Subtype Name', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151))), const Text(' *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.red))]),
                        const SizedBox(height: 12),
                        CommonTextField(hintText: isLeadType ? 'Enter lead type name (e.g., Hot Lead, Cold Call)' : 'Enter subtype name (e.g., Follow-up, Qualified)', controller: controller),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildOptionTile(Icons.notification_important_outlined, 'Enable Reminders', isLeadType ? 'Set automatic reminders for this lead type' : 'Set automatic reminders for this subtype', isReminder),
                    if (isEditMode) ...[
                      const SizedBox(height: 20),
                      _buildOptionTile(Icons.checklist_outlined, 'Remove from To-Do', 'Automatically remove completed items from to-do list', removeFromTodo),
                      const SizedBox(height: 20),
                      _buildOptionTile(Icons.list_alt_outlined, 'Remove from List', isLeadType ? 'Hide this lead type from main listings when completed' : 'Hide this subtype from main listings when completed', removeFromList),
                      const SizedBox(height: 20),
                      _buildOptionTile(Icons.signal_wifi_statusbar_4_bar, 'Status', 'Toggle between Active and Inactive', RxBool(status.value.toLowerCase() == 'active'), status: status),
                    ],
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey))),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(flex: 2, child: OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 12)), child: const Text("Cancel", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)))),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: Obx(() => ElevatedButton(
                        onPressed: isLoading.value ? null : () => _handleAction(context, controller, isReminder, isLoading, item, isEditMode: isEditMode, isLeadType: isLeadType, removeFromTodo: isEditMode ? removeFromTodo : null, removeFromList: isEditMode ? removeFromList : null, status: isEditMode ? status : null, id: isLeadType ? leadTypeId : (isEditMode ? subtypeId : null)),
                        style: ElevatedButton.styleFrom(backgroundColor: AllColors.mediumPurple ?? Colors.blue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 12)),
                        child: isLoading.value ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) : Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add, size: 18), const SizedBox(width: 8), Text(isLeadType ? (isEditMode ? "Update Lead Type" : "Add Lead Type") : (isEditMode ? "Update Subtype" : "Add Subtype"), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600))]),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, String subtitle, RxBool value, {Color? activeColor, RxString? status}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey[200]!)),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: (AllColors.mediumPurple ?? Colors.blue).withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: Icon(icon, size: 16, color: AllColors.mediumPurple ?? Colors.blue)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1F2937))), Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey))])),
          Obx(() => Switch(
            value: status != null ? status.value.toLowerCase() == 'active' : value.value,
            onChanged: status != null ? (newValue) => status.value = newValue ? 'Active' : 'Inactive' : (newValue) => value.value = newValue,
            activeColor: activeColor ?? AllColors.mediumPurple ?? Colors.blue,
            activeTrackColor: (activeColor ?? AllColors.mediumPurple ?? Colors.blue).withOpacity(0.3),
            inactiveThumbColor: Colors.red,
            inactiveTrackColor: Colors.white,
            trackOutlineColor: WidgetStateProperty.resolveWith((states) => (status != null ? !(status.value.toLowerCase() == 'active') : !value.value) ? Colors.red : Colors.grey[300]),            trackOutlineWidth: WidgetStateProperty.all(1.0),
          )),
        ],
      ),
    );
  }

  Future<void> _handleAction(BuildContext context, TextEditingController controller, RxBool isReminder, RxBool isLoading, LeadTypesResponseModel item, {required bool isEditMode, required bool isLeadType, RxBool? removeFromTodo, RxBool? removeFromList, RxString? status, String? id}) async {
    if (controller.text.trim().isEmpty) {
      _showSnackBar(context, isLeadType ? 'Please enter a lead type name' : 'Please enter a subtype name', Colors.orange, Icons.warning_outlined);
      return;
    }
    isLoading.value = true;
    try {
      if (isLeadType) {
        if (isEditMode && id != null) {
          final success = await Get.put(LeadUpdateTypeViewModel()).updateLeadTypeApi(id, controller.text.trim(), status!.value, isReminder.value, removeFromTodo!.value, removeFromList!.value);
          if (success) {
            leadTypeList.fetchLeadTypes();
            Navigator.pop(context);
            _showSnackBar(context, 'Lead type updated successfully', Colors.green, Icons.check_circle_outline);
          } else {
            Navigator.pop(context);
          }
        } else {
          final requestModel = AddLeadTypeReqModel(name: controller.text.trim(), isReminderRequired: isReminder.value, removeFromTodo: removeFromTodo?.value ?? false, removeFromList: removeFromList?.value ?? false);
          await Get.put(LeadTypeAddViewModel()).addLeadType(context, requestModel);
          leadTypeList.fetchLeadTypes();
          Navigator.pop(context);
          _showSnackBar(context, 'Lead type added successfully', Colors.green, Icons.check_circle_outline);
        }
      } else {
        if (isEditMode && id != null) {
          final success = await Get.put(LeadUpdateSubTypeViewModel()).updateSubLeaveTypeApi(id, controller.text.trim(), status!.value, isReminder.value);
          if (success) {
            leadTypeList.fetchLeadTypes();
            Navigator.pop(context);
            _showSnackBar(context, 'Subtype updated successfully', Colors.green, Icons.check_circle_outline);
          } else {
            _showSnackBar(context, 'Failed to update subtype.', Colors.red, Icons.error_outline);
          }
        } else {
          final requestSubModel = LeadSubTypeAddReqModel(name: controller.text.trim(), isReminderRequired: isReminder.value, type: item.id);
          await Get.put(LeadSubTypeAddViewModel()).leadSubTypeAddApi(context, requestSubModel);
          leadTypeList.fetchLeadTypes();
          Navigator.pop(context);
          _showSnackBar(context, 'Subtype added successfully', Colors.green, Icons.check_circle_outline);
        }
      }
    } catch (e) {
      _showSnackBar(context, 'Failed to ${isEditMode ? 'update' : 'add'} ${isLeadType ? 'lead type' : 'subtype'}.', Colors.red, Icons.error_outline);
    } finally {
      isLoading.value = false;
    }
  }

  void _showSnackBar(BuildContext context, String message, Color backgroundColor, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [Icon(icon, color: Colors.white, size: 20), const SizedBox(width: 12), Expanded(child: Text(message, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)))]),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    ));
  }
}

class LeadSettingTypeScreenBottomSheet extends StatelessWidget {
  final LeadTypeViewModel viewModel;
  const LeadSettingTypeScreenBottomSheet({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final leadTypeAddViewModel = Get.put(LeadTypeAddViewModel());
    final typeController = TextEditingController();
    final isReminder = false.obs, removeFromTodo = false.obs, removeFromList = false.obs, isLoading = false.obs;

    return Material(
      color: Colors.white, borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Container(
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24)), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 2, offset: Offset(0, -4))]),
          height: MediaQuery.of(context).size.height * 0.83,
          child: Column(
              children: [
          Container(margin: const EdgeInsets.symmetric(vertical: 10), width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: (AllColors.mediumPurple ?? Colors.blue).withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.add_business_outlined, color: AllColors.mediumPurple ?? Colors.blue, size: 20)),
            const SizedBox(width: 12),
            const Expanded(child: Text("Add New Lead Status", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: FontFamily.sfPro))),
            InkWell(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey[50], shape: BoxShape.circle, border: Border.all(color: Colors.grey[200]!)), child: const Icon(Icons.close, size: 18, color: Colors.grey))),
          ],
        ),
      ),
      const Divider(thickness: 0.4),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerUtils(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [Icon(Icons.label_outline, size: 16, color: AllColors.mediumPurple ?? Colors.blue), const SizedBox(width: 8), const Text('Lead Type Name', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151))), const Text(' *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.red))]),
                    const SizedBox(height: 12),
                    CommonTextField(hintText: 'Enter lead type name (e.g., Hot Lead, Cold Call)', controller: typeController),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ContainerUtils(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [Icon(Icons.settings_outlined, size: 16, color: AllColors.mediumPurple ?? Colors.blue), const SizedBox(width: 8), const Text('Configuration Options', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151)))]),
                    const SizedBox(height: 16),
                    _buildOptionTile(Icons.notification_important_outlined, 'Enable Reminders', 'Set automatic reminders for this lead type', isReminder),
                    const SizedBox(height: 12),
                    _buildOptionTile(Icons.checklist_outlined, 'Remove from To-Do', 'Automatically remove completed items from to-do list', removeFromTodo),
                    const SizedBox(height: 12),
                    _buildOptionTile(Icons.list_alt_outlined, 'Remove from List', 'Hide this lead type from main listings when completed', removeFromList),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey))),
        child: SafeArea(
            child: Row(
                children: [
                Expanded(flex: 2, child: OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(side:
                BorderSide(color: Colors.grey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 10)), child: const Text("Cancel", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))),
        const SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: Obx(() => ElevatedButton(
            onPressed: isLoading.value ? null : () => _handleAddLeadType(context, leadTypeAddViewModel, typeController, isReminder, removeFromTodo, removeFromList, isLoading),
            style: ElevatedButton.styleFrom(backgroundColor: AllColors.mediumPurple ?? Colors.blue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 10)),
            child: isLoading.value ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) : Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.add, size: 18), SizedBox(width: 8), Text("Add Lead Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))]),
          )),
        ),
        ],
      ),
    ),
    ),
    ],
    ),
    ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, String subtitle, RxBool value, {Color? activeColor, RxString? status}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey[200]!)),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: (AllColors.mediumPurple ?? Colors.blue).withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: Icon(icon, size: 16, color: AllColors.mediumPurple ?? Colors.blue)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1F2937))), Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey))])),
          Obx(() => Switch(
            value: status != null ? status.value.toLowerCase() == 'active' : value.value,
            onChanged: status != null ? (newValue) => status.value = newValue ? 'Active' : 'InActive' : (newValue) => value.value = newValue,
            activeColor: activeColor ?? AllColors.mediumPurple ?? Colors.blue,
            activeTrackColor: (activeColor ?? AllColors.mediumPurple ?? Colors.blue).withOpacity(0.3),
            inactiveThumbColor: Colors.red,
            inactiveTrackColor: Colors.white,
            trackOutlineColor: WidgetStateProperty.resolveWith((states) => (status != null ? !(status.value.toLowerCase() == 'active') : !value.value) ? Colors.red : Colors.grey[300]),          )),
        ],
      ),
    );
  }

  Future<void> _handleAddLeadType(BuildContext context, LeadTypeAddViewModel leadTypeAddViewModel, TextEditingController typeController, RxBool isReminder, RxBool removeFromTodo, RxBool removeFromList, RxBool isLoading) async {
    if (typeController.text.trim().isEmpty) {
      _showSnackBar(context, 'Please enter a lead type name', Colors.orange, Icons.warning_outlined);
      return;
    }
    isLoading.value = true;
    try {
      final requestModel = AddLeadTypeReqModel(name: typeController.text.trim(), isReminderRequired: isReminder.value, removeFromList: removeFromList.value, removeFromTodo: removeFromTodo.value);
      await leadTypeAddViewModel.addLeadType(context, requestModel);
      viewModel.fetchLeadTypes();
      Navigator.pop(context);
    } catch (e) {
      _showSnackBar(context, 'Failed to add lead type. Please try again.', Colors.red, Icons.error_outline);
    } finally {
      isLoading.value = false;
    }
  }

  void _showSnackBar(BuildContext context, String message, Color backgroundColor, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [Icon(icon, color: Colors.white, size: 20), const SizedBox(width: 12), Expanded(child: Text(message, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)))]),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    ));
  }
}