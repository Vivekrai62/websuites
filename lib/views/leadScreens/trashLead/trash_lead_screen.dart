import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../resources/imageStrings/image_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';

import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datetrim/DateTrim.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/leadScreens/createNewLead/constant_controller/constant_controller.dart';
import '../../../viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import '../../../viewModels/leadScreens/lead_list/delete/LeadDeleteViewmodel.dart';
import '../../../viewModels/leadScreens/lead_list/lead_assign/lead_assign.dart';
import '../../../viewModels/leadScreens/lead_list/lead_list.dart';
import '../../../viewModels/leadScreens/trashLeads/deleteList/delete_list_viewModel.dart';
import 'package:websuites/data/models/responseModels/leads/trashLeads/deleteList/delete_list_response_model.dart';
import '../../../viewModels/leadScreens/trashLeads/delete_permanent/TrashLeadPermanentViewModel.dart';
import '../../../viewModels/leadScreens/trashLeads/restore/LeadTrashRestoreViewModel.dart';

class TrashLeadScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const TrashLeadScreen({super.key, required this.scaffoldKey});

  @override
  _TrashLeadScreenState createState() => _TrashLeadScreenState();
}

class _TrashLeadScreenState extends State<TrashLeadScreen> {
  final TrashDeleteListViewModel _viewModel = Get.put(TrashDeleteListViewModel());
  final TrashLeadPermanentViewModel _trashLeadPermanentViewModel = Get.put(TrashLeadPermanentViewModel()); // Add this line
  final LeadTrashRestoreViewModel _leadDeleteRestoreViewModel = Get.put(LeadTrashRestoreViewModel()); // Add this line
  final TextEditingController searchController = TextEditingController();
  bool isFloatingButtonClicked = false;

  final ListLeadAssignViewModel searchAssigned = Get.put(ListLeadAssignViewModel());
  final ConstantValueViewModel staticText = Get.put(ConstantValueViewModel());
  final DivisionsViewModel divisionList = Get.put(DivisionsViewModel());

