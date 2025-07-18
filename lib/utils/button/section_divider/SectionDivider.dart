import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomToggleButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;
  final Widget? selectedChild;
  final Widget? unselectedChild;
  final Color selectedColor;
  final Color unselectedColor;
  final double width;
  final double height;
  final double borderRadius;
  final String? navigateToRoute;
  final dynamic routeArguments;
  final BoxShadow? boxShadow;
  final EdgeInsetsGeometry padding;

  const CustomToggleButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
    this.selectedChild,
    this.unselectedChild,
    this.selectedColor = Colors.black,
    this.unselectedColor = Colors.transparent,
    this.width = 140,
    this.height = 40,
    this.borderRadius = 20,
    this.navigateToRoute,
    this.routeArguments,
    this.boxShadow,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
        if (navigateToRoute != null) {
          Get.toNamed(navigateToRoute!, arguments: routeArguments);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutCubic,
        width: width,
        height: height,
        padding: padding,
        // Slide effect using transform
        transform: Matrix4.identity()..translate(isSelected ? 0.0 : 4.0, 0.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOutCubic,
              left: isSelected ? 0 : -width, // Slide content in from left
              right: isSelected ? 0 : width, // Slide content out to right
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: isSelected ? 1.0 : 0.0,
                  child: selectedChild ?? const SizedBox(),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOutCubic,
              left: isSelected ? width : 0, // Slide content out to right
              right: isSelected ? -width : 0, // Slide content in from left
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: isSelected ? 0.0 : 1.0,
                  child: unselectedChild ?? const SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomToggleButtonGroup extends StatefulWidget {
  final List<ToggleOption> options;
  final int initialSelectedIndex;
  final Color backgroundColor;
  final double height;
  final double borderRadius;
  final BoxShadow? boxShadow;
  final Function(int)? onIndexChanged;

  const CustomToggleButtonGroup({
    super.key,
    required this.options,
    this.initialSelectedIndex = 0,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.height = 35,
    this.borderRadius = 20,
    this.boxShadow,
    this.onIndexChanged,
  });

  @override
  State<CustomToggleButtonGroup> createState() =>
      _CustomToggleButtonGroupState();
}

class _CustomToggleButtonGroupState extends State<CustomToggleButtonGroup>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late AnimationController _animationController;
  late Animation<double> _indicatorAnimation;
  double _previousPosition = 0.0;
  double _currentPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Set initial indicator position
    _currentPosition = widget.initialSelectedIndex.toDouble();
    _indicatorAnimation = Tween<double>(
      begin: _previousPosition,
      end: _currentPosition,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Initial animation setup
    _animationController.value = 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateSelectedTab(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _previousPosition = _selectedIndex.toDouble();
      _selectedIndex = index;
      _currentPosition = index.toDouble();

      _indicatorAnimation = Tween<double>(
        begin: _previousPosition,
        end: _currentPosition,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));

      _animationController.forward(from: 0.0);
    });

    if (widget.onIndexChanged != null) {
      widget.onIndexChanged!(index);
    }

    if (widget.options[index].onPressed != null) {
      widget.options[index].onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: widget.boxShadow != null
              ? [widget.boxShadow!]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: Stack(
          children: [
            // This creates the sliding selector background
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned(
                  left: _getPositionForIndex(_indicatorAnimation.value),
                  top: 0,
                  child: Container(
                    width: widget.options.isEmpty
                        ? 0
                        : widget.options[_selectedIndex].width,
                    height: widget.height,
                    decoration: BoxDecoration(
                      color: widget.options.isEmpty
                          ? Colors.transparent
                          : widget.options[_selectedIndex].selectedColor,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                  ),
                );
              },
            ),
            // The toggle buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.options.length,
                (index) => CustomToggleButton(
                  isSelected: _selectedIndex == index,
                  onPressed: () => _updateSelectedTab(index),
                  selectedChild: widget.options[index].selectedChild,
                  unselectedChild: widget.options[index].unselectedChild,
                  selectedColor: Colors
                      .transparent, // We use the background slider instead
                  unselectedColor: Colors.transparent,
                  width: widget.options[index].width,
                  height: widget.options[index].height,
                  borderRadius: widget.borderRadius,
                  navigateToRoute: widget.options[index].navigateToRoute,
                  routeArguments: widget.options[index].routeArguments,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Calculate the position for the sliding indicator based on index
  double _getPositionForIndex(double index) {
    double position = 0;
    for (int i = 0; i < index.floor(); i++) {
      position += widget.options[i].width;
    }

    // Add fractional position for smooth animation
    if (index > index.floor()) {
      double fraction = index - index.floor();
      double remainingWidth = widget.options[index.floor()].width;
      position += fraction * remainingWidth;
    }

    return position;
  }
}

class ToggleOption {
  final Widget? selectedChild;
  final Widget? unselectedChild;
  final Color selectedColor;
  final Color unselectedColor;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final String? navigateToRoute;
  final dynamic routeArguments;

  ToggleOption({
    this.selectedChild,
    this.unselectedChild,
    this.selectedColor = Colors.black,
    this.unselectedColor = Colors.transparent,
    this.width = 140,
    this.height = 40,
    this.onPressed,
    this.navigateToRoute,
    this.routeArguments,
  });
}

class ToggleButtonUtils {
  /// Creates a standard icon with text toggle option where icon is optional
  static ToggleOption createIconTextOption({
    IconData? icon, // Made icon optional by adding ?
    required String text,
    required Color selectedColor,
    Color unselectedColor = Colors.transparent,
    Color selectedTextColor = Colors.white,
    Color unselectedTextColor = Colors.black87,
    double width = 140,
    double height = 40,
    double iconSize = 20,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w500,
    VoidCallback? onPressed,
    String? navigateToRoute,
    dynamic routeArguments,
  }) {
    return ToggleOption(
      selectedChild: Row(
        key: ValueKey('selected-$text'),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: selectedTextColor,
              size: iconSize,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(
              color: selectedTextColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
      unselectedChild: Row(
        key: ValueKey('unselected-$text'),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: unselectedTextColor,
              size: iconSize,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(
              color: unselectedTextColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
      selectedColor: selectedColor,
      unselectedColor: unselectedColor,
      width: width,
      height: height,
      onPressed: onPressed,
      navigateToRoute: navigateToRoute,
      routeArguments: routeArguments,
    );
  }

  /// Creates a standard text-only toggle option
  static ToggleOption createTextOption({
    required String text,
    required Color selectedColor,
    Color unselectedColor = Colors.transparent,
    Color selectedTextColor = Colors.white,
    Color unselectedTextColor = Colors.black87,
    double width = 140,
    double height = 40,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w500,
    VoidCallback? onPressed,
    String? navigateToRoute,
    dynamic routeArguments,
  }) {
    return ToggleOption(
      selectedChild: Text(
        text,
        key: ValueKey('selected-$text'),
        style: TextStyle(
          color: selectedTextColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
      unselectedChild: Text(
        text,
        key: ValueKey('unselected-$text'),
        style: TextStyle(
          color: unselectedTextColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
      selectedColor: selectedColor,
      unselectedColor: unselectedColor,
      width: width,
      height: height,
      onPressed: onPressed,
      navigateToRoute: navigateToRoute,
      routeArguments: routeArguments,
    );
  }

  /// Creates a custom toggle option with custom widgets
  static ToggleOption createCustomOption({
    required Widget selectedChild,
    required Widget unselectedChild,
    required Color selectedColor,
    Color unselectedColor = Colors.transparent,
    double width = 140,
    double height = 40,
    VoidCallback? onPressed,
    String? navigateToRoute,
    dynamic routeArguments,
  }) {
    return ToggleOption(
      selectedChild: selectedChild,
      unselectedChild: unselectedChild,
      selectedColor: selectedColor,
      unselectedColor: unselectedColor,
      width: width,
      height: height,
      onPressed: onPressed,
      navigateToRoute: navigateToRoute,
      routeArguments: routeArguments,
    );
  }
}
