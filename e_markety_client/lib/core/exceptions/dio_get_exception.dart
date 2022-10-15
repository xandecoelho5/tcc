import 'package:e_markety_client/core/exceptions/base_exception.dart';

class DioGetException extends BaseException {
  DioGetException(super.message, [super.stackTrace]);

  @override
  String toString() => 'Erro ao buscar -> $message $stackTrace';
}
