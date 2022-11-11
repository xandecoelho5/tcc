import 'dart:async';

import 'package:e_markety_client/features/user/auth/blocs/auth_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/sign-in');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    return Modular.get<AuthBloc>().state is AuthLogged;
  }
}
