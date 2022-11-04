import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskFormatterUtils {
  MaskFormatterUtils._();

  static TextInputFormatter get phone => MaskTextInputFormatter(
        mask: '(##) ####-####',
        filter: _numberFilter,
      );

  static TextInputFormatter get cellPhone => MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: _numberFilter,
      );

  static TextInputFormatter get time => MaskTextInputFormatter(
        mask: '##:##',
        filter: _numberFilter,
      );

  static TextInputFormatter get decimalNumber =>
      FilteringTextInputFormatter.allow(
        RegExp(r'^\d+\.?\d{0,2}'),
      );

  static Map<String, RegExp> get _numberFilter => {'#': RegExp('[0-9]')};
}
