import 'package:flutter/material.dart';

import '../../../appColors/app_colors.dart';

class PasswordInputField extends StatelessWidget {
  PasswordInputField(
      {this.title,
      this.node,
      this.hintText,
      this.labelText,
      this.icon,
      this.obSecure,
      this.suffixIcon,
      this.validator,
      super.key});

  dynamic title;
  dynamic node;
  String? hintText;
  String? labelText;
  dynamic icon;
  dynamic obSecure;
  dynamic suffixIcon;
  dynamic validator;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 2),
        child: TextFormField(
          style: const TextStyle(fontSize: 18),
          controller: title,
          obscureText: obSecure,
          focusNode: node,
          validator: validator,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: AllColors.welcomeColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: AllColors.welcomeColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.red.shade700)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.red.shade700)),
            contentPadding: const EdgeInsets.fromLTRB(0, 15, 10, 15),
            hintText: hintText,
            labelText: labelText,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(2),
              child: Icon(icon, size: 2.5),
            ),
            suffixIcon: suffixIcon,
          ),
        ));
  }
}
