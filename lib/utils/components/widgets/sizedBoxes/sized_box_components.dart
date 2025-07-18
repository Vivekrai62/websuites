import 'package:flutter/material.dart';

class CommonSizedBox {
  static Widget height(BuildContext context, double heightPercent) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * (heightPercent / 100),
    );
  }

  static Widget width(BuildContext context, double widthPercent) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * (widthPercent / 100),
    );
  }
}
