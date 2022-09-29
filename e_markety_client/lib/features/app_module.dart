import 'package:e_markety_client/features/auth/screens/sign_in_screen.dart';
import 'package:e_markety_client/features/auth/screens/sign_up_screen.dart';
import 'package:e_markety_client/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../shared/theme/theme.dart';
import 'auth/screens/welcome_screen.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const WelcomeScreen()),
    ChildRoute(
      '/sign-up',
      child: (context, args) => const SignUpScreen(),
    ),
    ChildRoute(
      '/sign-in',
      child: (context, args) => const SignInScreen(),
    ),
    ChildRoute(
      '/home',
      child: (context, args) => const HomeScreen(),
    ),
  ];
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EMarkety',
      theme: kThemeData,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
      debugShowCheckedModeBanner: false,
    );
  }
}
