import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websuites/viewModels/customerScreens/customer_list/customer_list_viewModel.dart';

// Enhanced Pagination Controller (unchanged)
class EnhancedPaginationController extends GetxController {
  RxInt currentPage = 1.obs;
  RxInt itemsPerPage = 15.obs;
  RxInt totalItems = 0.obs;
  final List<int> itemsPerPageOptions;

  EnhancedPaginationController({
    int currentPage = 1,
    int itemsPerPage = 15,
    required int totalItems,
    this.itemsPerPageOptions = const [2, 5, 10, 15, 20, 25, 50, 100],
  }) {
    this.currentPage.value = currentPage;
    this.itemsPerPage.value = itemsPerPage;
    this.totalItems.value = totalItems;
  }

  int get totalPages => totalItems.value == 0 ? 1 : (totalItems.value / itemsPerPage.value).ceil();
  int get startIndex => (currentPage.value - 1) * itemsPerPage.value;
  int get endIndex {
    int calculatedEnd = startIndex + itemsPerPage.value;
    return calculatedEnd > totalItems.value ? totalItems.value : calculatedEnd;
  }

  // Get actual items to display on current page
  int get itemsOnCurrentPage {
    if (totalItems.value == 0) return 0;
    int remaining = totalItems.value - startIndex;
    return remaining > itemsPerPage.value ? itemsPerPage.value : remaining;
  }

  String get rangeText {
    if (totalItems.value == 0) return '0-0 of 0';
    int actualStart = startIndex + 1;
    int actualEnd = startIndex + itemsOnCurrentPage;
    return '$actualStart-$actualEnd of ${totalItems.value}';
  }

  bool canGoToPage(int page) => page >= 1 && page <= totalPages;

  void setPage(int page) {
    if (canGoToPage(page)) {
      currentPage.value = page;
      update();
    }
  }

  void setItemsPerPage(int items) {
    // print('Setting itemsPerPage to: $items');
    itemsPerPage.value = items;
    currentPage.value = 1; // Reset to first page

    // Ensure we're not on an invalid page after changing items per page
    if (currentPage.value > totalPages) {
      currentPage.value = totalPages > 0 ? totalPages : 1;
    }

    update();
  }

  void updateTotalItems(int newTotalItems) {
    totalItems.value = newTotalItems;
    // Ensure current page is still valid
    if (currentPage.value > totalPages) {
      currentPage.value = totalPages > 0 ? totalPages : 1;
    }
    update();
  }

  List<int> getVisiblePages() {
    int pages = totalPages;
    if (pages <= 7) {
      return List.generate(pages, (i) => i + 1);
    }

    List<int> visiblePages = [];

    if (currentPage.value <= 4) {
      visiblePages = [1, 2, 3, 4, 5];
      if (pages > 6) {
        visiblePages.addAll([-1, pages]);
      }
    } else if (currentPage.value >= pages - 3) {
      visiblePages = [1, -1];
      for (int i = pages - 4; i <= pages; i++) {
        visiblePages.add(i);
      }
    } else {
      visiblePages = [
        1,
        -1,
        currentPage.value - 1,
        currentPage.value,
        currentPage.value + 1,
        -1,
        pages
      ];
    }

    return visiblePages;
  }

  // Helper method to get the correct data slice
  List<T> getPaginatedData<T>(List<T> fullData) {
    if (fullData.isEmpty) return [];

    int start = startIndex;
    int end = startIndex + itemsPerPage.value;

    // Ensure we don't go beyond the available data
    if (start >= fullData.length) return [];
    if (end > fullData.length) end = fullData.length;

    return fullData.sublist(start, end);
  }
}

// Modern Pagination Widget
class ModernPagination extends StatelessWidget {
  final EnhancedPaginationController controller;
  final Function(EnhancedPaginationController) onUpdate;
  final Color primaryColor;
  final Color backgroundColor;
  final Color disabledColor;
  final double borderRadius;

