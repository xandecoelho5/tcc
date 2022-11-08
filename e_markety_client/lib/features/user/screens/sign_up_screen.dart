import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/features/user/blocs/user_bloc.dart';
import 'package:e_markety_client/shared/utils/strings.dart';
import 'package:e_markety_client/shared/widgets/filled_button.dart';
import 'package:e_markety_client/shared/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../admin/product/components/text_field_with_label.dart';
import '../auth/components/email_password_component.dart';
import '../auth/components/text_button_auth.dart';
import '../models/register_model.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, showAction: false),
      resizeToAvoidBottomInset: false,
      body: BlocListener<UserBloc, UserState>(
        bloc: Modular.get<UserBloc>(),
        listener: (context, state) {
          if (state is UserSuccess) {
            Modular.get<ISnackBarService>().showSuccess(
              context,
              'Usuário registrado com sucesso!',
            );
            Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
          }

          if (state is UserError) {
            Modular.get<ISnackBarService>().showError(context, state.message);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              flex: 10,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: _SignUpForm(),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextButtonAuth(
                  textLabel: 'Já possui uma conta?',
                  textButtonLabel: 'Entrar',
                  onPressed: () => Modular.to.pushNamed('/sign-in'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm({Key? key}) : super(key: key);

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final _registerFormKey = GlobalKey<FormState>();

  RegisterModel user = const RegisterModel(name: '', email: '', password: '');

  Future<void> _register() async {
    if (_registerFormKey.currentState!.validate()) {
      _registerFormKey.currentState!.save();
      Modular.get<UserBloc>().add(UserRegisterEvent(user));
    }
  }

  void _onNomeSaved(String? value) => user = user.copyWith(name: value);

  void _onEmailSaved(String? value) => user = user.copyWith(email: value);

  void _onSenhaSaved(String? value) => user = user.copyWith(password: value);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        children: [
          const Text(
            'Criar uma nova conta',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextFieldWithLabel(
            label: 'Nome',
            onValidate: Validatorless.required(
              Strings.obrigatorio,
            ),
            onSaved: _onNomeSaved,
            fillColor: Colors.white,
          ),
          const SizedBox(height: 12),
          EmailPasswordComponent(
            onEmailSaved: _onEmailSaved,
            onPasswordSaved: _onSenhaSaved,
          ),
          const SizedBox(height: 28),
          FilledButton(
            text: 'Registrar',
            color: Theme.of(context).colorScheme.secondary,
            onPressed: _register,
            height: 50,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Ou se registre com',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  text: 'Google',
                  color: kGoogleColor,
                  icon: Icons.sports_golf_outlined,
                  height: 40,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomOutlinedButton(
                  text: 'Facebook',
                  color: kFacebookColor,
                  icon: Icons.facebook,
                  height: 40,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
