import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';

class DefaultFlag extends StatelessWidget {
  const DefaultFlag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWeakSecondaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Text(
        'Padrão',
        style: kLabelLarge.copyWith(color: kSecondaryColor),
      ),
    );
  }
}
