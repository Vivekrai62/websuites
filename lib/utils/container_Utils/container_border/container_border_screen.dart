import 'package:flutter/material.dart';

class ContainerBorderComponent extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BoxBorder border;
  final BorderRadiusGeometry borderRadius;
  final Color color;

  const ContainerBorderComponent({
    Key? key,
    this.child,
    this.padding = const EdgeInsets.all(10),
    this.margin = EdgeInsets.zero,
    this.border = const Border.fromBorderSide(
      BorderSide(color: Color(0xFFE0E0E0)), // Colors.grey.shade300
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
