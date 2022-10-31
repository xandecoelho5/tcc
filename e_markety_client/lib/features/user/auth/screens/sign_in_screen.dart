import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/features/user/auth/blocs/auth_bloc.dart';
import 'package:e_markety_client/shared/environment/platform.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:e_markety_client/shared/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/widgets/filled_button.dart';
import '../components/email_password_component.dart';
import '../components/text_button_auth.dart';
import '../models/login_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  LoginModel login = const LoginModel(login: '', password: '');

  Future<void> _signIn() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      Modular.get<AuthBloc>().add(AuthSignInEvent(login));
    }
  }

  void _onEmailSaved(String? value) => login = login.copyWith(login: value);

  void _onSenhaSaved(String? value) => login = login.copyWith(password: value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.buildAppBar(context),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: Modular.get<AuthBloc>(),
        listener: (context, state) {
          if (state is AuthLogged) {
            Modular.to.navigate(Modular.get<AppPlatform>().defaultRoute);
          }
          if (state is AuthError) {
            Modular.get<ISnackBarService>().showError(context, state.message);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.055,
                      ),
                      const LogoWidget(),
                      const SizedBox(height: 60),
                      EmailPasswordComponent(
                        onEmailSaved: _onEmailSaved,
                        onPasswordSaved: _onSenhaSaved,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Esqueci minha senha',
                              style: TextStyle(
                                color: kBasicDarkColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      FilledButton(
                        text: 'Entrar',
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: _signIn,
                      ),
                    ],
                  ),
                ),
                TextButtonAuth(
                  textLabel: 'Não tem uma conta?',
                  textButtonLabel: 'Cadastre-se',
                  onPressed: () => Modular.to.navigate('/sign-up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
