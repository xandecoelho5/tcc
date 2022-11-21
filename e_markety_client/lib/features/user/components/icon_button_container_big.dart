import 'package:e_markety_client/shared/theme/constants.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: iconButton.color,
        borderRadius: BorderRadius.circular(12),
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
              style: kHeadline6Light.copyWith(letterSpacing: -0.5),
            ),
          ),
        ],
      ),
    );
  }
}
