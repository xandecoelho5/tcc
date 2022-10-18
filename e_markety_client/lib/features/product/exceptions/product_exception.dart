import 'package:e_markety_client/core/exceptions/base_exception.dart';

class ProductException extends BaseException {
  ProductException(super.message, [super.stackTrace]);

  @override
  String toString() =>
      'ProductException{message: $message, stackTrace: $stackTrace}';
}
