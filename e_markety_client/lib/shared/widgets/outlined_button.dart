import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.color,
    required this.text,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final Color color;
  final String text;
  final Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 54),
        side: BorderSide(color: color, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: Text(text, style: TextStyle(color: color)),
    );
  }
}
