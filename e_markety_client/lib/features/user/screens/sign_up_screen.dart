import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/features/user/blocs/user_bloc.dart';
import 'package:e_markety_client/shared/utils/strings.dart';
import 'package:e_markety_client/shared/widgets/custom_text_form_field.dart';
import 'package:e_markety_client/shared/widgets/filled_button.dart';
import 'package:e_markety_client/shared/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../auth/components/email_password_component.dart';
import '../auth/components/text_button_auth.dart';
import '../models/register_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context),
      resizeToAvoidBottomInset: false,
      body: BlocListener<UserBloc, UserState>(
        bloc: Modular.get<UserBloc>(),
        listener: (context, state) {
          if (state is UserSuccess) {
            Modular.get<ISnackBarService>().showSuccess(
              context,
              'Usuário criado com sucesso!',
            );
            Future.delayed(const Duration(seconds: 2), () {
              Modular.to.pushReplacementNamed('/');
            });
          }

          if (state is UserError) {
            Modular.get<ISnackBarService>().showError(context, state.message);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  child: Form(
                    key: _registerFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Criar uma nova conta',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Informe seus dados para criar a conta',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 40),
                        CustomTextFormField(
                          label: 'Nome',
                          validator: Validatorless.required(
                            Strings.campoObrigatorio,
                          ),
                          onSaved: _onNomeSaved,
                        ),
                        const SizedBox(height: 20),
                        EmailPasswordComponent(
                          onEmailSaved: _onEmailSaved,
                          onPasswordSaved: _onSenhaSaved,
                        ),
                        const SizedBox(height: 40),
                        FilledButton(
                          text: 'Registrar',
                          color: Theme.of(context).colorScheme.secondary,
                          onPressed: _register,
                        ),
                        const SizedBox(height: 32),
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
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomOutlinedButton(
                                text: 'Google',
                                color: kGoogleColor,
                                icon: Icons.sports_golf_outlined,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: CustomOutlinedButton(
                                text: 'Facebook',
                                color: kFacebookColor,
                                onPressed: () {},
                                icon: Icons.facebook,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Flexible(
                child: TextButtonAuth(
                  textLabel: 'Já possui uma conta?',
                  textButtonLabel: 'Entrar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
