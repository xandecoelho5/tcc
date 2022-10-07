import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class Accordion extends StatelessWidget {
  const Accordion({
    Key? key,
    required this.title,
    required this.content,
    this.titleColor,
  }) : super(key: key);

  final String title;
  final Widget content;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: titleColor ?? kBasicDarkColor,
          ),
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_down,
          color: kBasicDarkColor,
          size: 28,
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
        children: [
          content,
        ],
      ),
    );
  }
}
