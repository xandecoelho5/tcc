import 'package:flutter/material.dart';

import '../theme/constants.dart';

class TableContainer extends StatelessWidget {
  const TableContainer({
    Key? key,
    required this.title,
    this.child,
  }) : super(key: key);

  final String title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Colors.grey.shade50),
        boxShadow: kElevationToShadow[1],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(title, style: kHeadline6),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