  // Simplified refresh method matching CustomerCredentialScreen
  Future<void> _refreshLeadList() async {
    if (mounted) {
      await _viewModel.fetchTrashDeleteList(forceRefresh: true);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
      Get.lazyPut(() => TrashLeadPermanentViewModel()); // Add lazy initialization
    });
  }

  Future<void> _initializeData() async {
    // Initialize all required data
    searchAssigned.leadListLeadAssign(context);
    searchAssigned.leadAssignList();
    staticText.fetchConstantList(context);
    divisionList.fetchDivisions();
    _viewModel.fetchTrashDeleteList(); // Explicit initial fetch
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          setState(() {
            isFloatingButtonClicked = !isFloatingButtonClicked;
          });
        },
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor:   DarkMode.backgroundColor(context),
      body: Column(
        children: [
          CustomAppBar(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
              child: Row(
                children: [
                  if (!isTablet)
                    IconButton(
                      icon:  Icon(Icons.menu,   color: DarkMode.backgroundColor2(context),),
                      onPressed: () {
                        if (widget.scaffoldKey.currentState != null) {
                          if (!widget.scaffoldKey.currentState!.isDrawerOpen) {
                            widget.scaffoldKey.currentState!.openDrawer();
                          }
                        } else {
                          debugPrint("Scaffold key has no current state");
                        }
                      },
                    ),
                  if (isTablet) const SizedBox(width: 10),
                  Text(
                    'Trash List',
                    style: TextStyle(
                      color: DarkMode.backgroundColor2(context),
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 18.5,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement filter bottom sheet if needed
                      debugPrint('Filter button pressed');
                    },
                    child:  Icon(Icons.filter_list,   color: DarkMode.backgroundColor2(context),),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              // Show loading indicator when loading and list is empty
              if (_viewModel.loading.value && _viewModel.leadsTrashList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return RefreshIndicator(
                onRefresh: _refreshLeadList,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (_viewModel.leadsTrashList.isEmpty) {
                      return const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Center(child: Text("No trash leads available")),
                      );
                    }

                    final double screenWidth = constraints.maxWidth;
                    int crossAxisCount = screenWidth < 600
                        ? 1
                        : screenWidth < 1200
                        ? 2
                        : 3;
                    const double itemHeight = 175;
                    final double itemWidth = (screenWidth - (crossAxisCount - 1) * 16) / crossAxisCount;
                    final double childAspectRatio = itemWidth / itemHeight;

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          if (isFloatingButtonClicked)
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                              child: CreateNewLeadScreenCard2(
                                hintText: 'Search trash leads...',
                                onSearch: (value) {
                                  _viewModel.searchLeads(value);
                                },
                                controller: searchController,
                              ),
                            ),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(16),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemCount: _viewModel.filteredLeads.length,
                            itemBuilder: (context, index) {
                              final item = _viewModel.filteredLeads[index];
                              return GestureDetector(
                                onLongPress: () {
                                  _showEditDeleteDialog(item);
                                },
                                child: ContainerUtils(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          (item.firstName?.isNotEmpty == true ||
                                              item.lastName?.isNotEmpty == true)
                                              ? "${item.firstName ?? ""} ${item.lastName ?? ""}".trim()
                                              : 'N/A',
                                          style:  TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: FontFamily.sfPro,
                                            color: DarkMode.backgroundColor2(context),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.organization ?? 'N/A',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                  color: DarkMode.backgroundColor2(context),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Image.asset(
                                            ImageStrings.call,
                                            height: 14,
                                            width: 14,
                                          ),
                                          const SizedBox(width: 10),
                                          InkWell(
                                            onTap: () {},
                                            child: Text(
                                              '+${item.mobileWithCountryCode ?? ''}',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: AllColors.figmaGrey,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/date.png',
                                            height: 14,
                                            width: 14,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            formatDateWithTime(item.latestEnquiryDate?.toString()),
                                            style: TextStyle(fontSize: 13, color: AllColors.mediumPurple),
                                          ),
                                          const Spacer(),
                                          Icon(Icons.language, size: 18.5, color: AllColors.figmaGrey),
                                          const SizedBox(width: 5),
                                          Text(
                                            item.deleteRemark ?? "Unknown Source",
                                            style: TextStyle(fontSize: 13, color: AllColors.figmaGrey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      const Divider(thickness: 0.4),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: AllColors.lighterPurple,
                                            ),
                                            child: Text(
                                              "No Assignee",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AllColors.vividPurple,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(Icons.restore, size: 21, color: AllColors.darkGreen),
                                          const SizedBox(width: 5),
                                          Icon(Icons.delete, size: 21, color: AllColors.darkRed),
                                          const SizedBox(width: 5),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: AllColors.lightBlue,
                                            ),
                                            child: Text(
                                              item.type?.name ?? "N/A",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AllColors.darkBlue,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showEditDeleteDialog(Item item) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double dialogWidth = MediaQuery.of(context).size.width * 0.85;
              final double maxDialogWidth = dialogWidth > 300 ? 300 : dialogWidth;

              return SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: DarkMode.backgroundColor(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  width: maxDialogWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      Text(
                        'Are You Sure',
                        style: TextStyle(
                          fontSize: maxDialogWidth < 250 ? 20 : 24,
                          fontWeight: FontWeight.bold,
                          color: DarkMode.backgroundColor2(context),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Want To Restore or Delete?',
                        style: TextStyle(
                          fontSize: maxDialogWidth < 250 ? 20 : 24,
                          fontWeight: FontWeight.bold,
                          color: DarkMode.backgroundColor2(context),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'This will allow you to modify or restore and delete your item',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: maxDialogWidth < 250 ? 14 : 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _showRestoreConfirmationDialog(item, context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Yes Restore')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AllColors.darkGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Yes Restore',
                            style: TextStyle(
                              fontSize: maxDialogWidth < 250 ? 14 : 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _showDeleteConfirmationDialog(item, context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Yes Delete')),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: maxDialogWidth < 250 ? 14 : 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showRestoreConfirmationDialog(Item item, BuildContext leadRestoreWithContext) {
    showGeneralDialog(
      context: leadRestoreWithContext,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(leadRestoreWithContext).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double dialogWidth = MediaQuery.of(context).size.width * 0.85;
              final double maxDialogWidth = dialogWidth > 300 ? 300 : dialogWidth;

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: DarkMode.backgroundColor(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: maxDialogWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.restore_from_trash,
                        color: AllColors.darkGreen,
                        size: maxDialogWidth < 250 ? 28 : 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'You are about to restore',
                      style: TextStyle(
                        fontSize: maxDialogWidth < 250 ? 18 : 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'This will restore your item permanently. Are you sure?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: maxDialogWidth < 250 ? 14 : 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.grey[700],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: maxDialogWidth < 250 ? 14 : 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              final leadDeleteRestoresViewModel = Get.find<LeadTrashRestoreViewModel>();
                              await leadDeleteRestoresViewModel.leadTrashRestoreApi(
                                item.id ?? '',
                                onSuccess: () async {
                                  if (leadRestoreWithContext.mounted) {
                                    final leadListViewModel = Get.find<LeadListViewModel>();
                                    await leadListViewModel.fetchLeadList();
                                  }
                                },
                                onError: (error) {
                                  if (leadRestoreWithContext.mounted) {
                                    ScaffoldMessenger.of(leadRestoreWithContext).showSnackBar(
                                      SnackBar(content: Text('Error: $error')),
                                    );
                                  }
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AllColors.darkGreen,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Restore',
                              style: TextStyle(
                                fontSize: maxDialogWidth < 250 ? 14 : 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child,
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(Item item, BuildContext leadTrashDeletePermWithContext) {
    showGeneralDialog(
      context: leadTrashDeletePermWithContext,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(leadTrashDeletePermWithContext).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double dialogWidth = MediaQuery.of(context).size.width * 0.85;
              final double maxDialogWidth = dialogWidth > 300 ? 300 : dialogWidth;
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: DarkMode.backgroundColor(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: maxDialogWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.delete,
                        color: AllColors.vividRed,
                        size: maxDialogWidth < 250 ? 28 : 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'You are about to Delete Permanent',
                      style: TextStyle(
                        fontSize: maxDialogWidth < 250 ? 18 : 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'This will Delete your item permanently. Are you sure?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: maxDialogWidth < 250 ? 14 : 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.grey[700],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: maxDialogWidth < 250 ? 14 : 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              final trashLeadPerm = Get.find<TrashLeadPermanentViewModel>();
                              await trashLeadPerm.leadTrashDeletePermApi(
                                item.id ?? '',
                                onSuccess: () async {
                                  if (leadTrashDeletePermWithContext.mounted) {
                                    await _viewModel.fetchTrashDeleteList(forceRefresh: true);
                                    ScaffoldMessenger.of(leadTrashDeletePermWithContext).showSnackBar(
                                      const SnackBar(content: Text('Lead deleted permanently')),
                                    );
                                  }
                                },
                                onError: (error) {
                                  if (leadTrashDeletePermWithContext.mounted) {
                                    ScaffoldMessenger.of(leadTrashDeletePermWithContext).showSnackBar(
                                      SnackBar(content: Text('Error: $error')),
                                    );
                                  }
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AllColors.vividRed,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: maxDialogWidth < 250 ? 14 : 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child,
        );
      },
    );
  }
}