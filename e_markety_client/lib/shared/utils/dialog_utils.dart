import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  DialogUtils._();

  static Future<bool> showDialog(
    String title,
    String contentText,
    Function() onConfirm,
  ) async {
    return await Asuka.showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(contentText),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
