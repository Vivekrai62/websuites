import 'package:flutter/material.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';

import '../dark_mode/dark_mode.dart';

class RequiredLabel extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextStyle? labelStyle;
  final TextStyle? asteriskStyle;

  const RequiredLabel({
    Key? key,
    required this.label,
    this.isRequired = true,
    this.labelStyle,
    this.asteriskStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: labelStyle ??
                 TextStyle(
                   fontSize: 14,
                   fontWeight: FontWeight.w500,
                   color: DarkMode.editColor(context),
                   fontFamily: FontFamily.sfPro,

                ),
          ),
          if (isRequired)
            TextSpan(
              text: ' *',
              style: asteriskStyle ??
                  const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.red,

                    fontFamily: FontFamily.sfPro,
                    letterSpacing: 0,
                    fontSize: 14,
                  ),
            ),
        ],
      ),
    );
  }
}
