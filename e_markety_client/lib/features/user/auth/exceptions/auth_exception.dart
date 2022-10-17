import 'package:e_markety_client/core/exceptions/base_exception.dart';

class AuthException extends BaseException {
  AuthException(super.message, [super.stackTrace]);

  @override
  String toString() => 'AuthException: $message';
}
