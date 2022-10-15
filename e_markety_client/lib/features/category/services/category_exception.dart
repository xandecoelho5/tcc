import 'package:e_markety_client/core/exceptions/base_exception.dart';

class CategoryException extends BaseException {
  CategoryException(super.message, [super.stackTrace]);

  @override
  String toString() =>
      'CategoryException{message: $message, stackTrace: $stackTrace}';
}
