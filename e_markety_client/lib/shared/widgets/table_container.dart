import 'package:flutter/material.dart';

class TableContainer extends StatelessWidget {
  const TableContainer({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Colors.grey.shade50),
        boxShadow: kElevationToShadow[1],
      ),
      child: child,
    );
  }
}
