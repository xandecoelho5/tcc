import 'package:flutter_modular/flutter_modular.dart';

import '../../features/user/auth/blocs/auth_bloc.dart';

class BlocUtils {
  BlocUtils._();

  static Future<void> signOut() async {
    Modular.get<AuthBloc>().add(AuthSignOutEvent());
    Future.delayed(const Duration(milliseconds: 500), () {
      Modular.to.navigate('/');
    });
  }
}
