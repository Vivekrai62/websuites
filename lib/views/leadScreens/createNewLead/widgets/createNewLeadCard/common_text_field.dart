import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';

class CommonTextField extends StatefulWidget {
  final String hintText;
  final List<String>? categories;
  final Function(List<String>)? onCategoriesChanged;
  final Function(String)? onCategoryChanged;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool isMultiSelect;
  final bool isDateField;
  final bool allowCustomInput;
  final bool isForDivisions;
  final bool isPincode;
  final Function(String)? onSearch;
  final bool isLoading;
  final List<String>? filteredPincodeList;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixPressed;
  final BorderRadius? allowCustomBorderInput;
  final double? textFieldHeight;
  final EdgeInsetsGeometry? textFieldPadding;
  final double? containerHeight;
  final EdgeInsetsGeometry? containerPadding;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool isEditable;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final Color? borderColor;
  final bool hasError;
  final String? value;
  final List<TextInputFormatter>? inputFormatters;
  final bool readonly;
  final int? maxLength;

  const CommonTextField({
    super.key,
    required this.hintText,
    this.categories,
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
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  List<String> _selectedCategories = [];
  bool _isDropdownVisible = false;
  late TextEditingController _textController;
  List<String> _filteredCategories = [];
  String? _errorMessage;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  static _CommonTextFieldState? _currentlyOpenDropdown;

  @override
  void initState() {
    super.initState();
    _textController = widget.controller ?? TextEditingController();
    _focusNode.addListener(_handleFocusChange);
    _filteredCategories = widget.categories ?? [];

    if (widget.value != null) {
      _textController.text = widget.value!;
    }
    _errorMessage = widget.errorMessage;

    _textController.addListener(_updateErrorMessage);
  }

  void _updateErrorMessage() {
    if (!mounted) return;
    setState(() {
      if (widget.validator != null) {
        _errorMessage = widget.validator!(_textController.text);
      } else {
        _errorMessage = widget.errorMessage;
      }
    });
  }

  @override
  void didUpdateWidget(CommonTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.categories != oldWidget.categories) {
      setState(() {
        _filteredCategories = widget.categories ?? [];
      });
      if (_overlayEntry != null && _isDropdownVisible) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _updateDropdownPosition();
        });
      }
    }
    if (widget.value != oldWidget.value && widget.value != null) {
      _textController.text = widget.value!;
    }
  }

  void _handleFocusChange() {
    if (!mounted) return;
    setState(() {
      _isFocused = _focusNode.hasFocus;
      if (_focusNode.hasFocus &&
          widget.categories != null &&
          widget.categories!.isNotEmpty &&
          widget.isEditable &&
          !widget.readonly) {
        _showDropdown();
      } else {
        _hideDropdown();
      }
    });
  }

  @override
  void dispose() {
    _hideDropdown();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _textController.removeListener(_updateErrorMessage);
    if (widget.controller == null) {
      _textController.dispose();
    }
    if (_currentlyOpenDropdown == this) {
      _currentlyOpenDropdown = null;
    }
    super.dispose();
  }

  void _toggleDropdownMenu() {
    if (!mounted || widget.readonly || widget.categories == null || widget.categories!.isEmpty) return;
    if (_isDropdownVisible) {
      _hideDropdown();
    } else {
      _showDropdown();
    }
  }

  void _selectCategory(String category) {
    if (!mounted) return;
    setState(() {
      if (widget.isMultiSelect) {
        if (_selectedCategories.contains(category)) {
          _selectedCategories.remove(category);
        } else {
          _selectedCategories.add(category);
        }
        widget.onCategoriesChanged?.call(_selectedCategories);
      } else {
        _selectedCategories = [category];
        _textController.text = category;
        widget.onCategoryChanged?.call(category);
        _hideDropdown();
      }
      _updateTextController();

      // Update dropdown position immediately after selection
      if (_isDropdownVisible && (widget.isForDivisions || widget.isMultiSelect)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _updateDropdownPosition();
        });
      }
    });
  }

  void _updateTextController() {
    if (!mounted || widget.isForDivisions) return;
    _textController.text = _selectedCategories.join(', ');
  }

  void _filterCategories(String query) {
    if (!mounted || widget.categories == null) return;
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = widget.categories!;
      } else {
        _filteredCategories = widget.categories!
            .where((category) => category.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
    if (_overlayEntry != null) {
      _updateOverlay();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AllColors.mediumPurple,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && mounted) {
      setState(() {
        _textController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        widget.onChanged?.call(_textController.text);
      });
    }
  }

  void _removeCategory(String category) {
    if (!mounted) return;
    setState(() {
      _selectedCategories.remove(category);
      _updateTextController();
      widget.onCategoriesChanged?.call(_selectedCategories);

      // Update dropdown position after removing category
      if (_isDropdownVisible && (widget.isForDivisions || widget.isMultiSelect)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _updateDropdownPosition();
        });
      }
    });
  }

  void _clearSelection() {
    if (!mounted) return;
    setState(() {
      _selectedCategories.clear();
      _textController.clear();
      widget.onCategoriesChanged?.call(_selectedCategories);
      if (widget.categories != null && widget.categories!.isNotEmpty && !widget.readonly) {
        _showDropdown();
        _focusNode.requestFocus();
      }
    });
  }

  Widget _buildChipsInFixedHeight() {
    return Container(
      height: 60, // Fixed height for chips area
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          spacing: 6,
          runSpacing: 4,
          children: _selectedCategories.map((category) {
            return Chip(
              label: Text(
                category,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              backgroundColor: AllColors.mediumPurple,
              deleteIcon: const Icon(Icons.close, size: 14, color: Colors.white),
              onDeleted: () {
                _removeCategory(category);
              },
              visualDensity: const VisualDensity(
                horizontal: -2,
                vertical: -2,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Calculate current container height dynamically
  double _getCurrentContainerHeight() {
    double baseHeight = 48; // Input field height
    if (widget.isForDivisions && _selectedCategories.isNotEmpty) {
      baseHeight += 60; // Add chips height
    }
    return baseHeight;
  }

  void _showDropdown() {
    if (!mounted || _overlayEntry != null || widget.categories == null || widget.categories!.isEmpty) {
      return;
    }

    // Close any existing dropdown
    if (_currentlyOpenDropdown != null && _currentlyOpenDropdown != this) {
      _currentlyOpenDropdown!._hideDropdown();
    }
    _currentlyOpenDropdown = this;

    _filteredCategories = widget.categories ?? [];
    _isDropdownVisible = true;

    _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _createOverlayEntry() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Size size = renderBox.size;

    // Always position dropdown below the entire textfield container
    double dropdownTopOffset = _getCurrentContainerHeight();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, dropdownTopOffset),
          child:
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Material(
              color: Colors.white,
              elevation: 0, // Remove Material elevation to rely solely on custom shadow
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxHeight: 200), // Limit dropdown height
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1), // Soft black with low opacity
                      blurRadius: 6,
                      spreadRadius: 1,
                      offset: Offset(0, 2), // Slight downward slope
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05), // Even softer shadow for depth
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: Offset(0, 4), // Deeper offset for follow effect
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: _filteredCategories.isEmpty
                    ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No options found'),
                )
                    : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _filteredCategories.map((category) {
                      final isSelected = _selectedCategories.contains(category);
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () => _selectCategory(category),
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              color: isSelected ? AllColors.microPurple : Colors.transparent,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected ? AllColors.mediumPurple : Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          )
        ),
      ),
    );
  }

  void _updateDropdownPosition() {
    if (!mounted || _overlayEntry == null || !_isDropdownVisible) return;

    // Remove old overlay
    _overlayEntry?.remove();

    // Create new overlay with updated position
    _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _updateOverlay() {
    if (!mounted || _overlayEntry == null) return;
    _overlayEntry!.markNeedsBuild();
  }

  void _hideDropdown() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    _isDropdownVisible = false;
    if (_currentlyOpenDropdown == this) {
      _currentlyOpenDropdown = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasChips = widget.isForDivisions && _selectedCategories.isNotEmpty;

    return GestureDetector(
      onTap: () {
        if (widget.categories != null &&
            widget.categories!.isNotEmpty &&
            widget.isEditable &&
            !widget.readonly) {
          _toggleDropdownMenu();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CompositedTransformTarget(
            link: _layerLink,
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.hasError || _errorMessage != null
                      ? Colors.red
                      : (_isFocused
                      ? (widget.borderColor ?? AllColors.mediumPurple)
                      : (widget.borderColor ?? AllColors.commonTextFiledColor)),
                  width: _isFocused ? 1.0 : 1,
                ),
                color: Colors.white,
                borderRadius: widget.allowCustomBorderInput ?? BorderRadius.circular(75),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fixed height chips section
                  if (hasChips) _buildChipsInFixedHeight(),

                  // Fixed height input section
                  Container(
                    height: 40, // here is height of my  text-field before 48
                    padding: widget.containerPadding ??
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.prefixIcon != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: widget.prefixIcon!,
                          ),
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            focusNode: _focusNode,
                            enabled: widget.isEditable,
                            inputFormatters: widget.inputFormatters,
                            maxLines: 1, // Force single line
                            maxLength: widget.maxLength,
                            keyboardType: widget.keyboardType,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: hasChips ? "Select" : widget.hintText,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: widget.textFieldPadding ??
                                  const EdgeInsets.symmetric(vertical: 8),
                              hintStyle: TextStyle(
                                color: AllColors.commonTextFiledColor,
                                fontFamily: FontFamily.sfPro,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                              counterText: "", // Hide character counter
                            ),
                            onChanged: (value) {
                              if (widget.allowCustomInput) {
                                _filterCategories(value);
                                widget.onChanged?.call(value);
                                _updateErrorMessage();
                              }

                              if (widget.onSearch != null) {
                                widget.onSearch!(value);
                              }
                            },
                            readOnly: widget.readonly || widget.isDateField || !widget.isEditable,
                            onTap: widget.isDateField
                                ? () => _selectDate(context)
                                : () {
                              if (widget.categories != null &&
                                  widget.categories!.isNotEmpty &&
                                  widget.isEditable &&
                                  !widget.readonly) {
                                _toggleDropdownMenu();
                              }
                            },
                          ),
                        ),
                        if (widget.suffixIcon != null)
                          GestureDetector(
                            onTap: widget.onSuffixPressed,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: widget.suffixIcon!,
                            ),
                          ),
                        if ((_textController.text.isNotEmpty || _selectedCategories.isNotEmpty) &&
                            widget.isEditable &&
                            !widget.readonly)
                          GestureDetector(
                            onTap: _clearSelection,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(Icons.close, color: Colors.black54, size: 18),
                            ),
                          ),
                        if (widget.categories != null &&
                            widget.categories!.isNotEmpty &&
                            widget.isEditable &&
                            !widget.readonly)
                          GestureDetector(
                            onTap: _toggleDropdownMenu,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(Icons.arrow_drop_down, color: Colors.black54),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_errorMessage != null && _errorMessage!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}