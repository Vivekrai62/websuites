import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';

class FilterConfig {
  final String title;
  final Widget? customHeader;
  final double? width;
  final List<FilterOption> filterOptions;
  final Function(String, dynamic)? onFilterApplied;
  final Color? primaryColor;
  final Color? backgroundColor;
  final Map<String, Widget Function(BuildContext)>? customBuilders;

  FilterConfig({
    this.title = "Filters",
    this.customHeader,
    this.width,
    required this.filterOptions,
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

  FilterOption({
    required this.id,
    required this.label,
    required this.hintText,
    this.icon,
  });
}

void showResponsiveFilter(BuildContext context, FilterConfig config) {
  final bool isDesktop = MediaQuery.of(context).size.width > 1024;

  if (isDesktop) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          alignment: Alignment.centerRight,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: config.width ?? 400,
            height: double.infinity,
            color: config.backgroundColor ?? Colors.white,
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      builder: (context) => _buildFilterUI(context, config),
    );
  }
}

Widget _buildFilterUI(BuildContext context, FilterConfig config) {
  final RxString selectedFilter = ''.obs;
  final RxMap<String, dynamic> filterValues = <String, dynamic>{}.obs;
  final bool isDesktop = MediaQuery.of(context).size.width > 1024;

  if (selectedFilter.value.isEmpty && config.filterOptions.isNotEmpty) {
    selectedFilter.value = config.filterOptions[0].id;
  }

  final double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    height: isDesktop
        ? double.infinity
        : screenHeight * (isPortrait(context) ? 0.8 : 0.9),
    color: config.backgroundColor ?? Colors.white,
    child: Column(
      children: [
        config.customHeader ??
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Row(
                children: [
                  Text(
                    config.title,
                    style: const TextStyle(
                      fontFamily: FontFamily.sfPro,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
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
                    // Grey container
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: AllColors.whiteColor,
                      child: ListView.builder(
                        itemCount: config.filterOptions.length,
                        itemBuilder: (context, index) {
                          final option = config.filterOptions[index];
                          return Obx(() => InkWell(
                                onTap: () => selectedFilter.value = option.id,
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 11, horizontal: 16),
                                      child: Text(
                                        option.label,
                                        style: TextStyle(
                                          color:
                                              selectedFilter.value == option.id
                                                  ? AllColors.mediumPurple
                                                  : Colors.black,
                                          fontWeight:
                                              selectedFilter.value == option.id
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                          fontFamily:
                                              selectedFilter.value == option.id
                                                  ? FontFamily.sfPro
                                                  : FontFamily.sfPro,
                                          fontSize: 15.5,
                                        ),
                                      ),
                                    ),
                                    if (selectedFilter.value == option.id)
                                      Positioned(
                                        right: 0,
                                        top: 1,
                                        bottom: 0,
                                        child: Container(
                                          width: 6.9, // Width of the green line

                                          decoration: BoxDecoration(
                                              color: AllColors.mediumPurple,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                bottomLeft: Radius.circular(30),
                                              )),
                                        ),
                                      ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                    // Yellow line on the right side
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 2, // Width of the line
                        color: Colors.grey.shade100,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 3),
                  child: Obx(() {
                    final currentFilter = config.filterOptions.firstWhere(
                      (element) => element.id == selectedFilter.value,
                      orElse: () => config.filterOptions.first,
                    );

                    if (config.customBuilders?.containsKey(currentFilter.id) ==
                        true) {
                      return config.customBuilders![currentFilter.id]!(context);
                    }

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentFilter.label,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: currentFilter.hintText,
                                    prefixIcon: Icon(
                                        currentFilter.icon ?? Icons.search),
                                    border: const OutlineInputBorder(),
                                  ),
                                  onChanged: (value) =>
                                      filterValues[currentFilter.id] = value,
                                ),
                                const SizedBox(height: 16),
                                // Additional dummy content to test scrolling behavior
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 20,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text("Option ${index + 1}"),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  child: const Text('Clear'),
                  onPressed: () {
                    filterValues.clear();
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        config.primaryColor ?? AllColors.mediumPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Apply'),
                  onPressed: () {
                    if (config.onFilterApplied != null) {
                      config.onFilterApplied!(
                        selectedFilter.value,
                        filterValues[selectedFilter.value],
                      );
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

bool isPortrait(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}
