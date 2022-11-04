import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWithLabel extends StatefulWidget {
  const TextFieldWithLabel({
    Key? key,
    required this.label,
    this.fieldName,
    this.onFocusLost,
    this.onValidate,
    this.onSaved,
    this.onCustomSaved,
    this.data,
    this.inputFormatters,
    this.readOnly = false,
  }) : super(key: key);

  final String label;
  final String? fieldName;
  final void Function(String)? onFocusLost;
  final String? Function(String?)? onValidate;
  final void Function(String?)? onSaved;
  final void Function(String?, String?)? onCustomSaved;
  final String? data;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;

  @override
  State<TextFieldWithLabel> createState() => _TextFieldWithLabelState();
}

class _TextFieldWithLabelState extends State<TextFieldWithLabel> {
  final _focus = FocusNode();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final data = widget.data ?? '';
    if (widget.inputFormatters != null) {
      _controller.value = widget.inputFormatters![0].formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(text: data),
      );
    } else {
      _controller.text = data;
    }

    _focus.addListener(() {
      if (!_focus.hasFocus) {
        widget.onFocusLost?.call(_controller.text);
      }
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  //TODO usar regex para validar url, e se for url, fazer o request e verificar se é valido
  //TODO usar regex para validar telefone
  //TODO usar regex para validar horario
  //TODO validar todos os campos tanto de empresa quanto de produto
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label.toUpperCase(), style: kLabelStyle),
        const SizedBox(height: 8),
        TextFormField(
          controller: _controller,
          focusNode: _focus,
          decoration: kTextInputDecoration,
          validator: widget.onValidate,
          onSaved: (value) {
            if (widget.onSaved != null) {
              widget.onSaved!.call(value);
            } else if (widget.onCustomSaved != null) {
              widget.onCustomSaved!.call(widget.fieldName, value);
            }
          },
          inputFormatters: widget.inputFormatters,
          readOnly: widget.readOnly,
        ),
      ],
    );
  }
}
