import 'package:e_markety_client/shared/extensions/snack_bar_copy_with.dart';
import 'package:flutter/material.dart';

class BasicSnackBarService {
  final SnackBar _snackBar = const SnackBar(content: Text(''));

  void show(BuildContext context, String message) {
    _show(context, _snackBar.copyWith(content: Text(message)));
  }

  void showError(BuildContext context, String message) {
    _show(
      context,
      _snackBar.copyWith(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void showSuccess(BuildContext context, String message) {
    _show(
      context,
      _snackBar.copyWith(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void _show(BuildContext context, SnackBar snackbar) {
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
