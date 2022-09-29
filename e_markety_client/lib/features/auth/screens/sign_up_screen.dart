import 'package:e_markety_client/features/auth/components/email_password_component.dart';
import 'package:e_markety_client/features/auth/components/text_button_auth.dart';
import 'package:e_markety_client/shared/widgets/custom_text_form_field.dart';
import 'package:e_markety_client/shared/widgets/filled_button.dart';
import 'package:e_markety_client/shared/widgets/outlined_button.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/custom_app_bar.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              const Text(
                'Informe seus dados para criar a conta',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 40),
              const CustomTextFormField(label: 'Nome'),
              const SizedBox(height: 20),
              const EmailPasswordComponent(),
              const SizedBox(height: 56),
              FilledButton(
                text: 'Registrar',
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {},
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Ou se registre com',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
                      color: Theme.of(context).colorScheme.primary,
                      icon: Icons.sports_golf_outlined,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: CustomOutlinedButton(
                      text: 'Facebook',
                      color: const Color(0xFF3C5899),
                      onPressed: () {},
                      icon: Icons.facebook,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              const TextButtonAuth(
                textLabel: 'Já possui uma conta?',
                textButtonLabel: 'Entrar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
