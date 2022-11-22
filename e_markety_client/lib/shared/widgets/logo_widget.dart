import 'package:flutter/material.dart';

import '../theme/constants.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'E',
                  style: TextStyle(
                    fontSize: 40,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'MARKETY',
                  style: TextStyle(
                    fontSize: 36,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const Text('Seu Mercado Online', style: kHeadline6),
          ],
        ),
      ],
    );
  }
}
