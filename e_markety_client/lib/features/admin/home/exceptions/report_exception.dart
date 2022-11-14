import 'package:e_markety_client/core/exceptions/base_exception.dart';

class ReportException extends BaseException {
  ReportException(super.message);

  @override
  String toString() {
    return 'ReportException: $message';
  }
}
