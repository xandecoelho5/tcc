import 'package:e_markety_client/features/product/models/flag_type.dart';
import 'package:flutter/material.dart';

class ProductFlagWidget extends StatelessWidget {
  const ProductFlagWidget.small({
    Key? key,
    required this.flagType,
    this.promotionPercentage,
    this.fontSize = 9,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
  }) : super(key: key);

  const ProductFlagWidget.big({
    Key? key,
    required this.flagType,
    this.promotionPercentage,
    this.fontSize = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  }) : super(key: key);

  final FlagType flagType;
  final int? promotionPercentage;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: flagType.backgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Text(
          flagType == FlagType.promotion
              ? '- $promotionPercentage%'
              : flagType.label,
          style: TextStyle(
            color: flagType.foregroundColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
