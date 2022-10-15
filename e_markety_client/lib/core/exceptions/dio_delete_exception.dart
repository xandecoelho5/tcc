import 'package:e_markety_client/core/exceptions/base_exception.dart';

class DioDeleteException extends BaseException {
  DioDeleteException(super.message, super.stackTrace);

  @override
  String toString() => 'Erro ao deletar -> $message $stackTrace';
}
