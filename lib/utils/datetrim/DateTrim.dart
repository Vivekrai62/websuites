/// Use `formatSaleTarget` to format an integer sale target with commas and a currency symbol.
/// Example: 100000 -> ₹1,00,000
library;

/// Use `formatShortDate` to format a date into "dd MMM, yyyy".
/// Example: "2024-02-22" -> "22 Feb, 2024"

/// Use `formatDateWithTime` to format a date string to include time in IST.
/// Example: "2023-10-17T11:02:00Z" -> "Oct 17, 2023, 4:32 PM"

/// Use `formatDate` to format a date string to show "Today" with time if the date is today,
/// otherwise show "MMM d, yyyy, h:mm a".
/// Example: "2024-02-22T11:02:00Z" -> "Today at 4:32 PM" or "Feb 22, 2024, 4:32 PM"

/// Use `formatElapsedTime` to format elapsed time in seconds into "HH : MM : SS".
/// Example: 3665 -> "01 : 01 : 05"

/// Use `formatDuration` to format a `Duration` object into "HH:MM:SS".
/// Example: Duration(hours: 1, minutes: 1, seconds: 5) -> "01:01:05"

/// Use `getCurrentTimeInIST` to get the current time in IST (hh:mm:ss format).
/// Example: "10:15:30 AM"

/// Use `formatDateToLongMonth` to format a date into "MMMM d, yyyy".
/// Example: "2024-06-25" -> "June 25, 2024"

/// Use `formatDateWithDay` to format a date into "EEE MMM d, yyyy".
/// Example: "2024-10-01" -> "Tue Oct 1, 2024"

/// Use `formatTimeDifference` to calculate the time difference between now and a start date.
/// Example: "2024-02-22T10:00:00Z" -> "0 hours 15 minutes 30 seconds"

/// Use `formatStartDateTime` to display "Today at h:mm a" if the date is today,
/// otherwise display "MMM d, yyyy at h:mm a".
/// Example: "2024-02-22T11:02:00Z" -> "Today at 4:32 PM" or "Feb 22, 2024 at 4:32 PM"

/// Use `formatTimeDuration` to calculate the time duration between two dates in "H:M:S".
/// Example: "2024-02-22T10:00:00Z", "2024-02-22T11:30:00Z" -> "1:30:0"

/// Use `formatDateWithCustomFormat` to format a date into "dd MMM, yyyy h:mm a".
/// Example: "2024-01-27T11:23:00Z" -> "27 Jan, 2024 05:53 PM"

/// Use `formatDateToYMD` to format a date into "yyyy-MM-dd".
/// Example: "2024-01-28" -> "2024-01-28"

/// Use `formatHoursMinutes` to format hours and minutes into "HH : MM : SS".
/// Example: 2.5 hours, 15 minutes -> "2 : 45 : 00"

import 'package:intl/intl.dart';

/// Formats an integer sale target with commas and a currency symbol (e.g., ₹1,00,000).
String formatSaleTarget(int? saleTarget) {
  if (saleTarget == null) return '₹0';
  return '₹${saleTarget.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
}

/// Formats a date to "dd MMM, yyyy" (e.g., 22 Feb, 2024).
String formatShortDate(String? date) {
  if (date == null || date.isEmpty) return 'N/A';

  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd MMM, yyyy').format(parsedDate);
  } catch (e) {
    return 'N/A';
  }
}

/// Formats a date string to include time (e.g., "Oct 17, 2023, 4:32 PM").
String formatDateWithTime(String? date) {
  if (date == null || date.isEmpty) return 'N/A';

  try {
    DateTime parsedDate = DateTime.parse(date);
    DateTime istDate =
        parsedDate.toUtc().add(const Duration(hours: 5, minutes: 30));
    return DateFormat('MMM d, yyyy, h:mm a').format(istDate);
  } catch (e) {
    return 'N/A';
  }
}

String formatDate(String? date) {
  if (date == null || date.isEmpty) return 'N/A';

  try {
    // Parse the date string into a DateTime object
    DateTime parsedDate = DateTime.parse(date);
    DateTime now = DateTime.now();

    // Adjust for IST (Indian Standard Time)
    DateTime istDate =
        parsedDate.toUtc().add(const Duration(hours: 5, minutes: 30));

    // Check if the date is today
    if (istDate.year == now.year &&
        istDate.month == now.month &&
        istDate.day == now.day) {
      return 'Today at ${DateFormat('h:mm a').format(istDate)}';
    } else {
      // Format for other dates
      return DateFormat('MMM d, yyyy, h:mm a').format(istDate);
    }
  } catch (e) {
    return 'N/A';
  }
}

