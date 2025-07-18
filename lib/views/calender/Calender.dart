import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import '../../../resources/iconStrings/icon_strings.dart';
import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../../utils/datafilter/SeletDateFilter.dart';
import '../../../viewModels/customerScreens/proformas/CustomerProformaListViewModel.dart';
import '../../../viewModels/leadScreens/createNewLead/constant_controller/constant_controller.dart';
import '../../../viewModels/leadScreens/createNewLead/divisions/divisions_view_model.dart';
import '../../../viewModels/leadScreens/lead_list/lead_assign/lead_assign.dart';
import 'package:websuites/views/leadScreens/leadList/widgets/manat.dart';

import '../../resources/strings/strings.dart';
import '../../resources/textStyles/responsive/test_responsive.dart';
import '../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../utils/dark_mode/dark_mode.dart';
import '../../utils/responsive/responsive_utils.dart';
import '../homeScreen/home_manager/HomeManagerScreen.dart';
import '../leadScreens/leadList/leadlist_screen.dart';

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

class CalenderScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CalenderScreen({super.key, required this.scaffoldKey});

  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen>
    with SingleTickerProviderStateMixin {
  DateTime _currentDate = DateTime(2025, 5, 1); // May 2025
  bool _showFilters = false;
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  final Map<String, bool> _selectedFilters = {
    'View All': true,
    'Followup': true,
    'Reminder': true,
    'Payment Reminder': true,
    'Service Expiring': true,
    'Project Report': true,
    'Task': true,
    'Project Deadline': true,
  };

  final Map<String, Color> _filterColors = {
    'View All': Colors.grey.shade500,
    'Followup': Colors.purple.shade500,
    'Reminder': Colors.green.shade500,
    'Payment Reminder': Colors.blue.shade500,
    'Service Expiring': Colors.red.shade500,
    'Project Report': Colors.yellow.shade500,
    'Task': Colors.teal.shade500,
    'Project Deadline': Colors.purple.shade600,
  };

  final CustomerProformaListViewModel _viewModel =
      Get.put(CustomerProformaListViewModel());
  final TextEditingController searchController = TextEditingController();
  bool isFloatingButtonClicked = false;

  final ListLeadAssignViewModel searchAssigned =
      Get.put(ListLeadAssignViewModel());
  final ConstantValueViewModel staticText = Get.put(ConstantValueViewModel());
  final DivisionsViewModel divisionList = Get.put(DivisionsViewModel());

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchAssigned.leadListLeadAssign(context);
      staticText.fetchConstantList(context);
      divisionList.fetchDivisions();
      _viewModel.fetchCustomerProformas();
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    searchController.dispose();
    super.dispose();
  }

  int getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  int getFirstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday % 7;
  }

  String formatMonth(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  void navigateMonth(String direction) {
    setState(() {
      if (direction == 'prev') {
        _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
      } else {
        _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
      }
    });
  }

  List<Widget> renderCalendar() {
    final daysInMonth = getDaysInMonth(_currentDate);
    final firstDay = getFirstDayOfMonth(_currentDate);
    final days = <Widget>[];
    const dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    // Add day names
    for (int i = 0; i < 7; i++) {
      days.add(
        Center(
          child: Text(
            dayNames[i],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
               color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : AllColors.grey,
              fontFamily: FontFamily.sfPro,
            ),
          ),
        ),
      );
    }


    for (int i = 0; i < firstDay; i++) {
      days.add(const SizedBox());
    }

    // Add days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      final isToday = day == 12; // Example: Highlight day 12
      final hasEvent =
          day % 5 == 0; // Example: Add event indicator for every 5th day
      days.add(
        GestureDetector(
          onTap: () {
            // Handle day tap
          },
          child: AnimatedContainer(

            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isToday ? AllColors.lightBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  '$day',
                  style: TextStyle(
                    fontSize: 14,
                    color: isToday
                        ? AllColors.darkBlue
                        : Theme.of(context).brightness == Brightness.dark
                            ? AllColors.whiteColor
                            : AllColors.blackColor,
                    fontWeight: isToday ? FontWeight.w600 : FontWeight.w400,
                    fontFamily: FontFamily.sfPro,
                  ),
                ),
                if (hasEvent)
                  Positioned(
                    bottom: 4,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AllColors.mediumPurple,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return days;
  }

  void toggleFilter(String filter) {
    setState(() {
      _selectedFilters[filter] = !_selectedFilters[filter]!;
    });
  }

  @override
  Widget build(BuildContext context) {

    final homeController = Get.find<HomeManagerController>();

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
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : AllColors.whiteColor,
      body: Column(
        children: [
          // CustomAppBar(
          //
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 40, right: 15, left: 5),
          //     child: Row(
          //       children: [
          //         if (!isTablet)
          //           IconButton(
          //             icon: Icon(
          //               Icons.menu,
          //               color: Theme.of(context).brightness == Brightness.dark
          //                   ? Colors.white
          //                   : AllColors.blackColor,
          //               size: 25,
          //             ),
          //             onPressed: () {
          //               widget.scaffoldKey.currentState?.openDrawer();
          //             },
          //           ),
          //         if (isTablet) const SizedBox(width: 10),
          //         Text(
          //           'Calender',
          //           style: TextStyle(
          //             color: Theme.of(context).brightness == Brightness.dark
          //                 ? Colors.white
          //                 : AllColors.blackColor,
          //             fontWeight: FontWeight.w700,
          //             fontFamily: FontFamily.sfPro,
          //             fontSize: 18.5,
          //           ),
          //         ),
          //         const Spacer(),
          //         InkWell(
          //           onTap: () => openProformasFilterBottomSheet(context),
          //           child: Icon(
          //             Icons.filter_list,
          //             color: Theme.of(context).brightness == Brightness.dark
          //                 ? Colors.white
          //                 : AllColors.blackColor,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          CustomAppBar(
            child: Row(
              children: [
                if (ResponsiveUtilsScreenSize.isMobile(context))
                GestureDetector(
                  onTap: () => homeController.resetOrderDetails(),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.back,
                        color: DarkMode.backgroundColor2(context),),
                      const SizedBox(width: 9),
                      ResponsiveText.getAppBarTextSize(context, Strings.back),
                    ],
                  ),
                ),
                // if (ResponsiveUtilsScreenSize.isMobile(context))
                //   SizedBox(width: 10,),
                const SizedBox(width: 8),
                ResponsiveText.getAppBarTextSize(context, Strings.calender),


              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: ContainerUtils(
                      paddingTop: 5,
                      paddingBottom: 5,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => navigateMonth('prev'),
                                icon: Icon(Icons.chevron_left,
                                    color: AllColors.grey, size: 24),
                                splashRadius: 20,
                              ),
                              Text(
                                formatMonth(_currentDate),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : AllColors.blackColor,
                                  fontFamily: FontFamily.sfPro,
                                ),
                              ),
                              IconButton(
                                onPressed: () => navigateMonth('next'),
                                icon: Icon(Icons.chevron_right,
                                    color: AllColors.grey, size: 24),
                                splashRadius: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showFilters = !_showFilters;
                                      if (_showFilters) {
                                        _animationController?.forward();
                                      } else {
                                        _animationController?.reverse();
                                      }
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : AllColors.mediumPurple
                                                .withOpacity(0.1),
                                    foregroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.black
                                            : AllColors.mediumPurple,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    side: BorderSide(
                                        color: AllColors.mediumPurple
                                            .withOpacity(0.3)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.filter_list,
                                          size: 18,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.black
                                              : AllColors.mediumPurple),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Filters',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.black
                                              : AllColors.mediumPurple,
                                          fontFamily: FontFamily.sfPro,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                        ],
                      ),
                    ),
                  ),
                  // Filters Panel
                  if (_showFilters)
                    AnimatedBuilder(
                      animation: _fadeAnimation!,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation!.value,
                          child: ContainerUtils(
                            height: MediaQuery.of(context).size.height *
                                0.6, // Limit filter panel height,

                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),

                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Event Types',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color:Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white
                                          : AllColors.blackColor,
                                      fontFamily: FontFamily.sfPro,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ..._selectedFilters.entries.map((entry) {
                                    final filter = entry.key;
                                    final isChecked = entry.value;
                                    return Padding(
                                       padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: CheckboxListTile(
                                        title: Text(
                                          filter,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: _filterColors[filter],
                                            fontWeight: FontWeight.w500,
                                            fontFamily: FontFamily.sfPro,
                                          ),
                                        ),
                                        value: isChecked,
                                        onChanged: (value) =>
                                            toggleFilter(filter),
                                        contentPadding: EdgeInsets.zero,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        activeColor: AllColors.mediumPurple,
                                        checkColor: AllColors.whiteColor,
                                        dense: true,
                                        checkboxShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  // Calendar Grid
                  Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height *
                          0.5, // Ensure calendar has enough space
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 7,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1,
                      children: renderCalendar(),
                    ),
                  ),
                ],
              ),
            ),
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: Text(
                                  item.label,
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    color: AllColors.blackColor,
                                    fontFamily: FontFamily.sfPro,
                                  ),
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
                                      checkColor: AllColors.whiteColor,
                                      side: BorderSide(
                                          color: AllColors.mediumPurple),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
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
              isMultiSelect: false),
          FilterOption(
              id: 'lead_assigned',
              label: 'Lead Assigned',
              hintText: 'Select Assignee',
              icon: Icons.people,
              isMultiSelect: false),
          FilterOption(
              id: 'created_by',
              label: 'Created By',
              hintText: 'Search',
              icon: Icons.person,
              isMultiSelect: true),
          FilterOption(
              id: 'division',
              label: 'Division',
              hintText: 'Division',
              icon: Icons.business,
              isMultiSelect: true),
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
          Get.find<CustomerProformaListViewModel>()
              .applyFilters(selectedFilters);
        },
      ),
    );
  }
}
