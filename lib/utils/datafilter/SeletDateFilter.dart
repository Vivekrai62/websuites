import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../appColors/app_colors.dart';

// Enhanced DateRangeStorage class with better debugging and state management
class DateRangeStorage {
  static final Map<String, DateTime?> _startDates = {};
  static final Map<String, DateTime?> _endDates = {};
  static final Map<String, String> _selectedOptions =
      {}; // Track selected option for each filter

  static DateTime? getStartDate(String identifier) {
    return _startDates[identifier];
  }

  static DateTime? getEndDate(String identifier) {
    return _endDates[identifier];
  }

  static String? getSelectedOption(String identifier) {
    return _selectedOptions[identifier];
  }

  static void setDates(
      String identifier, DateTime? start, DateTime? end, String option) {
    _startDates[identifier] = start;
    _endDates[identifier] = end;
    _selectedOptions[identifier] = option;

    // Debug output to verify storage
    print('Stored for $identifier: Start: $start, End: $end, Option: $option');

    // Print all stored dates for debugging
    print('All stored dates:');
    _startDates.forEach((key, value) {
      print(
          '$key: Start: $value, End: ${_endDates[key]}, Option: ${_selectedOptions[key]}');
    });
  }

  static void clearAll() {
    _startDates.clear();
    _endDates.clear();
    _selectedOptions.clear();
  }
}

