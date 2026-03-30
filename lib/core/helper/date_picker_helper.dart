import 'package:flutter/material.dart';
import '../functions/format_date.dart';

class DatePickerHelper {
  DatePickerHelper._();

  static Future<String?> showDatePickerDialog(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        return FormatDate.formatToDayMonthYear(selectedDate);
      }
      return null;
    });
  }
}
