import 'package:e_markety_client/core/exceptions/base_exception.dart';

class DistrictException extends BaseException {
  DistrictException(String message) : super(message);

  @override
  String toString() => 'DistrictException: $message';
}
