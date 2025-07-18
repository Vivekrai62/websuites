import 'package:flutter/material.dart';

// class ContainerUtils extends StatelessWidget {
//   final Widget? child;
//   final Color? backgroundColor;
//   final EdgeInsets? margin;
//   final double? paddingTop;
//   final double? paddingBottom;
//   final double? paddingLeft;
//   final double? paddingRight;
//   final BorderRadius? borderRadius;
//   final bool enableDecoration;
//   final double? height;
//   final double? width;
//   final bool enableBoxShadow; // Controls box shadow visibility
//   final double? boxShadowBlurRadius; // Controls blur radius
//   final double? boxShadowSpreadRadius; // Controls spread radius
//   final Color? boxShadowColor; // Controls shadow color
//   final Color? borderColor; // New parameter for border color
//   final double? borderWidth; // New parameter for border width
//
//   const ContainerUtils({
//     super.key,
//     this.child,
//     this.backgroundColor = Colors.white,
//     this.margin,
//     this.paddingTop = 15,
//     this.paddingBottom = 15.0,
//     this.paddingLeft = 12.0,
//     this.paddingRight = 12.0,
//     this.borderRadius,
//     this.enableDecoration = true,
//     this.height,
//     this.width,
//     this.enableBoxShadow = true, // Default to true for backward compatibility
//     this.boxShadowBlurRadius = 4.0,
//     this.boxShadowSpreadRadius = 2.0,
//     this.boxShadowColor,
//     this.borderColor,
//     this.borderWidth = 1.0,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       height: height,
//       width: width,
//       margin: margin,
//       padding: EdgeInsets.only(
//         top: paddingTop!,
//         bottom: paddingBottom!,
//         left: paddingLeft!,
//         right: paddingRight!,
//       ),
//       decoration: enableDecoration
//           ? BoxDecoration(
//         color: backgroundColor,
//         borderRadius: borderRadius ?? BorderRadius.circular(8),
//         // Border configuration
//         border: borderColor != null
//             ? Border.all(
//           color: borderColor!,
//           width: borderWidth!,
//         )
//             : null,
//         // Box shadow configuration
//         boxShadow: enableBoxShadow
//             ? [
//           BoxShadow(
//             color: boxShadowColor ?? Colors.grey.withOpacity(0.2),
//             blurRadius: boxShadowBlurRadius!,
//             spreadRadius: boxShadowSpreadRadius!,
//           ),
//         ]
//             : [], // Empty list means no shadow
//       )
//           : null,
//       color: enableDecoration ? null : backgroundColor,
//       child: child,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:websuites/utils/appColors/app_colors.dart';

class ContainerUtils extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  final double? paddingTop;
  final double? paddingBottom;
  final double? paddingLeft;
  final double? paddingRight;
  final BorderRadius? borderRadius;
  final bool enableDecoration;
  final double? height;
  final double? width;
  final bool? enableBoxShadow;
  final double? boxShadowBlurRadius;
  final double? boxShadowSpreadRadius;
  final Color? boxShadowColor;
  final Color? borderColor;
  final double? borderWidth;

  const ContainerUtils({
    super.key,
    this.child,
    this.backgroundColor,
    this.margin,
    this.paddingTop = 15,
    this.paddingBottom = 15.0,
    this.paddingLeft = 12.0,
    this.paddingRight = 12.0,
    this.borderRadius,
    this.enableDecoration = true,
    this.height,
    this.width,
    this.enableBoxShadow,
    this.boxShadowBlurRadius,
    this.boxShadowSpreadRadius,
    this.boxShadowColor,
    this.borderColor,
    this.borderWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the current theme is dark mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Define properties based on theme
    final effectiveBackgroundColor = backgroundColor ??
        (isDarkMode ? AllColors.darkModeGrey : Colors.white);
    final effectiveEnableBoxShadow = enableBoxShadow ?? (isDarkMode ? true : true); // True for both modes unless overridden
    final effectiveBoxShadowBlurRadius =
        boxShadowBlurRadius ?? (isDarkMode ? 0.0 : 4.0);
    final effectiveBoxShadowSpreadRadius =
        boxShadowSpreadRadius ?? (isDarkMode ? 0.0 : 2.0);
    final effectiveBoxShadowColor =
        boxShadowColor ?? (isDarkMode ? Colors.white10 : Colors.grey.withOpacity(0.2));
    final effectiveBorderColor =
        borderColor ?? (isDarkMode ? Colors.grey[800]! : null); // No border in light mode by default

    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      margin: margin,
      padding: EdgeInsets.only(
        top: paddingTop!,
        bottom: paddingBottom!,
        left: paddingLeft!,
        right: paddingRight!,
      ),
      decoration: enableDecoration
          ? BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        // Border configuration
        border: effectiveBorderColor != null
            ? Border.all(
          color: effectiveBorderColor,
          width: borderWidth!,
        )
            : null,
        // Box shadow configuration
        boxShadow: effectiveEnableBoxShadow
            ? [
          BoxShadow(
            color: effectiveBoxShadowColor,
            blurRadius: effectiveBoxShadowBlurRadius,
            spreadRadius: effectiveBoxShadowSpreadRadius,
          ),
        ]
            : [],
      )
          : null,
      color: enableDecoration ? null : effectiveBackgroundColor,
      child: child,
    );
  }
}
