import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class UserInfoContainer extends StatelessWidget {
  const UserInfoContainer({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.5,
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(icon, color: kPrimaryColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
