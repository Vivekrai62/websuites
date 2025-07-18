import 'package:get/get.dart';

class CreateNewLeadScreenController extends GetxController {
  final RxList<String> selectedCategories = <String>[].obs;
  final RxBool isDropdownVisible = false.obs;
  final RxBool isFocused = false.obs;

  void toggleDropdownMenu() {
    isDropdownVisible.value = !isDropdownVisible.value;
  }

  void selectCategory(String category, bool isMultiSelect, Function(List<String>)? onCategoriesChanged, Function(String)? onCategoryChanged) {
    if (isMultiSelect) {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
      if (onCategoriesChanged != null) {
        onCategoriesChanged(selectedCategories);
      }
    } else {
      selectedCategories.assignAll([category]);
      if (onCategoryChanged != null) {
        onCategoryChanged(category);
      }
    }
  }

  void removeCategory(String category, bool isMultiSelect, Function(List<String>)? onCategoriesChanged) {
    selectedCategories.remove(category);
    if (isMultiSelect && onCategoriesChanged != null) {
      onCategoriesChanged(selectedCategories);
    }
  }

  void clearCategories() {
    selectedCategories.clear();
  }
}
