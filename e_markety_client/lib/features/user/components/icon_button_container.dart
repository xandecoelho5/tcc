import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

import 'icon_button_model.dart';

class IconButtonContainer extends StatelessWidget {
  const IconButtonContainer({
    Key? key,
    required this.iconButton,
  }) : super(key: key);

  final IconButtonModel iconButton;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.14,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(28),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              color: Colors.white,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: iconButton.onTap,
                splashColor: kPrimaryColor,
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(iconButton.icon, color: kPrimaryColor, size: 28),
                ),
              ),
            ),
            FittedBox(
              child: Text(
                iconButton.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
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
