import 'package:flutter/material.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';

import '../../../utils/dark_mode/dark_mode.dart';

extension StringExtension on String {

  String capitalizeWords() {
    if (isEmpty) return this; // Return empty string if empty

    List<String> parts = split(' ');

    List<String> unitsToLowercase = [

    ];

    for (int i = 0; i < parts.length; i++) {
      // Split each part by hyphen to handle hyphenated words
      List<String> subParts = parts[i].split('-');

      for (int j = 0; j < subParts.length; j++) {
        String currentWord = subParts[j];

        // 1. Handle units after numbers (space or hyphen)
        if (j > 0 && unitsToLowercase.contains(currentWord.toLowerCase())) {
          String previousWord = subParts[j - 1];

          // If the previous part is a number, convert the current unit to lowercase
          if (RegExp(r'^\d+(\.\d+)?$').hasMatch(previousWord)) {
            // Handling decimals too
            subParts[j] = currentWord.toLowerCase();
            continue;
          }
        }

        if (i > 0 && unitsToLowercase.contains(currentWord.toLowerCase())) {
          String previousWord = parts[i - 1];

          // If the previous part (space-separated) is a number, convert to lowercase
          if (RegExp(r'^\d+(\.\d+)?$').hasMatch(previousWord)) {
            // Handling decimals too
            parts[i] = currentWord.toLowerCase();
            continue;
          }
        }

        // 2. Apply capitalization rules based on length
        if (currentWord.isNotEmpty) {
          if (currentWord.length <= 1) {
            // If the word is 2 letters or fewer, capitalize the whole word
            subParts[j] = currentWord.toUpperCase();
          } else {
            // Otherwise, camel-case it (capitalize first letter, lowercase the rest)
            subParts[j] = currentWord[0].toUpperCase() +
                currentWord.substring(1).toLowerCase();
          }
        }
      }

      // Rejoin the subParts (handling hyphenated words)
      parts[i] = subParts.join('-');
    }

    // Rejoin all parts and return the final formatted string
    return parts.join(' ');
  }
}

