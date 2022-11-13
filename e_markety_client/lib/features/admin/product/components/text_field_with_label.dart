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
    this.onChanged,
    this.data,
    this.inputFormatters,
    this.readOnly = false,
    this.fillColor,
    this.obscureText = false,
    this.icon,
    this.onTapSuffix,
    this.maxLines = 1,
  }) : super(key: key);

  final String label;
  final String? fieldName;
  final void Function(String)? onFocusLost;
  final String? Function(String?)? onValidate;
  final void Function(String?)? onSaved;
  final void Function(String?, String?)? onCustomSaved;
  final void Function(String)? onChanged;
  final String? data;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final Color? fillColor;
  final bool obscureText;
  final Icon? icon;
  final void Function()? onTapSuffix;
  final int maxLines;

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
  //TODO validar todos os campos tanto de empresa quanto de produto
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label.toUpperCase(), style: kLabelStyle),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: widget.obscureText,
          obscuringCharacter: '*',
          controller: _controller,
          focusNode: _focus,
          decoration: kTextInputDecoration.copyWith(
            filled: widget.fillColor != null,
            fillColor: widget.fillColor,
            suffixIcon: widget.icon != null
                ? InkWell(
                    onTap: widget.onTapSuffix,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: widget.icon,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: widget.maxLines > 1 ? 20 : 0,
            ),
          ),
          validator: widget.onValidate,
          onSaved: (value) {
            if (widget.onSaved != null) {
              widget.onSaved!.call(value);
            } else if (widget.onCustomSaved != null) {
              widget.onCustomSaved!.call(widget.fieldName, value);
            }
          },
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters,
          readOnly: widget.readOnly,
          onEditingComplete: _focus.unfocus,
          maxLines: widget.maxLines,
        ),
      ],
    );
  }
}
