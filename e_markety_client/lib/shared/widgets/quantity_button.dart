import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton.plus({
    Key? key,
    this.icon = Icons.add,
    this.height,
    this.width,
    this.borderRadius,
    this.onTap,
  }) : super(key: key);

  const QuantityButton.minus({
    Key? key,
    this.icon = Icons.remove,
    this.height,
    this.width,
    this.borderRadius,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 20,
      width: width ?? 55,
      child: Material(
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          child: Icon(icon, size: 28, color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
