import 'package:e_markety_client/features/user/components/user_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/filled_button.dart';
import '../blocs/user_bloc.dart';
import '../models/password.dart';

class SecurityFormView extends StatefulWidget {
  const SecurityFormView({Key? key}) : super(key: key);

  @override
  State<SecurityFormView> createState() => _SecurityFormViewState();
}

class _SecurityFormViewState extends State<SecurityFormView> {
  final _securityFormKey = GlobalKey<FormState>();
  late Password _password = Password();

  void _onCurrentPasswordChanged(String? password) =>
      _password = _password.copyWith(currentPassword: password);

  void _onNewPasswordChanged(String? password) =>
      _password = _password.copyWith(newPassword: password);

  void _onConfirmPasswordChanged(String? password) =>
      _password = _password.copyWith(confirmPassword: password);

  void _onSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_securityFormKey.currentState!.validate()) {
      _securityFormKey.currentState!.save();
      Modular.get<UserBloc>().add(UserUpdatePasswordEvent(_password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Form(
        key: _securityFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Segurança', style: kHeadline6),
            const SizedBox(height: 12),
            UserInfoContainer(
              icon: Icons.lock,
              label: 'Senha Atual',
              onChanged: _onCurrentPasswordChanged,
              onValidate: Validatorless.multiple([
                Validatorless.required(Strings.obrigatorio),
                Validatorless.min(6, Strings.senhaMinimo),
              ]),
            ),
            const SizedBox(height: 12),
            UserInfoContainer(
              icon: Icons.lock,
              label: 'Nova Senha',
              onChanged: _onNewPasswordChanged,
              onValidate: Validatorless.multiple([
                Validatorless.required(Strings.obrigatorio),
                Validatorless.min(6, Strings.senhaMinimo),
              ]),
            ),
            const SizedBox(height: 12),
            UserInfoContainer(
              icon: Icons.lock,
              label: 'Confirmar Senha',
              onChanged: _onConfirmPasswordChanged,
              onValidate: Validatorless.multiple([
                Validatorless.required(Strings.obrigatorio),
                Validatorless.min(6, Strings.senhaMinimo),
                (value) {
                  return value != _password.newPassword
                      ? Strings.senhaDiferente
                      : null;
                }
              ]),
              onFieldSubmitted: (_) => _onSubmit(),
            ),
            const SizedBox(height: 20),
            FilledButton(
              text: 'Salvar',
              color: kPrimaryColor,
              onPressed: _onSubmit,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
