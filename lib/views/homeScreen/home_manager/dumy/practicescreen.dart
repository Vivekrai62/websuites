    import 'package:flutter/material.dart';
import 'package:websuites/utils/appColors/app_colors.dart';

class PaginationWidget extends StatefulWidget {
  final int totalItems;
  final int itemsPerPage;
  final Function(int currentPage, int itemsPerPage) onPageChanged;
  final List<int> itemsPerPageOptions;

  const PaginationWidget({
    super.key,
    required this.totalItems,
    required this.itemsPerPage,
    required this.onPageChanged,
    this.itemsPerPageOptions = const [2, 5, 10, 15, 30, 50, 100, 200, 400],
  });



  @override
  _PaginationWidgetState createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
  }

  void _updatePage(int newPage) {
    if (newPage >= 1 &&
        newPage <= (widget.totalItems / widget.itemsPerPage).ceil()) {
      setState(() {
        currentPage = newPage;
      });
      widget.onPageChanged(currentPage, widget.itemsPerPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (widget.totalItems / widget.itemsPerPage).ceil();
    int maxVisiblePages = 3;
    int startPage = (currentPage - (maxVisiblePages ~/ 2)).clamp(1, totalPages);
    int endPage = (startPage + maxVisiblePages - 1).clamp(1, totalPages);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed:
              currentPage > 1 ? () => _updatePage(currentPage - 1) : null,
          icon: const Icon(Icons.chevron_left),
        ),
        if (startPage > 1) ...[
          GestureDetector(
            onTap: () => _updatePage(1),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text('1', style: TextStyle(color: Colors.black)),
            ),
          ),
          if (startPage > 2)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text('...'),
            ),
        ],
        for (int page = startPage; page <= endPage; page++)
          if (page == currentPage)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Card(
                color: AllColors.mediumPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: Text('$page',
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            )
          else
            GestureDetector(
              onTap: () => _updatePage(page),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child:
                    Text('$page', style: const TextStyle(color: Colors.black)),
              ),
            ),
        if (endPage <
            totalPages) // Show "..." and last page if we are not at the end
          ...[
          if (endPage < totalPages - 1)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text('...'),
            ),
          GestureDetector(
            onTap: () => _updatePage(totalPages),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text('$totalPages',
                  style: const TextStyle(color: Colors.black)),
            ),
          ),
        ],
        IconButton(
          onPressed: currentPage < totalPages
              ? () => _updatePage(currentPage + 1)
              : null,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
