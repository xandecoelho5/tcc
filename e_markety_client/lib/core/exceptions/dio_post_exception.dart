import 'package:e_markety_client/core/exceptions/base_exception.dart';

class DioPostException extends BaseException {
  DioPostException(super.message, super.stackTrace);

  @override
  String toString() => 'Erro ao cadastrar -> $message $stackTrace';
}
