import 'package:e_markety_client/core/exceptions/base_exception.dart';

class MeasureUnitException extends BaseException {
  MeasureUnitException(String message) : super(message);

  @override
  String toString() => 'MeasureUnitException: $message';
}
