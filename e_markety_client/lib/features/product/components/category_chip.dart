import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip.small({
    Key? key,
    required this.label,
    required this.color,
    this.fontSize = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  }) : super(key: key);

  const CategoryChip.big({
    Key? key,
    required this.label,
    required this.color,
    this.fontSize = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  }) : super(key: key);

  final String label;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        // color: Colors.grey.withOpacity(0.15),
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: kBasicDarkColor.withOpacity(0.8),
        ),
      ),
    );
  }
}
