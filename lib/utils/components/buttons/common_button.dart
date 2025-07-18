import 'package:flutter/material.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import '../../appColors/app_colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    this.title = '',
    this.onPress,
    this.width = 60,
    this.height = 50,
    this.loading = false,
    this.color,
    this.textColor,
    this.borderColor,
    this.borderRadius = 5.0,
    this.fontWeight,
    this.fontSize,
    this.icon,
    this.iconSpacing = true,
    this.child,
    this.alignment = Alignment.center,
    this.margin,
    this.padding,
  });

  final bool loading;
  final String title;
  final double height, width;
  final VoidCallback? onPress;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double borderRadius;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Widget? icon;
  final bool iconSpacing;
  final Widget? child;
  final Alignment alignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        margin: margin ?? const EdgeInsets.only(bottom: 10),
        padding: padding,
        alignment: alignment,
        decoration: BoxDecoration(
          color: color ?? AllColors.mediumPurple,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
          ),
        ),
        child: loading
            ? Center(
          child: CircularProgressIndicator(
            color: textColor ?? AllColors.whiteColor,
          ),
        )
            : child ?? _buildDefaultContent(),
      ),
    );
  }

  Widget _buildDefaultContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: fontWeight ?? FontWeight.w400,
              fontSize: fontSize ?? 13,
              fontFamily: FontFamily.sfPro,
              letterSpacing: 0
            ),
          ),
        if (icon != null && title.isNotEmpty && iconSpacing)
          const SizedBox(width: 4),
        if (icon != null) icon!,
      ],
    );
  }
}