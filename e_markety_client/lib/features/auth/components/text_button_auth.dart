import 'package:flutter/material.dart';

import '../../../shared/theme/constants.dart';

class TextButtonAuth extends StatelessWidget {
  const TextButtonAuth({
    Key? key,
    required this.textLabel,
    required this.textButtonLabel,
  }) : super(key: key);

  final String textLabel;
  final String textButtonLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textLabel,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: kBasicDarkColor),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            textButtonLabel,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
