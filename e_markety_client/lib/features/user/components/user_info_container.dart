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
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(icon, color: kPrimaryColor),
            ),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
