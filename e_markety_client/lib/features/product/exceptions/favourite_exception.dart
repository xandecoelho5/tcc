import 'package:e_markety_client/core/exceptions/base_exception.dart';

class FavouriteException extends BaseException {
  FavouriteException(String message) : super(message);

  @override
  String toString() => 'FavouriteException: $message';
}
