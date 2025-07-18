import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';

// Utility class for responsive breakpoints
class ResponsiveBreakpoints {
  static const double mobile = 500;
  static const double tablet = 900;
  static const double desktop = 1000;

  static int getCrossAxisCount(
    BuildContext context, {
    int mobile = 1,
    int tablet = 3,
    int desktop = 4,
    int largeDesktop = 5,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > ResponsiveBreakpoints.desktop) return largeDesktop;
    if (screenWidth > ResponsiveBreakpoints.tablet) return desktop;
    if (screenWidth > ResponsiveBreakpoints.mobile) return tablet;
    return mobile;
  }
}

// Simplified Generic Masonry Grid View Component
class CommonResponsiveGridView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final int? crossAxisCount;
  final double? minItemWidth;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final ScrollController? controller;
  final Color? backgroundColor;
  final bool isLoading;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final String? emptyMessage;
  final VoidCallback? onRefresh;
  final Function(T item, int index)? onItemTap;
  final Function(T item, int index)? onItemLongPress;
  final int maxCrossAxisCount;

  const CommonResponsiveGridView({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.crossAxisCount,
    this.minItemWidth = 300.0,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.controller,
    this.backgroundColor,
    this.isLoading = false,
    this.loadingWidget,
    this.emptyWidget,
    this.emptyMessage,
    this.onRefresh,
    this.onItemTap,
    this.onItemLongPress,
    this.maxCrossAxisCount = 4,
  }) : super(key: key);

  int _getResponsiveCrossAxisCount(BuildContext context) {
    if (crossAxisCount != null) return crossAxisCount!;

    try {
      final screenWidth = MediaQuery.of(context).size.width;
      final effectivePadding = padding ?? const EdgeInsets.all(16.0);
      final horizontalPadding = effectivePadding.horizontal;

      final availableWidth = screenWidth - horizontalPadding;
      if (availableWidth <= 0) return 1;

      final calculatedCount = ((availableWidth + crossAxisSpacing) /
              (minItemWidth! + crossAxisSpacing))
          .floor();

      return calculatedCount.clamp(1, maxCrossAxisCount);
    } catch (e) {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingWidget();
    }

    if (items.isEmpty) {
      return _buildEmptyWidget();
    }

    final responsiveCrossAxisCount = _getResponsiveCrossAxisCount(context);

    Widget gridView = MasonryGridView.count(
      crossAxisCount: responsiveCrossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      padding: padding ?? const EdgeInsets.all(16.0),
      physics: physics,
      shrinkWrap: shrinkWrap,
      controller: controller,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        Widget child = itemBuilder(context, item, index);

        if (onItemTap != null || onItemLongPress != null) {
          child = GestureDetector(
            onTap: onItemTap != null ? () => onItemTap!(item, index) : null,
            onLongPress: onItemLongPress != null
                ? () => onItemLongPress!(item, index)
                : null,
            child: child,
          );
        }

        return child;
      },
    );

    if (onRefresh != null) {
      gridView = RefreshIndicator(
        onRefresh: () async => onRefresh!(),
        child: gridView,
      );
    }

    return Container(
      color: backgroundColor,
      child: gridView,
    );
  }

  Widget _buildLoadingWidget() {
    return loadingWidget ??
        const Center(
          child: CircularProgressIndicator(),
        );
  }

  Widget _buildEmptyWidget() {
    return emptyWidget ??
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                emptyMessage ?? 'No items found',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
  }
}


class CardMasonryGrid<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T item, int index) cardBuilder;
  final int? crossAxisCount;
  final double? minCardWidth;
  final double spacing;
  final EdgeInsetsGeometry? padding;
  final Function(T item, int index)? onCardTap;
  final bool isLoading;
  final bool useCard;
  final int maxCrossAxisCount;

  const CardMasonryGrid({
    Key? key,
    required this.items,
    required this.cardBuilder,
    this.crossAxisCount,
    this.minCardWidth = 300.0,
    this.spacing = 10.0,
    this.padding,
    this.onCardTap,
    this.isLoading = false,
    this.useCard = true,
    this.maxCrossAxisCount = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonResponsiveGridView<T>(
      items: items,
      crossAxisCount: crossAxisCount,
      minItemWidth: minCardWidth,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      padding: padding,
      isLoading: isLoading,
      onItemTap: onCardTap,
      maxCrossAxisCount: maxCrossAxisCount,
      itemBuilder: (context, item, index) {
        final child = cardBuilder(item, index);
        return useCard
            ? Card(
color: Colors.transparent,

                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: child,
              )
            : child;
      },
    );
  }
}

// Profile Stats Card Component
class ProfileStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const ProfileStatsCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Profile Menu Item Component
class ProfileMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;
  final bool showBadge;
  final String? badgeText;
  final String? subtitle;

  const ProfileMenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.textColor,
    this.showBadge = false,
    this.badgeText,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    //   Card(
    //   color: Theme
    //       .of(context)
    //       .brightness == Brightness.dark
    //       ? Colors.black
    //       : Colors.white,
    //   elevation: 1,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    //   child:
    //   Center(
    //     child: GestureDetector(
    //       onTap: onTap, // Handle tap here
    //       child: ListTile(
    //         leading: Container(
    //           width: 48,
    //           height: 48,
    //           decoration: BoxDecoration(
    //             color: (iconColor ?? AllColors.mediumPurple).withOpacity(0.1),
    //             borderRadius: BorderRadius.circular(12),
    //           ),
    //           child: Icon(
    //             icon,
    //             color: iconColor ??  AllColors.mediumPurple,
    //             size: 24,
    //           ),
    //         ),
    //         title: Text(
    //           title,
    //           style: TextStyle(
    //             fontSize: 16,
    //             fontWeight: FontWeight.w600,
    //             color: textColor,
    //           ),
    //         ),
    //         subtitle: subtitle != null
    //             ? Text(
    //           subtitle!,
    //           style: TextStyle(
    //             fontSize: 14,
    //             color: Colors.grey[600],
    //           ),
    //         )
    //             : null,
    //         trailing: Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             if (showBadge && badgeText != null)
    //               Container(
    //                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    //                 decoration: BoxDecoration(
    //                   color: Colors.red,
    //                   borderRadius: BorderRadius.circular(12),
    //                 ),
    //                 child: Text(
    //                   badgeText!,
    //                   style: const TextStyle(
    //                     color: Colors.white,
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             const SizedBox(width: 8),
    //             Icon(
    //               Icons.arrow_forward_ios,
    //               size: 16,
    //               color: Colors.grey[400],
    //             ),
    //           ],
    //         ),
    //         // Disable ListTile's default tap behavior
    //         onTap: null,
    //         // Optionally, set splash and highlight colors to transparent
    //         splashColor: Colors.transparent,
    //         // highlightColor: Colors.transparent,
    //       ),
    //     ),
    //   ),
    // );
    ContainerUtils(

      paddingRight: 0,
      paddingTop: 0,
      paddingLeft: 0,
      paddingBottom: 0,
      child:  Center(
        child: GestureDetector(
          onTap: onTap, // Handle tap here
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: (iconColor ?? AllColors.mediumPurple).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor ??  AllColors.mediumPurple,
                size: 24,
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            subtitle: subtitle != null
                ? Text(
              subtitle!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            )
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showBadge && badgeText != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badgeText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
            // Disable ListTile's default tap behavior
            onTap: null,
            // Optionally, set splash and highlight colors to transparent
            splashColor: Colors.transparent,
            // highlightColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
