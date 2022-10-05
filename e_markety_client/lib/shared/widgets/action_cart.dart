import 'package:flutter/material.dart';

import '../theme/constants.dart';

class ActionCart extends StatelessWidget {
  const ActionCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      margin: const EdgeInsets.fromLTRB(0, 32, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kBackgroundColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          borderRadius: BorderRadius.circular(8),
          child: const Icon(
            Icons.camera_alt_outlined,
            color: kBasicDarkColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}
