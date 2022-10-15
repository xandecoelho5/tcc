import 'package:e_markety_client/shared/widgets/filled_button.dart';
import 'package:e_markety_client/shared/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.18),
              const LogoWidget(),
              const SizedBox(height: 80),
              FilledButton(
                text: 'Entrar',
                color: Theme.of(context).colorScheme.primary,
                onPressed: () => Modular.to.pushNamed('/sign-in'),
              ),
              const SizedBox(height: 24),
              FilledButton(
                text: 'Criar uma conta',
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () => Modular.to.pushNamed('/sign-up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
