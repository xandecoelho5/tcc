import 'package:e_markety_client/core/exceptions/base_exception.dart';

class AddressException extends BaseException {
  AddressException(super.message, [super.stackTrace]);

  @override
  String toString() => 'AddressException: $message $stackTrace';
}
