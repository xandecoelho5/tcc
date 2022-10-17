import 'package:flutter/material.dart';

import 'icon_button_model.dart';

class IconButtonContainerBig extends StatelessWidget {
  const IconButtonContainerBig({
    Key? key,
    required this.iconButton,
  }) : super(key: key);

  final IconButtonModel iconButton;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        decoration: BoxDecoration(
          color: iconButton.color,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(28),
              child: InkWell(
                onTap: iconButton.onTap,
                borderRadius: BorderRadius.circular(28),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Icon(
                    iconButton.icon,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
            FittedBox(
              child: Text(
                iconButton.label,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
