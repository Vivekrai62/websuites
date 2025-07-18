import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';
import '../../../../../utils/appColors/app_colors.dart';

// class CreateNewLeadScreenCard2 extends StatefulWidget {
//   final String hintText;
//   final List<String>? categories;
//   final Function(List<String>)? onCategoriesChanged;
//   final Function(String)? onCategoryChanged;
//   final TextEditingController? controller;
//   final bool isMultiSelect;
//   final bool isDateField; // New parameter to distinguish date fields
//   final bool allowCustomInput;
//   final bool isForDivisions;
//   final Function(String)? onChanged;
//   final bool isPincode;
//   final Function(String)? onSearch;
//   final bool isLoading;
//   final List<String>? filteredPincodeList;
//   final Icon? prefixIcon;
//   final Icon? suffixIcon;
//   final VoidCallback? onSuffixPressed;
//   final BorderRadius? allowCustomBorderInput; // Change type to BorderRadius?
//   final double? textFieldHeight;
//   final EdgeInsetsGeometry? textFieldPadding;
//   final double? containerHeight;
//   final EdgeInsetsGeometry? containerPadding;
//   final int? maxLines;
//   final TextInputType? keyboardType;
//   final bool isEditable;
//   final String? Function(String?)? validator;
//   final String? errorMessage;
//   final Color? borderColor; // Add this line
//   final bool hasError; // Add this line
//   final String? value; // Add this line to accept a value
//   final String? initialValue; // Add this parameter
//
//
//
//   const CreateNewLeadScreenCard2({
//
//     Key? key,
//     required this.hintText,
//     this.value, // Make this parameter optional
//     this.initialValue, // Add to constructor
//
//     this.categories,
//     this.onCategoriesChanged,
//     this.onCategoryChanged,
//     this.onChanged,
//     this.isDateField = false,
//     this.controller,
//     this.isMultiSelect = false,
//     this.allowCustomInput = false,
//     this.isForDivisions = false,
//     this.isPincode = false,
//     this.onSearch,
//     this.isLoading = false,
//     this.filteredPincodeList,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.onSuffixPressed,
//     this.allowCustomBorderInput, // Now accepts BorderRadius
//     this.hasError = false, // Default to false
//     this.textFieldHeight,
//     this.textFieldPadding,
//     this.containerHeight,
//     this.containerPadding,
//     this.maxLines,
//     this.keyboardType,
//     this.isEditable = true,
//     this.validator,
//     this.errorMessage,
//     this.borderColor, Future<void> Function()? onTap, // Add this line
//
//
//   }) : super(key: key);
//
//   @override
//   _CreateNewLeadScreenCard2State createState() =>
//       _CreateNewLeadScreenCard2State();
// }
//
// class _CreateNewLeadScreenCard2State extends State<CreateNewLeadScreenCard2> {
//   final FocusNode _focusNode = FocusNode();
//   String? _errorMessage;
//
//   bool _isFocused = false;
//   List<String> _selectedCategories = [];
//   bool _isDropdownVisible = false;
//   late TextEditingController _textController;
//   List<String> _filteredCategories = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _textController = widget.controller ?? TextEditingController();
//
//     // Handle initial selection
//     if (widget.initialValue != null) {
//       _textController.text = widget.initialValue!;
//       _selectedCategories = [widget.initialValue!];
//       // Notify parent of initial selection
//       widget.onCategoryChanged?.call(widget.initialValue!);
//     } else if (widget.value != null) {
//       _textController.text = widget.value!;
//     }
//
//     _focusNode.addListener(() {
//       setState(() {
//         _isFocused = _focusNode.hasFocus;
//       });
//     });
//     _filteredCategories = widget.categories ?? [];
//   }
//
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     if (widget.controller == null) {
//       _textController.dispose();
//     }
//     super.dispose();
//   }
//
//   void _toggleDropdownMenu() {
//     setState(() {
//       _isDropdownVisible = !_isDropdownVisible;
//     });
//   }
//
//   void _selectCategory(String category) {
//     setState(() {
//       if (widget.isMultiSelect) {
//         if (_selectedCategories.contains(category)) {
//           _selectedCategories.remove(category);
//         } else {
//           _selectedCategories.add(category);
//         }
//         widget.onCategoriesChanged?.call(_selectedCategories);
//       } else {
//         _selectedCategories = [category];
//         widget.onCategoryChanged?.call(category);
//       }
//       _updateTextController();
//       _isDropdownVisible = false;
//     });
//   }
//
//   void _updateTextController() {
//     if (!widget.isForDivisions) {
//       _textController.text = _selectedCategories.join(', ');
//     }
//   }
//
//   void _filterCategories(String query) {
//     if (query.isEmpty) {
//       setState(() {
//         _filteredCategories = widget.categories ?? [];
//       });
//     } else {
//       setState(() {
//         _filteredCategories = (widget.categories ?? [])
//             .where((category) =>
//             category.toLowerCase().contains(query.toLowerCase()))
//             .toList();
//       });
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime initialDate = DateTime.now();
//
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(

//           data: ThemeData.light().copyWith(
//             colorScheme: ColorScheme.light(
//               primary: AllColors.mediumPurple, // Header background color
//               onPrimary: Colors.white, // Header text color
//
//
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//         _textController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//       });
//     }
//   }
//
//   void _removeCategory(String category) {
//     setState(() {
//       _selectedCategories.remove(category);
//       _updateTextController();
//
//       if (widget.isMultiSelect) {
//         widget.onCategoriesChanged?.call(_selectedCategories);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           margin: const EdgeInsets.only(top: 5),
//           width: double.infinity,
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: widget.hasError ? Colors.red : (_isFocused ? (widget.borderColor ?? AllColors.mediumPurple) : (AllColors.lightGrey)),
//               width: _isFocused ? 1.0 : 0.3,
//             ),
//             color: AllColors.whiteColor,
//             borderRadius: widget.allowCustomBorderInput ?? BorderRadius.circular(22), // Corrected line
//           ),
//
//
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (widget.isForDivisions && _selectedCategories.isNotEmpty)
//                 Wrap(
//                   spacing: 4,
//                   runSpacing: 4,
//                   alignment: WrapAlignment.start,
//                   children: _selectedCategories.map((category) {
//                     return Chip(
//                       label: Text(
//                         category,
//                         style: const TextStyle(fontSize: 12, color: Colors.white),
//                       ),
//                       backgroundColor: AllColors.mediumPurple,
//                       deleteIcon: const Icon(Icons.close,
//                           size: 16, color: Colors.white),
//                       onDeleted: () => _removeCategory(category),
//                       visualDensity:
//                       const VisualDensity(horizontal: -4, vertical: -4),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * 0.02,
//                         vertical: MediaQuery.of(context).size.height * 0.005,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               if (widget.isForDivisions && _selectedCategories.isNotEmpty)
//                 const SizedBox(height: 8),
//               Row(
//                 children: [
//                   if (widget.prefixIcon != null)
//                     Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: widget.prefixIcon!,
//                     ),
//                   Expanded(
//                     child: TextField(
//                       controller: _textController,
//                       focusNode: _focusNode,
//                       decoration: InputDecoration(
//                         // suffixIcon: widget.suffixIcon != null
//                         //     ? IconButton(
//                         //   icon: Icon(Icons.close,color: Colors.grey,),
//                         //   onPressed: widget.onSuffixPressed,
//                         // )
//                         //     : null,
//                         hintText: widget.isDateField
//                             ? 'Select a date'
//
//
//
//                             : (widget.isForDivisions && _selectedCategories.isNotEmpty
//                             ? ''
//                             : widget.hintText),
//                         border: InputBorder.none,
//                         isDense: true,
//                         contentPadding: const EdgeInsets.symmetric(
//                           vertical: 2.0,
//                           horizontal: 9.0,
//                         ),
//                       ),
//                       readOnly: widget.isDateField,
//
//                       onTap: widget.isDateField ? () => _selectDate(context) : null,
//                       style: const TextStyle(fontSize: 14.0),
//                       // onChanged: (text) {
//                       //   _filterCategories(text);
//                       //   if (widget.allowCustomInput) {
//                       //     if (!widget.isMultiSelect) {
//                       //       widget.onCategoryChanged?.call(text);
//                       //     }
//                       //     if (widget.isPincode) {
//                       //       widget.onSearch?.call(text);
//                       //     }
//                       //   }
//                       // },
//
//                       // onChanged: (value) {
//                       //   if (widget.allowCustomInput) {
//                       //     _filterCategories(value);
//                       //   }
//                       //   widget.onChanged?.call(value);
//                       //
//                       //   if (widget.validator != null) {
//                       //     setState(() {
//                       //       _errorMessage = widget.validator!(value);
//                       //     });
//                       //   }
//                       // },
//
//                       onChanged: (value) {
//                         if (widget.allowCustomInput) {
//                           _filterCategories(value);
//                         }
//                         widget.onChanged?.call(value);
//
//                         if (widget.validator != null) {
//                           setState(() {
//                             _errorMessage = widget.validator!(value);
//                           });
//                         }
//                       },
//
//                     ),
//                   ),
//                   if (_selectedCategories.isNotEmpty && widget.isMultiSelect)
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedCategories.clear();
//                         });
//                       },
//                       child: const Icon(Icons.close, size: 16),
//                     ),
//                   if (widget.categories != null)
//                     GestureDetector(
//                       onTap: _toggleDropdownMenu,
//                       child: const Icon(Icons.arrow_drop_down_sharp),
//                     ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         if (_isDropdownVisible)
//           Column(
//             children: [
//               SizedBox(height: Get.height / 60),
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: AllColors.whiteColor,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 4,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: _filteredCategories.length,
//                         itemBuilder: (context, index) {
//                           final category = _filteredCategories[index];
//                           final isSelected = _selectedCategories.contains(category);
//
//                           return GestureDetector(
//                             onTap: () => _selectCategory(category),
//                             child: Container(
//                               height: 40,
//                               alignment: Alignment.centerLeft,
//                               decoration: BoxDecoration(
//                                 color: isSelected ? AllColors.minorPurple : Colors.transparent,
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 5),
//                                 child: Text(
//                                   category,
//                                   style: TextStyle(
//                                     color: isSelected ? AllColors.mediumPurple : AllColors.blackColor,
//                                     fontSize: 15,
//                                     fontFamily: FontFamily.sfPro,
//                                     fontWeight: FontWeight.w400
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         if (widget.isLoading)
//           const Center(
//             child: CircularProgressIndicator(),
//           ),
//         if (widget.filteredPincodeList != null && widget.filteredPincodeList!.isEmpty)
//           Center(
//             child: Text(
//               'No Results Found!',
//               style: TextStyle(
//                 color: Colors.redAccent,
//                 fontSize: MediaQuery.of(context).size.width * 0.04,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }



class CreateNewLeadScreenCard2 extends StatefulWidget {
  final String? initialValue; // Add this parameter
  final String hintText;
  final List<String>? categories;
  final Function(List<String>)? onCategoriesChanged;
  final Function(String)? onCategoryChanged;
  final TextEditingController? controller;
  final bool isMultiSelect;
  final bool isDateField; // New parameter to distinguish date fields
  final bool allowCustomInput;
  final bool isForDivisions;
  final Function(String)? onChanged;
  final bool isPincode;
  final Function(String)? onSearch;
  final bool isLoading;
  final List<String>? filteredPincodeList;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final VoidCallback? onSuffixPressed;
  final BorderRadius? allowCustomBorderInput; // Change type to BorderRadius?
  final double? textFieldHeight;
  final EdgeInsetsGeometry? textFieldPadding;
  final double? containerHeight;
  final EdgeInsetsGeometry? containerPadding;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool isEditable;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final Color? borderColor; // Add this line
  final bool hasError; // Add this line
  final String? value; // Add this line to accept a value
  final bool readOnly;

  final VoidCallback? onTap;
  const CreateNewLeadScreenCard2({
    super.key,
    required this.hintText,
    this.value, // Make this parameter optional
    this.initialValue, // Add to constructor
    this.onTap,
    this.readOnly = false,
    this.categories,
    this.onCategoriesChanged,
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
    this.allowCustomBorderInput, // Now accepts BorderRadius
    this.hasError = false, // Default to false
    this.textFieldHeight,
    this.textFieldPadding,
    this.containerHeight,
    this.containerPadding,
    this.maxLines,
    this.keyboardType,
    this.isEditable = true,
    this.validator,
    this.errorMessage,
    this.borderColor, // Add this line
  });

  @override
  _CreateNewLeadScreenCard2State createState() =>
      _CreateNewLeadScreenCard2State();
}

class _CreateNewLeadScreenCard2State extends State<CreateNewLeadScreenCard2> {
  final FocusNode _focusNode = FocusNode();
  String? _errorMessage;

  bool _isFocused = false;
  List<String> _selectedCategories = [];
  bool _isDropdownVisible = false;
  late TextEditingController _textController;
  List<String> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _textController = widget.controller ?? TextEditingController();
    if (widget.value != null) {
      _textController.text = widget.value!; // Set initial value if provided
    }
    if (widget.initialValue != null) {
      _textController.text = widget.initialValue!;
      _selectedCategories = [widget.initialValue!];
      widget.onCategoryChanged?.call(widget.initialValue!);
    } else if (widget.value != null) {
      _textController.text = widget.value!;
    }
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _filteredCategories = widget.categories ?? [];
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.controller == null) {
      _textController.dispose();
    }
    super.dispose();
  }

  void _toggleDropdownMenu() {
    setState(() {
      _isDropdownVisible = !_isDropdownVisible;
    });
  }

  void _selectCategory(String category) {
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
        _textController.text = category; // Preserve exact category text
        widget.onCategoryChanged?.call(category);
      }
      _updateTextController();
      _isDropdownVisible = false;
    });
  }

  void _updateTextController() {
    if (!widget.isForDivisions) {
      _textController.text = _selectedCategories.join(', ');
    }
  }

  void _filterCategories(String query) {
    if (!mounted || widget.categories == null) return;
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = widget.categories!;
      } else {
        // Case-insensitive comparison that preserves original case in results
        _filteredCategories = widget.categories!
            .where((category) => category.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
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

    if (pickedDate != null) {
      setState(() {
        _textController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _removeCategory(String category) {
    setState(() {
      _selectedCategories.remove(category);
      _updateTextController();
      if (widget.isMultiSelect) {
        widget.onCategoriesChanged?.call(_selectedCategories);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(top: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.hasError
                  ? Colors.red
                  : (_isFocused
                  ? (widget.borderColor ?? AllColors.mediumPurple)
                  : AllColors.lightGrey),
              width: _isFocused ? 1.0 : 0.3,
            ),
            color: AllColors.whiteColor,
            borderRadius: widget.allowCustomBorderInput ?? BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.isForDivisions && _selectedCategories.isNotEmpty)
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  alignment: WrapAlignment.start,
                  children: _selectedCategories.map((category) {
                    return Chip(
                      label: Text(
                        category,
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      backgroundColor: AllColors.mediumPurple,
                      deleteIcon: const Icon(Icons.close, size: 16, color: Colors.white),
                      onDeleted: () => _removeCategory(category),
                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02,
                        vertical: MediaQuery.of(context).size.height * 0.005,
                      ),
                    );
                  }).toList(),
                ),
              if (widget.isForDivisions && _selectedCategories.isNotEmpty)
                const SizedBox(height: 8),
              Row(
                children: [
                  if (widget.prefixIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: widget.prefixIcon!,
                    ),
                  Expanded(
                    child: SizedBox(
                      height: widget.textFieldHeight,
                      child: TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: widget.isDateField
                              ? 'Select a date'
                              : (widget.isForDivisions && _selectedCategories.isNotEmpty
                              ? ''
                              : widget.hintText),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: widget.textFieldPadding ??
                              const EdgeInsets.symmetric(vertical: 2.0, horizontal: 9.0),
                        ),
                        readOnly: widget.isDateField || widget.readOnly,
                        onTap: widget.isDateField ? () => _selectDate(context) : widget.onTap,
                        style: const TextStyle(fontSize: 14.0),
                        onChanged: (value) {
                          if (widget.allowCustomInput) {
                            _filterCategories(value);
                          }
                          widget.onChanged?.call(value); // Pass exact input
                          if (widget.validator != null) {
                            setState(() {
                              _errorMessage = widget.validator!(value);
                            });
                          }
                        },
                        maxLines: widget.maxLines ?? 1,
                      ),
                    ),
                  ),
                  if (_selectedCategories.isNotEmpty && widget.isMultiSelect)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategories.clear();
                          _textController.clear();
                        });
                      },
                      child: const Icon(Icons.close, size: 16),
                    ),
                  if (widget.categories != null)
                    GestureDetector(
                      onTap: _toggleDropdownMenu,
                      child: const Icon(Icons.arrow_drop_down_sharp),
                    ),
                ],
              ),
            ],
          ),
        ),
        if (_isDropdownVisible)
          Column(
            children: [
              SizedBox(height: Get.height / 80),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AllColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.only(top: 5),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _filteredCategories.length,
                        itemBuilder: (context, index) {
                          final category = _filteredCategories[index];
                          final isSelected = _selectedCategories.contains(category);
                          return GestureDetector(
                            onTap: () => _selectCategory(category),
                            child: Column(
                              children: [
                                Container(
                                  height: 40,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: isSelected ? AllColors.mediumPurple : Colors.transparent,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      category,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : AllColors.blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        if (widget.isLoading)
          const Center(child: CircularProgressIndicator()),
        if (widget.filteredPincodeList != null && widget.filteredPincodeList!.isEmpty)
          Center(
            child: Text(
              'No Results Found!',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
          ),
      ],
    );
  }
}
