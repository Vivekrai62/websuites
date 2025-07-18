import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';

import '../../../../viewModels/leadScreens/lead_list/filter/country_code/country_code.dart';

import '../leadlist_screen.dart';

class FilterConfig {
  final String title;
  final Widget? customHeader;
  final double? width;
  final List<FilterOption>? filterOptionss; // Made optional
  final Function(String, List<String>)? onFilterApplied;
  final Color? primaryColor;
  final Color? backgroundColor;
  final Map<String, Widget Function(BuildContext)>? customBuilders;

  FilterConfig({
    this.title = "Filters",
    this.customHeader,
    this.width,
    this.filterOptionss, // Optional
    this.onFilterApplied,
    this.primaryColor,
    this.backgroundColor,
    this.customBuilders,
  });
}

class FilterOption {
  final String id;
  final String label;
  final String hintText;
  final IconData? icon;
  final bool isMultiSelect;

  FilterOption({
    required this.id,
    required this.label,
    required this.hintText,
    this.icon,
    this.isMultiSelect = false,
  });
}

class FilterOptionItem {
  // final String id;
  final String label;
  RxBool isSelected;
  final String? id;

  FilterOptionItem({required this.label, this.id, bool? isSelected})
      : isSelected = (isSelected ?? false).obs;
}

