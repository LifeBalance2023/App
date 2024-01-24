import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String toStringDateTime(DateTime date) => _formatDateTime(date, 'yyyy-MM-dd HH:mm:ss');

  static String toStringDateWithHours(DateTime date) => _formatDateTime(date, 'yyyy-MM-dd HH:mm');

  static String toStringDate(DateTime date) => _formatDateTime(date, 'yyyy-MM-dd');

  static String toStringTime(DateTime date) => _formatDateTime(date, 'HH:mm:ss');

  static String _formatDateTime(DateTime dateTime, String pattern) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(dateTime);
  }
}
