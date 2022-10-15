import 'package:flutter/material.dart';

abstract class ISnackBarService {
  void show(BuildContext context, String message);
  void showSuccess(BuildContext context, String message);
  void showError(BuildContext context, String message);
}
