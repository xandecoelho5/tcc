import 'package:flutter_modular/flutter_modular.dart';

import '../../features/user/auth/blocs/auth_bloc.dart';

class ModularUtils {
  ModularUtils._();

  static Future<void> signOut() async {
    Modular.get<AuthBloc>().add(AuthSignOutEvent());
    Future.delayed(const Duration(milliseconds: 10), () {
      Modular.to.navigate('/');
    });
  }
}
