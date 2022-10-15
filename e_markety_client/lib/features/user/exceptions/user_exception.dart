import 'package:e_markety_client/core/exceptions/base_exception.dart';

class UserException extends BaseException {
  UserException(super.message, [super.stackTrace]);

  @override
  String toString() => 'UserException: $message $stackTrace';
}
