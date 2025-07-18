import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    this.title,
    this.node,
    this.hintText,
    this.labelText,
    this.icon,
    this.validator,
    super.key,
    this.height = 40.0,
  });

  final dynamic title;
  final dynamic node;
  final String? hintText;
  final String? labelText;
  final dynamic icon;
  final dynamic validator;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      height: height,
      child: TextFormField(
        style: TextStyle(
          fontSize: 16,
          color: AllColors.lightGrey,
          fontWeight: FontWeight.w400,
          fontFamily: FontFamily.sfPro,
        ),
        controller: title,
        focusNode: node,
        maxLines: 1,
        textInputAction: TextInputAction.next,
        validator: validator,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            // Added hintStyle for green hint text
            color: AllColors.lightGrey,
            fontSize: 16,
            fontFamily: FontFamily.sfPro,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: AllColors.lightGrey, width: 0.3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: AllColors.mediumPurple),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.red.shade700),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.red.shade700),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: (height - 10) / 3, horizontal: 10),
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(icon, size: 23, color: AllColors.lightGrey),
          ),
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
