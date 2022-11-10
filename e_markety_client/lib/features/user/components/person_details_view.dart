import 'package:e_markety_client/features/user/components/user_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/utils/mask_formatter_utils.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/filled_button.dart';
import '../auth/blocs/auth_bloc.dart';
import '../blocs/user_bloc.dart';
import '../models/user.dart';

class PersonDetailsFormView extends StatefulWidget {
  const PersonDetailsFormView({Key? key}) : super(key: key);

  @override
  State<PersonDetailsFormView> createState() => _PersonDetailsFormViewState();
}

class _PersonDetailsFormViewState extends State<PersonDetailsFormView> {
  final _personDetailsFormKey = GlobalKey<FormState>();
  late User _user;

  void _onNameSaved(String? name) => _user = _user.copyWith(name: name);

  void _onEmailSaved(String? email) => _user = _user.copyWith(email: email);

  void _onPhoneSaved(String? phone) => _user = _user.copyWith(phone: phone);

  void _onSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_personDetailsFormKey.currentState!.validate()) {
      _personDetailsFormKey.currentState!.save();
      Modular.get<UserBloc>().add(UserUpdateEvent(_user));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    if (state is AuthLogged) {
      _user = state.user;
    } else {
      _user = const User.empty();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Form(
        key: _personDetailsFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detalhes Pessoais',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            UserInfoContainer(
              text: _user.name,
              icon: Icons.person,
              label: 'Nome',
              onSaved: _onNameSaved,
              onValidate: Validatorless.required(Strings.obrigatorio),
            ),
            const SizedBox(height: 12),
            UserInfoContainer(
              text: _user.email,
              icon: Icons.email,
              label: 'Email',
              onSaved: _onEmailSaved,
              onValidate: Validatorless.multiple([
                Validatorless.required(Strings.obrigatorio),
                Validatorless.email(Strings.emailInvalido),
              ]),
            ),
            const SizedBox(height: 12),
            UserInfoContainer(
              text: _user.phone ?? '',
              icon: Icons.phone,
              label: 'Telefone',
              onSaved: _onPhoneSaved,
              onFieldSubmitted: (_) => _onSubmit(),
              inputFormatters: [MaskFormatterUtils.cellPhone],
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
