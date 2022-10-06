import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton({
    Key? key,
    required this.icon,
    this.height,
    this.width,
    this.borderRadius,
  }) : super(key: key);

  final String icon;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 20,
      width: width ?? 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ), // Icon(icon, color: Colors.grey.shade700, size: 20)
      child: Center(
        child: Text(
          icon,
          style: TextStyle(
            fontSize: 30,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
