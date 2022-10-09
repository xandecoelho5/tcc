import 'package:flutter/material.dart';

class IconButtonModel {
  final IconData icon;
  final String label;
  final Function()? onTap;
  final Color? color;

  const IconButtonModel({
    required this.icon,
    required this.label,
    this.onTap,
    this.color,
  });
}