Widget _buildFilterUI(BuildContext context, FilterConfig config) {
  final RxString selectedFilter = ''.obs;
  final RxMap<String, RxList<FilterOptionItem>> filterItems =
      <String, RxList<FilterOptionItem>>{}.obs;
  final bool isDesktop = MediaQuery.of(context).size.width > 1024;


  final defaultOptions = [
    FilterOption(
        id: 'user',
        label: 'User  ',
        hintText: 'Search User',
        icon: Icons.search,
        isMultiSelect: false),
    FilterOption(
        id: 'division',
        label: 'Division',
        hintText: 'Search Division',
        icon: Icons.search,
        isMultiSelect: true),
  ];

  final options = config.filterOptionss ??
      defaultOptions; // Use provided options or default

  for (var option in options) {
    filterItems[option.id] = List.generate(
      option.id == 'user'
          ? 10
          : option.id == 'division'
              ? 10
              : 20,
      (index) => FilterOptionItem(
     label: 'Option ${index + (option.id == 'division' ? 11 : 1)}'),
    ).obs;
  }

  if (selectedFilter.value.isEmpty && options.isNotEmpty) {
    selectedFilter.value = options[0].id;
  }

  return Container(
    height: isDesktop
        ? double.infinity
        : MediaQuery.of(context).size.height *
            (MediaQuery.of(context).orientation == Orientation.portrait
                ? 0.8
                : 0.9),
    color: config.backgroundColor != null
        ? config.backgroundColor
        : Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900]
            : AllColors.whiteColor,
    child: Column(
      children: [
        config.customHeader ??
            Container(
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 7),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade800
                              : Colors.grey.shade100))),
              child: Row(
                children: [
                  Text(
                      config.title,
                      style: TextStyle(
                          fontFamily: FontFamily.sfPro,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : AllColors.blackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 17)),
                  const Spacer(),
                  IconButton(
                      icon:  Icon(Icons.close,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : AllColors.blackColor,

                      ),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
            ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width > 1024 ? 150 : MediaQuery.of(context).size.width > 600
                              ? 180
                              : MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[900]
                          : AllColors.whiteColor,),
                      child: ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final option = options[index];
                          return Obx(() => InkWell(
                                onTap: () => selectedFilter.value = option.id,
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 11, horizontal: 16),
                                      child: Text(option.label,
                                          style: TextStyle(
                                              color: selectedFilter.value == option.id
                                                  ? AllColors.mediumPurple
                                                  : Theme.of(context).brightness == Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight:
                                                  selectedFilter.value ==
                                                          option.id
                                                      ? FontWeight.w700
                                                      : FontWeight.normal,
                                              fontFamily: FontFamily.sfPro,
                                              fontSize: 15)),
                                    ),
                                    if (selectedFilter.value == option.id)
                                      Positioned(
                                          right: 0,
                                          top: 1,
                                          bottom: 0,
                                          child: Container(
                                              width: 6.9,
                                              decoration: BoxDecoration(
                                                  color: AllColors.mediumPurple,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  30))))),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child:
                            Container(

                                width: 2,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey[800]
                                    :
                                Colors.grey.shade100)),
                  ],
                ),
              ),
              Expanded(child:
                  // In your FilterConfig class file, update the state handling in _buildFilterUI

                  Obx(() {
                final currentFilter = options.firstWhere(
                  (element) => element.id == selectedFilter.value,
                  orElse: () => options.first,
                );

                // Check if the current filter is for states
                if (currentFilter.id == 'state') {
                  // Use the stateList from the StateListViewModel
                  final stateListViewModel = Get.find<StateListViewModel>();
                  final states = stateListViewModel.stateList;

                  if (states.isEmpty) {
                    return const Center(
                        child: Text("Please select a country first"));
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 9, bottom: 0, left: 10, right: 10),
                        child: SizedBox(
                          height: 43,
                          child: TextField(
                            onChanged: (value) =>
                                FilterUtils.searchText.value = value,
                            decoration: InputDecoration(
                              hintText: 'Search State',
                              prefixIcon: Icon(Icons.search,
                                  color: AllColors.figmaGrey, size: 25),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: AllColors.mediumPurple,
                                      width: 0.6)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Obx(() {
                          final searchText =
                              FilterUtils.searchText.value.toLowerCase();
                          var filteredStates = states
                              .where((state) =>
                                  (state.name?.toLowerCase() ?? "")
                                      .contains(searchText))
                              .toList();

                          // Sort the filtered states to show selected items at the top
                          filteredStates.sort((a, b) {
                            // If a is selected and b is not, a comes first
                            if (a.isSelected.value && !b.isSelected.value) {
                              return -1;
                            }
                            // If b is selected and a is not, b comes first
                            if (!a.isSelected.value && b.isSelected.value) {
                              return 1;
                            }
                            // Otherwise maintain alphabetical order
                            return (a.name ?? "").compareTo(b.name ?? "");
                          });

                          return ListView.builder(
                            itemCount: filteredStates.length,
                            itemBuilder: (context, index) {
                              final state = filteredStates[index];

                              // Add a visual indicator for selected items
                              return Container(
                                decoration: BoxDecoration(
                                  color: state.isSelected.value
                                      ? AllColors.mediumPurple.withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      // Show an icon for selected items (optional)

                                      Expanded(
                                        flex: 9,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: state.isSelected.value
                                                  ? 0
                                                  : 0),
                                          child: Text(
                                              state.name ?? "Unknown State",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color:Theme.of(context).brightness == Brightness.dark
                                                    ? Colors.white
                                                    :
                                                Colors.black,
                                                fontWeight:
                                                    state.isSelected.value
                                                        ? FontWeight.normal
                                                        : FontWeight.normal,
                                              )),
                                        ),
                                      ),
                                      const Spacer(),

                                      Obx(() => Transform.scale(
                                            scale: 0.8,
                                            child: Checkbox(
                                              value: state.isSelected.value,
                                              activeColor:
                                                  AllColors.mediumPurple,
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                  color: AllColors.mediumPurple,
                                                  width: 2),
                                              onChanged: (bool? value) {

                                                if (value == true) {

                                                  if (!currentFilter
                                                      .isMultiSelect) {
                                                    for (var s in states) {
                                                      s.isSelected.value =
                                                          false;
                                                    }
                                                  }
                                                }
                                                // Set the new value
                                                state.isSelected.value =
                                                    value ?? false;

                                                // Make sure to reset search after selection for better UX
                                                if (!currentFilter
                                                        .isMultiSelect &&
                                                    value == true) {
                                                  FilterUtils.searchText.value =
                                                      '';
                                                }
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  );
                }

                // Existing logic for other filters
                if (config.customBuilders?.containsKey(currentFilter.id) ==
                    true) {
                  return config.customBuilders![currentFilter.id]!(context);
                }

                // Default case for other filters
                return Container(); // Or your existing logic
              })),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300))),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    for (var items in filterItems.values) {
                      for (var item in items) {
                        item.isSelected.value = false;
                      }
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300)),
                  child: const Text('Clear'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          config.primaryColor ?? AllColors.mediumPurple,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    if (config.onFilterApplied != null) {
                      Map<String, List<String>> allSelectedItems = {};
                      for (var filterId in filterItems.keys) {
                        allSelectedItems[filterId] = filterItems[filterId]!
                            .where((item) => item.isSelected.value)
                            .map((item) => item.label)
                            .toList();
                      }
                      config.onFilterApplied!(selectedFilter.value,
                          allSelectedItems[selectedFilter.value] ?? []);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void showManatFilter(BuildContext context, FilterConfig config) {
  final bool isDesktop = MediaQuery.of(context).size.width > 600;
  if (isDesktop) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          alignment: Alignment.centerRight,
          child: Container(
            decoration:
                BoxDecoration(color: config.backgroundColor ?? Colors.white),
            width: config.width ?? 525,
            height: double.infinity,
            child: _buildFilterUI(context, config),
          ),
        ),
      ),
    );
  } else {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      builder: (context) => _buildFilterUI(context, config),
    );
  }
}

void showResponsiveFilter(
  BuildContext context,
  Widget content, {
  double? desktopWidth,
  Color? backgroundColor,
}) {
  final bool isDesktop = MediaQuery.of(context).size.width > 600;

  if (isDesktop) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (context) => Align(
        alignment: Alignment.centerRight,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: desktopWidth ?? 400,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: content,
            ),
          ),
        ),
      ),
    );
  } else {
    // Show bottom sheet for mobile
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Removed unnecessary handle
              Expanded(child: content),
            ],
          ),
        ),
      ),
    );
  }
}
