import 'package:flutter/material.dart';
import '../appColors/app_colors.dart';

class CustomButton extends StatefulWidget {
  final double borderRadius; // Parameter for border radius
  final Widget child; // Allows any widget as a child
  final VoidCallback onPressed; // Callback function for button press
  final double height; // Custom button height
  final double width; // Custom button width
  final Color? backgroundColor; // Optional parameter for background color
  final Color foregroundColor; // Optional parameter for content color
  final EdgeInsets padding; // Optional padding inside the button

  const CustomButton({
    super.key,
    this.borderRadius = 8.0, // Default border radius
    required this.child, // Child widget
    required this.onPressed, // Button callback
    this.height = 50.0, // Default height
    this.width = 150.0, // Default width
    this.backgroundColor, // Background color is optional
    this.foregroundColor = Colors.white, // Default content color
    this.padding = EdgeInsets.zero, // Default padding
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor ??
              AllColors.mediumPurple, // Optional background color
          foregroundColor: widget.foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                widget.borderRadius), // Custom border radius
          ),
          padding: widget.padding, // Custom padding
          visualDensity: VisualDensity.compact, // Reduce default spacing
        ),
        child: widget.child, // Use child widget directly
      ),
    );
  }
}
