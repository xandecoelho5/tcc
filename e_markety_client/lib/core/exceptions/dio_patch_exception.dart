import 'package:e_markety_client/core/exceptions/base_exception.dart';

class DioPatchException extends BaseException {
  DioPatchException(super.message, super.stackTrace);

  @override
  String toString() => 'Erro ao atualizar -> $message $stackTrace';
}
