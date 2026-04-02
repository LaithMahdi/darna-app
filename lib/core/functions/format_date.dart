import 'package:intl/intl.dart';

class FormatDate {
  FormatDate._();

  static final String _dayMonthYear = 'd MMMM yyyy';

  static String formatToDayMonthYear(DateTime date) =>
      DateFormat(_dayMonthYear).format(date);

  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return 'just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m';
    if (difference.inHours < 24) return '${difference.inHours}h';
    if (difference.inDays == 1) return 'yesterday';
    if (difference.inDays < 7) return '${difference.inDays}d';
    return '${dateTime.month}/${dateTime.day}';
  }
}
