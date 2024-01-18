import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String toDateTime(DateTime date) => _formatDateTime(date, 'yyyy-MM-dd HH:mm:ss');

  static String toDate(DateTime date) => _formatDateTime(date, 'yyyy-MM-dd');

  static String toTime(DateTime date) => _formatDateTime(date, 'HH:mm:ss');

  static String _formatDateTime(DateTime dateTime, String pattern) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(dateTime);
  }
}
