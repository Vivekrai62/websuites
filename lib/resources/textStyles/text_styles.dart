import 'package:flutter/material.dart';
import '../../utils/appColors/app_colors.dart';
import '../../utils/dark_mode/dark_mode.dart';
import '../../utils/fontfamily/FontFamily.dart';

class TextStyles {

  static w400_13(context, String message, {Color color = Colors.black}) {
    return Text(message,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 13,
          color: color,
        ));
  }

  static EdgeInsets defaultPadding(BuildContext context) {
    return const EdgeInsets.symmetric(horizontal: 10);
  }

  static TextStyle textFormHintStyle(BuildContext context) {
    return  TextStyle(
      fontWeight: FontWeight.w400,
      // fontSize: MediaQuery.of(context).size.width * 0.013,
      color: DarkMode.backgroundColorTextField(context),
      fontSize: 13,
    );

  }

  static w400_15(context, String message, {Color color = Colors.black}) {
    return Text(message,
        style:
            TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: color));
  }

  static w400_12(context, String message, {Color color = Colors.black}) {
    return Text(message,
        style:
            TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: color));
  }

  static w400_14(context, String message, {Color color = Colors.black}) {
    return Text(message,
        style:
            TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: color));
  }

  //============================================================================
//   w300

  static w300_10(context, String message, {Color color = Colors.black}) {
    return Text(message,
        style:
            TextStyle(fontWeight: FontWeight.w300, fontSize: 10, color: color));
  }

  static w300_12(context, String message, {Color color = Colors.black}) {
    return Text(message,
        style:
            TextStyle(fontWeight: FontWeight.w300, fontSize: 16, color: color));
  }

  //============================================================================
//   w500

  static w500_universal(context, String message,
      {Color color = Colors.black, double fontSize = 13.0}) {
    return Text(
      message,
      style: TextStyle(
          fontWeight: FontWeight.w600, color: color, fontSize: fontSize),
    );
  }

  static w500_12(context, String message, {Color color = Colors.black}) {
    return Text(message,
        style:
            TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: color));
  }

  static w500_16(context, String message, {Color color = Colors.black}) {
    return Text(message,
        style:
            TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: color));
  }

  static w500_14(context, String message, {Color color = Colors.black}) {
    return Text(
      message,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: color),
    );
  }

  //============================================================================
//   w600

  static w600_12(context, String message, {Color color = Colors.black}) {
    return Text(message,
        style:
            TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: color));
  }

  static w600_15(context, String message, {Color color = Colors.black}) {
    return Text(message,
        style:
            TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: color));
  }

  static w600_universal(context, String message,
      {Color color = Colors.black, double fontSize = 30.0}) {
    return Text(message,
        style: TextStyle(
            fontWeight: FontWeight.w600, color: color, fontSize: fontSize));
  }

  //============================================================================
//  w700

  static w700_17(context, String message, {Color color = Colors.black}) {
    return Text(message,
        style:
            TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: color));
  }

  static w700_16(context, String message, {Color color = Colors.black}) {
    return Text(message,
        style:
            TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: color));
  }

//==============================================================================
// w500, 14, BlackColor,

  static w500_14_Black(context, String message) {
    return Text(message,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AllColors.blackColor));
  }


  static w500_15_Black(context, String message) {
    return Text(message,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.5,
            color: AllColors.blackColor));
  }

  static w500_14_White(context, String message) {
    return Text(message,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AllColors.whiteColor));
  }

  static w400Common(context, String message) {
    return Text(message,
        style: TextStyle(
        color: Colors.grey[700],
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.sfPro,
    ));
  }

  static w600_12_Black(context, String message) {
    return Text(
      message,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: AllColors.blackColor),
    );
  }


  static Widget commonTextFieldTextHeading(BuildContext context, String message, {Color? color}) {
    return Text(
      message,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.sfPro,
        fontSize: 15,
        color: color ?? Colors.black45, // fallback to black45 if color not provided
      ),
    );
  }

  static Widget commonTextFieldSubHead(BuildContext context, String message, {Color? color}) {
    return Text(
      message,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.sfPro,
        fontSize: 14,
        color: color ?? DarkMode.editColor(context),

      ),
    );
  }

}
