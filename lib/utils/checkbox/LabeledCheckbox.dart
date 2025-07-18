import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  final String? label;
  final bool? value;
  final void Function(bool?)? onChanged;
  final Color? activeColor;
  final TextStyle? labelStyle;
  final MainAxisAlignment? alignment;

  const LabeledCheckbox({
    Key? key,
    this.label,
    this.value,
    this.onChanged,
    this.activeColor,
    this.labelStyle,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment ?? MainAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return activeColor;
            }
            return null;
          }),
        ),
        if (label != null)
          Text(
            label!,
            style: labelStyle ?? const TextStyle(fontSize: 16),
          ),
      ],
    );
  }
}