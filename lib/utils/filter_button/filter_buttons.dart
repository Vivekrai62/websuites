import 'package:flutter/material.dart';

import '../../resources/textStyles/responsive/test_responsive.dart';
import '../responsive/responsive_utils.dart';

class FilterButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final Color iconColor;
  final Color borderColor;
  final double borderRadius;
  final EdgeInsets padding;
  final double? iconSize;

  const FilterButton({
    super.key,
    required this.text,
    required this.iconPath,
    this.iconColor = Colors.purple, // Default color, replace with AllColors.mediumPurple
    this.borderColor = Colors.grey, // Default color, replace with AllColors.filterTextColor
    this.borderRadius = 30.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {

    final double defaultIconSize = ResponsiveUtilsScreenSize.isMobile(context) ? 12 : 14;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: iconSize ?? defaultIconSize,
            height: iconSize ?? defaultIconSize,
            color: iconColor,
          ),
          const SizedBox(width: 6),
          ResponsiveText.getFilterTextSize(context, text),
        ],
      ),
    );
  }
}