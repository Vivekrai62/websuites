import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/datetrim/DateTrim.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/dark_mode/dark_mode.dart';
import '../../../utils/datafilter/SeletDateFilter.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/leadScreens/createNewLead/constant_controller/constant_controller.dart';
import '../../../viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import '../../../viewModels/leadScreens/lead_list/lead_assign/lead_assign.dart';
import '../../../viewModels/leadScreens/proformas/LeadProformaListViewModel.dart';
import '../../customerScreens/customerList/CustomerListScreen.dart';
import '../../homeScreen/home_manager/HomeManagerScreen.dart';
import '../leadList/leadlist_screen.dart';
import '../leadList/widgets/manat.dart';

class FilterStateController extends GetxController {
  RxMap<String, RxList<FilterOptionItem>> selectedFilterItems =
      <String, RxList<FilterOptionItem>>{}.obs;

  void setSelectedItems(String filterId, List<FilterOptionItem> items) {
    selectedFilterItems[filterId] = RxList<FilterOptionItem>.from(items);
  }

  RxList<FilterOptionItem> getSelectedItems(String filterId) {
    return selectedFilterItems[filterId] ?? RxList<FilterOptionItem>();
  }

  void clearSelections() {
    selectedFilterItems.clear();
  }
}

final FilterStateController filterStateController =
    Get.put(FilterStateController());

class LeadProformaList extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const LeadProformaList({
    super.key,
    required this.scaffoldKey,
  });

  @override
  _LeadProformaListState createState() => _LeadProformaListState();
}

class _LeadProformaListState extends State<LeadProformaList> {
  final LeadProformaListViewModel _viewModel =
      Get.put(LeadProformaListViewModel());
  final TextEditingController searchController = TextEditingController();
  bool isFloatingButtonClicked = false;

  final ListLeadAssignViewModel searchAssigned =
      Get.put(ListLeadAssignViewModel());
  final ConstantValueViewModel staticText = Get.put(ConstantValueViewModel());
  final DivisionsViewModel divisionList = Get.put(DivisionsViewModel());
  final HomeManagerController homeController =
      Get.find<HomeManagerController>();

  Future<void> _refreshLeadList() async {
    await _viewModel.fetchLeadProformas(forceRefresh: true);
  }

