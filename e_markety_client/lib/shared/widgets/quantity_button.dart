import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton.plus({
    Key? key,
    this.icon = '+',
    this.height,
    this.width,
    this.borderRadius,
    this.onTap,
  }) : super(key: key);

  const QuantityButton.minus({
    Key? key,
    this.icon = '-',
    this.height,
    this.width,
    this.borderRadius,
    this.onTap,
  }) : super(key: key);

  final String icon;
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
          child: Center(
            child: Text(
              icon,
              style: TextStyle(
                fontSize: 35,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
