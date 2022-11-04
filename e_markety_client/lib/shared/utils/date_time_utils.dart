import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static const String _locale = 'pt_BR';

  DateTimeUtils._() {
    initializeDateFormatting(_locale);
  }

  static String getAbbrMonth(DateTime date) {
    return DateFormat.yMMMd(_locale).format(date);
  }

  static String getyMd(DateTime date) {
    return DateFormat.yMd(_locale).format(date);
  }
}
