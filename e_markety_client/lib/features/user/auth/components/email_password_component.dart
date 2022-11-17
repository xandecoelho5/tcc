import 'package:e_markety_client/features/admin/product/components/text_field_with_label.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../shared/utils/strings.dart';

class EmailPasswordComponent extends StatefulWidget {
  const EmailPasswordComponent({
    Key? key,
    this.onEmailSaved,
    this.onPasswordSaved,
  }) : super(key: key);

  final void Function(String?)? onEmailSaved;
  final void Function(String?)? onPasswordSaved;

  @override
  State<EmailPasswordComponent> createState() => _EmailPasswordComponentState();
}

class _EmailPasswordComponentState extends State<EmailPasswordComponent> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWithLabel(
          label: 'E-mail',
          onValidate: Validatorless.multiple([
            Validatorless.email(Strings.emailInvalido),
            Validatorless.required(Strings.obrigatorio),
          ]),
          onSaved: widget.onEmailSaved,
          fillColor: Colors.white,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 8),
        TextFieldWithLabel(
          label: 'Senha',
          obscureText: _obscureText,
          fillColor: Colors.white,
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onTapSuffix: () => setState(() => _obscureText = !_obscureText),
          onValidate: Validatorless.multiple([
            Validatorless.min(6, Strings.senhaMinimo),
            Validatorless.required(Strings.obrigatorio),
          ]),
          onSaved: widget.onPasswordSaved,
        ),
      ],
    );
  }
}
