import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridCountManager {
  static int getItemCountPerRow(BuildContext context, {double minTileWidth = 400}) {
    double availableWidth = MediaQuery.of(context).size.width;


    double usableWidth = availableWidth - 32; // 16 padding on each side

    int count = minTileWidth > usableWidth ? 1 : usableWidth ~/ minTileWidth;
    return count;
  }


  static int getItemCountPerRowWithSpacing(BuildContext context, {
    double minTileWidth = 400,
    double spacing = 16,
    double horizontalPadding = 32,
  }) {
    double availableWidth = MediaQuery.of(context).size.width;
    double usableWidth = availableWidth - horizontalPadding;

    if (minTileWidth > usableWidth) return 1;


    int maxPossibleItems = (usableWidth + spacing) ~/ (minTileWidth + spacing);
    return maxPossibleItems.clamp(1, double.infinity).toInt();
  }
}

class ResponsiveUtilsScreenSize {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 550;
  }

  static bool isTablet(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 550 && screenWidth < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  /// Returns the appropriate crossAxisCount based on screen width (legacy method)
  static int getCrossAxisCount(BuildContext context, double screenWidth) {
    if (screenWidth < 550) {
      return 1;
    } else if (screenWidth < 1200) {
      return 2;
    } else {
      return 3; // Desktop
    }
  }

  static double getFieldWidth(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 600
        ? screenWidth * 0.9
        : (screenWidth - 5 * ((screenWidth / 550).floor() - 1)) /
        (screenWidth / 250).floor(); // Adjust for padding and spacing
  }

  /// Calculates the wrap spacing based on screen width
  static double getWrapSpacing(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 550 ? 8 : 8;
  }

}

class ResponsiveMasonryGridView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final int? fixedCrossAxisCount;
  final double? minTileWidth;

  const ResponsiveMasonryGridView({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.fixedCrossAxisCount,
    this.minTileWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Handle empty state
        if (items.isEmpty) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: const Center(
                child: Text("No items available"),
              ),
            ),
          );
        }

        final double screenWidth = constraints.maxWidth;
        int crossAxisCount;


        if (minTileWidth != null) {
          crossAxisCount = GridCountManager.getItemCountPerRowWithSpacing(
            context,
            minTileWidth: minTileWidth!,
            spacing: crossAxisSpacing,
            horizontalPadding: padding?.horizontal ?? 32,
          );
        } else if (fixedCrossAxisCount != null) {
          crossAxisCount = fixedCrossAxisCount!;
        } else {

          crossAxisCount = ResponsiveUtilsScreenSize.getCrossAxisCount(context, screenWidth);
        }


        final double itemWidth = (screenWidth -
            (crossAxisCount - 1) * crossAxisSpacing -
            (padding?.horizontal ?? 0)) / crossAxisCount;

        return MasonryGridView.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          physics: physics ?? const NeverScrollableScrollPhysics(),
          shrinkWrap: shrinkWrap,
          padding: padding ?? EdgeInsets.zero,
          itemCount: items.length,
          itemBuilder: (context, index) {
            // Constrain each item to calculated width to prevent overflow
            return SizedBox(
              width: itemWidth,
              child: itemBuilder(context, items[index], index),
            );
          },
        );
      },
    );
  }
}


class EnhancedResponsiveMasonryGridView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final int? fixedCrossAxisCount;
  final Widget? searchWidget;
  final double? minTileWidth; // New parameter for GridCountManager

  const EnhancedResponsiveMasonryGridView({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.fixedCrossAxisCount,
    this.searchWidget,
    this.minTileWidth = 400, // Default minimum tile width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (items.isEmpty) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: const Center(
                child: Text("No items available"),
              ),
            ),
          );
        }

        final double screenWidth = constraints.maxWidth;
        int crossAxisCount;


        if (minTileWidth != null) {
          crossAxisCount = GridCountManager.getItemCountPerRowWithSpacing(
            context,
            minTileWidth: minTileWidth!,
            spacing: crossAxisSpacing,
            horizontalPadding: 32, // Default padding
          );
        } else if (fixedCrossAxisCount != null) {
          crossAxisCount = fixedCrossAxisCount!;
        } else {

          if (screenWidth < 600) {
            crossAxisCount = 1;
          } else if (screenWidth < 1200) {
            crossAxisCount = 2;
          } else {
            crossAxisCount = 3;
          }
        }


        final double itemWidth = (screenWidth -
            (crossAxisCount - 1) * crossAxisSpacing -
            32) / crossAxisCount;

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Optional search widget
              if (searchWidget != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: searchWidget!,
                ),

              // MasonryGridView
              MasonryGridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: padding ?? const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16
                ),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: itemWidth,
                    child: itemBuilder(context, items[index], index),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

