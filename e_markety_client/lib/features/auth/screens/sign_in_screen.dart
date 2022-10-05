import 'package:e_markety_client/features/auth/components/text_button_auth.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:e_markety_client/shared/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/widgets/filled_button.dart';
import '../components/email_password_component.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.055),
                  const LogoWidget(),
                  const SizedBox(height: 60),
                  const EmailPasswordComponent(),
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
                    text: 'Sign In',
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {},
                  ),
                ],
              ),
              const TextButtonAuth(
                textLabel: 'Não tem uma conta?',
                textButtonLabel: 'Cadastre-se',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
