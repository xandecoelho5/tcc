import 'package:flutter_modular/flutter_modular.dart';

import '../../core/services/snack_bar/snackbar_service.dart';
import '../../features/user/auth/blocs/auth_bloc.dart';

class ModularUtils {
  ModularUtils._();

  static Future<void> signOut() async {
    Modular.get<AuthBloc>().add(AuthSignOutEvent());
    Future.delayed(const Duration(milliseconds: 10), () {
      Modular.to.navigate('/');
    });
  }

  static void showSnackbar(String message) {
    Modular.get<ISnackBarService>().show(message);
  }

  static void showError(String message) {
    Modular.get<ISnackBarService>().showError(message);
  }

  static void showSuccess(String message) {
    Modular.get<ISnackBarService>().showSuccess(message);
  }
}
