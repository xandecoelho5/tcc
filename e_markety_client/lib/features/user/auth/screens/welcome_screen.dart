import 'package:e_markety_client/shared/utils/strings.dart';
import 'package:e_markety_client/shared/widgets/filled_button.dart';
import 'package:e_markety_client/shared/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/services/cache/cache_service.dart';
import '../../../../shared/environment/platform.dart';
import '../blocs/auth_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    _tryToLogin();
  }

  Future<void> _tryToLogin() async {
    final token = await Modular.get<ICacheService>().get(Strings.token);
    if (token != null) {
      Modular.get<AuthBloc>().add(
        AuthGetCurrentUserEvent(
          onSuccessful: () {
            Modular.to.navigate(Modular.get<AppPlatform>().defaultRoute);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              const SizedBox(height: 16),
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
