import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        onPressed: onPressed,
        splashRadius: 20,
        hoverColor: color.withOpacity(0.35),
        icon: Icon(iconData, color: color),
      ),
    );
  }
}
