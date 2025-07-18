

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:websuites/utils/reusable_validation/RequiredLabel.dart';
import 'package:websuites/views/leadScreens/createNewLead/widgets/createNewLeadCard/common_text_field.dart';


class FormFieldData {
  final String label;
  final String hintText;
  final bool isRequired;
  final List<String>? categories;

  FormFieldData({
    required this.label,
    required this.hintText,
    this.isRequired = false,
    this.categories,
  });
}




class SingleFormField extends StatelessWidget {
  final FormFieldData field;
  final String? value;
  final dynamic Function(List<String>)? onCategoriesChanged;
  final bool hasError;
  final dynamic Function(String)? onCategoryChanged;
  final dynamic Function(String)? onChanged;
  final bool isDateField;
  final TextEditingController? controller;
  final bool isMultiSelect;
  final bool allowCustomInput;
  final bool isForDivisions;
  final bool isPincode;
  final dynamic Function(String)? onSearch;
  final bool isLoading;
  final List<String>? filteredPincodeList;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final void Function()? onSuffixPressed;
  final BorderRadius? allowCustomBorderInput;
  final double? textFieldHeight;
  final EdgeInsetsGeometry? containerPadding;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool isEditable;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final Color? borderColor;
  final EdgeInsetsGeometry? textFieldPadding;
  final double? containerHeight;
  final List<TextInputFormatter>? inputFormatters;
  final bool readonly;
  final int? maxLength;

  const SingleFormField({
    super.key,
    required this.field,
    this.value,
    this.onCategoriesChanged,
    this.hasError = false,
    this.onCategoryChanged,
    this.onChanged,
    this.isDateField = false,
    this.controller,
    this.isMultiSelect = false,
    this.allowCustomInput = false,
    this.isForDivisions = false,
    this.isPincode = false,
    this.onSearch,
    this.isLoading = false,
    this.filteredPincodeList,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixPressed,
    this.allowCustomBorderInput,
    this.textFieldHeight,
    this.containerPadding,
    this.maxLines,
    this.keyboardType,
    this.isEditable = true,
    this.validator,
    this.errorMessage,
    this.borderColor,
    this.textFieldPadding,
    this.containerHeight,
    this.inputFormatters,
    this.readonly = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        field.isRequired
            ? Text("${field.label} *", style: TextStyle(fontWeight: FontWeight.bold))
            : Text(field.label, style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        CommonTextField(
          hintText: field.hintText,
          categories: field.categories ?? ["Option 1", "Option 2", "Option 3", "Option 4"],
          value: value,
          onCategoriesChanged: onCategoriesChanged,
          hasError: hasError,
          onCategoryChanged: onCategoryChanged,
          onChanged: onChanged,
          isDateField: isDateField,
          controller: controller,
          isMultiSelect: isMultiSelect,
          allowCustomInput: allowCustomInput,
          isForDivisions: isForDivisions,
          isPincode: isPincode,
          onSearch: onSearch,
          isLoading: isLoading,
          filteredPincodeList: filteredPincodeList,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          onSuffixPressed: onSuffixPressed,
          allowCustomBorderInput: allowCustomBorderInput,
          textFieldHeight: textFieldHeight,
          containerPadding: containerPadding,
          maxLines: maxLines,
          keyboardType: keyboardType,
          isEditable: isEditable,
          validator: validator,
          errorMessage: errorMessage,
          borderColor: borderColor,
          textFieldPadding: textFieldPadding,
          containerHeight: containerHeight,
          inputFormatters: inputFormatters,
          readonly: readonly,
          maxLength: maxLength,
        ),
      ],
    );
  }
}

class ResponsiveFieldsSection extends StatelessWidget {
  final String sectionTitle;
  final List<FormFieldData> fields;
  const ResponsiveFieldsSection({super.key, required this.sectionTitle, required this.fields});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: fields
              .map((field) => SizedBox(
            width: 250,
            child: SingleFormField(field: field),
          ))
              .toList(),
        ),
      ],
    );
  }
}