class SelectDate extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(DateTime?, DateTime?)? onDateRangeSelected;
  final String filterIdentifier;

  const SelectDate({
    super.key,
    required this.hintText,
    this.controller,
    this.onDateRangeSelected,
    required this.filterIdentifier,
  });

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate>
    with AutomaticKeepAliveClientMixin {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isDropdownVisible = false;
  late TextEditingController _textController;
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _focusedDay;
  String? _selectedOption;

  final List<String> _dateRangeOptions = [
    'Today',
    'Yesterday',
    'Last 7 Days',
    'Last 30 Days',
    'This Month',
    'Last Month',
    'Custom Range',
  ];

  @override
  bool get wantKeepAlive =>
      true; // Keep state when switching between tabs/filters

  @override
  void initState() {
    super.initState();
    _textController = widget.controller ?? TextEditingController();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _focusedDay = DateTime.now();

    // Initialize state based on stored values for this specific filter
    _loadStoredDates();
  }

  void _loadStoredDates() {
    print('Loading stored dates for ${widget.filterIdentifier}');

    // Check if we have stored dates for this specific filter identifier
    final storedStartDate =
        DateRangeStorage.getStartDate(widget.filterIdentifier);
    final storedOption =
        DateRangeStorage.getSelectedOption(widget.filterIdentifier);

    if (storedStartDate != null) {
      setState(() {
        _startDate = storedStartDate;
        _endDate = DateRangeStorage.getEndDate(widget.filterIdentifier);
        _selectedOption = storedOption;
        _updateTextFieldValue();
      });
      print(
          'Loaded dates for ${widget.filterIdentifier}: $_startDate to $_endDate, option: $_selectedOption');
    } else {
      // Only set default date for this specific filter if no dates are stored
      print('No stored dates for ${widget.filterIdentifier}, setting default');
      _selectDateRange('Today');
    }
  }

  @override
  void didUpdateWidget(SelectDate oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the filter identifier changes, reload the stored dates
    if (oldWidget.filterIdentifier != widget.filterIdentifier) {
      _loadStoredDates();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.controller == null) {
      _textController.dispose();
    }
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() {
      _isDropdownVisible = !_isDropdownVisible;
    });
  }

  void _selectDateRange(String option) {
    DateTime now = DateTime.now();

    setState(() {
      _selectedOption = option;
      switch (option) {
        case 'Today':
          _startDate = _endDate = now;
          break;
        case 'Yesterday':
          _startDate = _endDate = now.subtract(const Duration(days: 1));
          break;
        case 'Last 7 Days':
          _endDate = now;
          _startDate = now.subtract(const Duration(days: 6));
          break;
        case 'Last 30 Days':
          _endDate = now;
          _startDate = now.subtract(const Duration(days: 29));
          break;
        case 'This Month':
          _startDate = DateTime(now.year, now.month, 1);
          _endDate = DateTime(now.year, now.month + 1, 0);
          break;
        case 'Last Month':
          _startDate = DateTime(now.year, now.month - 1, 1);
          _endDate = DateTime(now.year, now.month, 0);
          break;
        case 'Custom Range':
          // Just set the selected option without changing dates
          return;
      }

      // Store dates specifically for this filter identifier
      DateRangeStorage.setDates(
          widget.filterIdentifier, _startDate, _endDate, option);

      _updateTextFieldValue();
      if (option != 'Custom Range') {
        _isDropdownVisible = false;
        widget.onDateRangeSelected?.call(_startDate, _endDate);
      }
    });
  }

  void _updateTextFieldValue() {
    if (_startDate != null && _endDate != null) {
      String startDateStr = DateFormat('yyyy-MM-dd').format(_startDate!);
      String endDateStr = DateFormat('yyyy-MM-dd').format(_endDate!);

      _textController.text = _startDate == _endDate
          ? startDateStr
          : '$startDateStr to $endDateStr';
    } else {
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the filter identifier for debugging (can be removed in production)

          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _isFocused ? Colors.blue : Colors.grey,
                  width: _isFocused ? 1.0 : 0.3,
                ),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : AllColors.whiteColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _toggleDropdown,
                    child: AbsorbPointer(
                      child: TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 3),
                          prefixIcon:  Icon(Icons.calendar_today_outlined,color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : AllColors.blackColor,),
                        ),
                        style:  TextStyle(fontSize: 14,color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : AllColors.blackColor,),
                      ),
                    ),
                  ),
                  if (_isDropdownVisible) ...[
                    Column(
                      children: _dateRangeOptions.map((option) {
                        final isSelected = option == _selectedOption;
                        return InkWell(
                          onTap: () => _selectDateRange(option),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            color: isSelected
                                ? AllColors.mediumPurple
                                : Colors.transparent,
                            child: Text(
                              option,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : (isSelected ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    if (_selectedOption == 'Custom Range')
                      TableCalendar(
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2100),
                        focusedDay: _focusedDay ?? DateTime.now(),
                        calendarFormat: CalendarFormat.month,
                        rangeSelectionMode: RangeSelectionMode.toggledOn,
                        selectedDayPredicate: (day) =>
                            day == _startDate || day == _endDate,
                        rangeStartDay: _startDate,
                        rangeEndDay: _endDate,
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          todayDecoration: BoxDecoration(
                            color: AllColors.mediumPurple,
                            shape: BoxShape.circle,
                          ),

                          selectedDecoration: BoxDecoration(
                            color: AllColors.mediumPurple,
                            shape: BoxShape.circle,
                          ),
                          weekendTextStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : AllColors.grey,),
                          rangeHighlightColor: AllColors.lightPurple,
                          defaultDecoration:  BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[800]
                                : AllColors.whiteColor,

                          ),
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _focusedDay = focusedDay;
                            _startDate = _endDate = selectedDay;

                            // Store dates for this specific filter
                            DateRangeStorage.setDates(widget.filterIdentifier,
                                _startDate, _endDate, 'Custom Range');

                            _updateTextFieldValue();
                            widget.onDateRangeSelected
                                ?.call(_startDate, _endDate);
                          });
                        },
                        onRangeSelected: (start, end, focusedDay) {
                          setState(() {
                            _startDate = start;
                            _endDate = end;
                            _focusedDay = focusedDay;
                            if (_startDate != null && _endDate != null) {
                              // Store dates for this specific filter
                              DateRangeStorage.setDates(widget.filterIdentifier,
                                  _startDate, _endDate, 'Custom Range');

                              _updateTextFieldValue();
                              _isDropdownVisible = false;
                              widget.onDateRangeSelected
                                  ?.call(_startDate, _endDate);
                            }
                          });
                        },
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