class ResponsiveText {
  static double getResponsiveTextSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    if (screenWidth <= 550) {
      return baseSize * (1 + ((screenWidth - 375) / 1200) * 0.3);
    } else {
      return baseSize * (1 + ((screenWidth - 600) / 1200) * 0.2);
    }
  }

  // ✅ check it

  static Widget getRegistrationTitle(BuildContext context, String? text) {
    final safeText = text ?? '';
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 18.0),
            fontWeight: FontWeight.w500,
            letterSpacing: 0));
  }

  static Widget getTitle(
      BuildContext context,
      String? text, {
        double? fontSize,
        Color? color,
        FontWeight? fontWeight,
      }) {
    final safeText = text ?? '';
    return Text(
      safeText.isNotEmpty ? safeText.capitalizeWords() : '',
      style: TextStyle(
        fontFamily: FontFamily.sfPro,
        fontSize: getResponsiveTextSize(context, fontSize ?? 18.0),
        fontWeight:fontWeight ?? FontWeight.w500,
        color: color ?? AllColors.welcomeColor,
        letterSpacing: 0,
      ),
    );
  }



  static Widget getSubTitle(
      BuildContext context,
      String? text, {
        double? fontSize,
        FontWeight? fontWeight,
        Color? color,
        int? maxLines,
        TextOverflow? overflow,
      }) {
    final safeText = text ?? '';
    return Text(
      safeText.isNotEmpty ? safeText.capitalizeWords() : '',
      style: TextStyle(
        fontSize: getResponsiveTextSize(context, fontSize ?? 12.0),
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? DarkMode.subTitleColor(context),
        fontFamily: FontFamily.sfPro,
        letterSpacing: 0,
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
  }



  static Widget getHeader(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 14.0),
            color: DarkMode.building(context),
            letterSpacing: 0,
            fontFamily: FontFamily.sfPro,
            fontWeight: FontWeight.w700));
  }


  static Widget getEmailTitle(
      BuildContext context,
      String? text, {
        double? fontSize,
      }) {
    final safeText = text ?? '';

    return Text(
      safeText,
      style: TextStyle(
        fontSize: getResponsiveTextSize(context, fontSize ?? 12.0),
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.sfPro,
        color: DarkMode.subTitleColor(context),
        letterSpacing: 0,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }



  static Widget getMobileTitle(BuildContext context, String? text) {
    final safeText = text ?? '';
    return Text(
      safeText, // <-- No capitalization applied
      style: TextStyle(
        fontSize: getResponsiveTextSize(context, 12.0),
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.sfPro,
        color:DarkMode.numberColor(context),
        letterSpacing: 0,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }




  static Widget getDateTitle(
      BuildContext context,
      String? text, {
        double? fontSize, // Optional font size parameter
      }) {
    final safeText = text ?? '';
    return Text(
      safeText,
      style: TextStyle(
        fontSize: getResponsiveTextSize(context, fontSize ?? 12.0), // Use provided fontSize or default to 12.0
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.sfPro,
        color: DarkMode.mobileColor(context),
        letterSpacing: 0,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }



  static Widget divisionTextColor(BuildContext context, String? text) {
    final safeText = text ?? '';
    return Text(
      safeText, // <-- No capitalization applied
      style: TextStyle(
        fontSize: getResponsiveTextSize(context, 12.0),
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.sfPro,
        color: DarkMode.divisionTextColor(context) ,
        letterSpacing: 0,
      ),
      overflow: TextOverflow.ellipsis,

    );
  }


  static Widget assignedTextColor(BuildContext context, String? text) {
    final safeText = text ?? '';
    return Text(
      safeText, // <-- No capitalization applied
      style: TextStyle(
        fontSize: getResponsiveTextSize(context, 12.0),
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.sfPro,
        color: DarkMode.assignedTextColor(context) ,
        letterSpacing: 0,
      ),
      overflow: TextOverflow.ellipsis,

    );
  }




  static Widget getAppBarTextSize(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 16.5),
            fontFamily: FontFamily.sfPro,
            letterSpacing: 0,
            fontWeight: FontWeight.w700));
  }


  //  filter text
  static Widget getFilterTextSize(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 12),
            fontFamily: FontFamily.sfPro,
            letterSpacing: 0,
            color: DarkMode.backgroundColor2(context),
            fontWeight: FontWeight.w400));
  }


  // drawer text  size

  static Widget getDrawerTextSize(
      BuildContext context,
      String? text, {
        Color? color, // Optional color parameter to override default
      }) {
    final safeText = text ?? '';
    return Text(
      safeText.isNotEmpty ? safeText.capitalizeWords() : '',
      style: TextStyle(
        fontSize: getResponsiveTextSize(context, 14.5),
        letterSpacing: 0,
        fontFamily: FontFamily.sfPro,
        fontWeight: FontWeight.w400,
        color: color ?? DarkMode.drawerText(context), // Use provided color or default
      ),
    );
  }
  // drawer text username

  static Widget getDrawerUserTextSize(BuildContext context, String? text) {
    final safeText = text ?? '';
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 14.0),
            letterSpacing: 0,
            fontFamily: FontFamily.sfPro,
            fontWeight: FontWeight.w600,
            color: DarkMode.backgroundColor2(context)));
  }

  static Widget getDrawerUserTextMobSize(BuildContext context, String? text) {
    final safeText = text ?? '';
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 12.0),
            letterSpacing: 0,

            fontFamily: FontFamily.sfPro,
            fontWeight: FontWeight.w400,
            // color: DarkMode.backgroundColor2(context)
          color: AllColors.profileNum
        )
    );
  }


