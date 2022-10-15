import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:flutter/material.dart';

class BasicSnackBarService implements ISnackBarService {
  @override
  void show(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    _show(context, snackbar);
  }

  @override
  void showError(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    _show(context, snackbar);
  }

  @override
  void showSuccess(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    _show(context, snackbar);
  }

  void _show(BuildContext context, SnackBar snackbar) {
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
