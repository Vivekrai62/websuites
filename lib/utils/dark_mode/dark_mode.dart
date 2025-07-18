import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websuites/utils/appColors/app_colors.dart';

class DarkMode extends StatefulWidget {
  const DarkMode({super.key});

  @override
  State<DarkMode> createState() => _DarkModeState();


  static Color backgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.darkModeGrey ?? Colors.grey.shade900
        : Colors.white;
  }


  static Color backgroundColorTextField(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.darkModeGrey ?? Colors.grey.shade900
        : Colors.black;
  }



  static Color backgroundColor2(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.whiteColor
        : AllColors.blackColor;
  }


  static Color subTitleColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.darkModeCommonColor
        : AllColors.subTitle;
  }




  static Color divisionBackColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.grey
        : AllColors.lightBlue;
  }

  static Color divisionTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.whiteColor
        : AllColors.darkBlue;
  }

  static Color assignedBackColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.mediumPurple
        : AllColors.lighterPurple;
  }

  static Color assignedTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.whiteColor
        : AllColors.mediumPurple;
  }

  static Color mobileColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.commonTextFiledColor
        : AllColors.mediumPurple;
  }


  static Color numberColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.darkModeCommonColor
        : AllColors.phone;
  }

  static Color editColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.darkModeCommonColor
        : AllColors.figmaGrey;
  }


  static Color filter(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.whiteColor
        : AllColors.blackColor;
  }




  static Color welcome(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.whiteColor
        : AllColors.welcomeColor;
  }



  static Color building(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.darkModeCommonColor
        : AllColors.welcomeColor;
  }

  static Color leadCall(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.darkBlue
        : AllColors.darkBlue;
  }

  static Color whatsApp(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.darkGreen
        : AllColors.darkGreen;
  }


  // for drawer
  static Color drawerText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AllColors.whiteColor
        : AllColors.bottomNavColor;
  }

  static Color appBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[900] ?? Colors.black
        : AllColors.whiteColor;
  }


  static Color textColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
  }
}

class _DarkModeState extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