// Text Filed Text


  static Widget mainTextField(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 12.0),
            letterSpacing: 0,
            fontFamily: FontFamily.sfPro,
            fontWeight: FontWeight.w600,
            color: DarkMode.editColor(context)
        ));
  }



  //Home Screen
  static double getBottomBarTextSize(BuildContext context) {
    return getResponsiveTextSize(context, 12.0);
  }

  //Dashboard Screen
  static Widget getCategoriesText(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 18.0),
            fontWeight: FontWeight.w500,
            letterSpacing: 0));
  }

  static Widget getNoInternetText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 16.0),
            color: Colors.white,
            letterSpacing: 0));
  }



  static Widget getDualToneIconText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 13.0),
            letterSpacing: 0,
            fontWeight: FontWeight.w500));
  }

  static Widget getMainCountText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 12.0),
            letterSpacing: 0,
            color: Colors.black54,
            fontWeight: FontWeight.w500));
  }

  //Product Screen
  static Widget getProductNameText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 17.0),
            letterSpacing: 0,
            fontWeight: FontWeight.w600));
  }

  static Widget getProductTypeText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 12.0),
            color: Colors.black54,
            letterSpacing: 0,
            fontWeight: FontWeight.w500));
  }

  static Widget getProductDetailsDesText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 16.0),
            color: Colors.black54,
            letterSpacing: 0,
            fontWeight: FontWeight.w500));
  }

  static Widget getProductDetailsPackingText(
      BuildContext context, String? text, Color color) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 13.0),
            color: color,
            letterSpacing: 0,
            fontWeight: FontWeight.w600));
  }

  static Widget getProductFilterTitle(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
          fontSize: getResponsiveTextSize(context, 15.0),
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ));
  }


  static Widget getProductDesText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        maxLines: 3,
        style: TextStyle(
          fontSize: getResponsiveTextSize(context, 15.0),
          color: Colors.black,
        ));
  }

  static Widget getProductPriceText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
          fontSize: getResponsiveTextSize(context, 15.0),
          color: Colors.black,
        ));
  }

  //Order Screen
  static Widget getOrderTitleText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 17.0),
            fontWeight: FontWeight.w500));
  }

  static Widget getOrderPriceText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 13.0),
            letterSpacing: 0,
            color: Colors.black54,
            fontWeight: FontWeight.w500));
  }

  static Widget getOrderIdText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        style: TextStyle(
          fontSize: getResponsiveTextSize(context, 15.0),
          letterSpacing: 0,
          color: Colors.black54,
        ));
  }

  static Widget getOrderProductText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
          fontSize: getResponsiveTextSize(context, 15.0),
        ));
  }

  static Widget getOrderItemCountText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
          fontSize: getResponsiveTextSize(context, 15.0),
        ));
  }

  static Widget getCourierName(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        style: TextStyle(
          fontSize: getResponsiveTextSize(context, 15.0),
          letterSpacing: 0,
        ));
  }

  static Widget getTrackingId(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 14.0),
            letterSpacing: 0,
            fontWeight: FontWeight.w600));
  }

  static Widget getTrackingNumber(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 15.0),
            letterSpacing: 0,
            color: Colors.black54));
  }

  static Widget orderProductName(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        maxLines: 3,
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 15.0),
            letterSpacing: 0,
            color: Colors.black));
  }

  //Bank Screen
  static Widget getBankAccountText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 16.0),
            color: Colors.black54,
            fontWeight: FontWeight.w400));
  }

  static Widget getBankAccountNumberText(BuildContext context, String? text) {
    final safeText = text ?? 'Na'; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 18.0),
            fontWeight: FontWeight.w600));
  }

  //Common TextStyles
  static Widget getAppBarText(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 20.0),
            fontWeight: FontWeight.w500,
            letterSpacing: 0));
  }



  static Widget getTitleText(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 18.0),
            letterSpacing: 0,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.sfPro,
            overflow:
             TextOverflow.ellipsis,
        ),
           maxLines: 1,
    );
  }

  static Widget getButtonText(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 17.0),
            fontWeight: FontWeight.w400,
            color: Colors.white,
            letterSpacing: 0));
  }

  //Error Dialogue
  static Widget getErrorTextSize(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 16.0),
            letterSpacing: 0,
            fontWeight: FontWeight.w500));
  }

  //flushBar Text
  static Widget getFlushBarTextSize(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 16.0),
            color: Colors.white,
            letterSpacing: 0));
  }

  //loginScreen
  static Widget getLoginGreetingTextSize(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 20.0),
            fontWeight: FontWeight.w500));
  }

  static Widget getLoginOptionTextSize(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 15.0),
            fontWeight: FontWeight.w400));
  }

  static Widget getLoginOptionTextSizes(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 14.0),
            fontWeight: FontWeight.w400));
  }

  static Widget getForgotPasswordTextSize(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 16.0),
            color: Colors.black,
            fontWeight: FontWeight.w400));
  }

  static Widget getRegistrationTextSize(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 17.0),
            color: Colors.black,
            fontWeight: FontWeight.w500));
  }

  //Cart Screen TextStyles
  static Widget getCartProductDesSize(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 16.0),
            color: Colors.black54,
            fontWeight: FontWeight.w400));
  }

  static Widget getTotalPriceText(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 19.0),
            fontWeight: FontWeight.w500,
            color: AllColors.mediumPurple,
            letterSpacing: 0));
  }

  //Retails Screen
  static Widget getRetailsProfessionTextSize(
      BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 14.0),
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            color: AllColors.mediumPurple));
  }

  static Widget getRetailsCircularTextSize(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 26.0),
            letterSpacing: 0,
            fontWeight: FontWeight.w600,
            color: AllColors.mediumPurple));
  }

  static Widget getRetailsDetailsTextSize(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 14.0),
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
            color: Colors.black54));
  }

  static Widget getRetailsCreatedTextSize(BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 14.0),
            letterSpacing: 0,
            fontWeight: FontWeight.w400,
            color: Colors.black45));
  }

  static Widget getRetailsCreatedOnTextSize(
      BuildContext context, String? text) {
    final safeText = text ?? ''; // Handle null text
    return Text(safeText.isNotEmpty ? safeText.capitalizeWords() : '',
        style: TextStyle(
            fontSize: getResponsiveTextSize(context, 14.0),
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
            color: Colors.black54));
  }

  static double getInputTextSize(BuildContext context) {
    return getResponsiveTextSize(context, 16.0);
  }
}

class ResponsiveTextBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, double fontSize) builder;
  final double baseSize;

  const ResponsiveTextBuilder(
      {
    Key? key,
    required this.builder,
    required this.baseSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fontSize =
        ResponsiveText.getResponsiveTextSize(context, baseSize);
        return builder(context, fontSize);
      },
    );
  }
}