  @override
  void initState() {
    super.initState();
    // Schedule initialization after the first frame to avoid build scope issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchAssigned.leadListLeadAssign(context);
      staticText.fetchConstantList(context);
      divisionList.fetchDivisions();
      _viewModel.fetchLeadProformas(); // Initial fetch
    });
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
      bottomNavigationBar: CustomBottomNavBar(),
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
      backgroundColor: DarkMode.backgroundColor(context),
      body: Column(
        children: [
          CustomAppBar(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
              child: Row(
                children: [
                  if (!isTablet)
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black),
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
                    'Proformas List',
                    style: TextStyle(
                      color:  DarkMode.backgroundColor2(context),
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.sfPro,
                      fontSize: 18.5,

                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => openProformasFilterBottomSheet(context),
                    child:  Icon(Icons.filter_list,    color:  DarkMode.backgroundColor2(context), ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_viewModel.loading.value && _viewModel.leadProItems.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return RefreshIndicator(
                onRefresh: _refreshLeadList,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (_viewModel.leadProItems.isEmpty) {
                      return const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Center(child: Text("No proformas available")),
                      );
                    }

                    final double screenWidth = constraints.maxWidth;
                    int crossAxisCount = screenWidth < 600
                        ? 1
                        : screenWidth < 1200
                            ? 2
                            : 3;
                    const double itemHeight = 175;
                    final double itemWidth =
                        (screenWidth - (crossAxisCount - 1) * 16) /
                            crossAxisCount;
                    final double childAspectRatio = itemWidth / itemHeight;

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          if (isFloatingButtonClicked)
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, right: 15),
                              child: CreateNewLeadScreenCard2(
                                hintText: 'Search proformas...',
                                onSearch: (value) {
                                  _viewModel.searchProformas(value);
                                },
                                controller: searchController,
                              ),
                            ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemCount: _viewModel.leadProItems.length,
                            itemBuilder: (context, index) {
                              final item = _viewModel.leadProItems[index];
                              return GestureDetector(
                                onTap: () {
                                  debugPrint('View proforma for ${item.id}');
                                },
                                child: ContainerUtils(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.name ?? 'Unknown Name',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: FontFamily.sfPro,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            '#${item.performaNumber ?? 'N/A'}',
                                            style: TextStyle(
                                                color: AllColors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        item.email ?? 'No Email',
                                        style: TextStyle(
                                          color: AllColors.grey,
                                          fontSize: 13,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/date.png',
                                            height: 14,
                                            width: 14,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            formatDate(item.createdAt ??
                                                'Unknown Date'),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AllColors.mediumPurple,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: AllColors.lightRed,
                                            ),
                                            child: Text(
                                              item.createdBy?.firstName ??
                                                  'N/A',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AllColors.darkRed,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      const Divider(thickness: 0.4),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: AllColors.lighterPurple,
                                            ),
                                            child: Text(
                                              item.division?.name ?? 'Unknown',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AllColors.mediumPurple,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              debugPrint(
                                                  'View proforma for ${item.id}');
                                            },
                                            child: Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: AllColors.vividBlue,
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

  void openProformasFilterBottomSheet(BuildContext context) {
    final Map<String, Widget Function(BuildContext)> customBuilders = {};
    final constants = staticText.constantList.isNotEmpty
        ? staticText.constantList.first
        : null;
    FilterUtils.searchText.value = '';

    final TextEditingController createDateController = TextEditingController();

    final filterData = {
      'date_range': {
        'title': 'Create Date',
        'hintText': 'Select Date',
        'isSingleSelect': true,
        'widget': SelectDate(
          hintText: 'Select Date',
          filterIdentifier: 'date_range',
          controller: createDateController,
          onDateRangeSelected: (start, end) {
            if (start != null && end != null) {
              final formattedRange = {
                'from':
                    "${start.toIso8601String().substring(0, 10)} 00:00:00.000",
                'to': "${end.toIso8601String().substring(0, 10)} 23:59:59.999",
              };
              createDateController.text = jsonEncode(formattedRange);
            } else {
              createDateController.text = '';
            }
          },
        ),
      },
      'lead_assigned': {
        'title': 'Lead Assigned',
        'hintText': 'Select Assignee',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>([
          FilterOptionItem(
              label: constants?.withteam ?? 'With Team', id: 'withteam'),
          FilterOptionItem(
              label: constants?.individual ?? 'Individual', id: 'individual'),
        ]),
      },
      'created_by': {
        'title': 'Created By',
        'hintText': 'Search',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          searchAssigned.leadAssignList.map((lead) {
            return FilterOptionItem(
                label: lead.firstName ?? 'N/A', id: lead.id);
          }).toList(),
        ),
      },
      'division': {
        'title': 'Division',
        'hintText': 'Search Division',
        'isSingleSelect': true,
        'items': RxList<FilterOptionItem>(
          divisionList.divisionsList.map((division) {
            return FilterOptionItem(
                label: division.name ?? 'N/A', id: division.id);
          }).toList(),
        ),
      },
    };

    filterData.forEach((filterId, data) {
      final items = data['items'] as RxList<FilterOptionItem>?;
      if (items != null) {
        final previouslySelected =
            filterStateController.getSelectedItems(filterId);
        for (var item in items) {
          item.isSelected.value = previouslySelected.any((selected) =>
              selected.label == item.label && selected.id == item.id);
        }
      }
    });

    filterData.forEach((filterId, data) {
      customBuilders[filterId] = (context) {
        final widget = data['widget'] as Widget?;
        if (widget != null) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
              child: widget,
            ),
          );
        }

        final items = data['items'] as RxList<FilterOptionItem>? ??
            RxList<FilterOptionItem>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 9, bottom: 0, left: 10, right: 10),
              child: SizedBox(
                height: 43,
                child: TextField(
                  onChanged: (value) {
                    FilterUtils.searchText.value = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Search ${data['title']}',
                    prefixIcon: Icon(Icons.search,
                        color: AllColors.figmaGrey, size: 25),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide:
                          BorderSide(color: AllColors.mediumPurple, width: 0.6),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                final filteredItems = FilterUtils.getFilteredItems(items);
                return ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          top: item.isSelected.value ? 5 : 0,
                          bottom: item.isSelected.value ? 0 : 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: item.isSelected.value
                              ? AllColors.mediumPurple.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: Text(
                                  item.label,
                                  style: const TextStyle(
                                      fontSize: 14.5, color: Colors.black),
                                ),
                              ),
                              const Spacer(),
                              Obx(() => Transform.scale(
                                    scale: 0.8,
                                    child: Checkbox(
                                      value: item.isSelected.value,
                                      onChanged: (newValue) {
                                        FilterUtils.handleSelection(items, item,
                                            data['isSingleSelect'] as bool);
                                        if (data['isSingleSelect'] as bool &&
                                            newValue == true) {
                                          FilterUtils.searchText.value = '';
                                        }
                                      },
                                      activeColor: AllColors.mediumPurple,
                                      checkColor: Colors.white,
                                      side: BorderSide(
                                          color: AllColors.mediumPurple),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      };
    });

    showManatFilter(
      context,
      FilterConfig(
        title: "My Filters",
        primaryColor: AllColors.mediumPurple,
        filterOptionss: [
          FilterOption(
            id: 'date_range',
            label: 'Date Range',
            hintText: 'Select Date',
            icon: Icons.calendar_today,
            isMultiSelect: false,
          ),
          FilterOption(
            id: 'lead_assigned',
            label: 'Lead Assigned',
            hintText: 'Select Assignee',
            icon: Icons.people,
            isMultiSelect: false,
          ),
          FilterOption(
            id: 'created_by',
            label: 'Created By',
            hintText: 'Search',
            icon: Icons.person,
            isMultiSelect: true,
          ),
          FilterOption(
            id: 'division',
            label: 'Division',
            hintText: 'Division',
            icon: Icons.business,
            isMultiSelect: true,
          ),
        ],
        customBuilders: customBuilders,
        onFilterApplied: (filterId, selectedItems) {
          Map<String, dynamic> selectedFilters = {};

          filterData.forEach((filterId, data) {
            final items = data['items'] as RxList<FilterOptionItem>? ??
                RxList<FilterOptionItem>();
            final selected =
                items.where((item) => item.isSelected.value).toList();
            if (selected.isNotEmpty) {
              filterStateController.setSelectedItems(filterId, selected);
              final isSingleSelect = data['isSingleSelect'] as bool? ?? true;
              if (isSingleSelect) {
                final selectedItem = selected.first;
                switch (filterId) {
                  case 'division':
                    selectedFilters['division'] = selectedItem.id;
                    break;
                  case 'created_by':
                    selectedFilters['created_by'] = selectedItem.id;
                    break;
                  case 'lead_assigned':
                    selectedFilters['lead_assigned'] = selectedItem.id;
                    break;
                  default:
                    selectedFilters[filterId] =
                        selectedItem.id ?? selectedItem.label;
                }
              } else {
                selectedFilters[filterId] =
                    selected.map((item) => item.id ?? item.label).toList();
              }
            }
          });

          try {
            if (createDateController.text.isNotEmpty) {
              selectedFilters['range'] = jsonDecode(createDateController.text);
            }
          } catch (e) {
            print('Error parsing date range filters: $e');
          }

          print('Selected Filters: $selectedFilters');
          Get.find<LeadProformaListViewModel>().applyFilters(selectedFilters);
        },
      ),
    );
  }
}
