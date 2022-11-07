import 'package:e_markety_client/core/exceptions/base_exception.dart';

class CurrentOrderException extends BaseException {
  CurrentOrderException(super.message);

  @override
  String toString() => message;
}
