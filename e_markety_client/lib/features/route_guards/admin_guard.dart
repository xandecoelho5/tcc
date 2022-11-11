import 'dart:async';

import 'package:e_markety_client/features/user/auth/blocs/auth_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AdminGuard extends RouteGuard {
  AdminGuard() : super(redirectTo: '/home/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    final state = Modular.get<AuthBloc>().state;
    if (state is AuthLogged) {
      return state.user.isAdmin;
    }
    return false;
  }
}
