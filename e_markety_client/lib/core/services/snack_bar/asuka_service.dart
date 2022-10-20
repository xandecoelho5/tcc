import 'package:asuka/asuka.dart';
import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:flutter/material.dart';

class AsukaService implements ISnackBarService {
  @override
  void show(BuildContext context, String message) {
    AsukaSnackbar.message(message).show();
  }

  @override
  void showError(BuildContext context, String message) {
    AsukaSnackbar.alert(message).show();
  }

  @override
  void showSuccess(BuildContext context, String message) {
    AsukaSnackbar.success(message).show();
  }
}
