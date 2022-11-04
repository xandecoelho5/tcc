import 'package:e_markety_client/core/exceptions/base_exception.dart';

class CompanyException extends BaseException {
  CompanyException(super.message) : super();

  @override
  String toString() => 'CompanyException: $message';
}
