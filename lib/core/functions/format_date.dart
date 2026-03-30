import 'package:intl/intl.dart';

class FormatDate {
  FormatDate._();

  static final String _dayMonthYear = 'd MMMM yyyy';

  static String formatToDayMonthYear(DateTime date) =>
      DateFormat(_dayMonthYear).format(date);
}