/// Formats elapsed time as "HH : MM : SS".
String formatElapsedTime(int? seconds) {
  if (seconds == null || seconds <= 0) return '00 : 00 : 00';

  int hours = seconds ~/ 3600;
  int minutes = (seconds % 3600) ~/ 60;
  int remainingSeconds = seconds % 60;
  return '${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${remainingSeconds.toString().padLeft(2, '0')}';
}

/// Formats a `Duration` to "HH:MM:SS".
String formatDuration(Duration duration) {
  final hours = duration.inHours.toString().padLeft(2, '0');
  final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
  final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

/// Returns the current time in IST (hh:mm:ss format).
String getCurrentTimeInIST() {
  DateTime now =
      DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30));
  return DateFormat('hh:mm:ss a').format(now);
}

/// Formats a date to "MMMM d, yyyy" (e.g., "June 25, 2024").
String formatDateToLongMonth(String? date) {
  if (date == null || date.isEmpty) return 'N/A';

  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('MMMM d, yyyy').format(parsedDate);
  } catch (e) {
    return 'N/A';
  }
}

/// Formats a date to "dd/MM/yyyy" (e.g., "24/07/2024").
String formatDateToDDMMYYYY(String? date) {
  if (date == null || date.isEmpty) return 'N/A';

  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  } catch (e) {
    return 'N/A';
  }
}
//Oct 25, 2024

String formatDateToLongMonth2(DateTime? date) {
  if (date == null) return 'N/A';

  // Format the date as "Oct 25, 2024"
  return DateFormat('MMM dd, yyyy').format(date);
}

/// Formats a date to "EEE MMM d, yyyy" (e.g., "Tue Oct 1, 2024").
String formatDateWithDay(String? date) {
  if (date == null || date.isEmpty) return 'N/A';

  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('EEE MMM d, yyyy').format(parsedDate);
  } catch (e) {
    return 'N/A';
  }
}

/// Formats the time difference between now and a start date.
String formatTimeDifference(String startDate) {
  try {
    DateTime start = DateTime.parse(startDate);
    DateTime now = DateTime.now();
    Duration difference = now.difference(start);

    int hours = difference.inHours;
    int minutes = (difference.inMinutes % 60);
    int seconds = (difference.inSeconds % 60);

    return '$hours hours $minutes minutes $seconds seconds';
  } catch (e) {
    return 'Invalid date';
  }
}

String formatStartDateTime(String? date) {
  if (date == null || date.isEmpty) return 'N/A';

  try {
    DateTime parsedDate = DateTime.parse(date);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime dateToCheck =
        DateTime(parsedDate.year, parsedDate.month, parsedDate.day);

    if (dateToCheck == today) {
      return 'Today at ${DateFormat('h:mm a').format(parsedDate)}';
    } else {
      return DateFormat('MMM d, yyyy at h:mm a').format(parsedDate);
    }
  } catch (e) {
    return 'N/A';
  }
}

/// Formats the time duration between two dates.
String formatTimeDuration(String startDate, String stopDate) {
  try {
    DateTime start = DateTime.parse(startDate);
    DateTime stop = DateTime.parse(stopDate);
    Duration duration = stop.difference(start);

    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);

    return '$hours:$minutes:$seconds';
  } catch (e) {
    return 'Invalid date';
  }
}

/// Formats a date to "dd MMM, yyyy h:mm a" (e.g., "27 Jan, 2024 05:53 PM").
String formatDateWithCustomFormat(String? date) {
  if (date == null || date.isEmpty) return 'N/A';

  try {
    DateTime parsedDate = DateTime.parse(date);
    DateTime istDate =
        parsedDate.toUtc().add(const Duration(hours: 5, minutes: 30));
    return DateFormat('dd MMM, yyyy h:mm a').format(istDate);
  } catch (e) {
    return 'N/A';
  }
}

/// Formats a date to "yyyy-MM-dd" (e.g., "2024-01-28").
String formatDateToYMD(String? date) {
  if (date == null || date.isEmpty) return 'N/A';

  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  } catch (e) {
    return 'N/A';
  }
}

/// Formats hours and minutes into "HH : MM : SS".
String formatHoursMinutes(double hours, double minutes) {
  // Combine hours and minutes into total seconds.
  final totalSeconds = (hours * 3600) + (minutes * 60);
  final duration = Duration(seconds: totalSeconds.toInt());

  // Extract hours, minutes, and seconds.
  final formattedHours = duration.inHours.toString();
  final formattedMinutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
  final formattedSeconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

  // Return in "HH : MM : SS" format.
  return "$formattedHours : $formattedMinutes : $formattedSeconds";
}

String formatNumberWithK(double value) {
  if (value >= 1000) {
    return "${(value / 1000).toStringAsFixed(2)}K"; // Formats numbers in K (thousands)
  }
  return value
      .toStringAsFixed(0); // For numbers less than 1000, show as integer
}
