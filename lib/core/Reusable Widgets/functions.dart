import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

String formatMonthYear(String monthYearString) {
  try {
    final parts = monthYearString.split('-');
    if (parts.length == 2) {
      final month = int.parse(parts[0]);
      final year = int.parse(parts[1]);
      return DateFormat('MMMM yyyy').format(DateTime(year, month));
    }
  } catch (e) {
    debugPrint('Error formatting month-year: $e');
  }
  return monthYearString;
}

String formatPaymentDate(String isoDate) {
  try {
    return DateFormat('d MMMM yyyy, hh:mm a').format(DateTime.parse(isoDate));
  } catch (e) {
    debugPrint('Error formatting payment date: $e');
    return isoDate;
  }
}
