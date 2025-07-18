// Search Controller using GetX
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/appColors/app_colors.dart';

import '../../fontfamily/FontFamily.dart';

class SearchController extends GetxController {
  final textController = TextEditingController();
  final focusNode = FocusNode();
  final RxBool isTextFieldFocused = false.obs;
  final RxList<String> textEntries = <String>[].obs;
  final RxString searchText = ''.obs;
  final RxBool showCreateButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    textController.addListener(_onTextChanged);
    focusNode.addListener(_onFocusChanged);

  }

  @override
  void onClose() {
    textController.removeListener(_onTextChanged);
    focusNode.removeListener(_onFocusChanged);
    textController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void _onFocusChanged() {
    isTextFieldFocused.value = focusNode.hasFocus;
  }

  void _onTextChanged() {
    searchText.value = textController.text.trim();
    showCreateButton.value = searchText.value.isNotEmpty && !textEntries.contains(searchText.value);
  }

  void addTextEntry() {
    if (searchText.value.isNotEmpty && !textEntries.contains(searchText.value)) {
      textEntries.add(searchText.value);
      textController.clear();
      searchText.value = '';
      showCreateButton.value = false;
    }
  }

  void removeEntry(String entry) {
    textEntries.remove(entry);
  }

  void clearSearch() {
    textController.clear();
    searchText.value = '';
    showCreateButton.value = false;
  }

  void clearAllEntries() {
    textEntries.clear();
  }
}

// SearchComponents class with all the reusable UI components
class SearchComponents {

  static Widget buildSearchBox({
    required TextEditingController textController,
    required FocusNode focusNode,
    required List<String> textEntries,
    required String searchText,
    required bool showCreateButton,
    required bool isTextFieldFocused,
    required VoidCallback onAddEntry,
    required Function(String) onRemoveEntry,
    required VoidCallback onClearSearch,
    required VoidCallback onClearAll,
    String? hintText, // Add optional hintText parameter
  }) {
    return Material(
      elevation: 0,
      shadowColor: AllColors.mediumPurple,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isTextFieldFocused ? AllColors.mediumPurple :AllColors.commonTextFiledColor,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              if (textEntries.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: textEntries.map((entry) => buildChip(
                    label: entry,
                    onDeleted: () => onRemoveEntry(entry),
                  )).toList(),
                ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        focusNode.requestFocus();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: TextField(
                          controller: textController,
                          focusNode: focusNode,
                          minLines: 1,
                          maxLines: null,
                          style: TextStyle(
                            color: AllColors.commonTextFiledColor,
                            fontFamily: FontFamily.sfPro,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: hintText, // Use optional hintText
                            hintStyle: TextStyle(
                              color: AllColors.commonTextFiledColor,
                              fontFamily: FontFamily.sfPro,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Action buttons
                  if (showCreateButton)
                    Row(
                      children: [
                        IconButton(
                          onPressed: onClearSearch,
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey[500],
                            size: 20,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 40,
                            minHeight: 40,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        Icon(
                          Icons.language,
                          color: Colors.grey[500],
                          size: 20,
                        ),
                      ],
                    ),
                ],
              ),

              // Clear all button if there are entries
              if (textEntries.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: AllColors.mediumPurple,
                      size: 20,
                    ),
                    onPressed: onClearAll,
                    tooltip: 'Clear all items',
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Chip component
  static Widget buildChip({
    required String label,
    required VoidCallback onDeleted,
  }) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: AllColors.mediumPurple,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: AllColors.lighterPurple,
      elevation: 0,

      deleteIcon: Icon(
        Icons.close,
        size: 16,
        color: AllColors.mediumPurple,
      ),
      onDeleted: onDeleted,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: AllColors.mediumPurple,
          width: 1,
        ),
      ),
    );
  }

  // CreateButton component
  static Widget buildCreateButton({
    required bool showCreateButton,
    required String searchText,
    required VoidCallback onCreate,
  }) {
    return AnimatedOpacity(
      opacity: showCreateButton ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: showCreateButton
          ? GestureDetector(
        onTap: onCreate,
        child: Material(
          elevation: 1,
          shadowColor:AllColors.mediumPurple,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AllColors.mediumPurple,
              borderRadius: BorderRadius.circular(9),

            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: Text(
                  'Create "$searchText"',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      )
          : const SizedBox.shrink(),
    );
  }
}

// Main user-facing widget using GetX for state management
class SearchPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SearchPage({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize GetX controller
    final searchController = Get.put(SearchController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Obx(() =>
                  SearchComponents.buildSearchBox(
                    isTextFieldFocused: searchController.isTextFieldFocused.value, // Add this line

                    textController: searchController.textController,
                    focusNode: searchController.focusNode,
                    textEntries: searchController.textEntries,
                    searchText: searchController.searchText.value,
                    showCreateButton: searchController.showCreateButton.value,
                    onAddEntry: searchController.addTextEntry,
                    onRemoveEntry: searchController.removeEntry,
                    onClearSearch: searchController.clearSearch,
                    onClearAll: searchController.clearAllEntries,
                  )),
              const SizedBox(height: 20),
              Obx(() =>
                  SearchComponents.buildCreateButton(
                    showCreateButton: searchController.showCreateButton.value,
                    searchText: searchController.searchText.value,
                    onCreate: searchController.addTextEntry,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}