import 'package:flutter/material.dart';
import '../../../../appColors/app_colors.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String imageIcon;
  final Color backgroundColor;

  const CustomFloatingButton({
    super.key,
    required this.onPressed,
    required this.imageIcon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the screen width is less than 600 (mobile phone range)
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    // Only show the FloatingActionButton on mobile devices
    return isMobile
        ? SizedBox(
            width: 64.0, // Set your desired width
            height: 64.0, // Set your desired height
            child: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: onPressed,
              backgroundColor: backgroundColor,
              child: Image.asset(
                imageIcon,
                scale: 19,
                color: AllColors.whiteColor,
              ),
            ),
          )
        : const SizedBox
            .shrink(); // Return an empty widget for tablets/desktops
  }
}
