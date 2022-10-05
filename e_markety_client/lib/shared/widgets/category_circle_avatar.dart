import 'package:e_markety_client/features/category/models/category.dart';
import 'package:flutter/material.dart';

class CategoryCircleAvatar extends StatelessWidget {
  const CategoryCircleAvatar({
    Key? key,
    required this.category,
    required this.outerRadius,
    required this.innerRadius,
    required this.iconSize,
    this.filled = true,
  }) : super(key: key);

  final Category category;
  final double outerRadius;
  final double innerRadius;
  final double iconSize;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: outerRadius,
      backgroundColor: filled ? Colors.white : Colors.white.withOpacity(0.5),
      child: CircleAvatar(
        radius: innerRadius,
        backgroundColor: filled ? category.color : Colors.white,
        child: Image.asset(
          category.iconUrl,
          color: filled ? Colors.white : category.color,
          width: iconSize,
          height: iconSize,
        ),
      ),
    );
  }
}