  const ModernPagination({
    super.key,
    required this.controller,
    required this.onUpdate,
    this.primaryColor = const Color(0xFF1E88E5),
    this.backgroundColor = Colors.white,
    this.disabledColor = const Color(0xFFF3F4F6),
    this.borderRadius = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Range text

            // Pagination controls
            Row(

              children: [



                _buildPaginationControls(context),
                const SizedBox(width: 16),
                Text(
                  controller.rangeText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(width: 16),
                _buildItemsPerPageSelector(),

              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildItemsPerPageSelector() {
    return Row(
      children: [

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD1D5DB)),
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor,
          ),
          child: Obx(() {
            int currentValue = controller.itemsPerPage.value;
            if (!controller.itemsPerPageOptions.contains(currentValue)) {
              currentValue = controller.itemsPerPageOptions.first;
            }

            return DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                dropdownColor: Colors.white,
                value: currentValue,
                isDense: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: Color(0xFF6B7280),
                ),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF111827),
                  fontWeight: FontWeight.w500,
                ),
                items: controller.itemsPerPageOptions
                    .map((value) => DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value'),
                ))
                    .toList(),
                onChanged: (newValue) {
                  if (newValue != null && newValue != controller.itemsPerPage.value) {
                    // print('Dropdown selected: $newValue items per page');
                    controller.setItemsPerPage(newValue);
                    onUpdate(controller);
                  }
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildPaginationControls(BuildContext context) {
    final visiblePages = controller.getVisiblePages();

    return Row(
      children: [
        _buildNavigationButton(
          icon: Icons.chevron_left,
          onPressed: controller.currentPage.value > 1
              ? () {
            controller.setPage(controller.currentPage.value - 1);
            onUpdate(controller);
          }
              : null,
        ),
        const SizedBox(width: 8),
        ...visiblePages.map((page) {
          if (page == -1) {
            return _buildEllipsis();
          }
          return _buildPageButton(page, context);
        }).toList(),
        const SizedBox(width: 8),
        _buildNavigationButton(
          icon: Icons.chevron_right,
          onPressed: controller.currentPage.value < controller.totalPages
              ? () {
            controller.setPage(controller.currentPage.value + 1);
            onUpdate(controller);
          }
              : null,
        ),
      ],
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: onPressed != null
                    ? const Color(0xFFD1D5DB)
                    : const Color(0xFFE5E7EB),
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              color: onPressed != null ? backgroundColor : disabledColor,
            ),
            child: Icon(
              icon,
              size: 20,
              color: onPressed != null
                  ? const Color(0xFF374151)
                  : const Color(0xFF9CA3AF),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageButton(int page, BuildContext context) {
    final isSelected = controller.currentPage.value == page;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: isSelected ? primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: () {
            controller.setPage(page);
            onUpdate(controller);
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? primaryColor : const Color(0xFFD1D5DB),
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              color: isSelected ? primaryColor : backgroundColor,
            ),
            child: Center(
              child: Text(
                page.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : const Color(0xFF374151),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 32,
      height: 32,
      child: const Center(
        child: Text(
          '…',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}


class CustomerListPaginationExample extends StatefulWidget {
  final CustomerListViewModel viewModel;

  const CustomerListPaginationExample({
    super.key,
    required this.viewModel,
  });

  @override
  State<CustomerListPaginationExample> createState() => _CustomerListPaginationExampleState();
}

class _CustomerListPaginationExampleState extends State<CustomerListPaginationExample> {
  late EnhancedPaginationController paginationController;

  @override
  void initState() {
    super.initState();
    // Initialize pagination controller with viewModel's pagination state
    paginationController = EnhancedPaginationController(
      currentPage: widget.viewModel.currentPage.value,
      itemsPerPage: widget.viewModel.itemsPerPage.value,
      totalItems: widget.viewModel.totalItems.value,
      itemsPerPageOptions: widget.viewModel.itemsPerPageOptions,
    );

    // Sync pagination controller with viewModel changes
    ever(widget.viewModel.currentPage, (_) {
      if (paginationController.currentPage.value != widget.viewModel.currentPage.value) {
        paginationController.currentPage.value = widget.viewModel.currentPage.value;
      }
    });
    ever(widget.viewModel.itemsPerPage, (_) {
      if (paginationController.itemsPerPage.value != widget.viewModel.itemsPerPage.value) {
        paginationController.itemsPerPage.value = widget.viewModel.itemsPerPage.value;
      }
    });
    ever(widget.viewModel.totalItems, (_) {
      if (paginationController.totalItems.value != widget.viewModel.totalItems.value) {
        paginationController.totalItems.value = widget.viewModel.totalItems.value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModernPagination(
      controller: paginationController,
      onUpdate: (controller) {
        // Update viewModel when pagination changes
        if (controller.currentPage.value != widget.viewModel.currentPage.value) {
          widget.viewModel.setPage(controller.currentPage.value);
        }
        if (controller.itemsPerPage.value != widget.viewModel.itemsPerPage.value) {
          widget.viewModel.setItemsPerPage(controller.itemsPerPage.value);
        }
      },
    );
  }

  @override
  void dispose() {
    paginationController.dispose();
    super.dispose();
  }
}



// For integration with your existing ViewModel
class CustomerViewModel extends GetxController {
  RxInt currentPage = 1.obs;
  RxInt itemsPerPage = 15.obs;
  RxInt totalItems = 0.obs;
  RxList<dynamic> customers = <dynamic>[].obs;
  RxList<dynamic> allCustomers = <dynamic>[].obs; // Store all customers

  final List<int> itemsPerPageOptions = [2, 5, 10, 15, 20, 25, 50, 100];

  void setPage(int page) {
    if (page >= 1 && page <= totalPages) {
      currentPage.value = page;
      _updatePaginatedData();
    }
  }

  void setItemsPerPage(int items) {
    itemsPerPage.value = items;
    currentPage.value = 1; // Reset to first page
    _updatePaginatedData();
  }

  int get totalPages => totalItems.value == 0 ? 1 : (totalItems.value / itemsPerPage.value).ceil();
  int get startIndex => (currentPage.value - 1) * itemsPerPage.value;

  void _updatePaginatedData() {
    if (allCustomers.isEmpty) return;

    int start = startIndex;
    int end = start + itemsPerPage.value;

    if (start >= allCustomers.length) {
      customers.clear();
      return;
    }

    if (end > allCustomers.length) end = allCustomers.length;

    customers.value = allCustomers.sublist(start, end);
  }

  void setCustomers(List<dynamic> newCustomers) {
    allCustomers.value = newCustomers;
    totalItems.value = newCustomers.length;
    currentPage.value = 1;
    _updatePaginatedData();
  }
}

// Widget to use with your ViewModel
class CustomerListWithViewModel extends StatelessWidget {
  final CustomerViewModel viewModel = Get.put(CustomerViewModel());

  CustomerListWithViewModel({super.key}) {
    // Initialize with sample data
    viewModel.setCustomers(List.generate(
      47,
          (index) => {
        'id': '${index + 1}',
        'name': 'Customer ${index + 1}',
        'email': 'customer${index + 1}@example.com',
        'phone': '+1234567890${index.toString().padLeft(2, '0')}',
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List (ViewModel)'),
        backgroundColor: const Color(0xFF1E88E5),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (viewModel.customers.isEmpty) {
                return const Center(child: Text('No customers found'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: viewModel.customers.length,
                itemBuilder: (context, index) {
                  final customer = viewModel.customers[index];
                  final globalIndex = viewModel.startIndex + index + 1;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF1E88E5),
                        child: Text(
                          globalIndex.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        customer['name']!,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(customer['email']!),
                          Text(customer['phone']!),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  );
                },
              );
            }),
          ),
          CustomerListPaginationWidget(viewModel: viewModel),
        ],
      ),
    );
  }
}

// Separate pagination widget for ViewModel integration
class CustomerListPaginationWidget extends StatefulWidget {
  final CustomerViewModel viewModel;

  const CustomerListPaginationWidget({
    super.key,
    required this.viewModel,
  });

  @override
  State<CustomerListPaginationWidget> createState() => _CustomerListPaginationWidgetState();
}

class _CustomerListPaginationWidgetState extends State<CustomerListPaginationWidget> {
  late EnhancedPaginationController paginationController;

  @override
  void initState() {
    super.initState();
    paginationController = EnhancedPaginationController(
      currentPage: widget.viewModel.currentPage.value,
      itemsPerPage: widget.viewModel.itemsPerPage.value,
      totalItems: widget.viewModel.totalItems.value,
      itemsPerPageOptions: widget.viewModel.itemsPerPageOptions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Sync with ViewModel
      if (paginationController.currentPage.value != widget.viewModel.currentPage.value) {
        paginationController.currentPage.value = widget.viewModel.currentPage.value;
      }
      if (paginationController.itemsPerPage.value != widget.viewModel.itemsPerPage.value) {
        paginationController.itemsPerPage.value = widget.viewModel.itemsPerPage.value;
      }
      if (paginationController.totalItems.value != widget.viewModel.totalItems.value) {
        paginationController.totalItems.value = widget.viewModel.totalItems.value;
      }

      return ModernPagination(
        controller: paginationController,
        onUpdate: (controller) {
          widget.viewModel.setPage(controller.currentPage.value);
          if (controller.itemsPerPage.value != widget.viewModel.itemsPerPage.value) {
            widget.viewModel.setItemsPerPage(controller.itemsPerPage.value);
          }
        },
      );
    });
  }

  @override
  void dispose() {
    paginationController.dispose();
    super.dispose();
  }
}