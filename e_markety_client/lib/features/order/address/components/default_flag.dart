import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';

class DefaultFlag extends StatelessWidget {
  const DefaultFlag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWeakSecondaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: const Text(
        'Padrão',
        style: TextStyle(
          fontSize: 13,
          color: kSecondaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
