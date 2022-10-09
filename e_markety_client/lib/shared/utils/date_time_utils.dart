import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static String getFormattedDate(DateTime date) {
    return DateFormat.yMMMd('en_US').format(date);
  }
}
