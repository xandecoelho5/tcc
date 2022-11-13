import 'package:asuka/asuka.dart';
import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/shared/extensions/snack_bar_copy_with.dart';

class AsukaService implements ISnackBarService {
  @override
  void show(String message) {
    AsukaSnackbar.message(message).show();
  }

  @override
  void showError(String message) {
    Asuka.showSnackBar(
      AsukaSnackbar.alert(message).copyWith(
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void showSuccess(String message) {
    Asuka.showSnackBar(
      AsukaSnackbar.success(message).copyWith(
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
