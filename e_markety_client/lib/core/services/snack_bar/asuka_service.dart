import 'package:asuka/asuka.dart';
import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';

class AsukaService implements ISnackBarService {
  @override
  void show(String message) {
    AsukaSnackbar.message(message).show();
  }

  @override
  void showError(String message) {
    AsukaSnackbar.alert(message).show();
  }

  @override
  void showSuccess(String message) {
    AsukaSnackbar.success(message).show();
  }
}
