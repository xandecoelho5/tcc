import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../shared/utils/strings.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';

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
        CustomTextFormField(
          label: 'E-mail',
          icon: true
              ? const Icon(Icons.check_circle_outline, color: kSecondaryColor)
              : const Icon(Icons.cancel_outlined, color: kPrimaryColor),
          validator: Validatorless.multiple([
            Validatorless.email(Strings.emailInvalido),
            Validatorless.required(Strings.campoObrigatorio),
          ]),
          onSaved: widget.onEmailSaved,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          obscureText: _obscureText,
          label: 'Senha',
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onTapSuffix: () => setState(() => _obscureText = !_obscureText),
          validator: Validatorless.multiple([
            Validatorless.min(6, 'Deve ter pelo menos 6 caracteres'),
            Validatorless.required(Strings.campoObrigatorio),
          ]),
          onSaved: widget.onPasswordSaved,
        ),
      ],
    );
  }
}
