import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static const String _locale = 'pt_BR';

  static String getAbbrMonth(DateTime date) {
    initializeDateFormatting(_locale);
    return DateFormat.yMMMd(_locale).format(date);
  }

  static String getyMd(DateTime date) {
    initializeDateFormatting(_locale);
    return DateFormat.yMd(_locale).format(date);
  }

  static DateTime fromHourString(String value) {
    final timeParts = value.split(':');
    final today = DateTime.now();
    return DateTime(
      today.year,
      today.month,
      today.day,
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
  }
}
