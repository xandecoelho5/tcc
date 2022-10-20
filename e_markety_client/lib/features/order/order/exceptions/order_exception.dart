import 'package:e_markety_client/core/exceptions/base_exception.dart';

class OrderException extends BaseException {
  OrderException(super.message, [super.stackTrace]);

  @override
  String toString() => 'OrderException: $message $stackTrace';
}
